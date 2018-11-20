<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
<%@include file="../layout/source.jsp" %>
<script type="text/javascript">
function doSync(){
	layer.confirm('确定同步？', {
	 btn: ['确定', '取消'] //按钮
	}, function(){
	 layer.load();
	 window.location.href='${pageContext.request.contextPath}/wxapi/syncAccountFansList.action';
	}, function(){
	layer.close();
	});
	};
</script>
</head>

<body >
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
<div  class="app-body" id="view">
<div style="min-height: 200px">
<!-- padding start -->
<div class="padding" >
<!-- 内容部分 -->
<div class="box">
<div class="box-header">
          <h2>粉丝管理 <button class="btn white" onclick="doSync();">批量同步粉丝</button></h2>
       </div>
        <div class="box-divider m-a-0"></div>
        <div class="box-body p-v-md">
          <form class="form-inline" role="form">
            <div class="form-group">
              <input type="text" class="form-control"  placeholder="昵称">
            </div>
            <div class="form-group">
              <input type="text" class="form-control"  placeholder="省份">
            </div>
            <div class="form-group">
            <input type="text" class="form-control"  placeholder="城市">
            </div>
            <div class="checkbox inline m-x">
            <select class="form-control c-select">
                  <option>请选择</option>
                  <option>男</option>
                  <option>女</option>
                </select>
            </div>
            <button type="submit" class="btn white">搜 索</button>
          </form>
        </div>
      </div>
      
<div class="row">
<c:forEach items="${pagination.list}" var="row">
<div class="col-xs-6 col-sm-12 col-md-6">
				  <div class="box">
				    <div class="item">
					    <div class="item-bg primary h6">
					    	<p class="p-a"><span class="label success pos-rlt m-r-xs"><b class="arrow right b-success pull-in"></b>OpenId:</span> ${row.openId}</p>
					    </div>
					    <div class="p-a p-y-lg pos-rlt">
					    	<img src="${row.headimgurl}" class="img-circle w-64" style="margin-bottom: -7rem">
					    </div>
					</div>
				    <div class="p-a">
				    	<span class="text-md m-t block">
				    	${row.nicknameStr}
				    	<c:choose>  
					   <c:when test="${row.gender==1}">
		    		   <span class="label rounded primary" style="float: right;">男</span>
					   </c:when>  
					   <c:otherwise>
					   <span class="label rounded warning" style="float: right;">女</span>
					   </c:otherwise>  
					</c:choose>  
				    	</span>
				    	<p><small>${row.country} - ${row.province} - ${row.city}</small></p>
				    	<p>
				    	关注时间： 
				    	<span class="label blue">
				    	<fmt:formatDate value="${row.createtime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				    	</span>
				    	</p>
				  </div></div>
				</div>
</c:forEach>
</div>

<!-- 分页条 -->		
<div class="row" style="text-align: center;"><%@include file="../layout/pagination.jsp" %></div>
<!-- 分页条END -->		
      
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
