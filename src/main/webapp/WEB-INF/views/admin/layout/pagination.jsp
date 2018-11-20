<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
</head>
<body>
<nav>
    <ul class="pagination">
        <c:if test="${pagination.pageCount >1}">
            <li class="disabled">
                <a href="${pagination.queryUrl }?pageNum=${pagination.prev }" aria-label="Previous">
                    <span aria-hidden="true">«</span>
                    <span class="sr-only">上一页</span>
                </a>
            </li>
        </c:if>
        <c:forEach items="${pagination.showPages}" var="showPages">
            <li <c:if test="${pagination.num==showPages}">class="active"</c:if>>
                <a href="${pagination.queryUrl }?pageNum=${showPages }">${showPages } <span
                        class="sr-only">${showPages }</span></a>
            </li>
        </c:forEach>
        <c:if test="${pagination.pageCount >1 }">
            <li>
                <a href="${pagination.queryUrl }?pageNum=${pagination.next }" aria-label="Next">
                    <span aria-hidden="true">»</span>
                    <span class="sr-only">下一页</span>
                </a>
            </li>
        </c:if>
    </ul>
</nav>
</body>
</html>