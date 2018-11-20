//处理错误图片
function imgError(tag) {
    console.log("error:" + $(tag).attr('src'));
    $(tag).attr('src', "http://img.hb.aicdn.com/38b79734f52ac98b9ac4c42dd6e1ee255aabf6a12e1d-YVXyVO_fw658");
}

$(function () {
    $('#aside').on('hide.bs.modal', function () {
        $("#logoHeader").fadeIn(1500);
    });
});

function left() {
    $("#aside").modal();
    $("#logoLeft").hide();
    $("#logoLeft").fadeIn(1500);
    $("#logoHeader").fadeOut(1500);
};


//表单序列化成JSON对象
jQuery.prototype.serializeObject = function () {
    var obj = new Object();
    $.each(this.serializeArray(), function (index, param) {
        if (!(param.name in obj)) {
            obj[param.name] = param.value;
        }
    });
    return obj;
};

//获取根路径
function getRootPath() {
    //获取当前网址，如： http://localhost:8083/uimcardprj/share/meun.jsp
    var curWwwPath = window.document.location.href;
    //获取主机地址之后的目录，如： uimcardprj/share/meun.jsp
    var pathName = window.document.location.pathname;
    var pos = curWwwPath.indexOf(pathName);
    //获取主机地址，如： http://localhost:8083
    var localhostPaht = curWwwPath.substring(0, pos);
    //获取带"/"的项目名，如：/uimcardprj
    var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);
    return localhostPaht + projectName;
};

function getDateDiff(dateStr) {
    var dateTimeStamp = getDateTimeStamp(dateStr);
    var minute = 1000 * 60;
    var hour = minute * 60;
    var day = hour * 24;
    var halfamonth = day * 15;
    var month = day * 30;
    var year = month * 12;
    var now = new Date().getTime();
    var diffValue = now - dateTimeStamp;
    if (diffValue < 0) {
        return;
    }
    var yearC = diffValue / year;
    var monthC = diffValue / month;
    var weekC = diffValue / (7 * day);
    var dayC = diffValue / day;
    var hourC = diffValue / hour;
    var minC = diffValue / minute;
    if (yearC >= 1) {
        var date = getDate(dateStr);
        result = date.getMonth() + "." + date.getDate() + "." + date.getFullYear();
    }
    else if (monthC >= 1) {
        result = "" + parseInt(monthC) + "月前";
    }
    else if (weekC >= 1) {
        result = "" + parseInt(weekC) + "周前";
    }
    else if (dayC >= 1) {
        result = "" + parseInt(dayC) + "天前";
    }
    else if (hourC >= 1) {
        result = "" + parseInt(hourC) + "小时前";
    }
    else if (minC >= 1) {
        result = "" + parseInt(minC) + "分钟前";
    } else
        result = "刚刚";
    return result;
}

//转换标准时间为时间戳
function getDateTimeStamp(dateStr) {
    return Date.parse(dateStr.replace(/-/gi, "/"));
}

//字符串转日期格式
function getDate(strDate) {
    var date = eval('new Date(' + strDate.replace(/\d+(?=-[^-]+$)/,
        function (a) {
            return parseInt(a, 10) - 1;
        }).match(/\d+/g) + ')');
    return date;
}

$(window).scroll(function () {
    var sc = $(window).scrollTop();
    var rwidth = $(window).width() + $(document).scrollLeft();
    var rheight = $(window).height() + $(document).scrollTop();
    if (sc > 100) {
        $("#goTop").css("display", "block");
    } else {
        $("#goTop").css("display", "none");
    }
});
