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
	<title>帮我送</title>
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
			<div class="w_form">
				<div class="line_card  bor-b link_rec marbot10" id="GetPlace">
					<div class="flex fl-1 fl-ali">
						<i class="icon icon_locaC"></i>
						<span class="card_l">取件地址</span>
						<input type="text" name="endUserNote" class="card_c font26" id="E_Address_Con"
							   style="color:#b7b3b3" placeholder="请输入取件地址" value="${endAddress[0].endUserNote}">
					</div>
					<div class="card_r" id="E_Con">
						<i class="icon icon_right"></i>
					</div>
				</div>
				<div class="pay_card" id="Name">
					<div class="paybox flex fl-ali bor-b">
						<i class="icon icon_menB"></i>
						<div class="pay_r">
							<input type="text" name="endUserName" class="pay_t font24" placeholder="请输入取件联系人姓名"
								   id="T_UserName" maxlength="10" value="${endAddress[0].endUserName}">
						</div>
					</div>
				</div>
				<div class="pay_card" id="Phone">
					<div class="paybox flex fl-ali bor-b">
						<i class="icon icon_phoneC"></i>
						<div class="pay_r">
							<input type="text" name="endPhone" maxlength="20" class="pay_t font24"
								   placeholder="请输入取件联系人电话" id="T_Phone" value="${endAddress[0].endPhone}">
						</div>
					</div>
				</div>
				<div class="line_card bor-b goodsType marbot10">
					<div class="flex fl-1 fl-ali">
						<i class="icon icon_goods"></i>
						<span class="card_l">物品类型</span>
					</div>
					<span class="tip"></span>
					<i class="icon icon_right"></i>
				</div>
				<div class="ipt_card bor-b flex fl-ali marbot10">
					<i class="icon icon_remark"></i>
					<span class="font_c card_l">备注信息</span>
					<textarea name="Note" class="msgTxt" id="Note" placeholder="请输入备注信息"></textarea>
					<em class="msgN"></em>
				</div>
				<div class="line_card  bor-b time_plug" style="margin-bottom:0">
					<div class="flex fl-1 fl-ali">
						<i class="icon icon_time"></i>
						<span class="font_c card_l">取件时间</span>
						<i class="icon icon_right concat_i"></i>
						<p class="time time_floor " style="width: 3rem;text-align:center;color:#656565;font-size: 0.37333333rem;">默认立即上门</p>
						<i class="icon icon_right concat_i"></i>
						<input type="text" placeholder="点此也可预约" readonly  onfocus="this.blur()" value="" class="card_c font24" style="width:auto; padding-left:.5rem;"/>
						<input type="text" name="appDateTime" id="appDateTime"/>
					</div>

				</div>
			</div>
			<div class="w_size" id="submit" onclick="return dosubmit();">
				<a href="javascript:void(0);" class="next_btn " id="submitText">免 费 预 约 派 客 上 门 取 件</a>
			</div>
			<div class="w_size"  ><div id="rule">《计 价 规 则》</div></div>
		</section>
	</div>

	<div class="page pageGoods hide">
		<div class="mask goodsClose"></div>
		<div class="goodsbox">
			<div class="close goodsClose"></div>
			<i class="imgbox"><img src="/resource/wechat/images/pic_goods.png"/></i>
			<h1>请选择物品类型</h1>
			<ul class="option">
				<li class="on">其他</li><li>文件</li><li>数码产品</li><li>日用品</li><li>服饰</li><li>食品</li><li>医药类产品</li><li>超大件</li>
			</ul>
			<div class="goods_btn next_btn">确认</div>
		</div>
	</div>

	<input id="IsSubscribe" name="isSubscribe" type="hidden" value="0"/>
	<input id="SubscribeTime" name="subscribeTime" type="hidden" />
	<input id="GoodsType" name="goodsType" type="hidden" value="其他"/>
	<input id="SendType" name="sendType" type="hidden" value="0"/>

</form>


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



<div class="hide" id="regular">
	<div class="page pagebuyP">
		<div class="addBox">
			<div class="Box_top">
			</div>
			<!--常用-->
			<div class="p_tab">
				<div class="tabbox bor-b">
					<div class="tab2"><span class="checked">《 计 价 规 则 》</span></div>
				</div>
				<!--常用地址-->
				<div class="tabcon stored" style="display: block;">

					<div class="place_card bor-b">
						<small>
							<br>
							体积重量是一种反映包裹密度的计算方式。低密度的包裹，与实际重量比较，占用的空间通常较大。计算出来的体积重量与实际重量比较，取大者作为计费重量，用以计算运费。<br>
							<br>
							中国大陆地区内业务<br>
							1. 同城、省内及经济区域内互寄：体积重量(KG)的计算方法为：长度(CM)x宽度(CM)x高度(CM)÷12000。<br><br>
							2. 省外非经济区域内互寄，体积重量(KG)的计算方法为：【即日/次晨/标快】长度(CM)x宽度(CM)x高度(CM)÷6000；【特惠】长度(CM)x宽度(CM)x高度(CM)÷12000。<br><br>
							<br>
							二、港澳台及国际业务<br>
							1、始发地或目的地任一方为港澳台地区或其他海外国家，体积重量(KG)的计算方法为：长度(CM)x宽度(CM)x高度(CM)÷6000；<br><br>
							2、台湾岛内件体积重量(KG)的计算方法为：长度(CM)x宽度(CM)x高度(CM)÷12000；港澳地区及海外国家的本地件体积重量(KG)的计算方法为：长度(CM)x宽度(CM)x高度(CM)÷6000；<br><br>
							备注：体积重量的计算方法参考各地区及当地市场惯例, 当中可能略有差异。以上涉及的具体产品范围请与收派员进行咨询。<br>
						</small>

					</div>
				</div>
			</div>
		</div>

	</div>
</div>

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
<script src="/resource/wechat/js/takeBySong.js?ver=87.1" type="text/javascript" charset="utf-8"></script>

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
        var title = '帮我送';
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
        if ($("#E_Address_Con").val().length < 1) {
            layer.open({ content: '请输入取件地址', time: 1 });
            return false
        }
        if ($("#T_UserName").val().length < 1) {
            layer.open({ content: '请输入取件联系人姓名', time: 1 });
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
        layer.open({
            content: '确认预约派客上门？',
            btn: ['确定', '取消'],
            shadeClose:false,
            yes: function(){
                $.ajax({
                    url: "${pageContext.request.contextPath}/weChat/takeBySong/pleaseOrder",
                    type: "post",
					dataType:"text",
                    data: $("#payform").serialize(),
                    success:function(data){
                        layer.open({
                            content: '预约成功',
                            btn: ['确定'],
							yes:function(){
                                window.location.href="${pageContext.request.contextPath}/weChat/userInfo";
							}
                        });
                    },
					error:function () {
                        layer.open({ content: '服务器繁忙，请稍后再试', time: 2 });
                    }
                });
            },
            no:function(index){
                layer.close(index);
            },
            success:function(){
            }
        });
    }

</script>

</body>

</html>
