package com.pk.server.wechat.cms.ctrl;

import com.pk.server.wechat.api.process.WxMemoryCacheClient;
import com.pk.server.wechat.cms.domain.MsgNews;
import com.pk.server.wechat.cms.service.MsgNewsService;
import com.pk.server.wechat.core.util.HttpRequestDeviceUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

/**
 * 手机微信页面
 */
@Controller
@RequestMapping("/wxweb")
public class WxWebCtrl {

    @Autowired
    private MsgNewsService msgNewsService;

    @RequestMapping(value = "/msg/newsread")
    public ModelAndView newsread(HttpServletRequest request, String id) {
        ModelAndView mv = new ModelAndView("admin/wxcms/newsread");
        MsgNews news = msgNewsService.getById(id);
        System.out.println(news.getPicpath());
        mv.addObject("news", news);
        if (!HttpRequestDeviceUtils.isMobileDevice(request)) {
            return mv;
        }
        return mv;
    }

    @RequestMapping(value = "/msg/newsList")
    public ModelAndView pageWebNewsList(HttpServletRequest request, MsgNews searchEntity) {
        ModelAndView mv = new ModelAndView("wxweb/mobileNewsList");
//		List<MsgNewsVO> pageList = msgNewsService.pageWebNewsList(searchEntity,page);
//		mv.addObject("pageList", pageList);
        return mv;
    }

    @RequestMapping(value = "/jssdk")
    public ModelAndView jssdk(HttpServletRequest request, String api) {
        ModelAndView mv = new ModelAndView("wxweb/jssdk");
        if (!StringUtils.isBlank(api)) {
            mv.addObject("api", api);
        }
        return mv;
    }

    @RequestMapping(value = "/sendmsg")
    public ModelAndView sendmsg(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView("wxweb/sendmsg");
        //拦截器已经处理了缓存,这里直接取
        String openid = WxMemoryCacheClient.getOpenid(request.getSession().getId());
        mv.addObject("openid", openid);
        return mv;
    }

    @RequestMapping(value = "/weui")
    public ModelAndView weui(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView("wxweb/weui");
        //拦截器已经处理了缓存,这里直接取
        String openid = WxMemoryCacheClient.getOpenid(request.getSession().getId());
        mv.addObject("openid", openid);
        return mv;
    }

}

