package com.pk.server.master.mybaitsLock.cache;

import com.pk.server.master.mybaitsLock.annotation.VersionLocker;
import org.apache.ibatis.logging.Log;
import org.apache.ibatis.logging.LogFactory;

import java.util.concurrent.ConcurrentHashMap;

public class LocalVersionLockerCache implements VersionLockerCache {

    private static final Log log = LogFactory.getLog(LocalVersionLockerCache.class);
    private ConcurrentHashMap<String, ConcurrentHashMap<VersionLockerCache.MethodSignature, VersionLocker>> caches = new ConcurrentHashMap<>();

    @Override
    public boolean containMethodSignature(MethodSignature vm) {
        String nameSpace = getNameSpace(vm);
        ConcurrentHashMap<VersionLockerCache.MethodSignature, VersionLocker> cache = caches.get(nameSpace);
        if (null == cache || cache.isEmpty()) {
            return false;
        }
        boolean containsMethodSignature = cache.containsKey(vm);
        if (containsMethodSignature && log.isDebugEnabled()) {
            log.debug("The method " + nameSpace + vm.getId() + "is hit in cache.");
        }
        return containsMethodSignature;
    }

    // 这里去掉synchronized或者重入锁，因为这里的操作满足幂等性
    // Here remove synchronized keyword or ReentrantLock, because it's a idempotent operation
    @Override
    public void cacheMethod(VersionLockerCache.MethodSignature vm, VersionLocker locker) {
        String nameSpace = getNameSpace(vm);
        ConcurrentHashMap<VersionLockerCache.MethodSignature, VersionLocker> cache = caches.get(nameSpace);
        if (null == cache || cache.isEmpty()) {
            cache = new ConcurrentHashMap<>();
            cache.put(vm, locker);
            caches.put(nameSpace, cache);
            if (log.isDebugEnabled()) {
                log.debug("Locker debug info ==> " + nameSpace + ": " + vm.getId() + " is cached.");
            }
        } else {
            cache.put(vm, locker);
        }
    }

    @Override
    public VersionLocker getVersionLocker(VersionLockerCache.MethodSignature vm) {
        String nameSpace = getNameSpace(vm);
        ConcurrentHashMap<VersionLockerCache.MethodSignature, VersionLocker> cache = caches.get(nameSpace);
        if (null == cache || cache.isEmpty()) {
            return null;
        }
        return cache.get(vm);
    }

    private String getNameSpace(VersionLockerCache.MethodSignature vm) {
        String id = vm.getId();
        int pos = id.lastIndexOf(".");
        return id.substring(0, pos);
    }

}
