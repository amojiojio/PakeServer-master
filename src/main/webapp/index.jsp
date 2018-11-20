<%@ page language="java" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <base href="<%=basePath%>">
    <title>校园派客</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta name="baidu-site-verification" content="Z3aQRrKFvw"/>
    <link rel="shortcut icon" sizes="128x128" href="${pageContext.request.contextPath}/resource/imgs/favicon.ico">
    <link href="<%=basePath %>/resource/index/index.css" rel="stylesheet" type="text/css" media="all"/>
    <script type="text/javascript">
        function reload() {
            location.reload();
        }
    </script>
</head>
<body id="PageTop" style="font-family: 微软雅黑;">
<div class="wrap">
    <header class="Header clear">
        <h1 class="Logo">
            <a href="javascript:void(0);" onclick="reload();">
                <img src="<%=basePath %>/resource/imgs/logo_black.png" alt="Pake" height="30"></a></h1>
    </header>
    <div class="Container">
        <div class="Container__inner">

            <article id="JsFirstBlock" class="FirstBlock">
                <div class="FirstBlock__inner">
                    <ul class="FirstBlock__items">
                        <li class="FirstBlock__item">
                            <div class="FirstBlock__item-inner">
                                <h3><img src="<%=basePath %>/resource/index/mission.png" alt="MISSION" width="180"
                                         height="180"></h3>
                                <p>微信<br>扫描二维码<br>关注我们</p>
                            </div>
                        </li>
                    </ul>
                </div>
            </article>

        </div>
    </div>
</div>

</div>
<canvas id="jsCanvas" class="canvas" width="1200" height="500"></canvas>
<script type="text/javascript" src="<%=basePath %>/resource/index/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath %>/resource/index/velocity.min.js"></script>
<script type="text/javascript" src="<%=basePath %>/resource/index/velocity.ui.min.js"></script>
<script type="text/javascript" src="<%=basePath %>/resource/index/easeljs-0.7.1.min.js"></script>
<script type="text/javascript" src="<%=basePath %>/resource/index/tweenjs-0.6.0.min.js"></script>
<script type="text/javascript" src="<%=basePath %>/resource/index/jazy19.min.js"></script>
</body>
</html>
