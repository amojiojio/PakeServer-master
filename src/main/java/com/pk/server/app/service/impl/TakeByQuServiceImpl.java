package com.pk.server.app.service.impl;

import com.pk.server.app.mapper.ITakeByQuDao;
import com.pk.server.app.model.TakeByQu;
import com.pk.server.app.service.ITakeByQuService;
import com.pk.server.wechat.core.page.PageEntity;
import com.pk.server.wechat.core.page.Pagenation;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class TakeByQuServiceImpl implements ITakeByQuService {

    @Resource
    private ITakeByQuDao takeByQuDao;

    @Override
    public void save(TakeByQu takeByQu) {
        takeByQuDao.save(takeByQu);
    }

    @Override
    public Pagenation findAll(TakeByQu takeByQu, PageEntity pageEntity) {
        Integer totalItemsCount = takeByQuDao.getTotalItemsCount(takeByQu);
        Pagenation pagenation = new Pagenation(pageEntity.getPageSize(), pageEntity.getPageNum(), totalItemsCount);
        pageEntity.setStartRow(pagenation.getStartRow());
        pagenation.setList(takeByQuDao.listForPageByPageEntity(takeByQu,pageEntity));
        return pagenation;
    }

    @Override
    public TakeByQu getOne(TakeByQu takeByQu) {
        return takeByQuDao.getOne(takeByQu);
    }

    @Override
    public void update(TakeByQu takeByQu) {
        takeByQuDao.update(takeByQu);
    }

    @Override
    public void delete(String id) {
        takeByQuDao.delete(id);
    }
}
