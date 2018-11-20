package com.pk.server.wechat.cms.service;

import com.pk.server.wechat.cms.domain.Account;

import java.util.List;


public interface AccountService {

    public Account getById(String id);

    public Account getByAccount(String account);

    public List<Account> listForPage(Account searchEntity);

    public void add(Account entity);

    public void update(Account entity);

    public void delete(Account entity);


}