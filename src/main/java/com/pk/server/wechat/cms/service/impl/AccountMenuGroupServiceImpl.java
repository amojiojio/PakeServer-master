package com.pk.server.wechat.cms.service.impl;

import com.pk.server.wechat.cms.domain.AccountMenuGroup;
import com.pk.server.wechat.cms.mapper.AccountMenuGroupDao;
import com.pk.server.wechat.cms.service.AccountMenuGroupService;
import com.pk.server.wechat.core.page.PageEntity;
import com.pk.server.wechat.core.page.Pagenation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class AccountMenuGroupServiceImpl implements AccountMenuGroupService {

    @Autowired
    private AccountMenuGroupDao entityDao;

    public AccountMenuGroup getById(String id) {
        return entityDao.getById(id);
    }

    public List<AccountMenuGroup> list(AccountMenuGroup searchEntity) {
        return entityDao.list(searchEntity);
    }

    public Pagenation paginationEntity(AccountMenuGroup searchEntity, PageEntity pageEntity) {
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

    public void add(AccountMenuGroup entity) {
        entityDao.add(entity);
    }

    public void update(AccountMenuGroup entity) {
        entityDao.update(entity);
    }

    public void delete(AccountMenuGroup entity) {
        entityDao.deleteAllMenu(entity);
        entityDao.delete(entity);
    }

    @Override
    public Long getGid(String gname) {
        return entityDao.getGid(gname);

    }

    @Override
    public void updata(AccountMenuGroup menu) {
        // TODO Auto-generated method stub
        entityDao.updata(menu);
    }


}

