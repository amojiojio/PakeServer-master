package com.pk.server.admin.ctrl;

import com.alibaba.fastjson.JSONArray;
import com.pk.server.admin.model.Admin;
import com.pk.server.admin.service.IAdminService;
import com.pk.server.app.model.Run;
import com.pk.server.app.model.TakeByQu;
import com.pk.server.app.model.TakeBySong;
import com.pk.server.app.service.IRunService;
import com.pk.server.app.service.ITakeByQuService;
import com.pk.server.app.service.ITakeBySongService;
import com.pk.server.wechat.api.process.MpAccount;
import com.pk.server.wechat.api.process.WxApiClient;
import com.pk.server.wechat.api.process.WxMemoryCacheClient;
import com.pk.server.wechat.api.vo.TemplateMessage;
import com.pk.server.wechat.core.page.PageEntity;
import com.pk.server.wechat.core.page.Pagenation;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.Executor;
import java.util.concurrent.Executors;

/**
 * 系统管理后台核心控制器
 */
@Controller
@RequestMapping("/admin")
public class AdminCtrl {

    @Autowired
    private IAdminService adminService;

    @Autowired
    private IRunService runService;

    @Autowired
    private ITakeBySongService takeBySongService;

    @Autowired
    private ITakeByQuService takeByQuService;


    @RequestMapping("/login")
    public ModelAndView login(@RequestParam String username, String password, HttpSession session) {
        ModelAndView mv = new ModelAndView();
        Admin admin = new Admin();
        admin.setUserName(username);
        admin.setPassWord(password);
        if (adminService.login(admin)) {
            session.setAttribute("user", true);
            mv.setViewName("redirect:../admin/index");
            return mv;
        }
        mv.setViewName("admin/error");
        return mv;
    }


    @ResponseBody
    @RequestMapping(value = "/one", method = RequestMethod.GET)
    public JSONObject one() {
        List<Map<String, Integer>> datas = adminService.one();
        String[] str = new String[datas.size()];
        str[0] = "跑腿订单";
        str[1] = "代取订单";
        str[2] = "代收订单";
        JSONArray jsonArray = new JSONArray();

        JSONObject run = new JSONObject();
        run.put("name", "跑腿订单");
        run.put("value", datas.get(0).get("num"));

        JSONObject qu = new JSONObject();
        qu.put("name", "代取订单");
        qu.put("value", datas.get(1).get("num"));

        JSONObject song = new JSONObject();
        song.put("name", "代收订单");
        song.put("value", datas.get(2).get("num"));

        jsonArray.add(run);
        jsonArray.add(qu);
        jsonArray.add(song);

        JSONObject data = new JSONObject();
        data.put("dataName", str);
        data.put("dataValue", jsonArray);
        return data;
    }


    @ResponseBody
    @RequestMapping(value = "/two", method = RequestMethod.GET)
    public JSONObject two() {
        List<Map<String, String>> datas = adminService.two();
        JSONObject data = new JSONObject();
        String[] dateList = new String[datas.size()];
        String[] valueList = new String[datas.size()];
        for (int i = 0; i < datas.size(); i++) {
            dateList[i] = datas.get(i).get("date");
            valueList[i] = String.valueOf(datas.get(i).get("num"));
        }
        data.put("dateList", dateList);
        data.put("valueList", valueList);
        return data;
    }

    @ResponseBody
    @RequestMapping(value = "/three", method = RequestMethod.GET)
    public JSONObject three() {
        List<Map<String, String>> datas = adminService.three();
        JSONObject data = new JSONObject();
        String[] dateList = new String[datas.size()];
        String[] valueList = new String[datas.size()];
        for (int i = 0; i < datas.size(); i++) {
            dateList[i] = datas.get(i).get("date");
            valueList[i] = String.valueOf(datas.get(i).get("num"));
        }
        data.put("dateList", dateList);
        data.put("valueList", valueList);
        return data;
    }


    @ResponseBody
    @RequestMapping(value = "/four", method = RequestMethod.GET)
    public JSONObject four() {
        List<Map<String, String>> datas = adminService.four();
        JSONObject data = new JSONObject();
        String[] dateList = new String[datas.size()];
        String[] valueList = new String[datas.size()];
        for (int i = 0; i < datas.size(); i++) {
            dateList[i] = datas.get(i).get("date");
            valueList[i] = String.valueOf(datas.get(i).get("num"));
        }
        data.put("dateList", dateList);
        data.put("valueList", valueList);
        return data;
    }


    /**
     * 首页
     */
    @RequestMapping("index")
    public ModelAndView index() {
        ModelAndView mv = new ModelAndView("admin/index");
        List<Map<String, Integer>> datas = adminService.index();
        mv.addObject("datas", datas);
        return mv;
    }


    /**
     * 跑腿订单
     */
    @RequestMapping("runOrders")
    public ModelAndView runOrders(Run run, PageEntity pageEntity) {
        ModelAndView mv = new ModelAndView("admin/pake/runOrders");
        Pagenation pagenation = runService.findAll(run, pageEntity);
        pagenation.setQueryUrl("runOrders");
        mv.addObject("run", run);
        mv.addObject("pagination", pagenation);
        return mv;
    }


    /**
     * 查询订单
     */
    @RequestMapping("/lookRunOrder")
    public ModelAndView lookRunOrder(@ModelAttribute Run run) {
        ModelAndView mv = new ModelAndView("admin/pake/lookRunOrder");
        run = runService.getOne(run);
        mv.addObject("run", run);
        return mv;
    }

    @RequestMapping("/sendOutByRun")
    @ResponseBody
    public String sendOutByRun(@ModelAttribute Run run) {
        MpAccount mpAccount = WxMemoryCacheClient.getSingleMpAccount();//获取缓存中的唯一账号
        try {
            //改为进行中
            run.setState(2);
            runService.update(run);

            TemplateMessage tplMsg = new TemplateMessage();
            tplMsg.setOpenid(run.getOpenId());
            tplMsg.setUrl("http://www.wanxunkj.com/weChat/userInfo");
            tplMsg.setTemplateId("h0Vy--9SBm-o63ECmtyb-ZGXSl-SBeHdk-KjrugdU0o");
            Map<String, String> dataMap = new HashMap<String, String>();
            dataMap.put("first", "您好，派客已出发，请保持手机畅通\r\n");
            dataMap.put("keyword1", run.getId() + "\r\n");
            dataMap.put("keyword2", "已接单"+ "\r\n");
            Date d = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd HH:mm:ss");
            String dateNowStr = sdf.format(d);
            dataMap.put("keyword3", dateNowStr + "\r\n");
            dataMap.put("remark", "感谢您选择派客配送\r\n ");
            tplMsg.setDataMap(dataMap);
            JSONObject result = WxApiClient.sendTemplateMessage(tplMsg, mpAccount);
            if (result.getInt("errcode") != 0) {
                if (result.getInt("errcode") == 43004) {
                    //给用户发送手机消息 用户未关注
                    return "43004";
                } else {
                    return "errorInfo";
                }
            } else {
                return "success";
            }
        } catch (Exception e) {
            return "error";
        }

    }

    @RequestMapping("/sendDoneByRun")
    @ResponseBody
    public String sendDoneByRun(@ModelAttribute Run run) {
        MpAccount mpAccount = WxMemoryCacheClient.getSingleMpAccount();//获取缓存中的唯一账号
        try {
            //改为已完成
            run.setState(3);
            runService.update(run);

            TemplateMessage tplMsg = new TemplateMessage();
            tplMsg.setOpenid(run.getOpenId());
            tplMsg.setUrl("http://www.wanxunkj.com/weChat/userInfo");
            tplMsg.setTemplateId("Vb-dzrV-UsNWeeH0mwh0JWkBYFTrv0Uus6M1SRXf6lk");
            Map<String, String> dataMap = new HashMap<>();
            dataMap.put("first", "您好,您的订单已完成\r\n");
            dataMap.put("keyword1", run.getId() + "\r\n");
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd HH:mm:ss");
            dataMap.put("keyword2", sdf.format(run.getCreateDate()) + "\r\n");
            dataMap.put("keyword3", sdf.format(new Date()) + "\r\n");
            dataMap.put("remark", "感谢您选择派客配送\r\n ");
            tplMsg.setDataMap(dataMap);
            Executor executor = Executors.newSingleThreadExecutor();
            executor.execute(() -> WxApiClient.sendTemplateMessage(tplMsg, mpAccount));
            return "success";
        } catch (Exception e) {
            return "error";
        }

    }

    /**
     * 收件订单
     */
    @RequestMapping("takeBySongOrders")
    public ModelAndView takeOrders(TakeBySong take, PageEntity pageEntity) {
        ModelAndView mv = new ModelAndView("admin/pake/takeBySongOrders");
        Pagenation pagenation = takeBySongService.findAll(take, pageEntity);
        pagenation.setQueryUrl("takeBySongOrders");
        mv.addObject("pagination", pagenation);
        return mv;
    }


    /**
     * 查看
     */
    @RequestMapping("/lookBySong")
    public ModelAndView lookBySong(@ModelAttribute TakeBySong takeBySong) {
        ModelAndView mv = new ModelAndView("admin/pake/lookBySong");
        takeBySong = takeBySongService.getOne(takeBySong);
        mv.addObject("takeBySong", takeBySong);
        return mv;
    }

    @RequestMapping("/sendOutBySong")
    @ResponseBody
    public String sendOutBySong(@ModelAttribute TakeBySong takeBySong) {
        MpAccount mpAccount = WxMemoryCacheClient.getSingleMpAccount();//获取缓存中的唯一账号
        try {
            takeBySong.setState(2);
            takeBySongService.update(takeBySong);

            TemplateMessage tplMsg = new TemplateMessage();
            tplMsg.setOpenid(takeBySong.getOpenId());
            tplMsg.setUrl("http://www.wanxunkj.com/weChat/userInfo");
            tplMsg.setTemplateId("h0Vy--9SBm-o63ECmtyb-ZGXSl-SBeHdk-KjrugdU0o");
            Map<String, String> dataMap = new HashMap<String, String>();
            dataMap.put("first", "您好，派客已出发，请保持手机畅通\r\n");
            dataMap.put("keyword1", takeBySong.getId() + "\r\n");
            dataMap.put("keyword2", "已接单"+ "\r\n");
            Date d = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd HH:mm:ss");
            String dateNowStr = sdf.format(d);
            dataMap.put("keyword3", dateNowStr + "\r\n");
            dataMap.put("remark", "感谢您选择派客配送\r\n ");
            tplMsg.setDataMap(dataMap);
            Executor executor = Executors.newSingleThreadExecutor();
            executor.execute(() -> WxApiClient.sendTemplateMessage(tplMsg, mpAccount));
            return "success";
        } catch (Exception e) {
            return "error";
        }

    }

    @RequestMapping("/sendDoneBySong")
    @ResponseBody
    public String sendDoneBySong(@ModelAttribute TakeBySong takeBySong) {
        MpAccount mpAccount = WxMemoryCacheClient.getSingleMpAccount();//获取缓存中的唯一账号
        try {
            //改为已完成
            takeBySong.setState(3);
            takeBySongService.update(takeBySong);

            TemplateMessage tplMsg = new TemplateMessage();
            tplMsg.setOpenid(takeBySong.getOpenId());
            tplMsg.setUrl("http://www.wanxunkj.com/weChat/userInfo");
            tplMsg.setTemplateId("pTZ9PeStP0A0nJgIUGuCn3097R1ewlqkKZEkFS0SZzg");
            Map<String, String> dataMap = new HashMap<>();
            dataMap.put("first", "您好，您的快递已发货\r\n");
            dataMap.put("keyword1", takeBySong.getCourierNumber() + "\r\n");
            dataMap.put("keyword2", takeBySong.getCourierCompany() + "\r\n");
            dataMap.put("remark", "感谢您选择派客配送\r\n ");
            tplMsg.setDataMap(dataMap);
            Executor executor = Executors.newSingleThreadExecutor();
            executor.execute(() -> WxApiClient.sendTemplateMessage(tplMsg, mpAccount));
            return "success";
        } catch (Exception e) {
            return "error";
        }

    }


    /*
     * 取件订单
     */
    @RequestMapping("takeByQuOrders")
    public ModelAndView takeByQuOrders(TakeByQu takeByQu, PageEntity pageEntity) {
        ModelAndView mv = new ModelAndView("admin/pake/takeByQuOrders");
        Pagenation pagenation = takeByQuService.findAll(takeByQu, pageEntity);
        pagenation.setQueryUrl("takeByQuOrders");
        mv.addObject("pagination", pagenation);
        return mv;
    }


    /**
     * 查看
     */
    @RequestMapping("/lookByQu")
    public ModelAndView lookByQu(@ModelAttribute TakeByQu takeByQu) {
        ModelAndView mv = new ModelAndView("admin/pake/lookByQu");
        takeByQu = takeByQuService.getOne(takeByQu);
        mv.addObject("takeByQu", takeByQu);
        return mv;
    }

    @RequestMapping("/sendOutByQu")
    @ResponseBody
    public String sendOutByQu(TakeByQu takeByQu) {
        MpAccount mpAccount = WxMemoryCacheClient.getSingleMpAccount();//获取缓存中的唯一账号
        try {
            //改为进行中
            takeByQu.setState(2);
            takeByQuService.update(takeByQu);

            TemplateMessage tplMsg = new TemplateMessage();
            tplMsg.setOpenid(takeByQu.getOpenId());
            tplMsg.setUrl("http://www.wanxunkj.com/weChat/userInfo");
            tplMsg.setTemplateId("h0Vy--9SBm-o63ECmtyb-ZGXSl-SBeHdk-KjrugdU0o");
            Map<String, String> dataMap = new HashMap<String, String>();
            dataMap.put("first", "您好，派客已出发，请保持手机畅通\r\n");
            dataMap.put("keyword1", takeByQu.getId() + "\r\n");
            dataMap.put("keyword2", "已接单"+ "\r\n");
            Date d = new Date();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd HH:mm:ss");
            String dateNowStr = sdf.format(d);
            dataMap.put("keyword3", dateNowStr + "\r\n");
            dataMap.put("remark", "感谢您选择派客配送\r\n ");
            tplMsg.setDataMap(dataMap);
            Executor executor = Executors.newSingleThreadExecutor();
            executor.execute(() -> WxApiClient.sendTemplateMessage(tplMsg, mpAccount));
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }

    }

    @RequestMapping("/sendDoneByQu")
    @ResponseBody
    public String sendDoneByQu(@ModelAttribute TakeByQu takeByQu) {
        try {
            MpAccount mpAccount = WxMemoryCacheClient.getSingleMpAccount();//获取缓存中的唯一账号
            //改为已完成
            takeByQu.setState(3);
            takeByQuService.update(takeByQu);

            TemplateMessage tplMsg = new TemplateMessage();
            tplMsg.setOpenid(takeByQu.getOpenId());
            tplMsg.setUrl("http://www.wanxunkj.com/weChat/userInfo");
            tplMsg.setTemplateId("Vb-dzrV-UsNWeeH0mwh0JWkBYFTrv0Uus6M1SRXf6lk");
            Map<String, String> dataMap = new HashMap<>();
            dataMap.put("first", "您好,您的订单已完成\r\n");
            dataMap.put("keyword1", takeByQu.getId() + "\r\n");
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd HH:mm:ss");
            dataMap.put("keyword2", sdf.format(takeByQu.getCreateDate()) + "\r\n");
            dataMap.put("keyword3", sdf.format(new Date()) + "\r\n");
            dataMap.put("remark", "感谢您选择派客配送\r\n ");
            tplMsg.setDataMap(dataMap);
            Executor executor = Executors.newSingleThreadExecutor();
            executor.execute(() -> WxApiClient.sendTemplateMessage(tplMsg, mpAccount));
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            return "error";
        }
    }

    /**
     * 数据统计
     */
    @RequestMapping("datas")
    public ModelAndView datas(PageEntity pageEntity) {
        ModelAndView mv = new ModelAndView("admin/pake/datas");
        return mv;
    }

}