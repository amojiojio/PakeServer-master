package com.pk.server.app.mapper;

import com.pk.server.app.model.TakeByQu;
import com.pk.server.wechat.core.page.PageEntity;

import java.util.List;

public interface ITakeByQuDao {

    void save(TakeByQu takeByQu);

    Integer getTotalItemsCount(TakeByQu takeByQu);

    List listForPageByPageEntity(TakeByQu takeByQu, PageEntity pageEntity);

    TakeByQu getOne(TakeByQu takeByQu);

    void update(TakeByQu takeByQu);

    void delete(String id);
}
