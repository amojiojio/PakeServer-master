package com.pk.server.master.mybaitsLock.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 乐观锁注解 默认拦截所有update语句
 * 如果不需要乐观锁控制 在对应的Mapper接口上添加 @VersionLocker（false）
 *
 * @author WangJie
 */
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.METHOD})
public @interface VersionLocker {

    boolean value() default true;
}
