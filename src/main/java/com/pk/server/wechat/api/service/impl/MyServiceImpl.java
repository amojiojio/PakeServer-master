package com.pk.server.wechat.api.service.impl;

import com.pk.server.wechat.api.process.*;
import com.pk.server.wechat.api.service.MyService;
import com.pk.server.wechat.api.vo.Matchrule;
import com.pk.server.wechat.api.vo.MsgRequest;
import com.pk.server.wechat.cms.domain.*;
import com.pk.server.wechat.cms.mapper.*;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 业务消息处理
 * 开发者根据自己的业务自行处理消息的接收与回复；
 */

@Service
public class MyServiceImpl implements MyService {

    @Autowired
    private MsgBaseDao msgBaseDao;

    @Autowired
    private MsgNewsDao msgNewsDao;

    @Autowired
    private AccountMenuDao menuDao;

    @Autowired
    private AccountMenuGroupDao menuGroupDao;

    @Autowired
    private AccountFansDao fansDao;

    /**
     * 处理消息
     * 开发者可以根据用户发送的消息和自己的业务，自行返回合适的消息；
     *
     * @param msgRequest : 接收到的消息
     * @param appId      ： appId
     * @param appSecret  : appSecret
     */
    public String processMsg(MsgRequest msgRequest, MpAccount mpAccount) {
        String msgtype = msgRequest.getMsgType();//接收到的消息类型
        String respXml = null;//返回的内容；
        if (msgtype.equals(MsgType.Text.toString())) {
            /**
             * 文本消息，一般公众号接收到的都是此类型消息
             */
            respXml = this.processTextMsg(msgRequest, mpAccount);
        } else if (msgtype.equals(MsgType.Event.toString())) {//事件消息
            /**
             * 用户订阅公众账号、点击菜单按钮的时候，会触发事件消息
             */
            respXml = this.processEventMsg(msgRequest);

            //其他消息类型，开发者自行处理
        } else if (msgtype.equals(MsgType.Image.toString())) {//图片消息
            System.out.println("图片消息");

        } else if (msgtype.equals(MsgType.Location.toString())) {//地理位置消息
            System.out.println("地理位置");
        }

        //如果没有对应的消息，默认什么也不做；
        if (StringUtils.isEmpty(respXml)) {

        }
        return respXml;
    }

    //处理文本消息
    private String processTextMsg(MsgRequest msgRequest, MpAccount mpAccount) {
        String content = msgRequest.getContent();
        if (!StringUtils.isEmpty(content)) {//文本消息
            String tmpContent = content.trim();
            MsgText text = msgBaseDao.getMsgTextByInputCode(tmpContent);

            if (text != null) {
                return MsgXmlUtil.textToXml(WxMessageBuilder.getMsgResponseText(msgRequest, text));
            }

            List<MsgNews> msgNews = msgNewsDao.getRandomMsgByContent(tmpContent, mpAccount.getMsgcount());
            if (!CollectionUtils.isEmpty(msgNews)) {
                return MsgXmlUtil.newsToXml(WxMessageBuilder.getMsgResponseNews(msgRequest, msgNews));
            }
        }
        return null;
    }

    //处理事件消息
    private String processEventMsg(MsgRequest msgRequest) {
        String key = msgRequest.getEventKey();
        if (MsgType.SUBSCRIBE.toString().equals(msgRequest.getEvent())) {
            //订阅消息
            MpAccount mpAccount = WxMemoryCacheClient.getSingleMpAccount();
            //从微信接口获取粉丝信息
            AccountFans fans = WxApiClient.syncAccountFans(msgRequest.getFromUserName(), mpAccount);
            AccountFans tmpFans = fansDao.getByOpenId(msgRequest.getFromUserName());
            /**发送文本 默认Subscribe*/
			MsgText text = msgBaseDao.getMsgTextBySubscribe();
            if (tmpFans == null) {
                fansDao.add(fans);
            } else {
                fansDao.update(fans);
            }
//            MsgText text = new MsgText();
//            text.setContent("谢谢你\n长的这么好看还来关注我");
            if (text != null) {
                return MsgXmlUtil.textToXml(WxMessageBuilder.getMsgResponseText(msgRequest, text));
            }
        } else if (MsgType.UNSUBSCRIBE.toString().equals(msgRequest.getEvent())) {
            //取消订阅消息
            //将订阅状态变更为未订阅
            fansDao.updateToState(msgRequest.getFromUserName());

        } else {//菜单独有点击事件消息
            if (!StringUtils.isEmpty(key)) {
                /**
                 * 固定消息
                 * _fix_ ：在我们创建菜单的时候，做了限制，对应的event_key 加了 _fix_
                 *
                 * 当然开发者也可以进行修改
                 */
                if (key.startsWith("_fix_")) {
                    String baseIds = key.substring("_fix_".length());
                    if (!StringUtils.isEmpty(baseIds)) {
                        String[] idArr = baseIds.split(",");
                        if (idArr.length > 1) {//多条图文消息
                            List<MsgNews> msgNews = msgBaseDao.listMsgNewsByBaseId(idArr);
                            if (msgNews != null && msgNews.size() > 0) {
                                return MsgXmlUtil.newsToXml(WxMessageBuilder.getMsgResponseNews(msgRequest, msgNews));
                            }
                        } else {//图文消息，或者文本消息
                            MsgBase msg = msgBaseDao.getById(baseIds);
                            if (msg.getMsgtype().equals(MsgType.Text.toString())) {
                                MsgText text = msgBaseDao.getMsgTextByBaseId(baseIds);
                                if (text != null) {
                                    return MsgXmlUtil.textToXml(WxMessageBuilder.getMsgResponseText(msgRequest, text));
                                }
                            } else {
                                List<MsgNews> msgNews = msgBaseDao.listMsgNewsByBaseId(idArr);
                                if (msgNews != null && msgNews.size() > 0) {
                                    return MsgXmlUtil.newsToXml(WxMessageBuilder.getMsgResponseNews(msgRequest, msgNews));
                                }
                            }
                        }
                    }
                }
            }
        }
        return null;
    }

    //发布菜单
    public JSONObject publishMenu(String gid, MpAccount mpAccount) {
        AccountMenu accountMenu = new AccountMenu();
        accountMenu.setGid(Long.valueOf(gid));
        List<AccountMenu> menus = menuDao.list(accountMenu);
        Matchrule matchrule = new Matchrule();
        String menuJson = prepareMenus(menus, matchrule);
        JSONObject rstObj = WxApiClient.publishMenus(menuJson, mpAccount);//创建普通菜单
//		matchrule.setSex("1");//1-男 ；2-女
//		JSONObject rstObj = WxApiClient.publishAddconditionalMenus(menuJson,mpAccount);//创建个性化菜单
        System.out.println("================" + rstObj);
        if (rstObj != null) {//成功，更新菜单组
            if (rstObj.containsKey("menu_id")) {
                menuGroupDao.updateMenuGroupDisable();
                menuGroupDao.updateMenuGroupEnable(gid);
            } else if (rstObj.containsKey("errcode") && rstObj.getInt("errcode") == 0) {
                menuGroupDao.updateMenuGroupDisable();
                menuGroupDao.updateMenuGroupEnable(gid);
            }
        }
        return rstObj;
    }

    //删除菜单
    public JSONObject deleteMenu(MpAccount mpAccount) {
        JSONObject rstObj = WxApiClient.deleteMenu(mpAccount);
        if (rstObj != null && rstObj.getInt("errcode") == 0) {//成功，更新菜单组
            menuGroupDao.updateMenuGroupDisable();
        }
        return rstObj;
    }

    //获取用户列表
    public boolean syncAccountFansList(MpAccount mpAccount) {
        String nextOpenId = null;
        AccountFans lastFans = fansDao.getLastOpenId();
        if (lastFans != null) {
            nextOpenId = lastFans.getOpenId();
        }
        return doSyncAccountFansList(nextOpenId, mpAccount);
    }

    //同步粉丝列表(开发者在这里可以使用递归处理)
    private boolean doSyncAccountFansList(String nextOpenId, MpAccount mpAccount) {
        String url = WxApi.getFansListUrl(WxApiClient.getAccessToken(mpAccount), nextOpenId);
        JSONObject jsonObject = WxApi.httpsRequest(url, HttpMethod.POST, null);
        if (jsonObject.containsKey("errcode")) {
            return false;
        }
        List<AccountFans> fansList = new ArrayList<AccountFans>();
        if (jsonObject.containsKey("data")) {
            if (jsonObject.getJSONObject("data").containsKey("openid")) {
                JSONArray openidArr = jsonObject.getJSONObject("data").getJSONArray("openid");
                int length = jsonObject.getInt("total");//同步全部
                if (openidArr.size() < length) {
                    length = openidArr.size();
                }
                for (int i = 0; i < length; i++) {
                    Object openId = openidArr.get(i);
                    AccountFans fans = WxApiClient.syncAccountFans(openId.toString(), mpAccount);
                    fansList.add(fans);
                }
                //批处理
                fansDao.addList(fansList);
            }
        }
        return true;
    }

    //获取用户信息接口 - 必须是开通了认证服务，否则微信平台没有开放此功能
    public AccountFans syncAccountFans(String openId, MpAccount mpAccount, boolean merge) {
        AccountFans fans = WxApiClient.syncAccountFans(openId, mpAccount);
        if (merge && null != fans) {
            AccountFans tmpFans = fansDao.getByOpenId(openId);
            if (tmpFans == null) {
                fansDao.add(fans);
            } else {
                fans.setId(tmpFans.getId());
                fansDao.update(fans);
            }
        }
        return fans;
    }

    //根据openid 获取粉丝，如果没有，同步粉丝
    public AccountFans getFansByOpenId(String openId, MpAccount mpAccount) {
        AccountFans fans = fansDao.getByOpenId(openId);
        if (fans == null) {//如果没有，添加
            fans = WxApiClient.syncAccountFans(openId, mpAccount);
            if (null != fans) {
                fansDao.add(fans);
            }
        }
        return fans;
    }

    /**
     * 获取微信公众账号的菜单
     *
     * @param menus     菜单列表
     * @param matchrule 个性化菜单配置
     * @return
     */
    private String prepareMenus(List<AccountMenu> menus, Matchrule matchrule) {
        if (!CollectionUtils.isEmpty(menus)) {
            List<AccountMenu> parentAM = new ArrayList<AccountMenu>();
            Map<Long, List<JSONObject>> subAm = new HashMap<Long, List<JSONObject>>();
            for (AccountMenu m : menus) {
                if (m.getParentid() == 0L) {//一级菜单
                    parentAM.add(m);
                } else {//二级菜单
                    if (subAm.get(m.getParentid()) == null) {
                        subAm.put(m.getParentid(), new ArrayList<JSONObject>());
                    }
                    List<JSONObject> tmpMenus = subAm.get(m.getParentid());
                    tmpMenus.add(getMenuJSONObj(m));
                    subAm.put(m.getParentid(), tmpMenus);
                }
            }
            JSONArray arr = new JSONArray();
            for (AccountMenu m : parentAM) {
                if (subAm.get(m.getId()) != null) {//有子菜单
                    arr.add(getParentMenuJSONObj(m, subAm.get(m.getId())));
                } else {//没有子菜单
                    arr.add(getMenuJSONObj(m));
                }
            }
            JSONObject root = new JSONObject();
            root.put("button", arr);
            root.put("matchrule", JSONObject.fromObject(matchrule).toString());
            return JSONObject.fromObject(root).toString();
        }
        return "error";
    }

    /**
     * 此方法是构建菜单对象的；构建菜单时，对于  key 的值可以任意定义；
     * 当用户点击菜单时，会把key传递回来；对已处理就可以了
     *
     * @param menu
     * @return
     */
    private JSONObject getMenuJSONObj(AccountMenu menu) {
        JSONObject obj = new JSONObject();
        obj.put("name", menu.getName());
        obj.put("type", menu.getMtype());
        if ("click".equals(menu.getMtype())) {//事件菜单
            if ("fix".equals(menu.getEventType())) {//fix 消息
                obj.put("key", "_fix_" + menu.getMsgId());//以 _fix_ 开头
            } else if ("suta".equals(menu.getEventType())) {
                obj.put("key", "_suta_" + menu.getMsgId());//以 _suta_ 开头
            } else {
                if (StringUtils.isEmpty(menu.getInputcode())) {//如果inputcode 为空，默认设置为 subscribe，以免创建菜单失败
                    obj.put("key", "subscribe");
                } else {
                    obj.put("key", menu.getInputcode());
                }
            }
        } else {//链接菜单-view
            obj.put("url", menu.getUrl());
        }
        return obj;
    }

    private JSONObject getParentMenuJSONObj(AccountMenu menu, List<JSONObject> subMenu) {
        JSONObject obj = new JSONObject();
        obj.put("name", menu.getName());
        obj.put("sub_button", subMenu);
        return obj;
    }


}


