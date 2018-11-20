<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>菜单列表</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, minimal-ui">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-barstyle"
	content="black-translucent">
<meta name="mobile-web-app-capable" content="yes">
<%@include file="../layout/source.jsp"%>
<script type="text/javascript">

	function doupdata(id) {
		var myid = id + 1;
		var tdval = $("#" + myid).text();
		$("#" + id).attr("style" ,"color: red") 
		/*  */
		//ifm层
		layer.open({
  		type: 2, 
  		closeBtn:1,
  		anim: 6,
  		fixed:true,
 		skin: 'layui-layer-rim', //加上边框
 		area: ['800px', '540px'], //宽高
  		content: '../accountmenu/doupdate.action?id='+id,
		}); 
		/*  */

			
	}
	function doAdd() {
		var gid = $('#id_gid').val();
		if (gid!="") {
			layer.open({
	  		type: 2, 
	  		closeBtn:1,
	  		anim: 6,
	  		fixed:true,
	 		skin: 'layui-layer-rim', //加上边框
	 		area: ['800px', '540px'], //宽高
	  		content: '../accountmenu/doaddmenu.action?id='+gid,
			}); 
		} else {
			layer.msg('请先保存菜单组名称');
		}
	}
	function doSaveGroupMenu() {
		var name = $('#id_name').val();
		if (!rf.isEmpty(name)) {
			$('#id_menu_group_form').attr('action', '/wxcms/accountMenuGroup/doMerge.html');
			$('#id_menu_group_form').submit();
		} else {
			alert('菜单组名称不能为空');
		}
	}
	function doDelete(id) {
		if (confirm("确定删除?")) {
			window.location.href = '/accountmenu/delete.html?id=' + id + '&gid=${groupEntity.id}';
		}
	}
	function doBack() {
		window.location.href = '/wxcms/accountMenuGroup/paginationEntity.html';
	}
</script>
</head>

<body>
	<!-- 框架布局开始 -->
	<div class="app" id="app">
		<!-- 左侧菜单 -->
		<%@include file="../layout/left.jsp"%>
		<!-- 左侧菜单结束 -->
		<!-- 右侧内容 -->
		<div id="content" class="app-content box-shadow-z3" role="main">
			<!-- 顶部 -->
			<%@include file="../layout/header.jsp"%>
			<!-- 顶部 -->
			<!-- 底部 -->
			<%@include file="../layout/footer.jsp"%>
			<!-- 底部 -->
			<!-- 中部 -->
			<div class="app-body" id="view">
				<div style="min-height: 200px">
					<!-- padding start -->
					<div class="padding">
						<!-- 内容部分 -->
						<div class="block-content-nav">
							<span class="title">菜单管理</span>
						</div>
						<div class="block-content-description">
							<span> 请先填写 <span style="color:#555;">菜单组名称</span> 并保存
								，再添加菜单
							</span>
						</div>
						<div class="block-content-content">
							<form id="id_menu_group_form" action="${s.base}/SuTa/accountmenu/toMerge.html" method="post">
								<input id="id_gid" name="id" type="hidden"
									value="${groupEntity.id}" /> <input name="gid" type="hidden"
									value="${groupEntity.id}" /> <input name="enable"
									type="hidden" value="${groupEntity.enable}" />
								<ul>
									<li><label style="width: 100px;">菜单组名称 </label> <input
										id="id_name" type="text" name="name" maxlength="10"
										value="${groupEntity.name}"> <span style="color:red">*</span>
										<input class="btn" onclick="doSaveGroupMenu();" type="button"
										value="保 存" /></li>
								</ul>
							</form>
							<table class="fm-table" style="margin-top:10px;">
								<thead>
									<tr>
										<td rowspan="2" style="width: 100px;">名称</td>
										<td colspan="3">消息类型</td>
										<td rowspan="2" style="width: 100px;">一级菜单</td>
										<td rowspan="2" style="width: 50px;">顺序</td>
										<td rowspan="2" style="width: 120px;"><a class="btn" onclick="doAdd();" type="button" value="添 加" >添 加</a></td>
									</tr>

									<tr>
										<td style="width:150px;">关键字消息</td>
										<td style="width:150px;">指定消息</td>
										<td>链接消息</td>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="row" items="${pageList}">
									<tr id="${row.id}" ng-repeat="row in rowCollectionBasic"
										class="ng-scope" >

										<!-- <# list pageList as row> -->

										<td id="${row.id}1">${row.name}</td>
										<td>${row.inputcode}</td>
										<td>${row.msgId}</td>
										<td>${row.url}</td>
										<td>${row.parentName}</td>
										<td>${row.sort}</td>
										<td><a href="javascript:void(0);"
											onclick="doDelete('${row.id}')">删除</a> ||<a
											href="javascript:void(0);" onclick="doupdata('${row.id}')">修改</a>
										</td>
									</tr>
								</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
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
