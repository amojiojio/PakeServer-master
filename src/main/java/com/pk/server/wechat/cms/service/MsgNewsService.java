package com.pk.server.wechat.cms.service;

import com.pk.server.wechat.cms.domain.MsgNews;
import com.pk.server.wechat.core.page.PageEntity;
import com.pk.server.wechat.core.page.Pagenation;

import java.util.List;


public interface MsgNewsService {

    public MsgNews getById(String id);

    public List<MsgNews> listForPage(MsgNews searchEntity);

    //public Pagenation paginationEntity(MsgNewsVO searchEntity ,PageEntity pageEntity);

    public void add(MsgNews entity);

    public void update(MsgNews entity);

    public void delete(MsgNews entity);

    public Pagenation paginationEntity(MsgNews msgNews, PageEntity pageEntity);

    //根据用户发送的文本消息，随机获取 num 条文本消息
    public List<MsgNews> getRandomMsg(String inputcode, Integer num);

}