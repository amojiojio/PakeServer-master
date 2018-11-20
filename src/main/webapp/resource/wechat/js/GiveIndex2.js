if (parseInt($("#PreOrderid").val()) > 0) {
    if ($("#Pre_SpecialType").val() == "1") {
        $('#Special').find("i").addClass('icon_checked1');
        $("#SpecialType").val(1);
    }
    setTimeout("position_toSelect('PriceToken_1')", 30);
    $("#S_Address_Con").css({ "color": "#333333" });
    $("#E_Address_Con").css({ "color": "#333333" });

}


$('#E_Con').on('click', function() {
    //页面层
    layer.open({
        type: 1,
        content: $('#E_address').html(),
        style: 'position:fixed; bottom:0; left:0; width: 100%; height: 50%; padding:10px 0; border:none;'
    });
});

if ($("#SpecialType").val() == '1') {
    $('#Special').find("i").addClass('icon_checked1');
} else {
    $('#Special').find("i").removeClass('icon_checked1');
}
$('#ValBack').on('click', function () {
    $('.pageVal').hide();
    if (window.location.hash.indexOf("price") > -1) {
        window.history.go(-1);
    }
})
$('#valTxt').on('click', function () {
    $('.val1').show();
    $('.val2').hide();
})

function DefautInfo() {
    if ($("#SendType").val() == "0") {
        if ($("#StartPhone").val() == "") {
        }
    } else if ($("#SendType").val() == "3") {
        if ($("#EndPhone").val() == "") {
        }
    }
}
$(function () {
    filterMobile($('#T_Phone'))
    DefautInfo();
    $("#ok").on('click', function () {
        if (JSON.parse(sessionStorage.getItem('couponId')) != null) {
            sessionStorage.removeItem('couponId')
        }

        if ($("#useruid").val() == 0) {
            $('.login_pup').show();
            return;
        }
        if ($("#StartTitle").val().length <= 1 || $("#StartXY").val().length == 0) {
            layer.open({ content: '请输入' + $("#start_tip").text() + '！', time: 1 });
            return false
        }

        if ($("#EndTitle").val().length <= 1 || $("#EndXY").val().length == 0) {
            layer.open({ content: '请输入收货地址', time: 1 });
            return false
        }
        if (!checkRate($("#EndPhone").val())) {
            layer.open({ content: '收货人手机号错误！', time: 1 });
            return false
        }

        if ($("#txtPrice").val() == "") {
            layer.open({ content: '未计算出跑腿费用', time: 1 });
            return false
        }
        if ($("#StartCity").val().length > 0 && !CheckOpenCity($("#StartCity").val())) {
            layer.open({ content: '发货地所在城市<br/>未开通UU跑腿', time: 1 });
            return
        }

        if ($("#StartPhone").val() == "") {
            layer.open({ content: '请输入发货人手机号！', time: 1 });
            $('#SendPlace').click();
            return false
        }
        if (!checkRate($("#StartPhone").val())) {
            layer.open({ content: '发货人手机号错误！', time: 1 });
            $('#SendPlace').click();
            return false
        }
        $("#StartUserNote").val($("#StartUserNote").val().replace(/\(\$\)/g, ""));
        $("#StartPhone").val($("#StartPhone").val().replace(/-/g, ""));
        $("#EndPhone").val($("#EndPhone").val().replace(/-/g, ""));
        $("#EndUserNote").val($("#EndUserNote").val().replace(/\(\$\)/g, ""));
    });

    //点击购买地址
    $('#S_Address_Con').on('click', function () {

    });
    //点击收货地址
    $('#E_Address_Con').on('click', function () {

    });

    //输入框文字限制
    var maxN = 36;
    $('.msgN').html('<em class="curN">' + maxN + '</em>/' + maxN);
    $('.msgTxt').on('input', function () {
        var val = $(this).val();
        if (val.length > maxN) {
            $(this).val(val.substr(0, maxN));
        }
        val = $(this).val();
        $('.curN').text(maxN - val.length);
    });

    var giveImg = $('.giveTab .tab_give').find('img');
    var giveSrc = $('.giveTab .tab_give').find('img').attr('src');
    var takeSrc = $('.giveTab .tab_take').find('img').attr('src');
    $('.giveTab i').on('click', function () {
        var img = $(this).find('img');
        var index = $(this).index();
        if ($(this).hasClass('on')) {
            return false
        } else {
            if (index == 0) {
                //帮我送
                $('#htmlData').html('123123')
            } else {
                //帮我取
                giveImg.attr('src', "/resource/wechat/images/give_txt.png");
            }
            $(this).addClass('on').siblings().removeClass('on')
            $('.giveTab .tab_give').find('img').attr('src', giveSrc);
            $('.giveTab .tab_take').find('img').attr('src', takeSrc);
            img.attr('src', img.data('src'));
        }

    });

    //点击‘选中框’
    $('#Special').on('click', function () {
        //选中保温箱
        if (!$(this).find("i").hasClass('icon_checked1')) {
            $(this).find("i").addClass('icon_checked1');
            $("#SpecialType").val(1);
        } else {
            $(this).find("i").removeClass('icon_checked1');
            $("#SpecialType").val(0);
        }
    });

    //物品类型
    //帮我送物品类型
    $('.goodsType').on('click', function () {
        $('.pageGoods').show();
    });
    $('.goodsClose').on('click', function () {
        $('.pageGoods').fadeOut(500);
    });
    $('.pageGoods li').on('click', function () {
        $(this).addClass('on').siblings().removeClass('on');
    });
    $('.goods_btn').on('click', function () {
        $('.pageGoods').fadeOut(500);
        //输出物品类型
        $('.goodsType .tip').text($('.pageGoods li.on').text());
        $("#GoodsType").val($('.pageGoods li.on').text());
    });


    //时间控件
    //绑定帮我送时间弹窗
    timePlug(
        '.give_con .time_plug', //点击出现时间弹窗的class
        '请选择预约时间', //设置选择时间的类型
        '.give_con .time_plug .card_c' //选择输出时间的地址
    );
    //绑定帮我取时间弹窗
    timePlug(
        '.take_con .time_plug',
        '请选择预约时间', //设置选择时间的类型
        '.take_con .time_plug .card_c' //选择输出时间的地址
    );
    //时间控件脚本
    function timePlug(showL, genre, loca) {
        var today = new Date();
        var nextDay = new Date(new Date().getTime() + 1000 * 60 * 60 * 24);
        var currYear = (new Date()).getFullYear();
        var opt = {};
        opt.date = {
            preset: 'date'
        };
        opt.datetime = {
            preset: 'datetime',
            minDate: dateAdd("h", 0.5, new Date()),
            maxDate: new Date(nextDay.getFullYear(), nextDay.getMonth(), nextDay.getDate(), 23, 50),
            stepMinute: 10
        };
        time = {
            preset: 'time'
        };
        opt.default = {
            theme: 'android-ics light', //皮肤样式
            display: 'modal', //显示方式 
            mode: 'scroller', //日期选择模式
            dateFormat: 'yy/mm/dd',
            height: 57,
            width: 85,
            rows: 3,
            lang: 'zh'
        };
        var optDateTime = $.extend(opt['datetime'], opt['default']);
        var optTime = $.extend(opt['time'], opt['default']);
        $("#appDateTime").mobiscroll(optDateTime).datetime(optDateTime);
        $("#appDateTime").hide();

        //计算当年当月最后一天
        var nextM_firstD = new Date(today.getFullYear(), today.getMonth() + 1, 1); //当下一个月第一天的值
        var curM_lastD = (new Date(nextM_firstD.getTime() - 1000 * 60 * 60 * 24)).getDate(); //取当前月最后一天的值
        var last_date;
        if (today.getDate() == 31 && (today.getMonth() + 1) == 12) { //判断当天是否是当年的最后一天
            last_date = 0;
        } else if (today.getDate() == curM_lastD && (today.getMonth() + 1) != 12) { //判断当天是否是当月的最后一天
            last_date = 1;
        } else { //当天不是特殊日期
            last_date = 2;
        }

        //弹窗
        // $(showL).on('touchend', function () {
        $(showL).on('click', function () {
            $("#Note").blur();
            $('#appDateTime').mobiscroll('show');
            modify();
            return false;
        });

        function modify() {
            for (var i = 0; i < 3; i++) { //隐藏时间控件年月日
                $('.dwwl.dwrc.dwwl' + i).css('display', 'none');
            }
            var show_list = $('.dwwl.dwrc.dwwl' + last_date);
            show_list.css('display', 'block'); //显示当前需要显示的list

            //修改当前分钟数
            var len = $('.dwwl.dwrc.dwwl4 .dw-i').length;
            var tM = today.getMinutes().toString().substr(today.getMinutes().toString().length - 1);
            for (var i = 0; i < len; i++) {
                $('.dwwl.dwrc.dwwl4 .dw-i').eq(i).text(i + tM);
            }
            $('.dwwl.dwrc.dwwl4 .dw-i').eq(0).text('0' + tM);
            //--------------------------------------------
            $('.dwwr').css('width', '100%');
            var d0 = show_list.find('.dw-li.dw-v').eq(0).text();
            var d1 = show_list.find('.dw-li.dw-v').eq(1).text();

            show_list.find('.dw-li.dw-v').eq(0).text('今天');
            show_list.find('.dw-li.dw-v').eq(1).text('明天');
            if ($('.dwv')) {
                $('.dwv').addClass('pick_timebox').removeClass('dwv');
            }
            $('.pick_timebox').html(
                '<div class="addDiv">' +
                '<div class="pic_time">' +
                '<img class="pic_timeimg" src="/resource/wechat/images/pic_time.png">' +
                '</div>' +
                '<p>' + genre + '</p>' +
                '</div>'
            );
            $('.dwbw.dwb-s .dwb').on('touchstart', function () {
                //获得时间
                var timeArr = [];
                for (var i = 0; i <= 4; i++) { //获取所有列中的时间
                    var timeVal = $('.dwwl.dwrc.dwwl' + i).find('.dw-li.dw-v.dw-sel').text();
                    $(".time_floor").text('预约上门');
                    timeArr.push(timeVal);
                }

                //输出时间
                $(loca).val(timeArr[last_date] + ' ' + timeArr[3] + ':' + timeArr[4]);

                //把汉字改成数值
                if (timeArr[last_date] == '今天') {
                    timeArr[last_date] = d0;
                } else if (timeArr[last_date] == '明天') {
                    timeArr[last_date] = d1;
                }
                var orderTime = timeArr.join('-');
                $("#IsSubscribe").val(1);
                $("#SubscribeTime").val(timeArr[0] + "/" + timeArr[1] + "/" + timeArr[2] + " " + timeArr[3] + ":" + timeArr[4]);
                setTimeout("position_toSelect('PriceToken_1')", 20);
            });
            $('.dwbw.dwb-s').prepend('<div class="liji">立即上门取件</div>');
            $('.liji').on('click', function () {
                $('#appDateTime').mobiscroll('hide');
                $(loca).val('');
                $("#IsSubscribe").val(0);
                $(".time_floor").text('立即上门取件');
                setTimeout("position_toSelect('PriceToken_1')", 20);
            });

            $('.dwbw.dwb-s .dwb').text('确定');
            $('.dwbw.dwb-c .dwb').text('');
            var winH = $(window).innerHeight();
            var winW = $(window).innerWidth();
            var cardH = $('.dw.dwbg').height();
            var cardW = $('.dw.dwbg').width();
            $('.dw.dwbg').css({
                'top': (winH - cardH) / 2,
                'left': (winW - cardW) / 2
            });
        }
    }
    //保价金额弹窗
    function chargePlug() {
        //帮我送页面保价
        $('.give_con .baojia').on('touchend', function () {
            if ($("#StartCity").val() != $("#InsuranceCity").val()) {
                GetlistInsurance();
            }
            reloadbj();
            $("#Note").blur();
            $('#charge').mobiscroll('show');
            style();
            return false;
        });
        //修改样式
        function style() {
            $('.dwwr').width('100%');
            $('.dw-li.dw-v').css({ 'line-height': '28px' });
            $('.dwbw.dwb-c .dwb').text('');
            $('.dwbw.dwb-s .dwb').text('确定');
            $('.dw-li.dw-v.dw-sel .dw-i .p1').css('color', '#ff8b03');
            $('.dwbw.dwb-s .dwb').on('touchstart', function () {
                var p1Text = $('.insurance').find('.dw-li.dw-v.dw-sel .p1').text();
                var p2Text = $('.insurance').find('.dw-li.dw-v.dw-sel .p2').text();
                var tip = p1Text + ':' + p2Text;
                $('.give_con .baojiaVal').text(p1Text);
                $('.give_con .baojia .icon').addClass('icon_checked1');
                if (p1Text == "不保价") {
                    $("#ToubaoId").val(0);
                    $("#ToubaoPrice").val(0);
                } else {
                    $("#ToubaoId").val($('.insurance').find('.dw-li.dw-v.dw-sel .p1').attr("dateid"));
                    $("#ToubaoPrice").val(p1Text.replace(/投保/g, "").replace(/元/g, ""));
                }

            });
        }
    };
    chargePlug();
})

function reloadbj() {
    $("#ToubaoId").val(0);
    $("#ToubaoPrice").val(0);
    var st = $("#InsuranceStr").html();
    if (st != "") {
        $("#baojia_check").show();
    } else {
        $("#baojia_check").hide();
        return;
    }
    var timesArr = st.split('($)'); //文案
    var s = 0;
    var length = timesArr.length - 1;
    //插件参数
    wheels = [];
    wheels[0] = { '请选择保价金额': {} };
    for (var i = 0; i < timesArr.length - 1; i++) {
        wheels[0]['请选择保价金额'][i] = timesArr[i];
    }
    $("#charge").scroller({
        theme: 'insurance',
        height: 80,
        wheels: wheels,
        onChange: function () {
            $('.dw-li.dw-v .dw-i p').css('color', '#444');
            $('.dw-li.dw-v.dw-sel .dw-i .p1').css('color', '#ff8b03');
        },
        formatResult: function (d) { //显示结果
            return '';
        }
    });
}

function dateAdd(strInterval, NumDay, dtTmp) {
    if (dtTmp == null | dtTmp == "")
        dtTmp = new Date();
    switch (strInterval) {
        case "m":
            return new Date(Date.parse(dtTmp) + (60000 * NumDay));
        case "h":
            return new Date(Date.parse(dtTmp) + (3600000 * NumDay));
        case "d":
            return new Date(Date.parse(dtTmp) + (86400000 * (NumDay + 1)));
        case "w":
            return new Date(Date.parse(dtTmp) + ((86400000 * 7) * NumDay) + 86400000);
        case "M":
            return new Date(dtTmp.getFullYear(), (dtTmp.getMonth()) + NumDay, dtTmp.getDate(), dtTmp.getHours(), dtTmp.getMinutes(), dtTmp.getSeconds());
        case "y":
            return new Date((dtTmp.getFullYear() + NumDay), dtTmp.getMonth(), dtTmp.getDate(), dtTmp.getHours(), dtTmp.getMinutes(), dtTmp.getSeconds());
    }

}
window.onhashchange = function (event) {
    var i = location.hash;

    if (i == "#index" || i == "") {
        $('.pagebuyP').addClass('hide');
        $("#search_loca").blur();
        $('.side_bar').hide();
        $('.citylist').hide();
        $('.pageVal').hide();
    } else if (i == "#temp_page0" || i == "#temp_page1") {
        $('.abso').removeClass('hide');
        $('.addTip').remove();
        $('.addBox').removeClass('hide');
        $('.seaBox').addClass('hide');

    }
};
//切换送取使用
function ChangeValue() {
    console.log('ChangeValue')

}
//获取保价
function GetlistInsurance() {
    $.post("../bizmall/GetPriceV5.ashx?r=" + Math.random(), {
        action: "GetlistInsurance",
        UserId: $("#useruid").val(),
        CityName: $("#InsuranceCity").val()
    },
        function (data) {
            if (data.State == "1") {
                $("#InsuranceStr").html(data.Body);
            } else {
                $("#InsuranceStr").html("");
                layer.open({ content: data.Msg, time: 1 });
            }
            reloadbj();
        },
        "json")
}