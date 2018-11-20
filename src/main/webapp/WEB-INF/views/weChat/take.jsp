<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>

	<meta charset='utf-8'>
	<meta name="flexible" content="initial-dpr=1" />
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
	<title>取送件</title>
</head>
<body>
<form id="payform" name="payform" method="post">
	<div class="page pageTitle">
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
		<section class="give_con con">
			<div style="padding: 15% 15%;">
				<a href="/weChat/takeBySong"><img src="/resource/wechat/images/use_tp2.png" style="width: 100%"></a>
			</div>
			<div style="padding: 1% 15%;">
				<a href="/weChat/takeByQu"><img src="/resource/wechat/images/use_tp4.png" style="width: 100%"></a>
			</div>
		</section>
	</div>
</form>

<script type="text/javascript" charset="utf-8" src="/resource/wechat/js/zepto.min.js"></script>
<script type="text/javascript">
    $('form').on('touchmove', function (event) {
        event.preventDefault();
    });

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
        var title = '取送件';
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
