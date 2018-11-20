<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>校园派客</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, minimal-ui">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-barstyle" content="black-translucent">
    <meta name="mobile-web-app-capable" content="yes">
    <%@include file="layout/source.jsp" %>
</head>

<body>
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
        <div class="app-body" id="view">
            <div style="min-height: 200px">
                <!-- padding start -->
                <div class="padding">
                    <!-- 内容部分 -->
                    内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容内容
                    <!-- 内容部分END -->
                </div>
                <!-- padding END -->
            </div>
        </div>
        <!-- 中部 END-->
    </div>
    <!-- 框架布局结束 -->
</div>
</body>
</html>
