<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ürün Yönetimi - KUNDURAŞ</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .table-responsive { overflow-x: auto; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #D4E4F7; }
        th { background-color: #5A7A8A; color: white; }
        tr:hover { background-color: #F8F9FA; }
        .action-buttons { display: flex; gap: 5px; flex-wrap: wrap; }
        .action-buttons a, .action-buttons button { padding: 5px 10px; text-decoration: none; border-radius: 4px; font-size: 12px; border: none; cursor: pointer; }
        .btn-edit { background-color: #4A90E2; color: white; }
        .btn-delete { background-color: #E8A5A5; color: white; }
        .btn-edit:hover { background-color: #3970C2; }
        .btn-delete:hover { background-color: #D88585; }
        .price { color: #4A90E2; font-weight: bold; }
        .stock-low { color: #E8A5A5; }
        .stock-ok { color: #72C8B3; }
    </style>
</head>
<body>
    <jsp:include page="/pages/header.jsp" />
    
    <div class="container">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px;">
            <h2 style="color: #2C3E50; margin: 0;">📦 Ürün Yönetimi</h2>
            <a href="${pageContext.request.contextPath}/admin?action=add-product" class="btn btn-success">➕ Yeni Ürün Ekle</a>
        </div>
        
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success" style="background-color: #E8F5F0; color: #2C5C4F; padding: 12px; border-left: 4px solid #72C8B3; margin-bottom: 20px;">
                ✅ ${successMessage}
            </div>
        </c:if>
        
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger" style="background-color: #F5E8E8; color: #8B4545; padding: 12px; border-left: 4px solid #E8A5A5; margin-bottom: 20px;">
                ❌ ${errorMessage}
            </div>
        </c:if>
        
        <div class="table-responsive">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Ürün Adı</th>
                        <th>Kategori</th>
                        <th>Fiyat</th>
                        <th>Stok</th>
                        <th>Durum</th>
                        <th>İşlemler</th>
                    </tr>
                </thead>
                <tbody>
                    <c:if test="${empty products}">
                        <tr>
                            <td colspan="7" style="text-align: center; color: #888; padding: 30px;">
                                Ürün bulunamadı
                            </td>
                        </tr>
                    </c:if>
                    <c:forEach items="${products}" var="product">
                        <tr>
                            <td>#${product.productId}</td>
                            <td><strong>${product.productName}</strong></td>
                            <td>${product.categoryName}</td>
                            <td class="price"><fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₺"/></td>
                            <td>
                                <c:choose>
                                    <c:when test="${product.quantityInStock <= 5}">
                                        <span class="stock-low">⚠️ ${product.quantityInStock}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="stock-ok">✅ ${product.quantityInStock}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:if test="${product.active}">
                                    <span style="background-color: #72C8B3; color: white; padding: 4px 8px; border-radius: 4px; font-size: 12px;">Aktif</span>
                                </c:if>
                                <c:if test="${!product.active}">
                                    <span style="background-color: #A0B0C8; color: white; padding: 4px 8px; border-radius: 4px; font-size: 12px;">Pasif</span>
                                </c:if>
                            </td>
                            <td>
                                <div class="action-buttons">
                                    <a href="${pageContext.request.contextPath}/admin?action=edit-product&productId=${product.productId}" class="btn-edit">✏️ Düzenle</a>
                                    <form action="${pageContext.request.contextPath}/admin" method="POST" style="display: inline; margin: 0;">
                                        <input type="hidden" name="action" value="delete-product">
                                        <input type="hidden" name="productId" value="${product.productId}">
                                        <button type="submit" class="btn-delete" onclick="return confirm('Bu ürünü silmek istediğinize emin misiniz?');">🗑️ Sil</button>
                                    </form>
                                </div>
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
