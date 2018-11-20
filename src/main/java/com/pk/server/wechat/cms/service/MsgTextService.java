package com.pk.server.wechat.cms.service;

import com.pk.server.wechat.cms.domain.MsgText;
import com.pk.server.wechat.core.page.PageEntity;
import com.pk.server.wechat.core.page.Pagenation;

import java.util.List;

public interface MsgTextService {

    public MsgText getById(String id);

    public MsgText getByBaseId(String baseId);

    public List<MsgText> listForPage(MsgText searchEntity);

    public void add(MsgText entity);

    public void update(MsgText entity);

    public void delete(MsgText entity);

    //根据用户发送的文本消息，随机获取一条文本消息
    public MsgText getRandomMsg(String inputcode);

    public MsgText getRandomMsg2();

    public Pagenation paginationEntity(MsgText searchEntity, PageEntity pageEntity);

}
