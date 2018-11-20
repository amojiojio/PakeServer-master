package com.pk.server.wechat.cms.service.impl;

import com.pk.server.wechat.cms.domain.AccountFans;
import com.pk.server.wechat.cms.mapper.AccountFansDao;
import com.pk.server.wechat.cms.service.AccountFansService;
import com.pk.server.wechat.core.page.PageEntity;
import com.pk.server.wechat.core.page.Pagenation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class AccountFansServiceImpl implements AccountFansService {

    @Autowired
    private AccountFansDao entityDao;

    public AccountFans getById(String id) {
        return entityDao.getById(id);
    }

    public AccountFans getByOpenId(String openId) {
        return entityDao.getByOpenId(openId);
    }

    public List<AccountFans> list(AccountFans searchEntity) {
        return entityDao.list(searchEntity);
    }


    public Pagenation paginationEntity(AccountFans searchEntity, PageEntity pageEntity) {
        // 算出所需数据的总条数
        Integer totalItemsCount = entityDao.getTotalItemsCount(searchEntity);
        // 通过（当前页、每页显示条数、总条数） 初始化分页信息
        Pagenation pagenation = new Pagenation(pageEntity.getPageSize(), pageEntity.getPageNum(), totalItemsCount);
        // 通过上步骤算出要查询的 开始条数，边set 到分页入参实体类中。
        pageEntity.setStartRow(pagenation.getStartRow());
        // 在查询 list 的时候，让传入的startRow 和 pageSize 作为limit 条件，添加至 sql。
        pagenation.setList(entityDao.listForPage(searchEntity, pageEntity));
        return pagenation;
    }

    public AccountFans getLastOpenId() {
        return entityDao.getLastOpenId();
    }

    public void sync(AccountFans searchEntity) {
        AccountFans lastFans = entityDao.getLastOpenId();
        if (lastFans != null) {
        }


    }

    public void add(AccountFans entity) {
        entityDao.add(entity);
    }

    public void update(AccountFans entity) {
        entityDao.update(entity);
    }

    public void delete(AccountFans entity) {
        entityDao.delete(entity);
    }

    public void deleteByOpenId(String openId) {
        entityDao.deleteByOpenId(openId);
    }

    @Override
    public AccountFans getByTokent(String tokent) {
        return entityDao.getByTokent(tokent);
    }

}