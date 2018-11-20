package com.pk.server.wechat.cms.service.impl;

import com.pk.server.wechat.cms.domain.MsgBase;
import com.pk.server.wechat.cms.mapper.MsgBaseDao;
import com.pk.server.wechat.cms.service.MsgBaseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class MsgBaseServiceImpl implements MsgBaseService {

    @Autowired
    private MsgBaseDao entityDao;

    public MsgBase getById(String id) {
        return entityDao.getById(id);
    }

    public List<MsgBase> listForPage(MsgBase searchEntity) {
        return entityDao.listForPage(searchEntity);
    }

    public void add(MsgBase entity) {
        entityDao.add(entity);
    }

    public void update(MsgBase entity) {
        entityDao.update(entity);
    }

    public void delete(MsgBase entity) {
        entityDao.delete(entity);
    }


}