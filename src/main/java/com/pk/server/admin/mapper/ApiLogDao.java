package com.pk.server.admin.mapper;

import com.pk.server.admin.model.ApiLog;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface ApiLogDao {

    /**
     * 查询全部接口日志记录
     *
     * @param appLog
     * @return
     */
    List<ApiLog> findAll(ApiLog apiLog);

    /**
     * 保存日志记录
     *
     * @param apiLog
     */
    void save(ApiLog apiLog);

    /**
     * 删除日志记录（根据主键）
     *
     * @param apiLog
     */
    void delete(ApiLog apiLog);

    /**
     * 更新日志记录（根据主键）
     *
     * @param apiLog
     */
    void update(ApiLog apiLog);

    List<Map<String, String>> one();

    List<Map<String, String>> two(@Param("method") String method);

    List<Map<String, String>> three();
}
