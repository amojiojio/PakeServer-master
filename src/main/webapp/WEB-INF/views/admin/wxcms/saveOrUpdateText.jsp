<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>文本消息</title>
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
url:"../msgtext/saveOrUpdate.action",
type:"post",
data:$("#form").serialize(),
dataType:"text",
success:function(data){
if(data=="success"){
parent.location.reload(); 
parent.layer.close(index);
}else{
parent.layer.close(index);
layer.msg("操作失败");
}
}
})
}
</script>
</head>

<body class="laycode">

      <div class="box">
        <div class="box-header">
          <small>如果关键字为subscribe,那么此消息为订阅消息</small>
        </div>
        <div class="box-divider m-a-0"></div>
        <div class="box-body">
          <form role="form" id="form" action="../msgtext/saveOrUpdate.action" method="post">
          <input type="hidden" name="id" value="${entity.id}"/>
		  <input type="hidden" name="baseId" value="${entity.baseId}"/>
            <div class="form-group">
              <label for="exampleInputPassword1">关键字</label>
              <input type="text" class="form-control" name="inputcode"  id="inputcode" value="${baseEntity.inputcode}">
            </div>
            <div class="form-group">
              <label for="exampleInputPassword1">内容</label>
              <textarea name="content"  class="form-control"  rows="8" cols="30">${entity.content}</textarea>
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
