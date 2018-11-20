<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<%@include file="../layout/source.jsp" %>
<script type="text/javascript">
	function addOrUpdateSort(id,parentid,gid){
		var content = '../accountmenu/toSaveOrUpdate.action?parentid='+parentid+'&id='+id+'&gid='+gid;
		var title='添加/修改一级菜单';
		layer.open({
	      type: 2,
	      title: title,
	      maxmin: true, //开启最大化最小化按钮
	      area: ['900px', '500px'],
	      content:content,
	      cancel: function(index, layero){ 
	 		}
	    });
	    
	}
	function deleteSort(id){
		layer.confirm('确定删除吗？', {
		  skin: 'layui-layer-molv', //样式类名
		  btn: ['确定','取消'] //按钮
		}, function(){
		var index = parent.layer.getFrameIndex(window.name); 
	    	$.ajax({
		    		url : 'delete.action',
					type : "post",
					dataType : "text",
					data : {"id":id},
					success : function(data) {
						if(data=="success"){
							location.reload(); 
							layer.close(index);
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
<div class="padding">
<!-- 内容部分 -->

<div class="row">
<div class="box">
<div class="box-header" style="height: 80px">
 <h3>微信菜单配置 <button style="float: right;" class="btn btn-fw success" onclick="addOrUpdateSort(0,0,${gid})">添 加 一 级 菜 单</button></h3>
      <small>注意：1级菜单最多只能开启3个，2级子菜单最多开启5个!	 </small>
</div>
 </div>
 </div>
<div class="row">
<div class="box">
  <c:forEach items="${accountParentMenuList}" var="row" varStatus="inx">
    <div class="padding">
    <button class="btn info btn-block">
    <i class="fa fa-bars pull-left"></i>
     ${row.name}
    <i class="fa pull-right">&nbsp;&nbsp;
    
    <i class="fa fa-pencil" onclick="addOrUpdateSort(${row.id},0,${gid})" ></i>&nbsp;&nbsp;
    <i class="fa fa-times"  onclick="deleteSort(${row.id},0,${gid})"></i>&nbsp;&nbsp;
    <i class="fa  fa-plus-square"  onclick="addOrUpdateSort(0,${row.id},${gid})"></i>
   </i> 
    </button>
    </div>
    
    <c:forEach items="${accountMenuList}" var="accountMenu">
    <c:if test="${accountMenu.parentid==row.id }">
    <div class="padding">
    <div class="col-sm-12">
    <button class="md-btn md-raised m-b-sm w-xs pink" style="width: 100%;">
     ${accountMenu.name}
     <i class="fa pull-right">&nbsp;&nbsp;
    <i class="fa fa-pencil"  onclick="addOrUpdateSort(${accountMenu.id},0,${gid})"></i>&nbsp;&nbsp;
    <i class="fa fa-times"  onclick="deleteSort(${accountMenu.id})"></i>&nbsp;&nbsp;</i> 
    </button>
    </div>
    </div>
    </c:if>
    </c:forEach>
     </c:forEach>

 </div>
<!-- 内容部分END -->
</div>
<!-- padding END -->
		</div>
</div>
 <!-- 中部 END-->
  </div>
<!-- 框架布局结束 -->
</div></div>
</body>
</html>
