package com.pk.server.wechat.cms.ctrl;

import com.pk.server.wechat.cms.domain.MsgBase;
import com.pk.server.wechat.cms.domain.MsgNews;
import com.pk.server.wechat.cms.domain.MsgText;
import com.pk.server.wechat.cms.service.MsgBaseService;
import com.pk.server.wechat.cms.service.MsgNewsService;
import com.pk.server.wechat.cms.service.MsgTextService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

/**
 *
 */

@Controller
@RequestMapping("/msgbase")
public class MsgBaseCtrl {

    @Autowired
    private MsgBaseService entityService;

    @Autowired
    private MsgNewsService newsService;

    @Autowired
    private MsgTextService textService;

    @RequestMapping(value = "/getById")
    public ModelAndView getById(String id) {
        entityService.getById(id);
        return new ModelAndView();
    }

    @RequestMapping(value = "/listForPage")
    public ModelAndView listForPage(@ModelAttribute MsgBase searchEntity) {
        return new ModelAndView();
    }

    @RequestMapping(value = "/toMerge")
    public ModelAndView toMerge(MsgBase entity) {

        return new ModelAndView();
    }

    @RequestMapping(value = "/menuMsgs")
    public ModelAndView menuMsgs() {
        ModelAndView mv = new ModelAndView("wxcms/menuMsgs");
        //获取所有的图文消息;
        List<MsgNews> newsList = newsService.listForPage(new MsgNews());
        //获取所有的文本消息;
        List<MsgText> textList = textService.listForPage(new MsgText());
        mv.addObject("newsList", newsList);
        mv.addObject("textList", textList);
        return mv;
    }

    @RequestMapping(value = "/doMerge")
    public ModelAndView doMerge(MsgBase entity) {
        entityService.add(entity);
        return new ModelAndView();
    }

    @RequestMapping(value = "/delete")
    public ModelAndView delete(MsgBase entity) {
        entityService.delete(entity);
        return new ModelAndView();
    }


}