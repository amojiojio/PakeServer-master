package com.pk.server.wechat.cms.mapper;

import com.pk.server.wechat.cms.domain.MsgText;
import com.pk.server.wechat.core.page.PageEntity;

import java.util.List;


public interface MsgTextDao {

    public MsgText getById(String id);

    public MsgText getByBaseId(String baseId);

    public List<MsgText> listForPage(MsgText searchEntity);

    public void add(MsgText entity);

    public void update(MsgText entity);

    public void delete(MsgText entity);

    public MsgText getRandomMsg(String inputCode);

    public MsgText getRandomMsg2();

    public Integer getTotalItemsCount(MsgText searchEntity);

    public List<MsgText> listForPageByPageEntity(MsgText searchEntity, PageEntity pageEntity);


}