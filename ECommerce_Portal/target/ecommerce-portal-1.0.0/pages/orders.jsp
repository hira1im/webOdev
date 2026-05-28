<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Siparişlerim - E-Commerce Portal</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="header.jsp" />
    
    <div class="container">
        <h2 style="color: #2C3E50;">Siparişlerim</h2>
        
        <c:choose>
            <c:when test="${not empty orders}">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Sipariş ID</th>
                            <th>Sipariş Tarihi</th>
                            <th>Toplam Tutar</th>
                            <th>Durum</th>
                            <th>İşlem</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="order" items="${orders}">
                            <tr>
                                <td>${order.orderId}</td>
                                <td><fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                <td><fmt:formatNumber value="${order.totalAmount}" type="currency"/></td>
                                <td>
                                    <span style="
                                        padding: 5px 10px;
                                        border-radius: 3px;
                                        background-color: 
                                        <c:choose>
                                            <c:when test="${order.status == 'PENDING'}">
                                                #fff3cd;
                                                color: #856404;
                                            </c:when>
                                            <c:when test="${order.status == 'CONFIRMED'}">
                                                #d1ecf1;
                                                color: #0c5460;
                                            </c:when>
                                            <c:when test="${order.status == 'SHIPPED'}">
                                                #cce5ff;
                                                color: #004085;
                                            </c:when>
                                            <c:when test="${order.status == 'DELIVERED'}">
                                                #d4edda;
                                                color: #155724;
                                            </c:when>
                                            <c:when test="${order.status == 'CANCELLED'}">
                                                #f8d7da;
                                                color: #721c24;
                                            </c:when>
                                            <c:otherwise>
                                                #e2e3e5;
                                                color: #383d41;
                                            </c:otherwise>
                                        </c:choose>
                                    ;">
                                        ${order.status}
                                    </span>
                                </td>
                                <td>
                                    <a href="orders?action=view&id=${order.orderId}" class="btn btn-info">Detayları Gör</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <p style="color: #2C3E50; text-align: center;">Henüz sipariş vermemişsiniz. <a href="${pageContext.request.contextPath}/pages/products.jsp">Alışverişe başla!</a></p>
            </c:otherwise>
        </c:choose>
    </div>
    
    <jsp:include page="footer.jsp" />
</body>
</html>
