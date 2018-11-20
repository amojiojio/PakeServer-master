package com.pk.server.wechat.cms.mapper;

import com.pk.server.wechat.cms.domain.AccountFans;
import com.pk.server.wechat.core.page.PageEntity;
import org.apache.ibatis.annotations.Param;

import java.util.List;


public interface AccountFansDao {

    public AccountFans getById(String id);

    public AccountFans getByOpenId(String openId);

    public List<AccountFans> list(AccountFans searchEntity);

    public Integer getTotalItemsCount(AccountFans searchEntity);

    public List<AccountFans> listForPage(AccountFans searchEntity, PageEntity pageEntity);

    public AccountFans getLastOpenId();

    public void add(AccountFans entity);

    public void addList(List<AccountFans> list);

    public void update(AccountFans entity);

    public void delete(AccountFans entity);

    public void deleteByOpenId(String openId);

    public void updateToState(String fromUserName);

    public AccountFans getByTokent(@Param("tokent") String tokent);

}