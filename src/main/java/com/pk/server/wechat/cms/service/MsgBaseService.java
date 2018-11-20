package com.pk.server.wechat.cms.service;

import com.pk.server.wechat.cms.domain.MsgBase;

import java.util.List;


public interface MsgBaseService {

    public MsgBase getById(String id);

    public List<MsgBase> listForPage(MsgBase searchEntity);

    public void add(MsgBase entity);

    public void update(MsgBase entity);

    public void delete(MsgBase entity);


}