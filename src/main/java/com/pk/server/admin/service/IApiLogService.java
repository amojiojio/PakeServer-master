package com.pk.server.admin.service;

import com.pk.server.admin.model.ApiLog;

import java.util.List;
import java.util.Map;

public interface IApiLogService {

    List<ApiLog> getlogByEntityToPage(int pageNum, int pageSize, ApiLog apiLog);

    void save(ApiLog apiLog);

    List<Map<String, String>> one();

    List<Map<String, String>> two(String method);

    List<Map<String, String>> three();

}