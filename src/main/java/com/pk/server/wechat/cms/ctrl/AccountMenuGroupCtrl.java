package com.pk.server.wechat.cms.ctrl;

import com.pk.server.wechat.cms.domain.AccountMenuGroup;
import com.pk.server.wechat.cms.service.AccountMenuGroupService;
import com.pk.server.wechat.cms.service.AccountMenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;


/**
 *
 */

@Controller
@RequestMapping("/wxcms")
public class AccountMenuGroupCtrl {

    @Autowired
    private AccountMenuGroupService entityService;

    @Autowired
    private AccountMenuService menuService;

    @RequestMapping(value = "/getById")
    public ModelAndView getById(String id) {
        ModelAndView mv = new ModelAndView("admin/wxcms/accountMenuGroup");
        mv.addObject("entity", entityService.getById(id));
        return mv;
    }

    @RequestMapping(value = "/list")
    public ModelAndView list(AccountMenuGroup searchEntity) {
        ModelAndView mv = new ModelAndView("admin/wxcms/accountMenuGroupList");
        List<AccountMenuGroup> list = entityService.list(searchEntity);
        mv.addObject("list", list);
        return mv;
    }


}

