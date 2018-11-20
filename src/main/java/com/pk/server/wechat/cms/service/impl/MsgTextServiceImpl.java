package com.pk.server.wechat.cms.service.impl;

import com.pk.server.wechat.api.process.MsgType;
import com.pk.server.wechat.cms.domain.MsgBase;
import com.pk.server.wechat.cms.domain.MsgText;
import com.pk.server.wechat.cms.mapper.MsgBaseDao;
import com.pk.server.wechat.cms.mapper.MsgTextDao;
import com.pk.server.wechat.cms.service.MsgTextService;
import com.pk.server.wechat.core.page.PageEntity;
import com.pk.server.wechat.core.page.Pagenation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;


@Service
public class MsgTextServiceImpl implements MsgTextService {

    @Autowired
    private MsgTextDao entityDao;

    @Autowired
    private MsgBaseDao baseDao;

    public MsgText getById(String id) {
        return entityDao.getById(id);
    }

    public MsgText getByBaseId(String baseId) {
        return entityDao.getByBaseId(baseId);
    }

    public List<MsgText> listForPage(MsgText searchEntity) {
        return entityDao.listForPage(searchEntity);
    }

    public void add(MsgText entity) {

        MsgBase base = new MsgBase();
        base.setInputcode(entity.getInputcode());
        base.setCreatetime(new Date());
        base.setMsgtype(MsgType.Text.toString());
        baseDao.add(base);

        entity.setBaseId(base.getId());
        entityDao.add(entity);
    }

    public void update(MsgText entity) {
        MsgBase base = baseDao.getById(entity.getBaseId().toString());
        base.setInputcode(entity.getInputcode());
        baseDao.updateInputcode(base);
        entityDao.update(entity);
    }

    public void delete(MsgText entity) {
        MsgBase base = new MsgBase();
        base.setId(entity.getBaseId());
        entityDao.delete(entity);
        baseDao.delete(entity);
    }

    //根据用户发送的文本消息，随机获取一条文本消息
    public MsgText getRandomMsg(String inputCode) {
        return entityDao.getRandomMsg(inputCode);
    }

    public MsgText getRandomMsg2() {
        return entityDao.getRandomMsg2();
    }

    @Override
    public Pagenation paginationEntity(MsgText searchEntity, PageEntity pageEntity) {
        // 算出所需数据的总条数
        Integer totalItemsCount = entityDao.getTotalItemsCount(searchEntity);
        // 通过（当前页、每页显示条数、总条数） 初始化分页信息
        Pagenation pagenation = new Pagenation(pageEntity.getPageSize(), pageEntity.getPageNum(), totalItemsCount);
        // 通过上步骤算出要查询的 开始条数，边set 到分页入参实体类中。
        pageEntity.setStartRow(pagenation.getStartRow());
        // 在查询 list 的时候，让传入的startRow 和 pageSize 作为limit 条件，添加至 sql。
        pagenation.setList(entityDao.listForPageByPageEntity(searchEntity, pageEntity));
        return pagenation;
    }
}

