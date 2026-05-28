<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sipariş Detayı - KUNDURAŞ</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .order-info { background: linear-gradient(135deg, #F8F9FA 0%, #F0F3F7 100%); padding: 20px; border-radius: 8px; margin: 20px 0; border-left: 4px solid #4A90E2; }
        .info-row { display: grid; grid-template-columns: 150px 1fr; margin: 10px 0; padding: 8px; border-bottom: 1px solid #D4E4F7; }
        .info-label { font-weight: bold; color: #2C3E50; }
        .info-value { color: #555; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #D4E4F7; }
        th { background-color: #5A7A8A; color: white; }
        tr:hover { background-color: #F8F9FA; }
        .price { color: #4A90E2; font-weight: bold; }
        .total-row { background-color: #E8F5F0; font-weight: bold; }
        .status-select { padding: 8px; border: 2px solid #D4E4F7; border-radius: 4px; font-size: 14px; }
    </style>
</head>
<body>
    <jsp:include page="/pages/header.jsp" />
    
    <div class="container">
        <h2 style="color: #2C3E50; margin-bottom: 30px;">📦 Sipariş Detayı #${order.orderId}</h2>
        
        <div class="order-info">
            <div class="info-row">
                <div class="info-label">Sipariş ID:</div>
                <div class="info-value">#${order.orderId}</div>
            </div>
            <div class="info-row">
                <div class="info-label">Müşteri ID:</div>
                <div class="info-value">${order.userId}</div>
            </div>
            <div class="info-row">
                <div class="info-label">Sipariş Tarihi:</div>
                <div class="info-value"><fmt:formatDate value="${order.orderDate}" pattern="dd.MM.yyyy HH:mm" /></div>
            </div>
            <div class="info-row">
                <div class="info-label">Toplam Tutar:</div>
                <div class="info-value price"><fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₺"/></div>
            </div>
            <div class="info-row">
                <div class="info-label">Kargo Adresi:</div>
                <div class="info-value">${order.shippingAddress}</div>
            </div>
            <div class="info-row">
                <div class="info-label">Durum:</div>
                <div class="info-value">
                    <form action="${pageContext.request.contextPath}/admin" method="POST" style="display: inline;">
                        <input type="hidden" name="action" value="update-order-status">
                        <input type="hidden" name="orderId" value="${order.orderId}">
                        <select name="status" class="status-select">
                            <option value="PENDING" <c:if test="${order.status == 'PENDING'}">selected</c:if>>⏳ Beklemede</option>
                            <option value="PROCESSING" <c:if test="${order.status == 'PROCESSING'}">selected</c:if>>⚙️ İşleniyor</option>
                            <option value="SHIPPED" <c:if test="${order.status == 'SHIPPED'}">selected</c:if>>🚚 Kargoda</option>
                            <option value="COMPLETED" <c:if test="${order.status == 'COMPLETED'}">selected</c:if>>✅ Tamamlandı</option>
                            <option value="CANCELLED" <c:if test="${order.status == 'CANCELLED'}">selected</c:if>>❌ İptal Edildi</option>
                        </select>
                        <button type="submit" class="btn btn-primary" style="padding: 6px 12px; margin-left: 10px;">Güncelle</button>
                    </form>
                </div>
            </div>
        </div>
        
        <h3 style="color: #2C3E50; margin-top: 30px;">📋 Sipariş Ürünleri</h3>
        
        <div style="overflow-x: auto;">
            <table>
                <thead>
                    <tr>
                        <th>Ürün ID</th>
                        <th>Ürün Adı</th>
                        <th>Birim Fiyat</th>
                        <th>Miktar</th>
                        <th>Ara Toplam</th>
                    </tr>
                </thead>
                <tbody>
                    <c:if test="${empty orderItems}">
                        <tr>
                            <td colspan="5" style="text-align: center; color: #888; padding: 20px;">
                                Ürün bilgisi bulunamadı
                            </td>
                        </tr>
                    </c:if>
                    <c:forEach var="item" items="${orderItems}">
                        <tr>
                            <td>#${item.productId}</td>
                            <td>${item.productName}</td>
                            <td class="price"><fmt:formatNumber value="${item.unitPrice}" type="currency" currencySymbol="₺"/></td>
                            <td>${item.quantity}</td>
                            <td class="price"><fmt:formatNumber value="${item.subtotal}" type="currency" currencySymbol="₺"/></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        
        <div style="text-align: right; margin-top: 20px;">
            <h3 style="color: #4A90E2;">Toplam: <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₺"/></h3>
        </div>
        
        <div style="margin-top: 30px;">
            <a href="${pageContext.request.contextPath}/admin?action=orders" class="btn btn-secondary" style="padding: 12px 28px;">⬅️ Siparişlere Dön</a>
        </div>
    </div>
    
    <jsp:include page="/pages/footer.jsp" />
</body>
</html>
