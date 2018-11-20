package com.pk.server.wechat.cms.service.impl;

import com.pk.server.wechat.cms.domain.AccountMenu;
import com.pk.server.wechat.cms.mapper.AccountMenuDao;
import com.pk.server.wechat.cms.service.AccountMenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class AccountMenuServiceImpl implements AccountMenuService {

    @Autowired
    private AccountMenuDao entityDao;

    @Override
    public AccountMenu getById(String id) {
        return entityDao.getById(id);
    }

    @Override
    public List<AccountMenu> list(AccountMenu accountMenu) {
        return entityDao.list(accountMenu);
    }

    @Override
    public List<AccountMenu> listParentMenu(AccountMenu accountMenu) {
        return entityDao.listParentMenu(accountMenu);
    }

    @Override
    public void add(AccountMenu entity) {
        entityDao.add(entity);
    }

    @Override
    public void update(AccountMenu entity) {
        entityDao.update(entity);
    }

    @Override
    public void delete(AccountMenu entity) {
        entityDao.delete(entity);
    }


}