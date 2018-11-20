package com.pk.server.app.ctrl;

import com.pk.server.app.service.IRunService;
import com.pk.server.wechat.api.process.WxMemoryCacheClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 *
 * 微信公众号App核心控制器
 */
@Controller
@RequestMapping("/weChat")
public class AppCtrl {

    @Autowired
    private IRunService runService;

    /**
     * 收发件
     */
    @RequestMapping("take")
    public ModelAndView take(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView("weChat/take");
        return mv;
    }

    /**
     * 取
     */
    @RequestMapping("takeByQu")
    public ModelAndView takeByQu(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView("weChat/takeByQu");
        String openId = WxMemoryCacheClient.getOpenid(request.getSession().getId());
        List<Map<String,String>> endAddress = runService.getHistoryAddressByEnd(openId);
        mv.addObject("endAddress",endAddress);
        return mv;
    }

    /**
     * 送
     */
    @RequestMapping("takeBySong")
    public ModelAndView takeBySong(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView("weChat/takeBySong");
        String openId = WxMemoryCacheClient.getOpenid(request.getSession().getId());
        List<Map<String,String>> endAddress = runService.getHistoryAddressByEnd(openId);
        mv.addObject("endAddress",endAddress);
        return mv;
    }

    /**
     * 我要跑腿
     */
    @RequestMapping("run")
    public ModelAndView run(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView("weChat/run");
        String openId = WxMemoryCacheClient.getOpenid(request.getSession().getId());
        List<Map<String,String>> endAddress = runService.getHistoryAddressByEnd(openId);
        List<Map<String,String>> startAddress = runService.getHistoryAddressByStart(openId);
        mv.addObject("endAddress",endAddress);
        mv.addObject("startAddress",startAddress);
        return mv;
    }

    /**
     * 个人中心
     */
    @RequestMapping("userInfo")
    public ModelAndView userInfo(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView("weChat/userInfo");
        String openId = WxMemoryCacheClient.getOpenid(request.getSession().getId());
        List<Map<String,Object>> orders = runService.getOrderByOpenId(openId);
        List<Map<String,Object>> data = runService.num(openId);
        mv.addObject("data",data);
        mv.addObject("orders",orders);
        return mv;
    }

}
