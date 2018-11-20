package com.pk.server.wechat.cms.ctrl;

import com.pk.server.wechat.cms.domain.MsgBase;
import com.pk.server.wechat.cms.domain.MsgNews;
import com.pk.server.wechat.cms.service.MsgBaseService;
import com.pk.server.wechat.cms.service.MsgNewsService;
import com.pk.server.wechat.core.page.PageEntity;
import com.pk.server.wechat.core.page.Pagenation;
import com.pk.server.wechat.core.spring.SpringFreemarkerContextPathUtil;
import com.pk.server.wechat.core.util.UploadUtil;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

/**
 *
 */

@Controller
@RequestMapping("/admin/msgnews")
public class MsgNewsCtrl {

    @Autowired
    private MsgNewsService entityService;

    @Autowired
    private MsgBaseService baseService;


    @RequestMapping(value = "/getById")
    public ModelAndView getById(String id) {
        entityService.getById(id);
        return new ModelAndView();
    }

    @RequestMapping("msgNewsPagination")
    public ModelAndView listMsg(@ModelAttribute MsgNews searchEntity, PageEntity pageEntity) {
        ModelAndView mv = new ModelAndView("admin/wxcms/msgNewsPagination");
        Pagenation pagenation = entityService.paginationEntity(searchEntity, pageEntity);
        pagenation.setQueryUrl("msgNewsPagination.action");
        mv.addObject("cur_nav", "weChat");
        mv.addObject("pagination", pagenation);
        return mv;
    }

    @RequestMapping("toMerge")
    public ModelAndView toMerge(MsgNews entity) {
        ModelAndView mv = new ModelAndView("admin/wxcms/saveOrUpdateMsgNews");
        mv.addObject("cur_nav", "weChat");
        if (entity.getId() != null) {
            MsgNews news = entityService.getById(entity.getId().toString());
            mv.addObject("entity", news);
            mv.addObject("baseEntity", baseService.getById(news.getBaseId().toString()));
        } else {
            mv.addObject("entity", new MsgNews());
            mv.addObject("baseEntity", new MsgBase());
        }
        return mv;
    }

    @RequestMapping("doMerge")
    public ModelAndView doMerge(HttpServletRequest request, MsgNews entity, @RequestParam(value = "imageFile", required = false) MultipartFile file) {
        String contextPath = SpringFreemarkerContextPathUtil.getBasePath(request);
        String url = request.getScheme() + "://" + request.getServerName() + contextPath;
        String realPath = request.getSession().getServletContext().getRealPath("/");
        if (file != null && file.getSize() > 0) {
            String tmpPath = UploadUtil.doUpload(realPath, file);//上传文件，上传文件到 /res/upload/ 下
            entity.setPicpath(url + tmpPath);
        } else {
            if (entity.getId() != null) {//更新
                entity.setPicpath(entityService.getById(entity.getId().toString()).getPicpath());
            }
        }

        if (!StringUtils.isEmpty(entity.getFromurl())) {
            String fromUrl = entity.getFromurl();
            if (!fromUrl.startsWith("http://")) {
                entity.setFromurl("http://" + fromUrl);
            }
        } else {
            entity.setUrl(url + "/wxweb/msg/newsread");//设置微信访问的url
        }

        if (entity.getId() != null) {//跟新
            entityService.update(entity);
        } else {
            entityService.add(entity);
        }
        return new ModelAndView("redirect:/msgnews/listMsg.action");
    }

    @RequestMapping("deleteMsg")
    @ResponseBody
    public void delete(MsgNews entity) {
        entityService.delete(entity);
    }
}