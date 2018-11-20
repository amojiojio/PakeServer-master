if (parseInt($("#PreOrderid").val()) > 0) {
    $("#S_Address_Con").css({ "color": "#333333" });
}
if ($("#SpecialType").val() == '1') {
    $('#Special').find("i").addClass('icon_checked1');
} else {
    $('#Special').find("i").removeClass('icon_checked1');
}


$(function() {
filterMobile($('#EndPhone'))
filterMobile($('#T_Phone'))

    //点击购买地址
    $('#S_Con').on('click', function() {
        //页面层
        layer.open({
            type: 1,
            content: $('#S_address').html(),
            style: 'position:fixed; bottom:0; left:0; width: 100%; height: 50%; padding:10px 0; border:none;'
        });
    });

    //点击收货地址
    $('#E_Con').on('click', function() {
        //页面层
        layer.open({
            type: 1,
            content: $('#E_address').html(),
            style: 'position:fixed; bottom:0; left:0; width: 100%; height: 50%; padding:10px 0; border:none;'
        });
    });

    //输入框文字限制
    var maxN = 36;
    $('.msgN').html('<em class="curN">' + maxN + '</em>/' + maxN);
    $('.msgTxt').on('input', function() {
        var val = $(this).val();
        if (val.length > maxN) {
            $(this).val(val.substr(0, maxN));
        }
        val = $(this).val();
        $('.curN').text(maxN - val.length);
    });
    //点击标签选项
    $('.tab_btn').on('click', function() {
        $(this).addClass('on').siblings().removeClass('on');
        $('#tabTxt').text($(this).text());
        $("#GoodsType").val($(this).text());
    });

    //点击‘选中框’
    $('#KnowMoney').on('click', function() {
        var haveinpt = $(this).parents('#GodsPrice').find('input').length;
        //选中不知道价格
        if (haveinpt == 1) {
            $('.card_input').toggle();
            $('#GodsPrice .card_tip').toggle();
            $("#GoodsMoney").val("");
        }
        if (!$(this).find("i").hasClass('icon_checked1')) {
            $(this).find("i").addClass('icon_checked1');
            $("#GoodsMoney").val("0");
        } else {
            $(this).find("i").removeClass('icon_checked1');
            $("#GoodsMoney").val("");
        }
    });

    //点击‘选中框’
    $('#Special').on('click', function() {
        //选中保温箱
        if (!$(this).find("i").hasClass('icon_checked1')) {
            $(this).find("i").addClass('icon_checked1');
            $("#SpecialType").val(1);
        } else {
            $(this).find("i").removeClass('icon_checked1');
            $("#SpecialType").val(0);
        }
    });

    //点击‘就近购买’
    $('#near').on('click', function() {
        if (!$(this).find("i").hasClass('icon_checked1')) {
            $(this).find("i").addClass('icon_checked1');
            $("#S_Address_Con").hide();
            $('#S_Address_Con').val('附近两公里内购买');
            $('#SendType').val(1);
            $('#BuyPlace .card_tip').show();
            $('#BuyPlace .card_r').hide();
        } else {
            $(this).find("i").removeClass('icon_checked1');
            $('#SendType').val(0);
            $('#S_Address_Con').val('');
            $("#S_Address_Con").text("请输入购买地址").css({ "color": "#b7b3b3" });
            $("#S_Address_Con").show();
            $('#BuyPlace .card_tip').hide();
            $('#BuyPlace .card_r').show();
            $("#StartTitle").val("");
            $("#txtPrice").val("");
        }
    });

    //时间控件
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
            minDate: dateAdd("h", 0.2, new Date()),
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
            dateFormat: 'yy/mm',
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
        // $(showL).on('touchend', function() {
        $(showL).on('click', function() {
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
            $('.dwbw.dwb-s .dwb').on('touchstart', function() {
                //获得时间
                var timeArr = [];
                for (var i = 0; i <= 4; i++) { //获取所有列中的时间
                    var timeVal = $('.dwwl.dwrc.dwwl' + i).find('.dw-li.dw-v.dw-sel').text();
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
            });
            $('.dwbw.dwb-s').prepend('<div class="liji">立即购买</div>');
            $('.liji').on('tap', function() {
                $('#appDateTime').mobiscroll('hide');
                $(loca).val('立即购买');
                $("#IsSubscribe").val(0);
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
    timePlug(
        '.time_plug', //点击出现时间弹窗的class
        '请选择购买时间', //设置选择时间的类型
        '.time_plug .card_c' //选择输出时间的地址
    );

})

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