<%@ page language="java" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <%@include file="../layout/source.jsp" %>
  
	</head>
	
	<body style="background-color: white;text-align: center;margin-top: 50px">
		<div class="box">
						<div class="box-header" style="height: 80px">
							<h3>${news.title}</h3>
						</div>
						<div class="box-body">
							<div style="margin-top:10px;font-size:13px;">
								<span style="color:#676767;"><fmt:formatDate value="${news.createtime}" pattern="yyyy-MM-dd"/></span>
								<span style="margin-left:10px;color:#676767;">${news.author}</span>
								<span style="margin-left:10px;color:#607fa6;">派客</span>
							</div>
						</div>
						<div class="box">
							<c:if test="${news.showpic ==1}">
								<c:if test="${news.picpath!=''}">
									<img src="${news.picpath}">
								</c:if>
							</c:if>
							<div>${news.description}</div>
						</div>
					</div>
		<script type="text/javascript">
			$(document).ready(function(){
				var imgs = $("#id_description").find("img");
				for(var i =0 ; i<imgs.length; i++){
					var src = $(imgs[i]).attr('src');
					if(src.indexOf("kindeditor/plugins/emoticons") == -1 && src.indexOf(".gif") == -1){
						$(imgs[i]).attr('style','');
						$(imgs[i]).css('width','100%');
						$(imgs[i]).attr('width','100%');
						$(imgs[i]).css('margin-top','2px;');
					}
				}
				try{
					wxbridge('${news.picpath}','${news.url}','${news.title}','${news.title}','');
				}catch(e){}
			});
		</script>
	</body>
</html>
