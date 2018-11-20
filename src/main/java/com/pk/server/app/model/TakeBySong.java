package com.pk.server.app.model;

import java.io.Serializable;
import java.util.Date;

public class TakeBySong implements Serializable {

    private String id;

    private String openId;
    //商品类型
    private String goodsType;
    //备注
    private String note;
    //取件地址
    private String endUserNote;
    //取件人
    private String endUserName;
    //取件电话
    private String endPhone;

    //是否预约收件 0 否 1 是
    private int isSubscribe;
    //预约时间
    private Date subscribeTime;
    //状态 1待接单 2已接单 3已完成
    private int state;

    //微信订单ID
    private String transactionId;

    //支付状态 0 未支付 1已支付
    private int payState;

    //快递单号
    private  String courierNumber;

    //快递公司
    private String courierCompany;

    private Date createDate;

    public String getTransactionId() {
        return transactionId;
    }

    public void setTransactionId(String transactionId) {
        this.transactionId = transactionId;
    }

    public int getPayState() {
        return payState;
    }

    public void setPayState(int payState) {
        this.payState = payState;
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

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getCourierNumber() {
        return courierNumber;
    }

    public void setCourierNumber(String courierNumber) {
        this.courierNumber = courierNumber;
    }

    public String getCourierCompany() {
        return courierCompany;
    }

    public void setCourierCompany(String courierCompany) {
        this.courierCompany = courierCompany;
    }
}
