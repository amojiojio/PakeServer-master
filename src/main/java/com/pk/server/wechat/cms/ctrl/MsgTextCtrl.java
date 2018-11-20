package com.pk.server.wechat.cms.ctrl;

import com.pk.server.wechat.cms.domain.MsgBase;
import com.pk.server.wechat.cms.domain.MsgText;
import com.pk.server.wechat.cms.service.MsgBaseService;
import com.pk.server.wechat.cms.service.MsgTextService;
import com.pk.server.wechat.core.page.PageEntity;
import com.pk.server.wechat.core.page.Pagenation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 *
 */

@Controller
@RequestMapping("/admin/msgtext")
public class MsgTextCtrl {

    @Autowired
    private MsgTextService entityService;

    @Autowired
    private MsgBaseService baseService;

    /**
     * 分页查询
     *
     * @param searchEntity
     * @param pageEntity
     * @return
     */
    @RequestMapping("textPagination")
    public ModelAndView list(@ModelAttribute MsgText searchEntity, PageEntity pageEntity) {
        ModelAndView mv = new ModelAndView("admin/wxcms/textPagination");
        Pagenation pagenation = entityService.paginationEntity(searchEntity, pageEntity);
        pagenation.setQueryUrl("textPagination.action");
        mv.addObject("cur_nav", "weChat");
        mv.addObject("pagination", pagenation);
        return mv;
    }

    @RequestMapping("saveOrUpdate")
    @ResponseBody
    public String saveOrUpdate(MsgText entity) {
        if (entity.getId() != null) {
            try {
                entityService.update(entity);
                return "success";
            } catch (Exception e) {
                return "error";
            }
        } else {
            try {
                entityService.add(entity);
                return "success";
            } catch (Exception e) {
                return "error";
            }
        }
    }


    @RequestMapping("toSaveOrUpdate")
    public ModelAndView toSaveOrUpdate(MsgText entity) {
        ModelAndView mv = new ModelAndView("admin/wxcms/saveOrUpdateText");
        if (entity.getId() != null) {
            MsgText text = entityService.getById(entity.getId().toString());
            mv.addObject("entity", text);
            mv.addObject("baseEntity", baseService.getById(text.getBaseId().toString()));
        } else {
            mv.addObject("entity", new MsgText());
            mv.addObject("baseEntity", new MsgBase());
        }
        return mv;
    }


    @RequestMapping(value = "/getById")
    public ModelAndView getById(String id) {
        entityService.getById(id);
        return new ModelAndView();
    }

    @RequestMapping("delete")
    @ResponseBody
    public String delete(MsgText entity) {
        try {
            entityService.delete(entity);
            return "success";
        } catch (Exception e) {
            return "error";
        }
    }
}

