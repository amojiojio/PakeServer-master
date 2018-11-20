<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<body>
<div id="aside" class="app-aside modal fade nav-expand">
    <div class="left navside black dk" layout="column">
        <div class="navbar no-radius">
            <!-- brand -->
            <a class="navbar-brand">
                <span class="hidden-folded inline">派 客</span>
            </a>
            <!-- / brand -->
        </div>
        <div flex="" class="hide-scroll">
            <nav class="scroll nav-stacked nav-active-primary">

                <ul class="nav" ui-nav="">
                    <li class="nav-header hidden-folded">
                        <small class="text-muted">Main</small>
                    </li>

                    <li <c:if test="${cur_nav =='index'}">class="active"</c:if>>
                    <a href="${pageContext.request.contextPath}/admin/index.html">
                      <span class="nav-icon"><i class="fa  fa-pie-chart"></i></span>
                        <span class="nav-text">主页</span>
                        </a>
                    </li>

                    <li>
                        <a href="${pageContext.request.contextPath}/admin/runOrders.html">
                            <span class="nav-icon"><i class="fa fa-bicycle"></i></span>
                            <span class="nav-text">跑腿订单</span>
                        </a>
                    </li>

                    <li>
                        <a href="${pageContext.request.contextPath}/admin/takeByQuOrders.html">
                            <span class="nav-icon"><i class="fa fa-truck"></i></span>
                            <span class="nav-text">代取订单</span>
                        </a>
                    </li>

                    <li>
                        <a href="${pageContext.request.contextPath}/admin/takeBySongOrders.html">
                            <span class="nav-icon"><i class="fa fa-paper-plane"></i></span>
                            <span class="nav-text">代收订单</span>
                        </a>
                    </li>

                    <li>
                        <a href="${pageContext.request.contextPath}/admin/wxcms/urltoken.html">
                        <span class="nav-icon"><i class="fa fa-cog"></i></span>
                            <span class="nav-text">微信公众号配置</span>
                        </a>
                    </li>

                    <li>
                        <a href="${pageContext.request.contextPath}/admin/msgtext/textPagination.html">
                            <span class="nav-icon"><i class="fa fa-navicon"></i></span>
                            <span class="nav-text">文本消息</span>
                        </a>
                    </li>

                    <li>
                        <a href="${pageContext.request.contextPath}/admin/msgnews/msgNewsPagination.html">
                            <span class="nav-icon"><i class="fa fa-tags"></i></span>
                            <span class="nav-text">图文消息</span>
                        </a>
                    </li>

                    <li>
                        <a href="${pageContext.request.contextPath}/admin/accountmenu/menuPagination.html">
                            <span class="nav-icon"><i class="fa fa-tasks"></i></span>
                            <span class="nav-text">菜单管理</span>
                        </a>
                    </li>

                    <li>
                        <a href="${pageContext.request.contextPath}/admin/accountfans/fansPagination.html">
                            <span class="nav-icon"><i class="fa fa-tree"></i></span>
                            <span class="nav-text">粉丝管理</span>
                        </a>
                    </li>
                </ul>
            </nav>
        </div>
        <div class="b-t">
            <div class="nav-fold">
                <a href="profile.html">
        	    <span class="pull-left">
        	      <img src="${pageContext.request.contextPath}/resource/imgs/a3.jpg" alt="..." class="w-40 img-circle">
        	    </span>
                    <span class="clear hidden-folded p-x">
        	      <span class="block _500">Jean Reyes</span>
        	      <small class="block text-muted"><i class="fa fa-circle text-success m-r-sm"></i>online</small>
        	    </span>
                </a>
            </div>
        </div>
    </div>
</div>
</body>
</html>
