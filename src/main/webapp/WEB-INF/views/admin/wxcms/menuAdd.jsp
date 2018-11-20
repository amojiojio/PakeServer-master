<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>添加菜单</title>
<%@include file="../layout/source.jsp"%>
<style type="text/css">
ul li {
	list-style: none;
}
</style>
<script type="text/javascript">
	function doSaveGroupMenu() {
		var name = $('#id_name').val();
		if (name != '') {
			/* $('#id_menu_group_form').submit();
			$('#xiayibu').attr('href','#tab3')  */
			$.ajax({
				url : 'doMerge.action',
				type : "post",
				dataType : "json",
				async : false,
				data : $('#form').serialize(),
				success : function(json) {
					$('#gname').attr('value', name)
					
				/*  $('#op').text(name),	$('#xiayibu').attr('href','#tab3'); */
				},
				error : function(data) {
					alert('菜单组添加失败');
				}
			});
		} else {
			alert('菜单组名称不能为空');
		}

	}


	function doSaveMenu() {

		/* var gid = $('#id_gid').val();
					if(gid!=''){
						$('#id_menu_group_form').attr('action','${s.base}/accountmenu/toMerge.html');
						$('#id_menu_group_form').submit();
					}else{
						alert('请先保存菜单组名称');
					} */


		$.ajax({
			url : '../accountmenu/doMerge.action',
			type : "post",
			dataType : "json",
			async : false,
			data : $('#fm-form').serialize(),
			success : function(data) {
				alert('菜单项添加成功');

			},
			error : function(data) {
				alert('菜单项添加失败');
			}
		});

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
				<!-- 内容部分 -->
				<div style="min-height: 200px">
					<!-- padding start -->
					<!-- 分割 -->

					<div class="padding">

						<div class="box">
							<div class="box-header b-b">
								<h3>
									<font style="vertical-align: inherit;"><font
										style="vertical-align: inherit;">添加菜单</font></font>
								</h3>
							</div>
							<div class="box-body">
								<form ui-jp="parsley" id="form" action="../wxcms/doMerge.action">
									<div id="rootwizard" ui-jp="bootstrapWizard"
										ui-options="{
            onTabClick: function(tab, navigation, index) {
              return false;
            },
            onNext: function(tab, navigation, index) {
              var instance = $('#form').parsley();
              instance.validate();
              if(!instance.isValid()) {
                return false;
              }
            }
            }">
										<ul class="nav nav-pills clearfix m-b">
											<!--  <li class="nav-item"><a class="nav-link active" href="#tab1" data-toggle="tab" aria-expanded="true"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">第一</font></font></a></li>
              <li class="nav-item"><a class="nav-link" href="#tab3" data-toggle="tab"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">第二</font></font></a></li> -->
										</ul>
										<div class="tab-content">
											<div class="tab-pane active" id="tab1" aria-expanded="true">

												<form id="id_menu_group_form">
													<input id="id_gid" name="id" type="hidden"
														value="${groupEntity.id}" /> <input name="gid"
														type="hidden" value="${groupEntity.id}" /> <input
														name="enable" type="hidden" value="${groupEntity.enable}" />
													<ul>
														<li><label style="width: 100px;">菜单组名称 </label> 
<input id="id_name"  name="name" class="form-control" maxlength="10" placeholder="Name" required="" data-parsley-id="85" value="${groupEntity.name}" type="text">														
 <!-- <input class="btn" onclick="doSaveGroupMenu();" type="button" value="保 存"/> -->
														</li>
													</ul>
												</form>
											</div>
											<div class="tab-pane" id="tab3">
												<font style="vertical-align: inherit;"><font
													style="vertical-align: inherit;"> <!--  -->

<form role="form" action="../accountmenu/doMerge.action" method="post"
	onsubmit="return doSubmit();">
	<input id="gname" type="hidden" name="gname">
<ul>
<li>
<div class="form-group row">
<label for="inputEmail3" class="col-sm-2 form-control-label">名称:</label>
<div class="col-sm-10">
<input class="form-control" id="inputEmail3" name="name"
placeholder="在此输入菜单名" type="text" value="${accountmenu.name}">
</div>
</div>
		<div class="form-group row">
			<label for="inputPassword3" class="col-sm-2 form-control-label">一级菜单:</label>
<div class="col-sm-10">
<select class="form-control c-select" name="parentid">
<option value="0">--</option>
<c:forEach var="r" items="${pageList}">
	<option value="${r.id}">${r.name}</option>
</c:forEach>
</select>
			</div>
		</div>
		<div class="form-group row">
			<label for="inputPassword3" class="col-sm-2 form-control-label">顺序:</label>
			<div class="col-sm-10">
				<select class="form-control c-select" name="sort">
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
						<option value="6">6</option>
						<option value="7">7</option>
						<option value="8">8</option>
				</select>
			</div>
		</div>
<div class="form-group row">
	<label for="inputPassword3" class="col-sm-2 form-control-label">菜单类型:</label>
	<div class="col-sm-10">
		<select id="id_type" name="mtype" class="form-control c-select"
			onchange="typeChange()">
				<option value="click" selected="selected">消息</option>
				<option value="view">链接</option>
		</select>
	</div>
</div>
	</li>
	<li id="id_msg" style="display: inline;">
<div class="form-group row">
	<label for="inputPassword3" class="col-sm-2 form-control-label">消息类型:</label>
	<div class="col-sm-10">
		<select id="id_event_type" name="eventType"
			class="form-control c-select" onchange="eventTypeChange()">
		<option value="key" >关键字</option>
		<option value="fix" selected="selected">指定</option>
		</select>
	</div>
</div>
		<div id="id_keymsg" class="form-group row" style="display: none;">
			<label for="inputEmail3" class="col-sm-2 form-control-label">关键字:</label>
			<div class="col-sm-10">
				<input class="form-control" id="inputEmail3" value="${accountmenu.inputcode}"
					placeholder="消息的关键字：" type="text" name="inputcode">
			</div>
		</div>
		<div id="id_fixmsg" class="form-group row"
			style="display: inline;">
			<label for="inputEmail3" class="col-sm-2 form-control-label">指定消息:</label>
			<div class="col-sm-10">
				<input id="id_msgIds" name="msgId" class="form-control" value="${accountmenu.msgId}"
					type="text" readonly="readonly">
				<a class="btn btn-fw white" type="button" onclick="getMsgs();">选择</a>
			</div>
		</div>
	</li>
	<li id="id_view" style="display: none;">
						<div class="form-group row">
							<label for="inputEmail3" class="col-sm-2 form-control-label">url:</label>
							<div class="col-sm-10">
								<input class="form-control" id="inputEmail3" placeholder="url地址"
								value="${accountmenu.url}" name="url" type="text">
							</div>
						</div>
					</li>
				</ul>
				<div class="form-group row m-t-md">
					<div class="col-sm-offset-2 col-sm-10">
						<button type="submit" class="btn white">保存</button>
					</div>
				</div>
			</form>
														<div id="id_msgs"></div>
														
														
														<script type="text/javascript">
															function typeChange() {
																var value = $("#id_type  option:selected").val();
																if (value == 'click') {
																	$("#id_view").css("display", "none")
																	$("#id_msg").css("display", "inline")
																} else {
																	$("#id_view").css("display", "inline")
																	$("#id_msg").css("display", "none")
																}
															}
														
															function eventTypeChange() {
																var value = $("#id_event_type  option:selected").val();
																if (value == 'key') {
																	$("#id_keymsg").css("display", "inline")
																	$("#id_fixmsg").css("display", "none")
																} else {
																	$("#id_keymsg").css("display", "none")
																	$("#id_fixmsg").css("display", "inline")
																}
															}
														
															function doSubmit() {
																var name = $("#id_name").val();
																if (name.replace(/(\s*$)/g, '') == '') {
																	alert('菜单名称不能为空');
																	return false;
																}
																return true;
															}
														
															function getMsgs() {
																$('#id_msgs').dialog({
																	title : '选择消息',
																	width : 600,
																	height : 400,
																	modal : true,
																	buttons : {
																		"确定" : function() {
																			var msgtype = $("#id_msgs_frame").contents().find('input[name="msgtype"]').val();
																			if (msgtype == 'news') {
																				var val = [];
																				$("#id_msgs_frame").contents().find('input[name="checkname"]:checked').each(function() {
																					val.push($(this).val())
																				})
																				if (val.length > 0) {
																					$("#id_msgIds").val(val.join(','));
																				}
																			} else {
																				var val = $("#id_msgs_frame").contents().find('input[name="radioname"]:checked').val();
																				if (val != undefined) {
																					$("#id_msgIds").val(val);
																				}
																			}
																			$(this).dialog('close');
																		}
																	}
																});
															}
														</script>
														<div></div>
														</fieldset>

														<div class="modal-footer"></div> <!--  -->
												</font></font>
											</div>
											<ul class="pager wizard">
												<li class="nav-item"><a class="nav-link active"
													href="#tab1" data-toggle="tab" aria-expanded="true"><font
														style="vertical-align: inherit;"><font
															style="vertical-align: inherit;">上一步</font></font></a></li>
												<li class="nav-item"><a id="xiayibu" class="nav-link"
													href="#tab3" data-toggle="tab" onclick="doSaveGroupMenu();"><font
														style="vertical-align: inherit;"><font
															style="vertical-align: inherit;">下一步</font></font></a></li>
											</ul>
										</div>
									</div>
								</form>
							</div>
						</div>

					</div>
					<!-- fenge  -->
				</div>
				<!-- 内容部分 -->
			</div>
			<!-- 中部 -->
		</div>
		<!-- 框架布局结束 -->
	</div>
</body>
</html>
