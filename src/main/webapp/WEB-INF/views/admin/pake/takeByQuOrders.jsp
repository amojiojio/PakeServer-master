<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>取件订单</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, minimal-ui">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-barstyle" content="black-translucent">
    <meta name="mobile-web-app-capable" content="yes">
    <%@include file="../layout/source.jsp" %>
</head>

<body>
<!-- 框架布局开始 -->
<div class="app" id="app">
    <!-- 左侧菜单 -->
    <%@include file="../layout/left.jsp" %>
    <!-- 左侧菜单结束 -->
    <!-- 右侧内容 -->
    <div id="content" class="app-content box-shadow-z3" role="main">
        <!-- 顶部 -->
        <%@include file="../layout/header.jsp" %>
        <!-- 顶部 -->
        <!-- 底部 -->
        <%@include file="../layout/footer.jsp" %>
        <!-- 底部 -->
        <!-- 中部 -->
        <div class="app-body" id="view">

                <!-- padding start -->
                <div class="padding" style="margin-bottom: -3.9rem;">
                    <div class="box">
                        <div class="box-body p-v-md">
                            <form class="form-inline" role="form" action="/admin/takeByQuOrders" method="post">
                                <div class="form-group">
                                    <input type="text" name="id" class="form-control" placeholder="订单号" value="${run.id}">
                                </div>
                                <div class="form-group">
                                    <input type="text" name="endPhone" class="form-control" placeholder="联系电话" value="${run.endPhone}">
                                </div>

                                <div class="form-group">
                                    <select name="state" class="form-control" data-parsley-id="114">
                                        <option value="0" <c:if test="${run.state==0}">selected</c:if>>全部</option>
                                        <option value="1" <c:if test="${run.state==1}">selected</c:if> >待接单</option>
                                        <option value="2" <c:if test="${run.state==2}">selected</c:if>>已接单</option>
                                        <option value="3" <c:if test="${run.state==3}">selected</c:if>>已完成</option>
                                    </select>
                                </div>
                                <button type="submit" class="btn white pull-right">搜 索</button>
                            </form>
                        </div>
                    </div>
                </div>
                <!-- padding end -->
                <!-- padding start -->
                <div class="padding">
                    <div class="box">
                        <div class="box-header" style="height: 80px">
                            <h3 style="margin-left: 10px;margin-top: 10px">取件订单
                            </h3>
                        </div>

                        <div class="table-responsive">
                            <table class="table table-striped b-t">
                                <thead>
                                <tr>
                                    <th>订单号</th>
                                    <th>支付状态</th>
                                    <th>收件人</th>
                                    <th>电话</th>
                                    <th>预约时间</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${pagination.list}" var="row" varStatus="index">
                                    <tr>
                                        <td>${row.id}</td>
                                        <c:if test="${row.payState==1}">
                                        <td><span style="color: green">已支付</span></td>
                                        </c:if>
                                        <td>${row.endUserName}</td>
                                        <td>${row.endPhone}</td>
                                        <td>
                                            <c:if test="${row.isSubscribe==0}">
                                                立即上门
                                            </c:if>
                                            <c:if test="${row.isSubscribe==1}">
                                                <fmt:formatDate value="${row.subscribeTime}" pattern="yyyy/MM/dd HH:mm"/>
                                            </c:if>
                                        </td>
                                        <td>
                                            <c:if test="${row.state==1}"><button class="btn rounded  btn-sm warn" onclick="taking('${row.id}')" data-toggle="modal">接 单</button></c:if>
                                            <c:if test="${row.state==2}"><button class="btn rounded  btn-sm primary" onclick="taking('${row.id}')" data-toggle="modal">进行中</button></c:if>
                                            <c:if test="${row.state==3}"><button class="btn rounded  btn-sm success" onclick="taking('${row.id}')" data-toggle="modal">查 看</button></c:if>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <!-- 分页条 -->
                    <div class="row" style="text-align: center;"><%@include file="../layout/pagination.jsp" %></div>
                    <!-- 分页条END -->

                </div>
                <!-- padding END -->
            </div>
        </div>
        <!-- 中部 END-->
    </div>
    <!-- 框架布局结束 -->
</div>
<script>
    function taking(id){
        layer.open({
            type: 2,
            title: '订单明细',
            shadeClose: true,
            area: ['80%', '75%'],
            content: '${pageContext.request.contextPath}/admin/lookByQu?id='+id
        });
    };
</script>
</body>
</html>
