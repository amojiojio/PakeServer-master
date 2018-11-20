package com.pk.server.admin.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.pk.server.admin.mapper.ApiLogDao;
import com.pk.server.admin.model.ApiLog;
import com.pk.server.admin.service.IApiLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class ApiLogServiceImpl implements IApiLogService {

    @Autowired
    private ApiLogDao apiLogDao;

    @Override
    public List<ApiLog> getlogByEntityToPage(int pageNum, int pageSize, ApiLog apiLog) {
        Page<ApiLog> page = PageHelper.startPage(pageNum, pageSize);
//     	PageHelper.orderBy("id desc");
        apiLogDao.findAll(apiLog);
        PageInfo<ApiLog> info = new PageInfo<ApiLog>(page);
        return info.getList();
    }

    @Override
    public void save(ApiLog apiLog) {
        apiLogDao.save(apiLog);
    }

    @Override
    public List<Map<String, String>> one() {
        return apiLogDao.one();
    }

    @Override
    public List<Map<String, String>> two(String method) {
        return apiLogDao.two(method);
    }

    @Override
    public List<Map<String, String>> three() {
        return apiLogDao.three();
    }


}
