package com.pk.server.admin.model;

import java.io.Serializable;

/**
 * 用于日志处理对象
 *
 *
 */
public class ApiLog implements Serializable {
    private static final long serialVersionUID = 5454155825314635342L;
    //主键
    private String id;
    //请求地址
    private String url;
    //传入参数
    private String param;
    // 开始时间
    private long startTimeMillis;
    // 结束时间
    private long endTimeMillis;
    //耗时
    private long seTimeMillis;
    //返回码
    private String returnCode;
    //描述信息
    private String message;
    //是否成功
    private String isSuccess;
    //调用来源
    private String fromSource;
    //IP
    private String ip;
    //请求方式
    private String method;

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getParam() {
        return param;
    }

    public void setParam(String param) {
        this.param = param;
    }

    public long getStartTimeMillis() {
        return startTimeMillis;
    }

    public void setStartTimeMillis(long startTimeMillis) {
        this.startTimeMillis = startTimeMillis;
    }

    public long getEndTimeMillis() {
        return endTimeMillis;
    }

    public void setEndTimeMillis(long endTimeMillis) {
        this.endTimeMillis = endTimeMillis;
    }

    public long getSeTimeMillis() {
        return seTimeMillis;
    }

    public void setSeTimeMillis(long seTimeMillis) {
        this.seTimeMillis = seTimeMillis;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getIsSuccess() {
        return isSuccess;
    }

    public void setIsSuccess(String isSuccess) {
        this.isSuccess = isSuccess;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public String getMethod() {
        return method;
    }

    public void setMethod(String method) {
        this.method = method;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getReturnCode() {
        return returnCode;
    }

    public void setReturnCode(String returnCode) {
        this.returnCode = returnCode;
    }

    public String getFromSource() {
        return fromSource;
    }

    public void setFromSource(String fromSource) {
        this.fromSource = fromSource;
    }

    @Override
    public String toString() {
        return "请求地址：" + url + "   耗时：" + seTimeMillis + "ms   来源：" + fromSource + "   描述信息：" + message;
    }

}

