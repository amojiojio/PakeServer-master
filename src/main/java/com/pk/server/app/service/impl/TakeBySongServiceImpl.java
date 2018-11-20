package com.pk.server.app.service.impl;

import com.pk.server.app.mapper.ITakeBySongDao;
import com.pk.server.app.model.TakeBySong;
import com.pk.server.app.service.ITakeBySongService;
import com.pk.server.wechat.core.page.PageEntity;
import com.pk.server.wechat.core.page.Pagenation;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class TakeBySongServiceImpl implements ITakeBySongService {

    @Resource
    private ITakeBySongDao takeBySongDao;

    @Override
    public void save(TakeBySong take) {
        takeBySongDao.save(take);
    }

    @Override
    public Pagenation findAll(TakeBySong take, PageEntity pageEntity) {
        Integer totalItemsCount = takeBySongDao.getTotalItemsCount(take);
        Pagenation pagenation = new Pagenation(pageEntity.getPageSize(), pageEntity.getPageNum(), totalItemsCount);
        pageEntity.setStartRow(pagenation.getStartRow());
        pagenation.setList(takeBySongDao.listForPageByPageEntity(take,pageEntity));
        return pagenation;
    }

    @Override
    public TakeBySong getOne(TakeBySong takeBySong) {
        return takeBySongDao.getOne(takeBySong);
    }

    @Override
    public void update(TakeBySong takeBySong) {
        takeBySongDao.update(takeBySong);
    }
}
