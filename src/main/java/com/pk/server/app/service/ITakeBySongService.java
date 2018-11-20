package com.pk.server.app.service;

import com.pk.server.app.model.TakeBySong;
import com.pk.server.wechat.core.page.PageEntity;
import com.pk.server.wechat.core.page.Pagenation;

public interface ITakeBySongService {

    void save(TakeBySong take);

    Pagenation findAll(TakeBySong take, PageEntity pageEntity);

    TakeBySong getOne(TakeBySong takeBySong);

    void update(TakeBySong takeBySong);
}
