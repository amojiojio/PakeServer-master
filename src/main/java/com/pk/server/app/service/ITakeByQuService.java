package com.pk.server.app.service;

import com.pk.server.app.model.TakeByQu;
import com.pk.server.wechat.core.page.PageEntity;
import com.pk.server.wechat.core.page.Pagenation;

public interface ITakeByQuService {

    void save(TakeByQu take);

    Pagenation findAll(TakeByQu take, PageEntity pageEntity);

    TakeByQu getOne(TakeByQu takeBySong);

    void update(TakeByQu takeBySong);

    void delete(String id);
}
