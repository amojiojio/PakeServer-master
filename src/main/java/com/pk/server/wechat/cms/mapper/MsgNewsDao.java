package com.pk.server.wechat.cms.mapper;

import com.pk.server.wechat.cms.domain.MsgNews;
import com.pk.server.wechat.core.page.PageEntity;

import java.util.List;


public interface MsgNewsDao {
    public int getTotalItemsCount(MsgNews eNews);

    public MsgNews getById(String id);

    public List<MsgNews> listForPage(MsgNews searchEntity);

    public List<MsgNews> listForPages(MsgNews msgNews, PageEntity pageEntity);

    public void add(MsgNews entity);

    public void update(MsgNews entity);

    public void updateUrl(MsgNews entity);

    public void delete(MsgNews entity);

    public List<MsgNews> getRandomMsg(Integer num);

    public List<MsgNews> getRandomMsgByContent(String inputcode, Integer num);

    public List<MsgNews> getMsgNewsByIds(String[] array);

}