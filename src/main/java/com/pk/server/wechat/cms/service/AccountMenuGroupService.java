package com.pk.server.wechat.cms.service;

import com.pk.server.wechat.cms.domain.AccountMenuGroup;
import com.pk.server.wechat.core.page.PageEntity;
import com.pk.server.wechat.core.page.Pagenation;

import java.util.List;


public interface AccountMenuGroupService {

    public AccountMenuGroup getById(String id);

    public List<AccountMenuGroup> list(AccountMenuGroup searchEntity);

    public Pagenation paginationEntity(AccountMenuGroup searchEntity, PageEntity pageEntity);

    public void add(AccountMenuGroup entity);

    public void update(AccountMenuGroup entity);

    public void delete(AccountMenuGroup entity);

    public Long getGid(String gname);

    public void updata(AccountMenuGroup menu);


}

