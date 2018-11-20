package com.pk.server.app.service;

import com.pk.server.app.model.Run;
import com.pk.server.wechat.core.page.PageEntity;
import com.pk.server.wechat.core.page.Pagenation;

import java.util.List;
import java.util.Map;

public interface IRunService {

    void save(Run run);

    Pagenation findAll(Run run, PageEntity pageEntity);

    void delete(String id);

    Run getOne(Run run);

    void update(Run run);

    List<Map<String,String>> getHistoryAddressByEnd(String openId);

    List<Map<String,String>> getHistoryAddressByStart(String openId);

    List<Map<String,Object>> getOrderByOpenId(String openId);

    List<Map<String,Object>> num(String openId);
}
