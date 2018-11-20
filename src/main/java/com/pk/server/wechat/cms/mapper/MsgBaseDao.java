package com.pk.server.wechat.cms.mapper;

import com.pk.server.wechat.cms.domain.MsgBase;
import com.pk.server.wechat.cms.domain.MsgNews;
import com.pk.server.wechat.cms.domain.MsgText;

import java.util.List;


public interface MsgBaseDao {

    public MsgBase getById(String id);

    public List<MsgBase> listForPage(MsgBase searchEntity);

    public List<MsgNews> listMsgNewsByBaseId(String[] ids);

    public MsgText getMsgTextByBaseId(String id);

    public MsgText getMsgTextBySubscribe();

    public MsgText getMsgTextByInputCode(String inputcode);

    public void add(MsgBase entity);

    public void update(MsgBase entity);

    public void updateInputcode(MsgBase entity);

    public void delete(MsgBase entity);

}