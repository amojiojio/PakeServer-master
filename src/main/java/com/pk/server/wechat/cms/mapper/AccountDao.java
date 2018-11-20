package com.pk.server.wechat.cms.mapper;

import com.pk.server.wechat.cms.domain.Account;

import java.util.List;


public interface AccountDao {

    public Account getById(String id);

    public Account getByAccount(String account);

    public Account getSingleAccount();

    public List<Account> listForPage(Account searchEntity);

    public void add(Account entity);

    public void update(Account entity);

    public void delete(Account entity);


}