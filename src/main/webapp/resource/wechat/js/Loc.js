var geocoder, map;
var wx_loc_address = "";
var wx_loc_tags = "";
var wx_loc_city = "";
var wx_loc = "";
var AddressType = 0;
var loctype = 1; //定位方式，1=微信定位，2=支付宝H5定位 
if ($("#WebType").val() == "1") {
    loctype = 1;
} else {
    loctype = 2;
}
var NeedLoc = parseInt($("#NeedLoc").val());
var wxConfig_appId, wxConfig_timestamp, wxConfig_nonceStr, wxConfig_signature;
if (NeedLoc == 1) {
    setTimeout("loadpage()", 50);
}
var uid = $("#useruid").val();

function loadpage() {
    if (loctype == 1) {
        $.post("../bizmall/AddOrderMethod.ashx?action=1002", {
            url: window.location.href,
            code: GetRequest()["code"]
        },
            function (data) {
                if (data.State == "1") {
                    wxConfig_appId = data.Body.appId;
                    wxConfig_timestamp = data.Body.timestamp;
                    wxConfig_nonceStr = data.Body.nonceStr;
                    wxConfig_signature = data.Body.signature;
                    wxconfig()
                } else {
                    alert("微信授权失败")
                }
            },
            "json")
    } else {
        requestPosition();
    }
}
if (loctype == 1) {
    function wxconfig() {
        wx.config({
            debug: false,
            appId: wxConfig_appId,
            timestamp: wxConfig_timestamp,
            nonceStr: wxConfig_nonceStr,
            signature: wxConfig_signature,
            jsApiList: ["getLocation"]
        })
    }
    wx.ready(function () {
        var latitude, longitude, speed, accuracy;
        try {
            setTimeout("getmylocBywx()", 30)
        } catch (e) { }
    });
}

function getmylocBywx() {
    wx.getLocation({
        type: "wgs84",
        success: function (res) {
            if (typeof (res.latitude) != "undefined" && typeof (res.longitude) != "undefined") {
                getlocbyGps(res.latitude, res.longitude);
            } else {
                layer.open({ content: '自动定位失败<br/>请手动输入地址', time: 1 });
            }
        },
        fail: function (res) {
            layer.open({ content: '自动定位失败<br/>请手动输入地址', time: 1 });
        }
    })
}

function requestPosition() {
    var nav = null;
    if (nav == null) {
        nav = window.navigator
    }
    if (nav != null) {
        var geoloc = nav.geolocation;
        if (geoloc != null) {
            geoloc.getCurrentPosition(successCallback, errorCallback, { enableHighAcuracy: true, timeout: 3000 })
        } else {
            layer.open({ content: '自动定位失败<br/>请手动输入地址或城市', time: 3 });
        }
    } else {
        layer.open({ content: '自动定位失败<br/>请手动输入地址或城市', time: 2 });
    }
}

function errorCallback(error) {

    switch (error.code) {
        case error.PERMISSION_DENIED:
            layer.open({ content: '您不允许地理定位<br/>请手动输入地址或城市', time: 2.5 });
            break;
        case error.POSITION_UNAVAILABLE:
            layer.open({ content: '自动定位失败<br/>请手动输入地址或城市', time: 2.5 });
            break;
        case error.TIMEOUT:
            break;
        case error.UNKNOWN_ERROR:
            layer.open({ content: '自动定位失败<br/>请手动输入地址或城市', time: 2.5 });
            break
    }
}
var gpsLatitude = "";
var gpsLongitude = "";

function successCallback(position) {

    gpsLatitude = position.coords.latitude;
    gpsLongitude = position.coords.longitude;
    getmyloc()
}

function getmyloc() {
    getlocbyGps(gpsLatitude, gpsLongitude);
}

function getlocbyGps(lat, lng) {
    var newlongitude = lng;
    var newlatitude = lat;
    $.post("/NewOrder/BaduMethod.ashx?action=1005", {
        xy: newlatitude + "," + newlongitude
    },
        function (data) {
            if (data.status == "0") {
                newlongitude = data.result.location.lng;
                newlatitude = data.result.location.lat;
                wx_loc = newlongitude + "," + newlatitude;
                var ncity = data.result.addressComponent.city;
                var district = data.result.addressComponent.district;
                ncity = district == "固始县" ? district : ncity;
                SetAddress(data.result.formatted_address, ncity);
                $.post("../bizmall/AddOrderMethod.ashx?action=1008", {
                    x: newlongitude,
                    y: newlatitude,
                    city: ncity
                },
                    function (data) {
                        if (data.State == "1") {
                            if (data.Msg != "0") {
                                $("#nearNum").text(data.Msg);
                                $(".tips").show();
                            }
                        }
                    },
                    "json")
            }
        },
        "json")
}

function SetAddress(address, city) {
    wx_loc_address = address;
    wx_loc_city = city;
    wx_loc_tags = "";
    $("#StartCity").val(city);
    $("#curCity").text(city);

    if ($("#Temp_City").val() == "") {
        $("#Temp_City").val(city);
    }
    if ($("#SendType").val() == 1 || $("#SendType").val() == 5 || $("#SendType").val() == 3) {
        $("#EndCity").val(city);
        if ($("#EndXY").val() == "") {
            $("#EndXY").val(wx_loc);
        }
        if ($("#EndTitle").val() == "") {
            $("#EndTitle").val(address);
            $("#E_Address_Con").text(address);
            $("#E_Address_Con").css({ "color": "#333333" });
        }
    } else if ($("#SendType").val() == 11) {
        if ($("#StartXY").val() == "") {
            $("#StartXY").val(wx_loc);
        }
        if ($("#StartTitle").val() == "") {
            $("#StartTitle").val(address);
            $("#S_Address_Con").text(address);
            $("#S_Address_Con").css({ "color": "#fff" });
        }
    }
    else {
        if ($("#StartXY").val() == "") {
            $("#StartXY").val(wx_loc);
        }
        if ($("#StartTitle").val() == "") {
            $("#StartTitle").val(address);
            $("#S_Address_Con").text(address);
            $("#S_Address_Con").css({ "color": "#333333" });
        }
    }
    setTimeout("getPriceNot('" + city + "')", 50);

}

function getPriceNot(cname) {
    $.post("../bizmall/GetPriceV4.ashx?r=" + Math.random(), {
        action: "cityprice",
        cityname: cname,
        sendtype: $("#SendType").val()
    },
        function (data) {
            if (data.State == 1) {
                $("#pricenote").html(data.Body.PriceInfo);
                $("#StartCity").val(data.Body.CityName);
                $("#city").text(data.Body.CityName);
                $("#InsuranceStr").html(data.Body.InsuranceStr);
                $("#NavigationType").val(data.Body.NavigationType);
                if ($("#SendType").val() == "0" || $("#SendType").val() == "3") {
                    reloadbj();
                }

            }
        },
        "json")
}

function GetRequest() {
    var url = location.search;
    var theRequest = new Object();
    if (url.indexOf("?") != -1) {
        var str = url.substr(1);
        strs = str.split("&");
        for (var i = 0; i < strs.length; i++) {
            theRequest[strs[i].split("=")[0]] = unescape(strs[i].split("=")[1])
        }
    }
    return theRequest
}
//常用地址
setTimeout("GetLogAddressfrom()", 50);

function GetLogAddressfrom() {
    if ($("#useruid").val() == "0") {
        return false;
    }
    $.post("../bizmall/AddOrderMethod.ashx?action=1006", {
        uid: $("#useruid").val(),
        type: 1
    },
        function (data) {
            var tmp_str = "";
            if (data.State == "1") {
                $("#from_group_1").html("");
                $.each(data.Body,
                    function (i) {
                        if (data.Body[i] != null) {
                            tmp_str = "";
                            tmp_str += "<div class=\"place_card bor-b\" ><div class=\"place_r \">";
                            tmp_str += "<p class=\"place_t AddressTitle\">" + data.Body[i].AddressTitle + "</p>";
                            tmp_str += "<p class=\"place_b AddressNote\">" + data.Body[i].AddressNote + "</p>";
                            tmp_str += "<span class='LinkManMobile' style='display:none'>" + data.Body[i].LinkManMobile + "</span><span class='LinkMan' style='display:none'>" + data.Body[i].LinkMan + "</span><span class='UserNote' style='display:none'>" + data.Body[i].UserNote + "</span><span class='AddressLoc' style='display:none' >" + data.Body[i].AddressLoc + "</span><span class='CityName' style='display:none' >" + data.Body[i].CityName + "</span><span class='addressID' style='display:none' >" + data.Body[i].ID + "</span>";
                            if (data.Body[i].AddressType == 4) {
                                tmp_str += "</div><div class=\"collect\"><i class=\"icon icon_collected\"></i></div></div>";
                            } else {
                                tmp_str += "</div><div class=\"collect\"><i class=\"icon icon_collect\"></i></div></div>";
                            }
                            $("#from_group_1").append(tmp_str);
                        }
                    });
                $("#from_group_1 .place_r").on('click', function () {
                    $("#Temp_Title").val($(this).find(".AddressTitle").text()).hide();
                    $("#Temp_Title_P").text($(this).find(".AddressTitle").text()).show();
                    $("#Temp_Note_P").text($(this).find(".AddressNote").text()).show();
                    $("#Temp_City").val($(this).find(".CityName").text());
                    $("#Temp_XY").val($(this).find(".AddressLoc").text());
                    $("#Temp_AddressId").val($(this).find(".addressID").text());
                    $("#Temp_Note").val($(this).find(".AddressNote").text());
                    $("#Temp_City").val($(this).find(".CityName").text());
                    $("#DoorNum").val($(this).find(".UserNote").text());
                    $("#T_UserName").val($(this).find(".LinkMan").text());
                    $("#T_Phone").val($(this).find(".LinkManMobile").text());
                    //SaveAddressInfo();
                });
                $("#from_group_1 .icon_collect").on('click', function () {
                    if (!$(this).hasClass('icon_collected')) {
                        var id = $(this).parents(".collect").prev().find(".addressID").text();
                        CollectAddress_From_Update(4, id);


                    }

                });
            }
        },
        "json")
}
//收藏地址
setTimeout("GetCollectAddressfrom()", 50);

function GetCollectAddressfrom() {
    if ($("#useruid").val() == "0") {
        return false;
    }
    $.post("../bizmall/AddOrderMethod.ashx?action=1006", {
        uid: $("#useruid").val(),
        type: 4
    },
        function (data) {
            if (data.State == "1") {
                var tmp_str = "";
                $("#from_group_2").html("");
                console.log(data);
                $.each(data.Body,
                    function (i) {
                        if (data.Body[i] != null) {
                            tmp_str = "";
                            tmp_str += "<div class=\"place_card bor-b\" ><div class=\"place_r\">";
                            tmp_str += "<p class=\"place_t AddressTitle\">" + data.Body[i].AddressTitle + "</p>";
                            tmp_str += "<p class=\"place_b AddressNote\">" + data.Body[i].AddressNote + "</p>";
                            tmp_str += "<span class='LinkManMobile' style='display:none'>" + data.Body[i].LinkManMobile + "</span><span class='LinkMan' style='display:none'>" + data.Body[i].LinkMan + "</span><span class='UserNote' style='display:none'>" + data.Body[i].UserNote + "</span><span class='AddressLoc' style='display:none' >" + data.Body[i].AddressLoc + "</span><span class='CityName' style='display:none' >" + data.Body[i].CityName + "</span><span class='addressID' style='display:none' >" + data.Body[i].ID + "</span>";
                            tmp_str += "</div><div class=\"collect\"><i class=\"icon icon_collected\"></i></div></div>";
                            $("#from_group_2").append(tmp_str);
                        }
                    });
                $("#from_group_2 .place_r").on('click', function () {
  
                    $("#Temp_Title").val($(this).find(".AddressTitle").text()).hide();
                    $("#Temp_Title_P").text($(this).find(".AddressTitle").text()).show();
                    $("#Temp_Note_P").text($(this).find(".AddressNote").text()).show();
                    $("#Temp_City").val($(this).find(".CityName").text());
                    $("#Temp_XY").val($(this).find(".AddressLoc").text());
                    $("#Temp_AddressId").val($(this).find(".addressID").text());
                    $("#Temp_Note").val($(this).find(".AddressNote").text());
                    $("#Temp_City").val($(this).find(".CityName").text());
                    $("#DoorNum").val($(this).find(".UserNote").text());
                    $("#T_UserName").val($(this).find(".LinkMan").text());
                    $("#T_Phone").val($(this).find(".LinkManMobile").text());
                    //SaveAddressInfo();
                });
                $("#from_group_2 .icon_collected").on('click', function () {
                    if ($(this).hasClass('icon_collected')) {
                        var id = $(this).parents(".collect").prev().find(".addressID").text();
                        console.log($("#E_Address_Con").text())
                        var nowText = $(this).parent().prev().find(".AddressTitle").text();
                        if (nowText == $("#S_Address_Con").attr("data-value")) {
                            $("#S_Address_Con").parent().next().find(".icon").removeClass("icon_collected");
                        }
                        if (nowText == $("#E_Address_Con").attr("data-value")) {
                            $("#E_Address_Con").parent().next().find(".icon").removeClass("icon_collected");
                        }
                        layer.open({
                            content: '确定要取消收藏吗?',
                            btn: ["确定", "取消"],
                            yes: function () {
                                CollectAddress_Del(4, id);
                            },
                            no: function () {
                                layer.closeAll();
                            }
                        });


                    }
                });
            }
        },
        "json")
}

function CollectAddress_From_Update(type, id) {
    $.post("CollectAddress.ashx?action=1001", { id: id, AddressType: type },
        function (data) {
            if (data.State == "1") {
                setTimeout("GetLogAddressfrom()", 50);
                setTimeout("GetCollectAddressfrom()", 50)
            }
        }, "json")
}

function CollectAddress_From_Insert(AddressCity, AddressTitle, Location, AddressNote, UserNote, UserName, UserMobile, AddressId, uid, ysid) {
    $.post("CollectAddress.ashx?action=1003", {
        AddressId: $("#" + AddressId).val(),
        AddressCity: AddressCity,
        AddressTitle: AddressTitle,
        Location: Location,
        AddressNote: AddressNote,
        UserNote: UserNote,
        UserName: UserName,
        UserMobile: UserMobile,
        uid: uid
    },
        function (data) {
            if (data.State == "1") {
                $("#" + AddressId).val(data.Body);
                $("#" + ysid).addClass("icon_collected");
                setTimeout("GetCollectAddressfrom()", 50)
            }
        }, "json")
}



function CollectAddress_Del(type, id) {
    if (parseInt(id) > 0) {
        $.post("CollectAddress.ashx?action=1002", { id: id },
            function (data) {
                if (data.State == "1") {
                    setTimeout("GetLogAddressfrom()", 50);
                    setTimeout("GetCollectAddressfrom()", 50)
                    layer.closeAll();
                }
            },
            "json")
    }
}