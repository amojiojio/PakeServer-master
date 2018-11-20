package com.pk.server.wechat.cms;

import com.pk.server.wechat.api.process.WxMemoryCacheClient;
import com.pk.server.wechat.cms.domain.Account;
import com.pk.server.wechat.cms.mapper.AccountDao;
import com.pk.server.wechat.core.spring.SpringBeanDefineService;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * 系统启动时自动加载，把公众号信息加入到缓存中
 */
public class AppDefineInitService implements SpringBeanDefineService {

    @Autowired
    private AccountDao accountDao;

    public void initApplicationCacheData() {
        Account account = accountDao.getSingleAccount();
        WxMemoryCacheClient.addMpAccount(account);
    }

}
