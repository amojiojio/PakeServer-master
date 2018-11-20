﻿<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset='utf-8'>
    <meta name="flexible" content="initial-dpr=1"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta name="description" content="不超过150个字符"/>
    <meta name="keywords" content=""/>
    <meta name="author" content="male"/>
    <meta name="robots" content="index,follow"/>
    <meta name="apple-mobile-web-app-title" content="派客">
    <meta name="apple-mobile-web-app-capable" content="yes"/>
    <meta name="apple-itunes-app" content="app-id=myAppStoreID, affiliate-data=myAffiliateData, app-argument=myURL">
    <meta name="apple-mobile-web-app-status-bar-style" content="black"/>
    <meta name="format-detection" content="telphone=no, email=no"/>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <meta name="HandheldFriendly" content="true">
    <meta name="MobileOptimized" content="320">
    <meta name="msapplication-tap-highlight" content="no">
    <meta name="msapplication-TileColor" content="#000"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, minimal-ui">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-barstyle" content="black-translucent">
    <meta name="mobile-web-app-capable" content="yes">
    <link rel="stylesheet" href="/resource/wechat/css/reset.css"/>
    <script type="text/javascript" charset="utf-8" src="/resource/wechat/js/flexible.js"></script>
    <script src="http://res.wx.qq.com/open/js/jweixin-1.1.0.js"></script>
    <title>代跑腿</title>
</head>
<body>
<form id="payform" class="buyIndex" name="payform" method="post"
      style="position:absolute;width:100%;height:100%;overflow:hidden;">
    <header class="w_title cr bor-b">
        <div class="title_l">
            <a href="javascript:;">
                <span><img src="/resource/wechat/images/logo_black.png" style="width: 100%;"></span>
            </a>
        </div>
        <div class="title_r">
            <a href="javascript:;">
                <span>${sessionScope.loginUser.nicknameStr}</span>
            </a>
        </div>
    </header>

    <div class="pageIndex " style="position:absolute;width:100%;height:100%;overflow:auto;">
        <section class="con">
            <div class="w_tag bor-b marbot10">
                <a href="#" class="tab_btn marbot20 on">随意购</a>
                <a href="#" class="tab_btn marbot20">代洗衣</a>
                <a href="#" class="tab_btn marbot20">买咖啡</a>
                <a href="#" class="tab_btn marbot20">买午饭</a>
                <a href="#" class="tab_btn">买早餐</a>
                <a href="#" class="tab_btn">买宵夜</a>
                <a href="#" class="tab_btn">买药品</a>
                <a href="#" class="tab_btn">买水果</a>
            </div>
            <div class="w_form">
                <div class="line_card area-card bor-b marbot10" id="FreeBuy">
                    <i class="icon icon_uu"></i>
                    <span class="card_l" id="tabTxt">随意购</span>
                    <textarea name="note" class="msgTxt font26 fl-1" id="Note" placeholder="填写购买的商品信息"></textarea>
                    <em class="msgN"></em>
                </div>

                <div class="line_card  bor-b link_buy marbot10" id="BuyPlace">
                    <div class="flex fl-1 fl-ali">
                        <i class="icon icon_locaL"></i>
                        <span class="card_l">购买地址</span>
                        <input type="text" name="startUserNote" class="card_c font26" id="S_Address_Con"
                               style="color:#b7b3b3" placeholder="请输入购买地址" value="${startAddress[0].startUserNote}">
                        <div class="card_tip">请确认附近2公里内有您需要的商品</div>
                    </div>
                    <div class="card_r" id="S_Con">
                        <i class="icon icon_right"></i>
                    </div>
                </div>
                <div class="line_card  bor-b link_rec marbot10" id="GetPlace">
                    <div class="flex fl-1 fl-ali">
                        <i class="icon icon_locaC"></i>
                        <span class="card_l">收货地址</span>
                        <input type="text" name="endUserNote" class="card_c font26" id="E_Address_Con"
                               style="color:#b7b3b3" placeholder="请输入收货地址" value="${endAddress[0].endUserNote}">
                    </div>
                    <div class="card_r" id="E_Con">
                        <i class="icon icon_right"></i>
                    </div>
                </div>
                <div class="pay_card" id="Name">
                    <div class="paybox flex fl-ali bor-b">
                        <i class="icon icon_menB"></i>
                        <div class="pay_r">
                            <input type="text" name="endUserName" class="pay_t font24" placeholder="请输入收货联系人姓名(选填)"
                                   id="T_UserName" maxlength="10" value="${endAddress[0].endUserName}">
                        </div>
                    </div>
                </div>
                <div class="pay_card" id="Phone">
                    <div class="paybox flex fl-ali bor-b">
                        <i class="icon icon_phoneC"></i>
                        <div class="pay_r">
                            <input type="text" name="endPhone" maxlength="20" class="pay_t font24"
                                   placeholder="请输入收货联系人电话" id="T_Phone" value="${endAddress[0].endPhone}">
                        </div>
                    </div>
                </div>

                <div class="line_card bor-b marbot10">
                    <div class="flex fl-1 fl-ali">
                        <i class="icon icon_point"></i>
                        <span class="font_c card_l">特殊要求</span>
                    </div>

                    <div class="card_r" id="Special">
                        <i class="icon icon_check check_on"></i>
                        <span class="check_on">需要保温箱</span>
                    </div>
                    <div class="card_r" id="near">
                        <i class="icon icon_check check_on" data-near="1"></i>
                        <span class="check_on">就近购买</span>
                    </div>
                </div>

                <div class="line_card  bor-b marbot10" id="GodsPrice">
                    <div class="flex fl-1 fl-ali">
                        <i class="icon icon_goodsprice"></i>
                        <span class="card_l">商品价格</span>
                    </div>
                    <div class="card_r">
                        <input class="card_input font26" type="number" pattern="[0-9]" id="GoodsMoney"
                               name="goodsMoney" placeholder="请输入商品金额"
                               oninput="if(value.length>4)value=value.slice(0,4)"
                               onkeydown="if(event.keyCode==13)event.keyCode=9"
                               onKeypress="if ((event.keyCode<48 || event.keyCode>57)) event.returnValue=false"> <span
                            class="card_tip">凭购物小票，线下支付</span>
                        <div id="KnowMoney" style="display:inline-block">
                            <i class="icon icon_check check_on"></i>
                            <span class="check_on">不知道价格</span>
                        </div>
                    </div>
                </div>

            </div>
            <div class="line_card  bor-b time_plug" style="margin-bottom:0">
                <div class="flex fl-1 fl-ali">
                    <i class="icon icon_time"></i>
                    <span class="font_c card_l">购买时间</span>
                    <input type="text" placeholder="请选择发货时间" readonly onfocus="this.blur()" value="立即购买（默认）"
                           class="card_c font26" style="width:auto;">
                    <input type="text" name="appDateTime" id="appDateTime"/>
                </div>
                <div class="concat_ibox time_plug">
                    <i class="icon icon_right concat_i"></i>
                </div>
            </div>

            <div class="w_size" id="submit" onclick="return dosubmit();">
                <a href="javascript:void(0);" class="next_btn " id="submitText">确认下单</a>
            </div>

            <div class="w_size">
                <div id="nowprice">
                    费 用 = 配送费(5元) + 商品费用<br/>
            </div>
        </section>
    </div>

    <div class="hide" id="S_address">

        <div class="page pagebuyP">
            <div class="addBox">
                <div class="Box_top">
                </div>
                <div class="p_tab">
                    <div class="tabbox bor-b">
                        <div class="tab2"><span class="checked">常用购买地址</span></div>
                    </div>
                    <div class="tabcon stored"  style="display: block;">

                        <c:forEach items="${startAddress}" var="address">
                            <div class="place_card bor-b" onclick="startAddress('${address.startUserNote}');">
                                <div class="place_r">
                                    <p></p>
                                    <p class="place_t AddressTitle">${address.startUserNote}</p>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>

        </div>
    </div>


    <div class="hide" id="E_address">

        <div class="page pagebuyP">
            <div class="addBox">
                <div class="Box_top">
                </div>
                <div class="p_tab">
                    <div class="tabbox bor-b">
                        <div class="tab2"><span class="checked">常用收货地址</span></div>
                    </div>
                    <div class="tabcon stored" style="display: block;">

                        <c:forEach items="${endAddress}" var="address">
                            <div class="place_card bor-b" onclick="endAddress('${address.endPhone}','${address.endUserNote}','${address.endUserName}')">
                                <div class="place_r">
                                    <p class="place_t AddressTitle">${address.endPhone}</p>
                                    <p class="place_b AddressNote">${address.endUserNote}</p>
                                </div>
                                <div class="collect">
                                        ${address.endUserName}
                                </div>
                            </div>
                        </c:forEach>

                    </div>
                </div>
            </div>

        </div>
    </div>

    <input id="GoodsType" name="goodsType" type="hidden" value="随意购"/>
    <input id="IsSubscribe" name="isSubscribe" type="hidden" value="0"/>
    <input id="SubscribeTime" name="subscribeTime" type="hidden"/>
    <input id="SendType" name="sendType" type="hidden" value="0"/>
    <input type="hidden" name="txtPrice" id="txtPrice" value=""/>
    <input id="KnowGoodMoney" name="KnowGoodMoney" type="hidden" value="1"/>
</form>

<script type="text/javascript" charset="utf-8" src="/resource/wechat/js/zepto.min.js"></script>
<script src="/resource/wechat/layer/layer.js" type="text/javascript" charset="utf-8"></script>
<script src="/resource/wechat/mobiscroll/js/mobiscroll.jq.min.js"></script>
<script src="/resource/wechat/mobiscroll/js/mobiscroll.core-2.5.2.js" type="text/javascript"></script>
<link href="/resource/wechat/mobiscroll/css/mobiscroll.core-2.5.2.css" rel="stylesheet" type="text/css"/>
<script src="/resource/wechat/mobiscroll/js/mobiscroll.datetime-2.5.1.js" type="text/javascript"></script>
<script src="/resource/wechat/mobiscroll/js/mobiscroll.datetime-2.5.1-zh.js" type="text/javascript"></script>
<script src="/resource/wechat/mobiscroll/js/mobiscroll.android-ics-2.5.2.js" type="text/javascript"></script>
<link href="/resource/wechat/mobiscroll/css/mobiscroll.android-ics-2.5.2.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" type="text/css" href="/resource/wechat/css/time_plug.css"/>
<script src="/resource/wechat/js/BuyIndex.js" type="text/javascript" charset="utf-8"></script>
<script src="/resource/wechat/js/common.js" type="text/javascript" charset="utf-8"></script>

</body>
</html>