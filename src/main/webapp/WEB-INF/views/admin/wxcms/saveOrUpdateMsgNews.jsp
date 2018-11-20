<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>文本消息</title>
<%@include file="../layout/source.jsp" %>
<script src="../resource//bootstrap/summerNote/summernote.min.js"></script>
<script src="../resource//bootstrap/summerNote/summernote-zh-CN.js"></script>
<link rel="stylesheet" type="text/css" href="../resource//bootstrap/summerNote//summernote.css">

<script src="../resource//bootstrap/fileUpload/fileinput.min.js"></script>
<script src="../resource//bootstrap/fileUpload/fileinput_locale_zh.js"></script>
<link rel="stylesheet" type="text/css" href="../resource//bootstrap/fileUpload/fileinput.min.css">

<script type="text/javascript">
function cancle(){
var index =parent.layer.getFrameIndex(window.name); 
parent.layer.close(index);
}

function doSubmit(){
var inputcode=$("#inputcode").val();
var author=$("#author").val();
var title=$("#title").val();
var brief=$("#brief").val();
if(inputcode==''){
	layer.msg("请输入关键字");
	return false;
}
if(author==''){
	layer.msg("请输入作者");
	return false;
}
if(title==''){
	layer.msg("请输入标题");
	return false;
}
if(brief==''){
	layer.msg("请输入介简");
	return false;
}
$("#form").submit();
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
         	<form id="form" class="fm-form" action="../msgnews/doMerge.action"  method="post" enctype="multipart/form-data">
          <input type="hidden" name="id" value="${entity.id}"/>
								<input type="hidden" name="baseId" value="${entity.baseId}"/>
								<label>关键字 </label>
								<input id="inputcode" name="inputcode" type="text" class="form-control" value="${baseEntity.inputcode}"/>
								<label>作者 </label>
								<input id="author" name="author" type="text" class="form-control" value="${entity.author}"/>
								<label>标题 </label>
								<input id="title" name="title" type="text" class="form-control"  value="${entity.title}"/>
								<label>简介 </label>
								<label></label>
								<textarea name="brief" rows="3" cols="60" class="form-control"  id="brief">${entity.brief}</textarea>
								<span class="helptext">长度 &lt; 100 字</span>
								<label>封面图片 </label>
								<input type="file" class="file-loading" name="imageFile"  id="imageFile" data-show-upload="false" data-min-file-count="1">
								<label>内容 </label>
								<span style="color:#ccc"> 如果填写了下方的 <span style="color:#555;">原文链接</span> ，内容可以不填写，微信中点击消息，自动跳转到原文链接</span>
								<textarea id="summernote" name="description">${entity.description}</textarea>
								
								<label>原文链接 </label>
								<input id="text" type="text" class="form-control"  name="fromurl" style="width:452px" value="${entity.fromurl}" style="width:452px;"/>
          </form>
        </div>
      </div>
      <div style="height: 50px;"></div>
      <div style="position: fixed;bottom: 0;background-color: #ffffff;width: 100%;border-top:3px dashed #a8a8a8;">
   	  <button class="btn btn-fw danger" style="float: right;margin-bottom: 1%;margin-right: 1%;margin-top: 1%;" onclick="cancle();">取消</button>
      <button class="btn btn-fw success" style="float: right;margin-bottom: 1%;margin-right: 1%;margin-top: 1%;" onclick="doSubmit(); ">确定</button>
   	  </div>
   	  
   	  
   	  <script type="text/javascript">
   	  var id ='${entity.id}';
   	  var goodsCover ="";
   	  if(id!=null&&id!=''){
   	  goodsCover ="<img src='"+'${entity.picpath}'+"' class='file-preview-image'><div><a class='glyphicon glyphicon-trash text-danger' onclick='deleteImg();'></a><div>";
   	  }
   	  	$("#imageFile").fileinput({
	              language: 'zh', //设置语言
	              uploadUrl:"", //上传的地址
	              allowedFileExtensions: ['jpg', 'gif', 'png'],//接收的文件后缀
	              allowedPreviewTypes: ['image'],
	              uploadAsync: true, //默认异步上传
	              showUpload:false, //是否显示上传按钮
	              showRemove :false, //显示移除按钮
	              showPreview :true, //是否显示预览
	              showCaption:true,//是否显示标题
	              browseClass:"btn btn-primary", //按钮样式    
	              dropZoneEnabled: false,//是否显示拖拽区域
	              maxFileCount:10, //表示允许同时上传的最大文件个数
	              enctype:'multipart/form-data',
	              validateInitialCount:true,
	              previewFileIcon: "<i class='glyphicon glyphicon-king'></i>",
	              msgFilesTooMany: "选择上传的文件数量({n}) 超过允许的最大数值{m}！",
	              initialPreview: goodsCover,
	         })
	         
			//富文本编辑器  
			$(document).ready(function() {
        		$('#summernote').summernote({
        			height: 500,
        			lang : "zh-CN",
        			onImageUpload:function(files,editor,$editable){	
        				for(var i=0;i<files.length;i++){	
        					sendFile(files[i],editor,$editable);
        				}
        			} 
        		});
   			 });
   			 function sendFile(file,editor,$editable){
   			 	var filename=false;
   			 	try{
   			 		filename=file['name'];
   			 	}catch(e){
   			 		filename=false;
   			 	}
   			 	if(!filename){
   			 		$(".note-alarm").remove();
   			 	}
   			 	data =new FormData();
   			 	data.append("imgFile",file);
   			 	data.append("key",filename);
   			 	$.ajax({
   			 		data:data,
   			 		url:'../wxcms/ckeditorImage.action',
   			 		async : false,
   			 		method: "POST",
   			 		cache: false,  
        			contentType: false,  
        			processData: false,  
        			dataType:"json",
   			 		success:function(data){
   			 			//alert(data.url);
   			 			 $("#summernote").summernote('insertImage', data.url,filename); // the insertImage API  
   			 		},
   			 		error:function(data){
   			 			alert("f");
   			 		}
   			 	});
   			 }
    </script>
</body>
</html>
