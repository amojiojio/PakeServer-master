 <%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>校园派客</title>
<%@include file="source.jsp" %>
</head>
<body class=" pace-done" ui-class="">
<div class="pace  pace-inactive">
<div class="pace-progress" data-progress-text="100%" data-progress="99" style="transform: translate3d(100%, 0px, 0px);">
  <div class="pace-progress-inner"></div>
</div>
<div class="pace-activity"></div></div>
  <div class="app" id="app">

  <div class="center-block w-xxl w-auto-xs p-y-md">
    <div class="p-a-md box-color r box-shadow-z1 text-color m-a">
      <form name="form" action="${pageContext.request.contextPath}/admin/login" method="post">
        <div class="md-form-group float-label">
          <input type="text" class="md-input" name="username">
          <label>用 户 名</label>
        </div>
        <div class="md-form-group float-label">
          <input type="password" class="md-input" name="password">
          <label>密 码</label>
        </div>      
        <button type="submit" class="btn primary btn-block p-x-md">登 录</button>
      </form>
    </div>
    </div>

  </div>
</body>
</html>