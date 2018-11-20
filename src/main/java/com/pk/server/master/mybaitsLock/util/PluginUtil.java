package com.pk.server.master.mybaitsLock.util;

import org.apache.ibatis.reflection.MetaObject;
import org.apache.ibatis.reflection.SystemMetaObject;

import java.lang.reflect.Proxy;

public final class PluginUtil {

    private PluginUtil() {
    }

    public static Object processTarget(Object target) {
        if (Proxy.isProxyClass(target.getClass())) {
            MetaObject mo = SystemMetaObject.forObject(target);
            return processTarget(mo.getValue("h.target"));
        }
        return target;
    }

}
