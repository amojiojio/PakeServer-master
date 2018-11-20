<%@ page contentType="text/html;charset=UTF-8" language="java"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>菜单组列表</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, minimal-ui">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-barstyle"
	content="black-translucent">
<meta name="mobile-web-app-capable" content="yes">
<%@include file="../layout/source.jsp"%>
<script type="text/javascript">
function doDelete(id) {
layer.confirm('确定删除吗？', {
		  skin: 'layui-layer-molv', //样式类名
		  btn: ['确定','取消'] //按钮
		}, function(){
		$.ajax({
				url : "deleteMenuGroup.action?id="+id,
				type : "get",
				dataType:"text",
				success : function(data) {
				if(data=="success"){
					$("#" + id).remove();
					layer.msg('删除菜单成功');
				}else{
					layer.msg('删除菜单失败');
				}
				},
				error : function() {
					layer.msg('系统异常');
				}
			});
		}, function(){
		
		});
	}
	
function toSaveOrUpdate(id){
	 var content = '../accountmenu/toSaveOrUpdateMenuGroup.action?id=';
     if(typeof(id)!="undefined"){
     content= '../accountmenu/toSaveOrUpdateMenuGroup.action?id='+id
	  }
	layer.open({
	  title:'添加或修改菜单组名称',
	  type: 2,
	  area: ['700px', '210px'],
	  scrolling:'no',
	  scrollbar: false,
	  fixed: false, //不固定
	  maxmin: true,
	  content:  [content, 'no']
	});
	}

	function doPublish(gid) {
			if (confirm("确定生成微信账号菜单?")) {
				$.ajax({
					url : '${pageContext.request.contextPath}/wxapi/publishMenu.action',
					type : "post",
					dataType : "text",
					data : {
						"gid" : gid
					},
					success : function(data) {
						if(data=="success"){
							layer.msg('生成菜单成功');
						}else{
						layer.msg(data);
						}
					},
					error : function() {
						layer.msg('生成菜单失败');				
					}
				})
			}
	}
	
		function doCancel(){
			layer.confirm('确定删除微信账号菜单？', {
		    btn: ['确认','取消'] //按钮
			}, function(){
			$.ajax({
					url:"${pageContext.request.contextPath}/wxapi/deleteMenu.action",
					async:false,
		  			type:'GET',
		  			dataType:'json',
					success:function(data){
					if (data.message=='success') {
					 layer.msg('删除成功');
					setTimeout(function(){
					parent.location.reload();
					}, 1500);
  					}
					if (data.message=='warring') {
		  		     layer.msg('删除失败，请检查');
		  		     setTimeout(function(){
					parent.location.reload();
					}, 1500);
		  			}
					if (data.message=='error') {
		  		     layer.msg('缓存账号为空');
		  		     setTimeout(function(){
					parent.location.reload();
					}, 1500);
		  			}
					}
				});
			}, function(){
			layer.close();
			});
			}
			
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
		<div class="box-header" style="height: 80px">
		<h3 style="margin-left: 10px;margin-top: 10px">菜单组
		<button style="float: right;" class="btn btn-fw success" onclick="toSaveOrUpdate();" data-toggle="modal">添 加</button>
		<button style="float: right;" class="btn btn-fw success" onclick="doCancel();">删除微信端菜单</button>
		</h3>
		</div>
						
	<div class="table-responsive">
      <table class="table table-striped b-t">
        <thead>
          <tr>
            <th>序号</th>
            <th>菜单组名称</th>
            <th>是否启用</th>
            <th style="width:50px;"></th>
            <th style="width:50px;"></th>
            <th style="width:50px;"></th>
          </tr>
        </thead>
        <tbody>
        
    <c:forEach var="row" items="${pagination.list}" varStatus="index">
    <tr id="${row.id}">
	<td>${index.index+1 }</td>		
	<td id="${row.id}1">${row.name}</td>
	<td>
	<label class="ui-switch primary m-t-xs m-r">
          <input type="checkbox"  <c:if test="${row.enable==1}">checked</c:if>  class="has-value" value="${row.id}" onchange="doPublish(${row.id})">
          <i></i>
        </label>
	</td>
	<td>
	<td>
	<a href="javascript:toSaveOrUpdate('${row.id}');" ><i class="fa fa-pencil" style="color: green;"></i></a>
	</td>
	<td>
	<a href="javascript:doDelete('${row.id}');" ><i class="fa fa-times" style="color: red;"></i></a>
	</td>
	<td>
	<a href="../accountmenu/accountMenus.html?gid=${row.id}" ><i class="fa fa-arrows" ></i></a>
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
