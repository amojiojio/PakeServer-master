package com.pk.server.app.service.impl;

import com.pk.server.app.mapper.IRunDao;
import com.pk.server.app.model.Run;
import com.pk.server.app.service.IRunService;
import com.pk.server.wechat.core.page.PageEntity;
import com.pk.server.wechat.core.page.Pagenation;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service
public class RunServiceImpl implements IRunService {

    @Resource
    private IRunDao runDao;

    @Override
    public void save(Run run) {
        runDao.save(run);
    }

    @Override
    public Pagenation findAll(Run run,PageEntity pageEntity) {
        Integer totalItemsCount = runDao.getTotalItemsCount(run);
        Pagenation pagenation = new Pagenation(pageEntity.getPageSize(), pageEntity.getPageNum(), totalItemsCount);
        pageEntity.setStartRow(pagenation.getStartRow());
        pagenation.setList(runDao.listForPageByPageEntity(run,pageEntity));
        return pagenation;
    }

    @Override
    public void delete(String id) {
        runDao.delete(id);
    }

    @Override
    public Run getOne(Run run) {
        return runDao.getOne(run);
    }

    @Override
    public void update(Run run) {
        runDao.update(run);
    }

    @Override
    public List<Map<String, String>> getHistoryAddressByStart(String openId) {
        return runDao.getHistoryAddressByStart(openId);
    }

    @Override
    public List<Map<String, Object>> getOrderByOpenId(String openId) {
        return runDao.getOrderByOpenId(openId);
    }

    @Override
    public List<Map<String, Object>> num(String openId) {
        return runDao.num(openId);
    }

    @Override
    public List<Map<String, String>> getHistoryAddressByEnd(String openId) {
        return runDao.getHistoryAddressByEnd(openId);
    }
}
