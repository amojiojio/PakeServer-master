<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>校园派客</title>
<%@include file="layout/source.jsp" %>
  <script src="${pageContext.request.contextPath}/resource/echar/echarts.min.js"></script>
</head>

<body >
<!-- 框架布局开始 -->
 <div class="app" id="app">
 <!-- 左侧菜单 -->
  <%@include file="layout/left.jsp" %>
<!-- 左侧菜单结束 -->  
	<!-- 右侧内容 -->
<div id="content" class="app-content box-shadow-z3" role="main">
			<!-- 顶部 -->
			<%@include file="layout/header.jsp" %>
			<!-- 顶部 -->
   			<!-- 底部 -->
			<%@include file="layout/footer.jsp" %>
			<!-- 底部 -->
    	<!-- 中部 -->
<div  class="app-body" id="view">
<!-- 内容部分 -->
		<div style="min-height: 200px">
		<!-- padding start -->
<div class="padding" >

	<div class="row">
      <a href="/admin/runOrders"><div class="col-sm-6 col-md-4">
        <div class="box p-a">
          <div class="pull-left m-r">
            <span class="w-40 warn text-center rounded">
              <i class="material-icons">shopping_basket</i>
            </span>
          </div>
          <div class="clear">
            <h4 class="m-a-0 text-md"> ${datas[0].num} <span class="text-sm">单</span></h4>
            <small class="text-muted">待 处 理 跑 腿 订 单 总 数</small>
          </div>
        </div>
      </div>
      </a>

      <a href="/admin/takeByQuOrders">
      <div class="col-sm-6 col-md-4">
        <div class="box-color p-a primary">
          <div class="pull-right m-l">
            <span class="w-40 dker text-center rounded">
              <i class="material-icons">local_shipping</i>
            </span>
          </div>
          <div class="clear">
            <h4 class="m-a-0 text-md">${datas[1].num}  <span class="text-sm">单</span></h4>
            <small class="text-muted">待 处 理 代 取 订 单</small>
          </div>
        </div>
      </div>
      </a>

      <a href="/admin/takeBySongOrders">
      <div class="col-sm-6 col-md-4">
        <div class="box p-a">
          <div class="pull-right m-l">
            <span class="w-40 accent text-center rounded">
              <i class="material-icons">people</i>
            </span>
          </div>
          <div class="clear">
            <h4 class="m-a-0 text-md">${datas[2].num}  <span class="text-sm">单</span></h4>
            <small class="text-muted">待 处 理 代 收 订 单</small>
          </div>
        </div>
      </div>
      </a>

	</div>

  <div class="row">

    <div class="col-sm-12">
      <div class="padding box" id="one" style="width: 100%;height: 600px;">
      </div>
    </div>
    <%--<div class="col-sm-12">--%>
      <%--<div class="padding box" id="two" style="width: 100%;height: 600px;">--%>
      <%--</div>--%>
    <%--</div>--%>
    <div class="col-sm-12">
      <div class="padding box" id="three" style="width: 100%;height: 600px;">
      </div>
    </div>
    <div class="col-sm-12">
      <div class="padding box" id="four" style="width: 100%;height: 600px;">
      </div>
    </div>

  </div>
  
<!-- 分页条 -->
<div class="row" style="text-align: center;"><%@include file="layout/pagination.jsp" %></div>
<!-- 分页条END -->		
  
</div>
		</div>
   <!-- 内容部分 -->
</div>
 <!-- 中部 -->
  </div>
<!-- 框架布局结束 -->
</div>

<script>
  var one = echarts.init(document.getElementById('one'));
  option = {
      title : {
          text: '总订单数据统计',
          x:'center'
      },
      tooltip : {
          trigger: 'item',
          formatter: "{a} <br/>{b} : {c} ({d}%)"
      }
  };

  // 异步加载数据
  $.ajax({
      url: "/admin/one",
      type: "get",
      dataType: "json",
      beforeSend: function () {
          one.showLoading();
      },
      complete: function () {
          one.hideLoading();
      },
      success: function (data) {
          one.setOption({
              legend: {
                  orient: 'vertical',
                  left: 'left',
                  data: data.dataName
              },
              series: [
                  {
                      name: '访问来源',
                      type: 'pie',
                      radius: '55%',
                      center: ['50%', '60%'],
                      data: data.dataValue,
                      itemStyle: {
                          emphasis: {
                              shadowBlur: 10,
                              shadowOffsetX: 0,
                              shadowColor: 'rgba(0, 0, 0, 0.5)'
                          }
                      }
                  }
              ]
          });
      },
      error: function () {
          alert("error")
      }
  });
  one.setOption(option);


  // var two = echarts.init(document.getElementById('two'));
  // option = {
  //     title: {
  //         text: '每日订单数量统计（跑腿）',
  //         subtext: '仅显示近一个月数据'
  //     }
  // };
  //
  // $.ajax({
  //     url: "/admin/two",
  //     type: "get",
  //     dataType: "json",
  //     beforeSend: function () {
  //         two.showLoading();
  //     },
  //     complete: function () {
  //         two.hideLoading();
  //     },
  //     success: function (data) {
  //         two.setOption({
  //             xAxis: {
  //                 type: 'category',
  //                 boundaryGap: false,
  //                 data: data.dateList
  //             },
  //             yAxis: {
  //                 type: 'value'
  //             },
  //             series: [{
  //                 data: data.valueList,
  //                 type: 'line',
  //                 areaStyle: {}
  //             }]
  //         });
  //     },
  //     error: function () {
  //         alert("error")
  //     }
  // });
  //
  // two.setOption(option);


  var three = echarts.init(document.getElementById('three'));
  option = {
      title: {
          text: '每日订单数量统计（代取）',
          subtext: '仅显示近一个月数据'
      }
  };

  $.ajax({
      url: "/admin/three",
      type: "get",
      dataType: "json",
      beforeSend: function () {
          three.showLoading();
      },
      complete: function () {
          three.hideLoading();
      },
      success: function (data) {
          three.setOption({
              xAxis: {
                  type: 'category',
                  boundaryGap: false,
                  data: data.dateList
              },
              yAxis: {
                  type: 'value'
              },
              series: [{
                  data: data.valueList,
                  type: 'line',
                  areaStyle: {}
              }]
          });
      },
      error: function () {
          alert("error")
      }
  });

  three.setOption(option);



  var four = echarts.init(document.getElementById('four'));
  option = {
      title: {
          text: '每日订单数量统计（代收）',
          subtext: '仅显示近一个月数据'
      }
  };

  $.ajax({
      url: "/admin/four",
      type: "get",
      dataType: "json",
      beforeSend: function () {
          four.showLoading();
      },
      complete: function () {
          four.hideLoading();
      },
      success: function (data) {
          four.setOption({
              xAxis: {
                  type: 'category',
                  boundaryGap: false,
                  data: data.dateList
              },
              yAxis: {
                  type: 'value'
              },
              series: [{
                  data: data.valueList,
                  type: 'line',
                  areaStyle: {}
              }]
          });
      },
      error: function () {
          alert("error")
      }
  });

  four.setOption(option);

</script>
</body>
</html>
