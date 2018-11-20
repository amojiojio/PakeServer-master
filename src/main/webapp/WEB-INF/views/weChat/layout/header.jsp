<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<body>

<div id="tong" style="display: none;">
				  <div class="text-center">
				    <div class="p-a-md">
				    	<p><img src="http://kol-statics.oss-cn-beijing.aliyuncs.com/editor/2231201bfe6815fa1c3e4dbda11f3b98d1cbfe.png" class="w-128"></p>
				    	<span  class="block text">长 按 识 别</span>
				    	<p><small><small>总有一件会令你心仪</small></small></p>
				    	<div>
				    		<a href="javascript:void(0);" class="btn btn-icon btn-social rounded white btn-sm">
								<i class="fa fa-wechat green"></i>
								<i class="fa fa-wechat danger"></i>
							</a>
							<a href="javascript:void(0);" class="btn btn-icon btn-social rounded white btn-sm">
								<i class="fa  fa-weibo red"></i>
								<i class="fa  fa-weibo danger"></i>
							</a>
							<a href="javascript:void(0);" class="btn btn-icon btn-social rounded white btn-sm">
								<i class="fa  fa-twitter light-blue"></i>
								<i class="fa  fa-twitter danger"></i>
							</a>
				    	</div>
				    </div>
				  </div>
				</div>
				
<div class="app-header white box-shadow">
				<div class="navbar">
					<!-- navbar right -->
					<ul class="nav navbar-nav pull-right" id="logoHeader" onclick="twoCode();">
						<li class="nav-item dropdown">
						<a class="nav-link clear" href="javascript:void(0);" > 
						<span class="avatar w-64">
									<img src="${pageContext.request.contextPath}/resource/imgs/logo_black.png" alt="...">
							</span>
						</a>
						</li>
             
			</ul>
					<!-- / navbar right -->
				</div>
			</div>
		<script type="text/javascript">
				function twoCode(){
				layer.open({
				type: 1,
				title: false,
				shadeClose: true,
				closeBtn:0,
				shade: 0.5,
				area: '300px',
				content: $('#tong')
				});
				};
		</script>
</body>
</html>
