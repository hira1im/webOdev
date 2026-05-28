<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sipariş Detayı - E-Commerce Portal</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="header.jsp" />
    
    <div class="container">
        <h2 style="color: #2C3E50;">Sipariş Detayları</h2>
        
        <c:if test="${not empty order}">
            <div style="background-color: white; padding: 30px; border-radius: 8px;">
                <div style="margin-bottom: 30px;">
                    <h3 style="color: #2C3E50;">Sipariş Bilgileri</h3>
                    <p><strong>Sipariş ID:</strong> ${order.orderId}</p>
                    <p><strong>Sipariş Tarihi:</strong> <fmt:formatDate value="${order.orderDate}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
                    <p><strong>Toplam Tutar:</strong> <fmt:formatNumber value="${order.totalAmount}" type="currency"/></p>
                    <p><strong>Durum:</strong> ${order.status}</p>
                    <p><strong>Kargo Adresi:</strong></p>
                    <p style="margin-left: 20px; white-space: pre-line;">${order.shippingAddress}</p>
                </div>
                
                <div>
                    <h3 style="color: #2C3E50;">Sipariş Ürünleri</h3>
                    <c:if test="${not empty orderDetails}">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Ürün ID</th>
                                    <th>Miktar</th>
                                    <th>Birim Fiyatı</th>
                                    <th>Ara Toplam</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="detail" items="${orderDetails}">
                                    <tr>
                                        <td>${detail.productId}</td>
                                        <td>${detail.quantity}</td>
                                        <td><fmt:formatNumber value="${detail.unitPrice}" type="currency"/></td>
                                        <td><fmt:formatNumber value="${detail.subtotal}" type="currency"/></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:if>
                </div>
            </div>
            
            <div style="margin-top: 20px;">
                <a href="orders" class="btn btn-primary">Siparişlere Dön</a>
            </div>
        </c:if>
        
        <c:if test="${empty order}">
            <p style="color: #2C3E50;">Sipariş bulunamadı. <a href="orders">Tüm siparişleri gör</a></p>
        </c:if>
    </div>
    
    <jsp:include page="footer.jsp" />
</body>
</html>
