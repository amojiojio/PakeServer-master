package com.pk.server.wechat.cms.service;

import com.pk.server.wechat.cms.domain.AccountMenu;

import java.util.List;


public interface AccountMenuService {

    public AccountMenu getById(String id);

    public List<AccountMenu> list(AccountMenu accountMenu);

    public List<AccountMenu> listParentMenu(AccountMenu accountMenu);

    public void add(AccountMenu entity);

    public void update(AccountMenu entity);

    public void delete(AccountMenu entity);


}