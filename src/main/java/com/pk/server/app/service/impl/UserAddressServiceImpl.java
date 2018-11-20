package com.pk.server.app.service.impl;

import com.pk.server.app.mapper.IUserAddressDao;
import com.pk.server.app.model.UserAddress;
import com.pk.server.app.service.IUserAddressService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class UserAddressServiceImpl implements IUserAddressService {

    @Resource
    private IUserAddressDao userAddressDao;

    @Override
    public void save(UserAddress userAddress) {
        userAddressDao.save(userAddress);
    }

}
