<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Siparişler - KUNDURAŞ Yönetici</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .table-responsive { overflow-x: auto; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #D4E4F7; }
        th { background-color: #5A7A8A; color: white; }
        tr:hover { background-color: #F8F9FA; }
        .badge { padding: 6px 12px; border-radius: 20px; font-size: 12px; font-weight: bold; }
        .badge-pending { background-color: #A0B0C8; color: white; }
        .badge-processing { background-color: #4A90E2; color: white; }
        .badge-shipped { background-color: #72C8B3; color: white; }
        .badge-completed { background-color: #72C8B3; color: white; }
        .badge-cancelled { background-color: #E8A5A5; color: white; }
        .price { color: #4A90E2; font-weight: bold; }
    </style>
</head>
<body>
    <jsp:include page="/pages/header.jsp" />
    
    <div class="container">
        <h2 style="color: #2C3E50; margin-bottom: 30px;">📋 Tüm Siparişler</h2>
        
        <div class="table-responsive">
            <table>
                <thead>
                    <tr>
                        <th>Sipariş ID</th>
                        <th>Müşteri ID</th>
                        <th>Sipariş Tarihi</th>
                        <th>Tutar</th>
                        <th>Durum</th>
                        <th>İşlemler</th>
                    </tr>
                </thead>
                <tbody>
                    <c:if test="${empty orders}">
                        <tr>
                            <td colspan="6" style="text-align: center; color: #888; padding: 30px;">
                                Sipariş bulunamadı
                            </td>
                        </tr>
                    </c:if>
                    <c:forEach var="order" items="${orders}">
                        <tr>
                            <td><strong>#${order.orderId}</strong></td>
                            <td>${order.userId}</td>
                            <td><fmt:formatDate value="${order.orderDate}" pattern="dd.MM.yyyy HH:mm" /></td>
                            <td class="price"><fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₺"/></td>
                            <td>
                                <c:choose>
                                    <c:when test="${order.status == 'PENDING'}">
                                        <span class="badge badge-pending">⏳ Beklemede</span>
                                    </c:when>
                                    <c:when test="${order.status == 'PROCESSING'}">
                                        <span class="badge badge-processing">⚙️ İşleniyor</span>
                                    </c:when>
                                    <c:when test="${order.status == 'SHIPPED'}">
                                        <span class="badge badge-shipped">🚚 Kargoda</span>
                                    </c:when>
                                    <c:when test="${order.status == 'COMPLETED'}">
                                        <span class="badge badge-completed">✅ Tamamlandı</span>
                                    </c:when>
                                    <c:when test="${order.status == 'CANCELLED'}">
                                        <span class="badge badge-cancelled">❌ İptal Edildi</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-pending">${order.status}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin?action=order-detail&orderId=${order.orderId}" class="btn btn-primary" style="padding: 6px 12px; font-size: 12px;">👁️ Detaylar</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    
    <jsp:include page="/pages/footer.jsp" />
</body>
</html>
                            <td>
                                <a href="${pageContext.request.contextPath}/orders?action=view&id=${order.orderId}" class="btn btn-sm btn-info">View</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
        
        <c:if test="${empty orders}">
            <p>No orders found.</p>
        </c:if>
        
        <div class="admin-nav">
            <a href="${pageContext.request.contextPath}/admin?action=dashboard" class="btn btn-primary">Back to Dashboard</a>
        </div>
    </div>
    
    <jsp:include page="/pages/footer.jsp" />
</body>
</html>
