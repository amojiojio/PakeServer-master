<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>校园派客</title>

<%@include file="../layout/source.jsp" %>
<script type="text/javascript">
	function fnSave(){
		var account = $('#id_account').val();
		account = account.replace(/(\s*$)/g, '');
		if(account == ''){
			layer.msg("请填写微信公众号ID");
			return false;
		}
		$.ajax({
			url:'getUrl.action',          
            type:"post",  
            async: false,  
            data:$('#acountForm').serialize(),
            success:function(data){  
       		location.reload();
            layer.msg("已成功获取URL 和 Token，请填写到微信平台中");
            },  
            error:function(data){  
            layer.msg("获取URL 和 Token失败");
            }  
		});
	}
</script>
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
<div ui-view="" class="app-body" id="view">
<!-- 内容部分 -->
		<div style="min-height: 200px">
		<!-- padding start -->
<div class="padding" >


<div class="box">
    <div class="box-header">
      <h3>Url和Token</h3>
      <small>填写公众号ID，点击保存按钮，系统将自动生成 URL 和 Token 。将它们填写到公众平台开发者中心 中，公众账号即可升级成为开发者账号</small>
    </div>
    <div class="box-body dker">
      <form id="acountForm" role="form" class="p-a-md">
		<input type="hidden" name="id" value="${account.id}"/>
         <div class="form-group">
           <label>公众号ID</label>
             <input id="id_account" name="account" type="text" class="form-control" value="${account.account}"/>
         </div>
         <div class="form-group">
           <label>URL</label>
           <input id="id_url" readonly="readonly" name="url" type="text" class="form-control" value="${account.url}"/>
         </div>
         <div class="form-group">
           <label>Token</label>
           <input id="id_tocken" readonly="readonly" name="token" type="text" class="form-control" value="${account.token}"/>
         </div>
         <div class="form-group">
           <label>AppId</label>
           <input name="appid" name="token" type="text" class="form-control" value="${account.appid}"/>
         </div>
         <div class="form-group">
           <label>AppSecret</label>
           <input name="appsecret" type="text" class="form-control" value="${account.appsecret}"/>
         </div>
         <div class="form-group">
           <label>消息条数</label>   
          <select name="msgcount" id="single-append-text" class="form-control select2-allow-clear">
          	<option value="1" <c:if test="${account.msgcount==1}">selected="selected"</c:if>>1条</option>
			<option value="2" <c:if test="${account.msgcount==2}">selected="selected"</c:if>>2条</option>
			<option value="3" <c:if test="${account.msgcount==3}">selected="selected"</c:if>>3条</option>
			<option value="4" <c:if test="${account.msgcount==4}">selected="selected"</c:if>>4条</option>
			<option value="5" <c:if test="${account.msgcount==5}">selected="selected"</c:if>>5条</option> 
			<option value="6" <c:if test="${account.msgcount==6}">selected="selected"</c:if>>6条</option>
			<option value="7" <c:if test="${account.msgcount==7}">selected="selected"</c:if>>7条</option>
			<option value="8" <c:if test="${account.msgcount==8}">selected="selected"</c:if>>8条</option>
          </select>  
         </div>
         <!-- <button type="submit" class="btn btn-info m-t" onclick="return dosubmit();">保存</button> -->
         <button class="btn btn-info m-t" type="button" onclick="fnSave()">保存</button>
         </form>
    </div>
  </div>

</div>
		</div>
   <!-- 内容部分 -->
</div>
 <!-- 中部 -->
  </div>
<!-- 框架布局结束 -->
</div>
</body>
</html>
