package com.pk.server.app.mapper;

import com.pk.server.app.model.TakeBySong;
import com.pk.server.wechat.core.page.PageEntity;

import java.util.List;

public interface ITakeBySongDao {

    void save(TakeBySong take);

    Integer getTotalItemsCount(TakeBySong take);

    List listForPageByPageEntity(TakeBySong take, PageEntity pageEntity);

    TakeBySong getOne(TakeBySong takeBySong);

    void update(TakeBySong takeBySong);
}
