package com.pk.server.app.ctrl;

import com.pk.server.app.model.TakeBySong;
import com.pk.server.app.service.ITakeBySongService;
import com.pk.server.app.util.AppUtil;
import com.pk.server.master.redis.RedisCache;
import com.pk.server.wechat.api.process.MpAccount;
import com.pk.server.wechat.api.process.WxApiClient;
import com.pk.server.wechat.api.process.WxMemoryCacheClient;
import com.pk.server.wechat.api.vo.TemplateMessage;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.Executor;
import java.util.concurrent.Executors;

@Controller
@RequestMapping("/weChat/takeBySong")
public class TakeBySongCtrl {

    @Resource
    private ITakeBySongService takeBySongService;

    @Resource
    private RedisCache redisCache;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        //转换日期
        DateFormat dateFormat=new SimpleDateFormat("yyyy/MM/dd HH:mm");
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));
    }

    /**
     * 系统下单
     */
    @RequestMapping("/pleaseOrder")
    @ResponseBody
    public String pleaseOrder(@ModelAttribute final TakeBySong takeBySong, HttpServletRequest request){
        try {
            //拦截器已经处理了缓存,这里直接取
            String openId = WxMemoryCacheClient.getOpenid(request.getSession().getId());
            takeBySong.setId(AppUtil.getOrderIdByUUId());
            takeBySong.setOpenId(openId);
            //1待接单
            takeBySong.setState(1);
            takeBySongService.save(takeBySong);

            final MpAccount mpAccount = WxMemoryCacheClient.getSingleMpAccount();//获取缓存中的唯一账号

            final TemplateMessage tplMsg = new TemplateMessage();
            tplMsg.setOpenid(takeBySong.getOpenId());
            tplMsg.setUrl("www.wanxunkj.com/weChat/userInfo");
            tplMsg.setTemplateId("C72lOWiBqUVmfU2T26fkMvWTlXdkQX0bgPxvwxRMjyo");
            Map<String, String> dataMap = new HashMap<String,String>();
            dataMap.put("first", "您好，您的订单已被受理");
            dataMap.put("storeName","校园派客");
            dataMap.put("orderId",takeBySong.getId());
            dataMap.put("orderType","帮我送");
            dataMap.put("remark", "\r\n感谢您选择派客配送\r\n ");
            tplMsg.setDataMap(dataMap);

            Executor executor = Executors.newSingleThreadExecutor();
            executor.execute(() -> {
            /**发送模版消息*/
            WxApiClient.sendTemplateMessage(tplMsg, mpAccount);
            /**发送客服消息*/
            WxApiClient.sendCustomTextMessage("od4xq1RzhU1uXpqS4eqMZQA6vD-g", "有新的订单需要处理,订单号为："+takeBySong.getId(), mpAccount);
            });
            //通知redis消息中心
            redisCache.getRedisTemplate().convertAndSend("redisMessage", takeBySong);
            return takeBySong.getId();
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }


}
