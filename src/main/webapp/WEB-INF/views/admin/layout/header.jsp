<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script type="text/javascript">
        function getRootPath_web() {
            var curWwwPath = window.document.location.href;
            var pathName = window.document.location.pathname;
            var pos = curWwwPath.indexOf(pathName);
            var localhostPaht = curWwwPath.substring(7, pos);
            var projectName = pathName.substring(0, pathName.substr(1).indexOf('/') + 1);
            return (localhostPaht + projectName);
        }

        var websocket = null;
        //判断当前浏览器是否支持WebSocket
        if ('WebSocket' in window) {
            websocket = new WebSocket("ws://" + getRootPath_web() + "/websocket");
        }
        else {
            alert('当前浏览器 Not support websocket')
        }
        //连接发生错误的回调方法
        websocket.onerror = function () {
            setMessageInnerHTML("webSocket连接发生错误</br>");
        };
        //连接成功建立的回调方法
        websocket.onopen = function () {
            $("#log").html('webSocket连接成功');
        }
        //接收到消息的回调方法
        websocket.onmessage = function (event) {
            setMessageInnerHTML(event.data + "</br>");
        }
        //连接关闭的回调方法
        websocket.onclose = function () {
            $("#log").html('webSocket连接关闭');
        }
        //监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。
        window.onbeforeunload = function () {
            closeWebSocket();
        }

        //将消息显示在网页上
        function setMessageInnerHTML(data) {
            var audioElement = document.createElement('audio');
            audioElement.setAttribute('src', '/resource/mp3/1024.wav');
            $("#log").html(data);
            audioElement.play();
        }

        //关闭WebSocket连接
        function closeWebSocket() {
            websocket.close();
        }

        //发送消息
        function send() {
            var message = document.getElementById('text').value;
            websocket.send(message);
        }
    </script>
</head>
<body>
<div class="app-header white box-shadow">
    <div class="navbar">
        <!-- Open side - Naviation on mobile -->
        <a data-toggle="modal" data-target="#aside" class="navbar-item pull-left hidden-lg-up"> <i
                class="material-icons"></i>
        </a>
        <!-- / -->
        <ul class="nav navbar-nav pull-left">
            <li class="nav-item dropdown">
                <a class="nav-link" href="" data-toggle="dropdown">
                    <i class="fa fa-fw fa-plus text-muted"></i>
                    <span id="log"></span>
                </a>
            </li>
        </ul>
        <!-- navbar right -->
        <ul class="nav navbar-nav pull-right">
            <li class="nav-item dropdown"><a class="nav-link clear" href="" data-toggle="dropdown">
                <span class="avatar w-32">
                    <img src="${pageContext.request.contextPath}/resource/imgs/a3.jpg" alt="...">
                    <i class="on b-white bottom"></i>
                  </span>
            </a>
            </li>
            <li class="nav-item hidden-md-up"><a class="nav-link collapsed" data-toggle="collapse"
                                                 data-target="#collapse" aria-expanded="false"> <i
                    class="fa fa-search"></i>
            </a></li>
        </ul>
        <!-- / navbar right -->

        <!-- navbar collapse -->
        <div class="navbar-toggleable-sm collapse" id="collapse" aria-expanded="false" style="height: 0px;">
            <form class="navbar-form form-inline pull-right pull-none-sm navbar-item v-m" role="search">
                <div class="form-group l-h m-a-0">
                    <div class="input-group">
                        <input type="text" class="form-control form-control-sm p-x b-a rounded"
                               placeholder="Search projects...">
                    </div>
                </div>
            </form>
        </div>
        <!-- / navbar collapse -->
    </div>
</div>
</body>
</html>
