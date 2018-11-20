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
                url:"${pageContext.request.contextPath}/admin/sendOutBySong.action",
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
			}
		});
	}, function(){
	layer.close();
	});
};

function sendDone(){
if($('#courierNumber').val()==""){
        layer.msg('请填写回执快递单号');
}
    else if($('#courierCompany').val()==""){
        layer.msg('请填写快递公司');
    }
    else{
        layer.confirm('确认完成该订单？', {
            btn: ['确认','取消'] //按钮
        }, function(){
            $.ajax({
                url:"${pageContext.request.contextPath}/admin/sendDoneBySong.action",
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
                }
            });
        }, function(){
            layer.close();
        });
    }
};
		</script>
	</head>
<body>

<div class="box">
<div class="table-responsive">
<form name="dataForm" id="dataForm">
<input type="hidden"  name="id" id="id" value="${takeBySong.id}"/>
<input type="hidden"  name="openId" id="openId" value="${takeBySong.openId}"/>
<input type="hidden"  name="note" id="note" value="${takeBySong.note}"/>
<input type="hidden"  name="goodsType" id="goodsType" value="${takeBySong.goodsType}"/>
      <table class="table">
       <tr>
            <td>订单号：</td>
            <td>${takeBySong.id}</td>
           <td>物品类型：</td>
           <td>${takeBySong.goodsType}</td>
          </tr>

          <tr>
              <td>预约时间：</td>
              <c:if test="${takeBySong.isSubscribe==0}">
              <td>立即上门取件</td>
              </c:if>
              <c:if test="${takeBySong.isSubscribe==1}">
                  <td><fmt:formatDate value="${takeBySong.subscribeTime}" pattern="yyyy/MM/dd HH:mm"/></td>
              </c:if>
              <td>取件人：</td>
              <td>${takeBySong.endUserName}</td>
          </tr>

          <tr>
              <td>联系电话：</td>
              <td>${takeBySong.endPhone}</td>
              <td>取件地址：</td>
              <td colspan="3">${takeBySong.endUserNote}</td>
          </tr>

          <tr>
              <td>备注信息：</td>
              <td colspan="3">${takeBySong.note}</td>
          </tr>

            <tr>
            <td>订单状态：</td>
            <c:if test="${takeBySong.state==1}"><td>待接单</td></c:if>
            <c:if test="${takeBySong.state==2}"><td>已接单</td></c:if>
            <c:if test="${takeBySong.state==3}"><td>已完成</td></c:if>
            <td>创建时间：</td>
            <td><fmt:formatDate value="${takeBySong.createDate}" pattern="yyyy/MM/dd HH:mm:ss"/></td>
          </tr>

          <c:if test="${takeBySong.state==2}">
              <tr>
                  <td>快递单号：</td>
                  <td>
                      <input type="text"  name="courierNumber" id="courierNumber" class="form-control"/></td>
                  <td>快递公司：</td>
                  <td>
                      <select name="courierCompany"  id="courierCompany" class="form-control c-select">
                          <option value="" >--请选择--</option>
                          <option value="天天快递" >天天快递</option>
                          <option value="汇通快递" >汇通快递</option>
                          <option value="顺丰速递" >顺丰速递</option>
                          <option value="申通速递" >申通速递</option>
                          <option value="圆通速递" >圆通速递</option>
                          <option value="中通速递" >中通速递</option>
                          <option value="中通速递" >韵达速递</option>
                      </select>
                  </td>
              </tr>
          </c:if>

          <c:if test="${takeBySong.state==3}">
              <tr>
                  <td>快递单号：</td>
                  <td>${takeBySong.courierNumber}</td>
                  <td>快递公司：</td>
                  <td>${takeBySong.courierCompany}</td>
              </tr>
          </c:if>


     </table>
</form>
    <c:if test="${takeBySong.state==1}">
        <div style="position: fixed;bottom: 0;background-color: #ffffff;width: 100%;border-top:3px dashed #a8a8a8;">
            <button class="btn btn-fw success" style="float: right;margin-bottom: 1%;margin-right: 1%;margin-top: 1%;" type="button" onclick="sendOut()">确认接单</button>
        </div>
    </c:if>
    <c:if test="${takeBySong.state==2}">
        <div style="position: fixed;bottom: 0;background-color: #ffffff;width: 100%;border-top:3px dashed #a8a8a8;">
            <button class="btn btn-fw success" style="float: right;margin-bottom: 1%;margin-right: 1%;margin-top: 1%;" type="button" onclick="sendDone()">确认完成</button>
        </div>
    </c:if>
    </div>
  </div>

</body>
</html>
