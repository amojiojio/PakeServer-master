package com.pk.server.admin.service.impl;

import com.pk.server.admin.mapper.AdminDao;
import com.pk.server.admin.model.Admin;
import com.pk.server.admin.service.IAdminService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class AdminServiceImpl implements IAdminService {

    @Autowired
    private AdminDao adminDao;


    @Override
    public boolean login(Admin admin) {
        Admin adminTem = adminDao.getAdmin(admin);
        if (adminTem != null && !"".equals(adminTem)) {
            return true;
        }
        return false;
    }

    @Override
    public List<Map<String,Integer>> one() {
        return adminDao.one();
    }

    @Override
    public List<Map<String, String>> two() {
        return adminDao.two();
    }

    @Override
    public List<Map<String, Integer>> index() {
        return adminDao.index();
    }

    @Override
    public List<Map<String, String>> three() {
        return adminDao.three();
    }

    @Override
    public List<Map<String, String>> four() {
        return adminDao.four();
    }

}
