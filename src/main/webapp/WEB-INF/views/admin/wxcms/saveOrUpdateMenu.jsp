<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<%@include file="../layout/source.jsp" %>
<script type="text/javascript">
function cancle(){
var index =parent.layer.getFrameIndex(window.name); 
parent.layer.close(index);
}

function doSubmit(){
var v1 = $("#inputcode").val();
var v2 = $("textarea").val();
if (v1 == '') {
	layer.msg('请输入关键字');
	return false;
}
if (v2 == '') {
layer.msg('请输入内容');
	return false;
}
var index =parent.layer.getFrameIndex(window.name); 
$.ajax({
url:"../accountmenu/saveOrUpdate.action",
type:"post",
data:$("#form").serialize(),
success:function(data){
parent.location.reload(); 
parent.layer.close(index);
}
})
}

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
		} else if(value=='fix') {
			$("#id_keymsg").css("display", "none")
			$("#id_fixmsg").css("display", "inline")
		}else if (value=='suta'){
		$("#id_keymsg").css("display", "none")
		$("#id_fixmsg").css("display", "none")
		}
	}
	
function getMsgs() {
	layer.open({
  		type: 2, 
  		closeBtn:1,
  		anim: 6,
  		fixed:true,
 		skin: 'layui-layer-rim', //加上边框
 		area: ['700px', '500px'], //宽高
  		content: '../accountmenu/selects.action',
		}); 
	
	}
</script>
</head>

<body class="laycode">
      <div class="box">
        <div class="box-divider m-a-0"></div>
        <div class="box-body">
          <form role="form" id="form" action="../msgtext/saveOrUpdate.action" method="post">
          <input name="id" type="hidden" id="id" value="${accountmenu.id}"/>
          <input name="parentid" type="hidden" id="parentid" value="${accountmenu.parentid}"/>
          <input name="gid" type="hidden" id="gid" value="${gid}"/>
            <div class="form-group">
              <label for="exampleInputPassword1">名称</label>
              <input class="form-control" id="inputEmail3" name="name" placeholder="在此输入菜单名" type="text" value="${accountmenu.name}">
            </div>
            <div class="form-group">
              <label for="exampleInputPassword1">顺序</label>
              <select class="form-control c-select" name="sort">
						<option value="1">1</option>
						<option value="2">2</option>
						<option value="3">3</option>
						<option value="4">4</option>
						<option value="5">5</option>
				</select>
            </div>
            <div class="form-group">
              <label for="exampleInputPassword1">菜单类型</label>
              <select id="id_type" name="mtype" class="form-control c-select" onchange="typeChange()">
				<option value="click" selected="selected">消息</option>
				<option value="view">链接</option>
			</select>
			</div>
			
     <div id="id_msg" style="display: inline;">
	<div class="form-group">
	<label for="exampleInputPassword1">消息类型</label>
		<select id="id_event_type" name="eventType"
			class="form-control c-select" onchange="eventTypeChange()">
		<option value="key" >关键字</option>
		<option value="fix" selected="selected">指定</option>
		<option value="suta" >SuTa_Random</option>
		</select>
</div>
		<div id="id_keymsg" class="form-group row" style="display: none;">
			<div class="form-group">
			<label for="exampleInputPassword1">关键字</label>
				<input class="form-control" id="inputEmail3" value="${accountmenu.inputcode}"
					placeholder="消息的关键字：" type="text" name="inputcode">
			</div>
		</div>
		<div id="id_fixmsg" class="form-group row"
			style="display: inline;">
			<div class="form-group">
			<label for="exampleInputPassword1">指定消息</label>
				<input id="id_msgIds" name="msgId" class="form-control" value="${accountmenu.msgId}"
					type="text" readonly="readonly">
				<a class="btn btn-fw white" type="button" onclick="getMsgs();">选择</a>
			</div>
		</div>
	</div>
	<div id="id_view" style="display: none;">
						<div class="form-group">
						<label for="exampleInputPassword1">url</label>
								<input class="form-control" id="inputEmail3" placeholder="url地址"
								value="${accountmenu.url}" name="url" type="text">
							</div>
					</div>
          </form>
        </div>
      </div>
      <div style="height: 50px;"></div>
      <div style="position: fixed;bottom: 0;background-color: #ffffff;width: 100%;border-top:3px dashed #a8a8a8;">
   	  <button class="btn btn-fw danger" style="float: right;margin-bottom: 1%;margin-right: 1%;margin-top: 1%;" onclick="cancle();">取消</button>
      <button class="btn btn-fw success" style="float: right;margin-bottom: 1%;margin-right: 1%;margin-top: 1%;" onclick="doSubmit(); ">确定</button>
   	  </div>
</body>
</html>
