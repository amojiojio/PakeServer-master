<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
    <script src="https://res.wx.qq.com/open/js/jweixin-1.0.0.js" type="text/javascript"></script>
    <title>我的派客</title>
</head>
<body>

<div class="pageIndex " style="position:absolute;width:100%;height:100%;overflow:auto;">
        <div class="side_bar pageMydide" style="">

            <div class="sidebox" style="width: 100%; left: 0px;">
                <div class="head signed">
                    <div class="headtop">
                        <div class="headpic">
                            <img src="${sessionScope.loginUser.headimgurl}">
                        </div>
                        <div class="name">
                            <h1><span class="username">${sessionScope.loginUser.nicknameStr}</span></h1>
                        </div>
                    </div>
                    <div class="headbot">
                        <div class="notice">
                            <div class="noticeR">
                                    <p class="top">${data[0].num}</p>
                                    <p class="down">跑腿订单</p>
                            </div>
                            <div class="noticeR">
                                    <p class="top">${data[1].num}</p>
                                    <p class="down">收发件记录</p>
                            </div>
                            <img class="side_dotte" src="/resource/wechat/images/side_dotte.png">
                        </div>
                    </div>
                </div>


                <c:forEach items="${orders}" var="order">
                    <div class="sidecon sidecon1 bor-b">
                        <a href="#" class="side_card flex fl-1 fl-ali bor-b">
                            <div class="flex fl-1 fl-ali">
                                <i class="icon aside_quan"></i>
                                <p>&nbsp;&nbsp;订单号码：${order.id}</p>
                            </div>
                            <i class="icon icon_right"></i>&nbsp;&nbsp;
                            <c:if test="${order.state==1}"><td>待接单</td></c:if>
                            <c:if test="${order.state==2}"><td>已接单</td></c:if>
                            <c:if test="${order.state==3}"><td>已完成</td></c:if>
                        </a>
                        <div class="fl-1 fl-ali">
                            <p></p>
                            <p>联系人：${order.endUserName}</p>
                            <p>联系电话：${order.endPhone}</p>
                            <p>地址：${order.endUserNote}</p>
                            <p>订单时间： <fmt:formatDate value="${order.createDate}" pattern="yyyy/MM/dd HH:mm:ss"/></p>
                        </div>
                    </div>
                </c:forEach>

            </div>

        </div>

</div>


<script type="text/javascript" charset="utf-8" src="/resource/wechat/js/zepto.min.js"></script>
<script src="/resource/wechat/layer/layer.js" type="text/javascript" charset="utf-8"></script>
<script src="/resource/wechat/js/solve.js?ver=33" type="text/javascript" charset="utf-8"></script>
<script src="/resource/wechat/mobiscroll/js/mobiscroll.jq.min.js"></script>
<script src="/resource/wechat/mobiscroll/js/mobiscroll.core-2.5.2.js" type="text/javascript"></script>
<link href="/resource/wechat/mobiscroll/css/mobiscroll.core-2.5.2.css" rel="stylesheet" type="text/css"/>
<script src="/resource/wechat/mobiscroll/js/mobiscroll.datetime-2.5.1.js" type="text/javascript"></script>
<script src="/resource/wechat/mobiscroll/js/mobiscroll.datetime-2.5.1-zh.js" type="text/javascript"></script>
<script src="/resource/wechat/mobiscroll/js/mobiscroll.android-ics-2.5.2.js" type="text/javascript"></script>
<link href="/resource/wechat/mobiscroll/css/mobiscroll.android-ics-2.5.2.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" type="text/css" href="/resource/wechat/css/time_plug.css"/>
<script src="/resource/wechat/js/common.js" type="text/javascript" charset="utf-8"></script>

<script>
    $(function () {
        var url = location.href.split('#')[0];
        $.ajax({
            url: '${pageContext.request.contextPath}/wxapi/jsTicket.html',
            type: 'post',
            data: {url: url},
            dataType: 'json',
            success: function (data) {
                var errcode = data.errcode;
                var sign = data.data;
                if (errcode == 0) {
                    wx.config({
                        debug: false,
                        appId: sign.appId,
                        timestamp: sign.timestamp,
                        nonceStr: sign.nonceStr,
                        signature: sign.signature,
                        jsApiList: ['openAddress', 'chooseWXPay', 'onMenuShareAppMessage', 'onMenuShareTimeline', 'hideMenuItems', 'showOptionMenu', 'showMenuItems'] //使用接口时，这里必须先声明
                    });
                }
            }
        });
        var url = location.href.split('#')[0];
        var title = '个人中心';
        var desc = '一拍就送，派客配送';
        var imgUrl = 'www.wanxunkj.com/resource/wechat/images/logo_black.png';
        wx.ready(function () {
            wx.showOptionMenu();
            wx.hideMenuItems({
                menuList: ['menuItem:editTag', 'menuItem:delete', 'menuItem:copyUrl', 'menuItem:originPage', 'menuItem:readMode', 'menuItem:openWithQQBrowser', 'menuItem:openWithSafari', 'menuItem:share:email', 'menuItem:share:brand', 'menuItem:share:qq', 'menuItem:share:QZone']
            });
            wx.showMenuItems({
                menuList: ['menuItem:share:appMessage', 'menuItem:share:timeline', 'menuItem:favorite']
            });
            wx.onMenuShareTimeline({
                title: title,
                link: url,
                imgUrl: imgUrl,
                success: function () {
                },
                cancel: function () {
                }
            });
            wx.onMenuShareAppMessage({
                title: title,
                desc: desc,
                link: url,
                imgUrl: imgUrl,
                type: '',
                dataUrl: '',
                success: function () {
                },
                cancel: function () {
                }
            });
        });
    });

</script>
</body>

</html>