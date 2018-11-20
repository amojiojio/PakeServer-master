<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>SuTa</title>
<%@include file="../layout/source.jsp" %>
<script type="text/javascript">
	function deleteMsg(id,baseId){
	layer.confirm('确定删除吗？', {
		  skin: 'layui-layer-molv', //样式类名
		  btn: ['确定','取消'] //按钮
		}, function(){
	   	$.ajax({
 		url : 'deleteMsg.action',
		type : "post",
		data : {"id":id,"baseId":baseId},
		success : function(data) {
			layer.msg('删除成功');
			$("#"+id).remove();
		},
		error:function(data){
		layer.msg('删除失败');
		}
	  }); 
		}, function(){
		});
	}
	
	function toSaveOrUpdate(id){
	 var content = '../msgnews/toMerge.action?id=';
     if(typeof(id)!="undefined"){
     content= '../msgnews/toMerge.action?id='+id
	  }
	layer.open({
	  title:'添加或修改文本消息',
	  type: 2,
	  area: ['800px', '450px'],
	  fixed: false, //不固定
	  maxmin: true,
	  content: content
	});
	}
</script>
</head>

<body>
<div class="app" id=app>
<!-- 框架布局开始 -->
<!-- 左侧菜单 -->
<%@include file="../layout/left.jsp" %>
<!-- 左侧菜单 -->
<!-- 右侧内容 -->
<div id="content" class="app-content box-shadow-z3" role="main">
<!-- 顶部 -->
<%@include file="../layout/header.jsp" %>
<!-- 顶部 -->

<!-- 中部 -->
<div class="app-body" id="view">
<!-- padding start -->
<div class="padding">
	<div class="box">
		<div class="box-header" style="height: 80px">
		<h3 style="margin-left: 10px;margin-top: 10px">图文消息
		<button style="float: right;" class="btn btn-fw success" onclick="toSaveOrUpdate()" data-toggle="modal">添 加</button>
		</h3>
		</div>
				<div class="table-responsive">
					<table class="table table-striped b-t">
						<thead>
							<tr>
								<th>关键词</th>
								<th>标题</th>
								<th>图片</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${pagination.list}" var="row">
								<tr id="${row.id}">
									<td>${row.inputcode}</td>
									<td>${row.title}</td>
									<td><img src="${row.picpath}" style="border:none;height:40px;width:60px;"/></td> 
									<td>
									<a href="javascript:void(0);" onclick="toSaveOrUpdate('${row.id}')"><i class="fa fa-pencil" style="color: green;"></i></a>
									<a href="javascript:deleteMsg(${row.id},${row.baseId});" ><i class="fa fa-times" style="color: red;"></i></a>
										<c:choose>
									   		<c:when test="${row.fromurl!=''}">
									   			<a href="${row.fromurl}" target="_blank" ><i class="fa fa-eye" ></i></a>
									   		</c:when>						
									   		<c:otherwise>
									   			<a href="../wxweb/msg/newsread.action?id=${row.id}" target="_blank" ><i class="fa fa-eye" ></i></a>
									   		</c:otherwise>
										</c:choose>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				
</div>
</div>
<!-- 中部 -->

<!-- 右侧内容 -->
</div>
<!-- 分页条 -->		
	<div class="row" style="text-align: center;"><%@include file="../layout/pagination.jsp" %></div>
<!-- 分页条END -->
</div>
<!-- 框架布局结束 -->
</div>
</body>
</html>
