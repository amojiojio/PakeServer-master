package com.pk.server.wechat.cms.ctrl;

import com.pk.server.wechat.cms.domain.AccountFans;
import com.pk.server.wechat.cms.service.AccountFansService;
import com.pk.server.wechat.core.page.PageEntity;
import com.pk.server.wechat.core.page.Pagenation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * 粉丝管理控制器
 */
@Controller
@RequestMapping("/admin/accountfans")
public class AccountFansCtrl {

    @Autowired
    private AccountFansService entityService;

    @RequestMapping(value = "/fansPagination")
    public ModelAndView paginationEntity(AccountFans accountFans, PageEntity pageEntity) {
        ModelAndView mv = new ModelAndView("admin/wxcms/fansPagination");
        Pagenation pagenation = entityService.paginationEntity(accountFans, pageEntity);
        pagenation.setQueryUrl("fansPagination.action");
        mv.addObject("cur_nav", "weChat");
        mv.addObject("pagination", pagenation);
        return mv;
    }

}