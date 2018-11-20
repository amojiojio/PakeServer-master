package com.pk.server.wechat.cms.service;

import com.pk.server.wechat.cms.domain.AccountFans;
import com.pk.server.wechat.core.page.PageEntity;
import com.pk.server.wechat.core.page.Pagenation;

import java.util.List;


public interface AccountFansService {

    public AccountFans getById(String id);

    public AccountFans getByOpenId(String openId);

    public List<AccountFans> list(AccountFans searchEntity);

    public Pagenation paginationEntity(AccountFans accountFans, PageEntity pageEntity);

    public AccountFans getLastOpenId();

    public void sync(AccountFans searchEntity);

    public void add(AccountFans entity);

    public void update(AccountFans entity);

    public void delete(AccountFans entity);

    public void deleteByOpenId(String openId);

    public AccountFans getByTokent(String tokent);

}