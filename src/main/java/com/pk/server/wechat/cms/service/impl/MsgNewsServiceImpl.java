package com.pk.server.wechat.cms.service.impl;

import com.pk.server.wechat.api.process.MsgType;
import com.pk.server.wechat.cms.domain.MsgBase;
import com.pk.server.wechat.cms.domain.MsgNews;
import com.pk.server.wechat.cms.mapper.MsgBaseDao;
import com.pk.server.wechat.cms.mapper.MsgNewsDao;
import com.pk.server.wechat.cms.service.MsgNewsService;
import com.pk.server.wechat.core.page.PageEntity;
import com.pk.server.wechat.core.page.Pagenation;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;


@Service
public class MsgNewsServiceImpl implements MsgNewsService {

    @Autowired
    private MsgBaseDao baseDao;

    @Autowired
    private MsgNewsDao entityDao;

    public MsgNews getById(String id) {
        return entityDao.getById(id);
    }
	
	/*public List<MsgNews> listForPage(MsgNews searchEntity){
		return entityDao.listForPage(searchEntity);
	}*/


    public void add(MsgNews entity) {

        MsgBase base = new MsgBase();
        base.setInputcode(entity.getInputcode());
        base.setCreatetime(new Date());
        base.setMsgtype(MsgType.News.toString());
        baseDao.add(base);

        entity.setBaseId(base.getId());
        entityDao.add(entity);

        if (StringUtils.isEmpty(entity.getFromurl())) {
            entity.setUrl(entity.getUrl() + "?id=" + entity.getId());
        } else {
            entity.setUrl("");
        }

        entityDao.updateUrl(entity);
    }

    public void update(MsgNews entity) {
        MsgBase base = baseDao.getById(entity.getBaseId().toString());
        base.setInputcode(entity.getInputcode());
        baseDao.updateInputcode(base);

        if (StringUtils.isEmpty(entity.getFromurl())) {
            entity.setUrl(entity.getUrl() + "?id=" + entity.getId());
        } else {
            entity.setUrl("");
        }

        entityDao.update(entity);
    }

    public void delete(MsgNews entity) {
        MsgBase base = new MsgBase();
        base.setId(entity.getBaseId());
        baseDao.delete(base);
        entityDao.delete(entity);
    }

    public List<MsgNews> getRandomMsg(String inputCode, Integer num) {
        return entityDao.getRandomMsgByContent(inputCode, num);
    }

    public Pagenation paginationEntity(MsgNews searchEntity, PageEntity pageEntity) {
        // 算出所需数据的总条数
        Integer totalItemsCount = entityDao.getTotalItemsCount(searchEntity);
        // 通过（当前页、每页显示条数、总条数） 初始化分页信息
        Pagenation pagenation = new Pagenation(pageEntity.getPageSize(), pageEntity.getPageNum(), totalItemsCount);
        // 通过上步骤算出要查询的 开始条数，边set 到分页入参实体类中。
        pageEntity.setStartRow(pagenation.getStartRow());
        // 在查询 list 的时候，让传入的startRow 和 pageSize 作为limit 条件，添加至 sql。
        pagenation.setList(entityDao.listForPages(searchEntity, pageEntity));
        return pagenation;
    }

    @Override
    public List<MsgNews> listForPage(MsgNews searchEntity) {
        // TODO Auto-generated method stub
        return null;
    }


}
