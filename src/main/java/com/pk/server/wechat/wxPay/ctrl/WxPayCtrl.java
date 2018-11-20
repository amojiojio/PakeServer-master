package com.pk.server.wechat.wxPay.ctrl;

import com.pk.server.app.model.Run;
import com.pk.server.app.model.TakeByQu;
import com.pk.server.app.service.IRunService;
import com.pk.server.app.service.ITakeByQuService;
import com.pk.server.master.redis.RedisCache;
import com.pk.server.wechat.api.process.MpAccount;
import com.pk.server.wechat.api.process.WxApiClient;
import com.pk.server.wechat.api.process.WxMemoryCacheClient;
import com.pk.server.wechat.api.vo.TemplateMessage;
import com.pk.server.wechat.core.util.HttpUtil;
import com.pk.server.wechat.wxPay.util.HttpConnection;
import com.pk.server.wechat.wxPay.util.XmlUtil;
import com.pk.server.wechat.wxPay.vo.JsAPIConfig;
import com.pk.server.wechat.wxPay.vo.PayCallback;
import com.pk.server.wechat.wxPay.vo.UnifiedOrder;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.util.*;
import java.util.concurrent.Executor;
import java.util.concurrent.Executors;


@Controller
@RequestMapping("/wxPay")
public class WxPayCtrl {

    @Autowired
    private XmlUtil xmlUtil;

    @Autowired
    private IRunService runService;

    @Autowired
    private ITakeByQuService takeByQuService;

    @Resource
    private RedisCache redisCache;

    // 应用编号（微信公众号编号）
    private static final String appId = "wxceb9b4cc8cce903b";
    // 商户号码
    private static final String mchId = "1501752771";
    // 支付码(微信支付的APIKEY)
    private static final String payKey = "65V83zf6bm6AYwjECJO3V8qUjPCE2TVd";
    //统一下单URL API
    private static final String unifiedOrderUrl = "https://api.mch.weixin.qq.com/pay/unifiedorder";
    //微信回调地址
    private static final String callbackUrl = "www.wanxunkj.com/wxPay/wechat_notify";


    /**
     * 统一下单
     */
    @RequestMapping(value = "/uniformorder", method = RequestMethod.POST, produces = "application/json")
    @ResponseBody
    public JsAPIConfig unifiedOrder(HttpServletRequest request) throws Exception {
        //拦截器已经处理了缓存,这里直接取
        String opend = WxMemoryCacheClient.getOpenid(request.getSession().getId());
        UnifiedOrder unifiedOrder = new UnifiedOrder();
        unifiedOrder.setAppid(appId);
        unifiedOrder.setBody("派客配送");
        unifiedOrder.setMch_id(mchId);
        unifiedOrder.setNonce_str(UUID.randomUUID().toString().substring(0, 30).replace("-", ""));
        unifiedOrder.setNotify_url(callbackUrl);
        unifiedOrder.setOpenid(opend);
        unifiedOrder.setOut_trade_no(request.getParameter("orderNo"));
        unifiedOrder.setAttach(request.getParameter("type"));
        String ip = HttpUtil.getIpAddr(request);
        if (StringUtils.isEmpty(ip)) {
            unifiedOrder.setSpbill_create_ip("127.0.0.1");
        } else {
            unifiedOrder.setSpbill_create_ip(ip);
        }
        unifiedOrder.setTotal_fee(BigDecimal.valueOf(Double.parseDouble(request.getParameter("money"))).multiply(new BigDecimal(100)).intValue());
        String sign = createUnifiedOrderSign(unifiedOrder);
        unifiedOrder.setSign(sign);
        /**
         * 转成XML格式
         */
        xmlUtil.getXstreamInclueUnderline().alias("xml", unifiedOrder.getClass());
        String xml = xmlUtil.getXstreamInclueUnderline().toXML(unifiedOrder);
        String response = HttpConnection.post(unifiedOrderUrl, xml);
        Map<String, String> responseMap = xmlUtil.parseXml(response);
        return createPayConfig(responseMap.get("prepay_id"));
    }


    /**
     * 微信支付回调页面
     */
    @ResponseBody
    @RequestMapping(value = "wechat_notify")
    public String wechatPayNotify(HttpServletRequest request) {
        final MpAccount mpAccount = WxMemoryCacheClient.getSingleMpAccount();//获取缓存中的唯一账号
        try {
            Map<String, String> map = getCallbackParams(request);
            if (map.get("result_code").toString().equalsIgnoreCase("SUCCESS")) {
                if (map.get("attach").toString().equals("run")) {
                    Run run = new Run();
                    run.setId(map.get("out_trade_no"));
                    final Run runTemp = runService.getOne(run);
                    if (runTemp.getTransactionId() == null || runTemp.getTransactionId().length() <= 0) {
                        run.setTransactionId(map.get("transaction_id"));
                        //已支付
                        run.setPayState(1);
                        //待接单
                        run.setState(1);
                        runService.update(run);

                        final TemplateMessage tplMsg = new TemplateMessage();
                        tplMsg.setOpenid(runTemp.getOpenId());
                        tplMsg.setUrl("www.wanxunkj.com/weChat/userInfo");
                        tplMsg.setTemplateId("C72lOWiBqUVmfU2T26fkMvWTlXdkQX0bgPxvwxRMjyo");
                        Map<String, String> dataMap = new HashMap<String, String>();
                        dataMap.put("first", "您好，您的订单已被受理\r\n");
                        dataMap.put("storeName", "校园派客");
                        dataMap.put("orderId", runTemp.getId());
                        dataMap.put("orderType", runTemp.getGoodsType());
                        dataMap.put("remark", "感谢您选择派客配送\r\n ");
                        tplMsg.setDataMap(dataMap);

                        Executor executor = Executors.newSingleThreadExecutor();
                        executor.execute(new Runnable() {
                            public void run() {
                                /**发送模版消息*/
                                WxApiClient.sendTemplateMessage(tplMsg, mpAccount);
                                /**发送客服消息*/
                                WxApiClient.sendCustomTextMessage("od4xq1RzhU1uXpqS4eqMZQA6vD-g", "有新的订单需要处理,订单号为：" + runTemp.getId(), mpAccount);
                            }
                        });
                        //通知redis消息中心
                        redisCache.getRedisTemplate().convertAndSend("redisMessage", run);
                        return getPayCallback();
                    } else {
                        return getPayCallback();
                    }
                }

                else if (map.get("attach").toString().equals("qu")) {
                    TakeByQu takeByQu = new TakeByQu();
                    takeByQu.setId(map.get("out_trade_no"));
                    final TakeByQu takeTemp = takeByQuService.getOne(takeByQu);
                    if (takeTemp.getTransactionId() == null || takeTemp.getTransactionId().length() <= 0) {
                        takeByQu.setPayState(1);
                        takeByQu.setState(1);
                        takeByQu.setTransactionId(map.get("transaction_id"));
                        takeByQu.setId(map.get("out_trade_no"));
                        takeByQuService.update(takeByQu);


                        final TemplateMessage tplMsg = new TemplateMessage();
                        tplMsg.setOpenid(takeByQu.getOpenId());
                        tplMsg.setUrl("www.wanxunkj.com/weChat/userInfo");
                        tplMsg.setTemplateId("C72lOWiBqUVmfU2T26fkMvWTlXdkQX0bgPxvwxRMjyo");
                        Map<String, String> dataMap = new HashMap<String, String>();
                        dataMap.put("first", "您好，您的订单已被受理\r\n");
                        dataMap.put("storeName", "校园派客");
                        dataMap.put("orderId", takeByQu.getId());
                        dataMap.put("keyword3", "帮我取");
                        dataMap.put("orderType", "感谢您选择派客配送");
                        tplMsg.setDataMap(dataMap);

                        Executor executor = Executors.newSingleThreadExecutor();
                        executor.execute(new Runnable() {
                            public void run() {
                                /**发送模版消息*/
                                WxApiClient.sendTemplateMessage(tplMsg, mpAccount);
                                /**发送客服消息*/
                                WxApiClient.sendCustomTextMessage("od4xq1RzhU1uXpqS4eqMZQA6vD-g", "有新的订单需要处理,订单号为：" + takeTemp.getId(), mpAccount);
                            }
                        });
                        //通知redis消息中心
                        redisCache.getRedisTemplate().convertAndSend("redisMessage", takeByQu);
                        return getPayCallback();
                    } else {
                        return getPayCallback();
                    }
                }
                else{
                    /**发送客服消息*/
                    WxApiClient.sendCustomTextMessage("od4xq1RzhU1uXpqS4eqMZQA6vD-g", "支付结果通知异常.......", mpAccount);
                }


            } else {
                System.out.println("err_code" + map.get("err_code"));
                System.out.println("err_code_des" + map.get("err_code_des"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return getPayCallback();
    }

    /**
     * 获取支付配置
     */
    public JsAPIConfig createPayConfig(String prepayId) throws Exception {
        JsAPIConfig config = new JsAPIConfig();
        String nonce = UUID.randomUUID().toString();
        String timestamp = Long.toString(System.currentTimeMillis() / 1000);
        String packageName = "prepay_id=" + prepayId;
        StringBuffer sign = new StringBuffer();
        sign.append("appId=").append(appId);
        sign.append("&nonceStr=").append(nonce);
        sign.append("&package=").append(packageName);
        sign.append("&signType=").append(config.getSignType());
        sign.append("&timeStamp=").append(timestamp);
        sign.append("&key=").append(payKey);
        String signature = DigestUtils.md5Hex(sign.toString()).toUpperCase();
        config.setAppId(appId);
        config.setNonce(nonce);
        config.setTimestamp(timestamp);
        config.setPackageName(packageName);
        config.setSignature(signature);
        return config;
    }

    /**
     * 生成收到支付结果的确认信息
     */
    public String getPayCallback() {
        PayCallback callback = new PayCallback();
        xmlUtil.getXstreamInclueUnderline().alias("xml", callback.getClass());
        String xml = xmlUtil.getXstreamInclueUnderline().toXML(callback);
        return xml;
    }

    /**
     * 获取请求参数
     */
    public Map<String, String> getCallbackParams(HttpServletRequest request)
            throws Exception {
        InputStream inStream = request.getInputStream();
        ByteArrayOutputStream outSteam = new ByteArrayOutputStream();
        byte[] buffer = new byte[1024];
        int len = 0;
        while ((len = inStream.read(buffer)) != -1) {
            outSteam.write(buffer, 0, len);
        }
        outSteam.close();
        inStream.close();
        String result = new String(outSteam.toByteArray(), "utf-8");
        return xmlUtil.parseXml(result);
    }

    /**
     * 获取统一下单签名
     */
    public String createUnifiedOrderSign(UnifiedOrder unifiedOrder) throws Exception {
        StringBuffer sign = new StringBuffer();
        Map<String, String> map = getSortMap(unifiedOrder);
        boolean isNotFirst = false;
        for (Map.Entry<String, String> entry : map.entrySet()) {
            if (isNotFirst == true) {
                sign.append("&");
            } else {
                isNotFirst = true;
            }
            sign.append(entry.getKey()).append("=").append(entry.getValue());
        }
        sign.append("&key=").append(payKey);
        System.out.println("sign+==============" + sign.toString());
        return DigestUtils.md5Hex(sign.toString().getBytes("UTF-8")).toUpperCase();
    }

    /**
     * 获取排序后的类属性及值
     *
     * @param object
     * @return
     * @throws Exception
     */
    private Map<String, String> getSortMap(Object object) throws Exception {
        Field[] fields = object.getClass().getDeclaredFields();
        Map<String, String> map = new HashMap<String, String>();
        for (Field field : fields) {
            String name = field.getName();
            String methodName = "get" + name.replaceFirst(name.substring(0, 1), name.substring(0, 1)
                    .toUpperCase());
            Method getter = object.getClass().getMethod(methodName);
            // 调用getter方法获取属性值
            String value = getter.invoke(object) + "";
            if (value != null && !"".equals(value) && !value.equals("null")) {
                map.put(name, value);
            }
        }
        Map<String, String> sortMap = new TreeMap<String, String>(
                new Comparator<String>() {
                    @Override
                    public int compare(String arg0, String arg1) {
                        return arg0.compareTo(arg1);
                    }
                });
        sortMap.putAll(map);
        return sortMap;
    }


}
