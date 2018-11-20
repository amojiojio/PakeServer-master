package com.pk.server.app.model;

import java.io.Serializable;
import java.util.Date;

public class Run implements Serializable {

    private String id;
    private String openId;

    //商品类型
    private String goodsType;

    //备注
    private String note;

    //购买地址
    private String startUserNote;

    //收货地址
    private String endUserNote;
    //收货人
    private String endUserName;
    //收货人电话
    private String endPhone;

    //商品价钱
    private String goodsMoney;

    //是否就近购买 0：否 1：是
    private int sendType;

    //是否立即购买 0 否 1 是
    private int isSubscribe;

    //购买时间
    private Date subscribeTime;

    //状态 1待接单 2已接单 3已完成
    private int state;

    //微信订单ID
    private String transactionId;

    //支付状态 0 未支付 1已支付
    private int payState;

    private Date createDate;

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getOpenId() {
        return openId;
    }

    public void setOpenId(String openId) {
        this.openId = openId;
    }

    public String getGoodsType() {
        return goodsType;
    }

    public void setGoodsType(String goodsType) {
        this.goodsType = goodsType;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public String getStartUserNote() {
        return startUserNote;
    }

    public void setStartUserNote(String startUserNote) {
        this.startUserNote = startUserNote;
    }

    public String getEndUserNote() {
        return endUserNote;
    }

    public void setEndUserNote(String endUserNote) {
        this.endUserNote = endUserNote;
    }

    public String getEndUserName() {
        return endUserName;
    }

    public void setEndUserName(String endUserName) {
        this.endUserName = endUserName;
    }

    public String getEndPhone() {
        return endPhone;
    }

    public void setEndPhone(String endPhone) {
        this.endPhone = endPhone;
    }

    public String getGoodsMoney() {
        return goodsMoney;
    }

    public void setGoodsMoney(String goodsMoney) {
        this.goodsMoney = goodsMoney;
    }

    public int getSendType() {
        return sendType;
    }

    public void setSendType(int sendType) {
        this.sendType = sendType;
    }

    public int getIsSubscribe() {
        return isSubscribe;
    }

    public void setIsSubscribe(int isSubscribe) {
        this.isSubscribe = isSubscribe;
    }

    public Date getSubscribeTime() {
        return subscribeTime;
    }

    public void setSubscribeTime(Date subscribeTime) {
        this.subscribeTime = subscribeTime;
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }

    public int getPayState() {
        return payState;
    }

    public void setPayState(int payState) {
        this.payState = payState;
    }

    public String getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(String transactionId) {
        this.transactionId = transactionId;
    }
}
