package com.pk.server.wechat.cms.ctrl;

import com.pk.server.wechat.cms.domain.AccountMenu;
import com.pk.server.wechat.cms.domain.AccountMenuGroup;
import com.pk.server.wechat.cms.domain.MsgNews;
import com.pk.server.wechat.cms.domain.MsgText;
import com.pk.server.wechat.cms.service.AccountMenuGroupService;
import com.pk.server.wechat.cms.service.AccountMenuService;
import com.pk.server.wechat.cms.service.MsgNewsService;
import com.pk.server.wechat.cms.service.MsgTextService;
import com.pk.server.wechat.core.page.PageEntity;
import com.pk.server.wechat.core.page.Pagenation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

/**
 *
 */

@Controller
@RequestMapping("/admin/accountmenu")
public class AccountMenuCtrl {

    @Autowired
    private AccountMenuService accountMenuService;

    @Autowired
    private MsgTextService textservice;

    @Autowired
    private MsgNewsService newsservice;

    @Autowired
    private AccountMenuGroupService groupService;


    /**
     * 查询菜单组
     *
     * @param searchEntity
     * @param pageEntity
     * @return
     */
    @RequestMapping("menuPagination")
    public ModelAndView menuPagination(AccountMenuGroup searchEntity, PageEntity pageEntity) {
        ModelAndView mv = new ModelAndView("admin/wxcms/accountMenuGroupPagination");
        Pagenation pagenation = groupService.paginationEntity(searchEntity, pageEntity);
        pagenation.setQueryUrl("menuPagination.action");
        mv.addObject("cur_nav", "weChat");
        mv.addObject("pagination", pagenation);
        return mv;
    }

    /**
     * 删除菜单组
     *
     * @param entity
     */
    @RequestMapping(value = "/deleteMenuGroup")
    @ResponseBody
    public String deleteMenuGroup(AccountMenuGroup accountMenuGroup) {
        try {
            groupService.delete(accountMenuGroup);
            return "success";
        } catch (Exception e) {
            return "error";
        }
    }

    /**
     * 去新增修改菜单名称
     *
     * @param menu
     * @return
     */
    @RequestMapping(value = "/toSaveOrUpdateMenuGroup")
    public ModelAndView toSaveOrUpdateMenuGroup(AccountMenuGroup accountMenuGroup) {
        ModelAndView mv = new ModelAndView("admin/wxcms/saveOrUpdateMenuGroup");
        if (accountMenuGroup.getId() != null) {
            mv.addObject("accountMenuGroup", groupService.getById(String.valueOf(accountMenuGroup.getId())));
        }
        return mv;
    }

    /**
     * 新增修改菜单组名称
     *
     * @param menu
     * @return
     */
    @RequestMapping(value = "/saveOrUpdateMenuGroup")
    @ResponseBody
    public String saveOrUpdateMenuGroup(AccountMenuGroup menu) {
        try {
            if (menu.getId() != null) {
                groupService.updata(menu);
            } else {
                groupService.add(menu);
            }
            return "success";
        } catch (Exception e) {
            return "error";
        }
    }

    /**
     * 查看菜单组菜单
     *
     * @param searchEntity
     * @return
     */
    @RequestMapping(value = "/accountMenus")
    public ModelAndView accountMenus(@ModelAttribute AccountMenu accountMenu) {
        ModelAndView modelAndView = new ModelAndView("admin/wxcms/accountMenus");
        List<AccountMenu> accountParentMenuList = accountMenuService.listParentMenu(accountMenu);
        List<AccountMenu> accountenuList = accountMenuService.list(accountMenu);
        modelAndView.addObject("accountMenuList", accountenuList);
        modelAndView.addObject("accountParentMenuList", accountParentMenuList);
        modelAndView.addObject("gid", accountMenu.getGid());
        modelAndView.addObject("cur_nav", "weChat");
        return modelAndView;
    }


    /**
     * 去修改或新增
     *
     * @param entity
     * @param id
     * @return
     */
    @RequestMapping(value = "/toSaveOrUpdate")
    public ModelAndView toSaveOrUpdate(AccountMenu accountMenu) {
        ModelAndView modelAndView = new ModelAndView("admin/wxcms/saveOrUpdateMenu");
        if (accountMenu.getId() != 0) {
            accountMenu = accountMenuService.getById(String.valueOf(accountMenu.getId()));
        }
        modelAndView.addObject("accountmenu", accountMenu);
        modelAndView.addObject("gid", accountMenu.getGid());
        return modelAndView;
    }


    /**
     * 修改或新增
     *
     * @param entity
     * @param id
     * @return
     */
    @RequestMapping(value = "/saveOrUpdate")
    @ResponseBody
    public void saveOrUpdate(AccountMenu accountMenu) {
        if (accountMenu.getId() == 0) {
            if (accountMenu.getParentid() == null) {
                accountMenu.setParentid((long) 0);
            }
            accountMenuService.add(accountMenu);
        } else {
            accountMenuService.update(accountMenu);
        }
    }


    @RequestMapping(value = "/delete")
    @ResponseBody
    public String delete(AccountMenu entity) {
        accountMenuService.delete(entity);
        return "success";
    }


    @RequestMapping(value = "/getById")
    public ModelAndView getById(String id) {
        accountMenuService.getById(id);
        return new ModelAndView();
    }


    @RequestMapping(value = "/toMerge")
    public ModelAndView toMerge(AccountMenu entity, Long gid) {
        ModelAndView modelAndView = new ModelAndView("admin/wxcms/menuMerge");
        if (gid != null) {
//			List<AccountMenu> list = accountMenuService.listParentMenu();
//			modelAndView.addObject("parentMenu", list);
            modelAndView.addObject("cur_nav", "menu");
            modelAndView.addObject("gid", gid);
        }
        return modelAndView;
    }

    @RequestMapping(value = "/doMerge")
    public ModelAndView doMerge(AccountMenu entity, String gname) {
        Long gid;
        String sgid = "";
        if (gname != "" && gname != null) {
            gid = groupService.getGid(gname);
            sgid = gid.toString();
            entity.setGid(gid);
            accountMenuService.add(entity);
        } else {
            gid = entity.getGid();
            sgid = gid.toString();
            entity.setGid(gid);
            accountMenuService.add(entity);
        }
//		return new ModelAndView("admin/wxcms/listMenu");
        return new ModelAndView("redirect:/accountmenu/list.html?gid=" + sgid);
    }


    @RequestMapping(value = "/doupdate")
    @ResponseBody
    public ModelAndView doupdate(AccountMenu entity, String id) {
        ModelAndView modelAndView = new ModelAndView("admin/wxcms/updateMenu");
        AccountMenu accountmenu = accountMenuService.getById(id);
        Long gid = accountmenu.getGid();
//		拿到上一级的id
        String string = accountmenu.getParentid().toString();
        //判断是否是一级菜单,如果不是一级菜单就进行赋值
        if (!(string.equals("0"))) {
            //通过这个id去拿到父id的name
            AccountMenu byId = accountMenuService.getById(string);
            if (byId != null) {
                String name = byId.getName();
                if (name != null) {
                    accountmenu.setParentName(name);
                }
            }

        }
        //拿到所有一级菜单
//			List<AccountMenu> list = accountMenuService.listParentMenu();
//		回显此id的菜单详情
//			modelAndView.addObject("parentMenu", list);
        modelAndView.addObject("accountmenu", accountmenu);
        modelAndView.addObject("cur_nav", "menu");
        modelAndView.addObject("gid", gid);

        return modelAndView;
    }

    @RequestMapping(value = "/selects")
    public ModelAndView selects(@ModelAttribute MsgText searchEntity, PageEntity pageEntity, @ModelAttribute MsgNews searchEntitys) {
        ModelAndView modelAndView = new ModelAndView("admin/wxcms/selects");
        Pagenation pagenation = textservice.paginationEntity(searchEntity, pageEntity);
        List<MsgNews> pageList = newsservice.listForPage(searchEntitys);
        modelAndView.addObject("pageList", pageList);
        modelAndView.addObject("pagination", pagenation);
        return modelAndView;
    }
}
