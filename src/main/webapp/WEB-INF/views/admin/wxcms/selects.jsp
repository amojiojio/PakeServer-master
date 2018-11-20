<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>

<html>
  <head>
<%@include file="../layout/source.jsp"%>
<script type="text/javascript">
function dosave() {	
	var id = $('input:radio[name=radio_name]:checked').val();
	var index = parent.layer.getFrameIndex(window.name);
	parent.$('#id_msgIds').val(id);
	parent.layer.tips(id, '#id_msgIds', {time: 10000});
	parent.layer.msg('您将标记 [ ' +id + ' ] 成功传送给了父窗口');
	parent.layer.close(index);
}
</script>
  </head>
  
  <body>
    
        <div class="b-b b-primary nav-active-primary">
          <ul class="nav nav-tabs">
            <li class="nav-item">
              <a class="nav-link active" href="" data-toggle="tab" data-target="#tab4" aria-expanded="true">文本消息列表</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="" data-toggle="tab" data-target="#tab5" aria-expanded="false">图文消息列表</a>
            </li>
          </ul>
        </div>
        <div class="tab-content p-a m-b-md">
          <div class="tab-pane animated fadeIn text-muted active" id="tab4" aria-expanded="true">
            <!--  -->
            <table class="table table-striped b-t">
        <thead>
          <tr>
          <th></th>
            <th>序号</th>
            <th>关键字</th>
            <th>消息描述</th>
          </tr>
        </thead>
        <tbody>
        
        <c:forEach items="${pagination.list}" var="row" varStatus="index">
			<tr id="${row.id}">
			<td><input type="radio" name="radio_name" value="${row.id}" /></td>
						<td>${index.index+1 }</td>		
						<td>${row.inputcode}</td>
						<td>${row.content}</td>	
			</tr>
			</c:forEach>
        </tbody>
      </table>
            <!--  -->
          </div>
          <div class="tab-pane animated fadeIn text-muted" id="tab5" aria-expanded="false">
          <!--  -->
          <table class="table table-striped b-t">
						<thead>
							<tr>
								<th></th>
								<th style="text-align: center;vertical-align: middle;font-size: 16px;">关键词</th>
								<th style="text-align: center;vertical-align: middle;font-size: 16px;">标题</th>
								<th style="text-align: center;vertical-align: middle;font-size: 16px;">图片</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${pageList}" var="row">
								<tr id="${row.id}">
								<td><input type="radio" name = "radio_name" value="${row.id}" /></td>
									<td rowspan=$rowspan
										style='vertical-align: middle;text-align: center;'>${row.inputcode}</td>
									<td rowspan=$rowspan
										style='vertical-align: middle;text-align: center;'>${row.title}</td>
									<td rowspan=$rowspan
										style='vertical-align: middle;text-align: center;'>
									<img src="${row.picpath}" style="border:none;height:40px;width:60px;"/>
									</td> 
									
								</tr>
							</c:forEach>
						</tbody>
					</table>
          <!--  -->
          </div>
        </div>
        <input class="btn" style="width:160px;" onclick="dosave();" type="button" value="保存" />
  </body>
</html>
