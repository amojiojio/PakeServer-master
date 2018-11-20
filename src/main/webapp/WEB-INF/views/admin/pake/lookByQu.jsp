<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@include file="../layout/source.jsp" %>
<script type="text/javascript">
function sendOut(){
layer.confirm('确认接单？', {
    btn: ['确认','取消'] //按钮
}, function(){
		$.ajax({
                url:"${pageContext.request.contextPath}/admin/sendOutByQu.action",
                async:false,
                type:'post',
                data:$("#dataForm").serialize(),
                dataType:'text',
                success:function(data){
                if (data=='success') {
                 layer.msg('接单成功,请尽快处理');
                setTimeout(function(){
                parent.location.reload();
                }, 1500);
  			}
			if (data=='errorInfo') {
  		     layer.msg('消息推送失败');
  		     setTimeout(function(){
					parent.location.reload();
			}, 1500);
  			}
			if (data=='43004') {
  		     layer.msg('用户未关注公众号,无法推送消息');
  		     setTimeout(function(){
					parent.location.reload();
			}, 1500);
  			}
			},
            error:function () {
                parent.location.reload();
            }
		});
	}, function(){
	layer.close();
	});
};

function sendDone(){
layer.confirm('确认完成该订单？', {
            btn: ['确认','取消'] //按钮
        }, function(){
            $.ajax({
                url:"${pageContext.request.contextPath}/admin/sendDoneByQu.action",
                async:false,
                type:'post',
                data:$("#dataForm").serialize(),
                dataType:'text',
                success:function(data){
                    if (data=='success') {
                        layer.msg('成功');
                        setTimeout(function(){
                            parent.location.reload();
                        }, 1500);
                    }
                    if (data=='errorInfo') {
                        layer.msg('消息推送失败');
                        setTimeout(function(){
                            parent.location.reload();
                        }, 1500);
                    }
                    if (data=='43004') {
                        layer.msg('用户未关注公众号,无法推送消息');
                        setTimeout(function(){
                            parent.location.reload();
                        }, 1500);
                    }
                },
                error:function () {
                    parent.location.reload();
                }
            });
        }, function(){
            layer.close();
        });
};
		</script>
	</head>
<body>

<div class="box">
<div class="table-responsive">
<form name="dataForm" id="dataForm">
<input type="hidden"  name="id" id="id" value="${takeByQu.id}"/>
<input type="hidden"  name="openId" id="openId" value="${takeByQu.openId}"/>
<input type="hidden"  name="note" id="note" value="${takeByQu.note}"/>
<input type="hidden"  name="createDate" id="createDate" value="${takeByQu.createDate}"/>

  <table class="table">
       <tr>
          <td>订单号：</td>
            <td>${takeByQu.id}</td>
       </tr>

      <tr>
          <td>微信支付订单号：</td>
          <td>${takeByQu.transactionId}</td>
      </tr>
          <tr>
              <td>取件码：</td>
              <td colspan="3">${takeByQu.sms}</td>
          </tr>
      <tr>
          <td>短信接受时间：</td>
          <td colspan="3"><span style="color: green">${takeByQu.messageTime}</span></td>
      </tr>

          <tr>
              <td>预约时间：</td>
              <c:if test="${takeByQu.isSubscribe==0}">
              <td>立即送件</td>
              </c:if>
              <c:if test="${takeByQu.isSubscribe==1}">
                  <td><span style="color: red"><fmt:formatDate value="${takeByQu.subscribeTime}" pattern="yyyy/MM/dd HH:mm"/></span></td>
              </c:if>
              <td>收件人：</td>
              <td>${takeByQu.endUserName}</td>
          </tr>

          <tr>
              <td>联系电话：</td>
              <td>${takeByQu.endPhone}</td>
              <td>收件地址：</td>
              <td colspan="3">${takeByQu.endUserNote}</td>
          </tr>

          <tr>
              <td>备注信息：</td>
              <td colspan="3">${takeByQu.note}</td>
          </tr>

            <tr>
            <td>订单状态：</td>
            <c:if test="${takeByQu.state==1}"><td>待接单</td></c:if>
            <c:if test="${takeByQu.state==2}"><td>已接单</td></c:if>
            <c:if test="${takeByQu.state==3}"><td>已完成</td></c:if>
            <td>创建时间：</td>
            <td><fmt:formatDate value="${takeByQu.createDate}" pattern="yyyy/MM/dd HH:mm:ss"/></td>
          </tr>
          <tr>
              <td>支付状态：</td>
              <td>
                  <c:if test="${takeByQu.payState==1}">
              <td><span style="color: green">已支付</span></td>
              </c:if>
          </tr>

     </table>
</form>
    <c:if test="${takeByQu.state==1}">
        <div style="position: fixed;bottom: 0;background-color: #ffffff;width: 100%;border-top:3px dashed #a8a8a8;">
            <button class="btn btn-fw success" style="float: right;margin-bottom: 1%;margin-right: 1%;margin-top: 1%;" type="button" onclick="sendOut()">确认接单</button>
        </div>
    </c:if>
    <c:if test="${takeByQu.state==2}">
        <div style="position: fixed;bottom: 0;background-color: #ffffff;width: 100%;border-top:3px dashed #a8a8a8;">
            <button class="btn btn-fw success" style="float: right;margin-bottom: 1%;margin-right: 1%;margin-top: 1%;" type="button" onclick="sendDone()">确认完成</button>
        </div>
    </c:if>
    </div>
  </div>

</body>
</html>
