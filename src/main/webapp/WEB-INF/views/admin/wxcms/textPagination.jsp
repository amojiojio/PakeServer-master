<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>文本消息</title>
<%@include file="../layout/source.jsp" %>
<script type="text/javascript">
	function deletes(id,baseid){  
	layer.confirm('确定删除吗？', {
		  skin: 'layui-layer-molv', //样式类名
		  btn: ['确定','取消'] //按钮
		}, function(){
	    	$.ajax({
		    		url : 'delete.action',
					type : "post",
					dataType : "text",
					data : {"id":id,"baseId":baseid},
					success : function(data) {
					if(data=="success"){
					$("#"+id).remove();
					layer.msg('删除成功');
					}else{
					layer.msg('删除失败');
					}
					},
					error:function(data){
				    layer.msg('网络错误');
				}
		    }); 
		}, function(){
		
		});
	};
	
function toSaveOrUpdate(id){
	 var content = '../msgtext/toSaveOrUpdate.action?id=';
     if(typeof(id)!="undefined"){
     content= '../msgtext/toSaveOrUpdate.action?id='+id
	  }
	layer.open({
	  title:'添加或修改文本消息',
	  type: 2,
	  area: ['700px', '450px'],
	  fixed: false, //不固定
	  maxmin: true,
	  content: content
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
		<div class="box-header" style="height: 80px">
		<h3 style="margin-left: 10px;margin-top: 10px">文本消息
		<button style="float: right;" class="btn btn-fw success" onclick="toSaveOrUpdate()" data-toggle="modal">添 加</button>
		</h3>
		</div>
						
	<div class="table-responsive">
      <table class="table table-striped b-t">
        <thead>
          <tr>
            <th>序号</th>
            <th>关键字</th>
            <th>消息描述</th>
            <th style="width:50px;"></th>
            <th style="width:50px;"></th>
          </tr>
        </thead>
        <tbody>
        
        <c:forEach items="${pagination.list}" var="row" varStatus="index">
			<tr id="${row.id}">
						<td>${index.index+1 }</td>		
						<td>${row.inputcode}</td>
						<td>${row.content}</td>	
						<td>
						<a href="javascript:void(0);" onclick="toSaveOrUpdate('${row.id}')"><i class="fa fa-pencil" style="color: green;"></i></a>
						</td>
						<td>
						<a href="javascript:deletes(${row.id},${row.baseId});" ><i class="fa fa-times" style="color: red;"></i></a>
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

</div>
</div>
</div>
   <!-- 内容部分 -->
</div>
 <!-- 中部 -->
  </div>
<!-- 框架布局结束 -->
	</body>
</html>
