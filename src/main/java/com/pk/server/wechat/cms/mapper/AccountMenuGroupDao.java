package com.pk.server.wechat.cms.mapper;

import com.pk.server.wechat.cms.domain.AccountMenuGroup;
import com.pk.server.wechat.core.page.PageEntity;

import java.util.List;


public interface AccountMenuGroupDao {

    public AccountMenuGroup getById(String id);

    public List<AccountMenuGroup> list(AccountMenuGroup searchEntity);

    public Integer getTotalItemsCount(AccountMenuGroup searchEntity);

    public List<AccountMenuGroup> listForPage(AccountMenuGroup searchEntity, PageEntity pageEntity);

    public void add(AccountMenuGroup entity);

    public void update(AccountMenuGroup entity);

    public void updateMenuGroupDisable();

    public void updateMenuGroupEnable(String gid);

    public void deleteAllMenu(AccountMenuGroup entity);

    public void delete(AccountMenuGroup entity);

    public Long getGid(String gname);

    public void updata(AccountMenuGroup menu);


}

