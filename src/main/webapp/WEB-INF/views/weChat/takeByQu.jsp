﻿<%@ page contentType="text/html;charset=UTF-8" language="java"%>
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
	<script src="http://res.wx.qq.com/open/js/jweixin-1.1.0.js"></script>
	<title>帮我取</title>
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
		<section class="give_con">
			<div class="w_form con">
				<div class="line_card  bor-b link_rec marbot10">
					公告<marquee width=100% behavior=scroll direction=left align=middle><span style="color: red">因业务变更,现不能代取中通包裹，中通包裹请勿下单，请见谅!</span></marquee>
				</div>
				<div class="ipt_card bor-b flex fl-ali marbot10">
					<i class="icon icon_remark"></i>
					<span class="font_c card_l">短信消息</span>
					<textarea rows="7" name="sms" class="msgTxt" id="sms" placeholder="请粘贴菜鸟驿站给您发送的快递通知短信"></textarea>
					<%--<em class="msgN"></em>--%>
					<em style="right: 0.16rem;position: absolute;bottom: 0.24rem;color:red;font-size:0.26rem;">(注：一条取货码只对应一条订单，请勿粘贴多条短信)</em>
				</div>
				<!--预约时间-->
				<div class="line_card  bor-b time_plugByM marbot10" style="margin-bottom:0">
					<div class="flex fl-1 fl-ali">
						<i class="icon icon_time"></i>
						<span class="font_c card_l">接收时间</span>
						<i class="icon icon_right concat_i"></i>
						<p class="time time_floorByM " style="width: 3rem;text-align:center;color:#656565;font-size: 0.37333333rem;">短信接收时间</p>
						<i class="icon icon_right concat_i"></i>
						<input type="text" placeholder="默认为今天" readonly  onfocus="this.blur()" value="" class="card_c font24 card_cByM" style="width:auto; padding-left:.5rem;"/>
						<input type="hidden" name="messageTime" id="messageTime" value="今天"/>
						<input type="text" id="appDateTimeByM"/>
					</div>
				</div>
				<!--收货地址-->
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
				<!--联系人-->
				<div class="pay_card" id="Name">
					<div class="paybox flex fl-ali bor-b">
						<i class="icon icon_menB"></i>
						<div class="pay_r">
							<input type="text" name="endUserName" class="pay_t font24" placeholder="请输入收货联系人姓名(选填)"
								   id="T_UserName" maxlength="10" value="${endAddress[0].endUserName}">
						</div>
					</div>
				</div>
				<!--收（电话）-->
				<div class="pay_card" id="Phone">
					<div class="paybox flex fl-ali bor-b">
						<i class="icon icon_phoneC"></i>
						<div class="pay_r">
							<input type="text" name="endPhone" maxlength="20" class="pay_t font24"
								   placeholder="请输入收货联系人电话" id="T_Phone" value="${endAddress[0].endPhone}">
						</div>
					</div>
				</div>

				<!--预约时间-->
				<div class="line_card  bor-b time_plug marbot10" style="margin-bottom:0">
					<div class="flex fl-1 fl-ali">
						<i class="icon icon_time"></i>
						<span class="font_c card_l">发货时间</span>
						<i class="icon icon_right concat_i"></i>
						<p class="time time_floor " style="width: 3rem;text-align:center;color:#656565;font-size: 0.37333333rem;">默认立即发货</p>
						<i class="icon icon_right concat_i"></i>
						<input type="text" placeholder="点此也可预约" readonly  onfocus="this.blur()" value="" class="card_c font24" style="width:auto; padding-left:.5rem;"/>
						<input type="text" name="appDateTime" id="appDateTime"/>
					</div>
				</div>
			</div>
			<div class="w_size" id="submit" onclick="return dosubmit();">
				<a href="javascript:void(0);" class="next_btn " id="submitText">确认下单</a>
			</div>
		</section>
	</div>


	<div class="hide" id="E_address">
		<div class="page pagebuyP">
			<div class="addBox">
				<div class="Box_top">
				</div>
				<!--常用-->
				<div class="p_tab">
					<div class="tabbox bor-b">
						<div class="tab2"><span class="checked">常用收货地址</span></div>
					</div>
					<!--常用地址-->
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


	<input id="ToubaoPrice" name="toubaoPrice" type="hidden" value="0"/>
	<input id="IsSubscribe" name="isSubscribe" type="hidden" value="0"/>
	<input id="SubscribeTime" name="subscribeTime" type="hidden" />
	<input id="GoodsType" name="goodsType" type="hidden" value=""/>
	<input id="SendType" name="sendType" type="hidden" value="0"/>

</form>

<script type="text/javascript" charset="utf-8" src="/resource/wechat/js/zepto.min.js"></script>
<script src="/resource/wechat/layer/layer.js" type="text/javascript" charset="utf-8"></script>
<script src="/resource/wechat/mobiscroll/js/mobiscroll.jq.min.js"></script>
<script src="/resource/wechat/mobiscroll/js/mobiscroll.core-2.5.2.js" type="text/javascript"></script>
<link href="/resource/wechat/mobiscroll/css/mobiscroll.core-2.5.2.css" rel="stylesheet" type="text/css" />
<script src="/resource/wechat/mobiscroll/js/mobiscroll.datetime-2.5.1.js" type="text/javascript"></script>
<script src="/resource/wechat/mobiscroll/js/mobiscroll.datetime-2.5.1-zh.js" type="text/javascript"></script>
<script src="/resource/wechat/mobiscroll/js/mobiscroll.android-ics-2.5.2.js" type="text/javascript"></script>
<link href="/resource/wechat/mobiscroll/css/mobiscroll.android-ics-2.5.2.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="/resource/wechat/css/time_plug.css"/>
<script src="/resource/wechat/js/common.js?v=2.1" type="text/javascript" charset="utf-8"></script>
<script src="/resource/wechat/js/takeByQu.js?ver=87.1" type="text/javascript" charset="utf-8"></script>

<script type="text/javascript">
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
        var title = '帮我取';
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

    function endAddress(endPhone,endUserNote,endUserName){
        $('#T_Phone').val(endPhone);
        $('#E_Address_Con').val(endUserNote);
        $('#T_UserName').val(endUserName);
        layer.closeAll();
    }

    $('form').on('touchmove', function (event) {
        event.preventDefault();
    });

    function checkRate(mynubmer) {
        mynubmer = mynubmer.replace(/-/g, '').replace(/[\r\n]/ig,'');
        mynubmer = mynubmer.replace(/ /g, '').replace(/[\r\n]/ig,'');
        var num='';
        for(i=0;i<mynubmer.length;i++){
            if(parseInt(mynubmer[i])>=0){
                num+=mynubmer[i]
            }
        }
        var myreg=/^[1][3,4,5,7,8][0-9]{9}$/;
        if (!myreg.test(mynubmer)) {
            return false;
        } else {
            return true;
        }
    }

    function dosubmit() {
        if ($("#sms").val().length < 1) {
            layer.open({ content: '请输入短信详情', time: 1 });
            return false
        }
        if ($("#E_Address_Con").val().length < 1) {
            layer.open({ content: '请输入收件地址', time: 1 });
            return false
        }
        if ($("#T_Phone").val().length < 1) {
            layer.open({ content: '请输入联系人手机号', time: 1 });
            $("#T_Phone").focus();
            return false;
        }
        if (!checkRate($("#T_Phone").val())) {
            layer.open({ content: '联系人手机号错误', time: 1 });
            $("#T_Phone").focus();
            return false
        }
        var a = $.ajax({
            url: "${pageContext.request.contextPath}/weChat/takeByQu/pleaseOrder",
            type: "post",
            data: $("#payform").serialize(),
            beforeSend: function () {
                $('#submitText').html('<img src="${pageContext.request.contextPath}/resource/imgs/loading.gif"></img>');//添加disabled属性
                $('#submit').removeAttr('onclick');//去掉onclick事件
            }
        });
        a.done(function (orderNo) {
        $.ajax({
        url: "${pageContext.request.contextPath}/wxPay/uniformorder.action",
        type: "post",
        dataType: "json",
        complete: function () {
        $('#submitText').html('确认下单');
        $("#submit").attr("onclick", "dosubmit();");
        },
        data: {"orderNo": orderNo,"type":"qu", "money": "5"}, //json字符串,
        success: function (data) {
        wx.chooseWXPay({
        timestamp: data.timestamp,
        nonceStr: data.nonce,
        package: data.packageName,
        signType: data.signType,
        paySign: data.signature,
        success: function (res) {
		window.location.href="${pageContext.request.contextPath}/weChat/userInfo"
        },
        fail: function (res) {
        $.ajax({
        url: "${pageContext.request.contextPath}/weChat/takeByQu/deleteByOrderNo.action?id=" + orderNo,
        type: "get",
        async: false,
        success: function (data) {
        layer.open({ content: '微信出现异常', time: 1 });
        }
        });
        },
        complete: function (res) {
        },
        cancel: function (res) {
        $.ajax({
        url: "${pageContext.request.contextPath}/weChat/takeByQu/deleteByOrderNo?id=" + orderNo,
        type: "get",
        async: false,
        success: function (data) {
        layer.open({ content: '取消支付', time: 1 });
        }
        });
        },
        trigger: function (res) {
        }
        });

        },
        error: function () {
        $.ajax({
        url: "${pageContext.request.contextPath}/weChat/takeByQu/deleteByOrderNo?id=" + orderNo,
        type: "get",
        async: false,
        success: function (data) {
        layer.open({ content: '获取prepay_id失败', time: 1 });
        }
        });
        }
        });
        }
        )
        a.fail(function (res) {
            layer.open({ content: '支付人数过多', time: 1 });
            $('#submitText').html('确认下单');
            $("#submit").attr("onclick", "dosubmit();");
        });
    }

</script>

</body>

</html>
