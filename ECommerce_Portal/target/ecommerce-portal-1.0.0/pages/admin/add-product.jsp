<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:choose><c:when test="${not empty product}">Ürün Düzenle</c:when><c:otherwise>Yeni Ürün Ekle</c:otherwise></c:choose> - KUNDURAŞ</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="/pages/header.jsp" />
    
    <div class="container">
        <h2 style="color: #2C3E50; margin-bottom: 30px;">
            <c:choose>
                <c:when test="${not empty product}">✏️ Ürün Düzenle</c:when>
                <c:otherwise>➕ Yeni Ürün Ekle</c:otherwise>
            </c:choose>
        </h2>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger" style="background-color: #F5E8E8; color: #8B4545; padding: 12px; border-left: 4px solid #E8A5A5; margin-bottom: 20px;">
                ❌ ${error}
            </div>
        </c:if>
        
        <form action="${pageContext.request.contextPath}/admin" method="POST" class="product-form" style="max-width: 600px;">
            <input type="hidden" name="action" value="<c:choose><c:when test="${not empty product}">update-product</c:when><c:otherwise>add-product</c:otherwise></c:choose>">
            <c:if test="${not empty product}">
                <input type="hidden" name="productId" value="${product.productId}">
            </c:if>
            
            <div class="form-group">
                <label for="categoryId">Kategori *</label>
                <select id="categoryId" name="categoryId" required style="width: 100%; padding: 10px; border: 2px solid #D4E4F7; border-radius: 4px; font-size: 14px;">
                    <option value="">-- Kategori Seçin --</option>
                    <c:forEach items="${categories}" var="cat">
                        <option value="${cat.categoryId}" <c:if test="${not empty product && product.categoryId == cat.categoryId}">selected</c:if>>
                            ${cat.categoryName}
                        </option>
                    </c:forEach>
                </select>
            </div>
            
            <div class="form-group">
                <label for="productName">Ürün Adı *</label>
                <input type="text" id="productName" name="productName" 
                       value="${not empty product ? product.productName : ''}" 
                       required maxlength="200" 
                       style="width: 100%; padding: 10px; border: 2px solid #D4E4F7; border-radius: 4px; font-size: 14px;">
            </div>
            
            <div class="form-group">
                <label for="description">Açıklama *</label>
                <textarea id="description" name="description" rows="4" required maxlength="1000"
                          style="width: 100%; padding: 10px; border: 2px solid #D4E4F7; border-radius: 4px; font-size: 14px; font-family: Arial;">${not empty product ? product.description : ''}</textarea>
            </div>
            
            <div class="form-group">
                <label for="price">Fiyat (₺) *</label>
                <input type="number" id="price" name="price" step="0.01" min="0" required
                       value="${not empty product ? product.price : ''}"
                       style="width: 100%; padding: 10px; border: 2px solid #D4E4F7; border-radius: 4px; font-size: 14px;">
            </div>
            
            <div class="form-group">
                <label for="quantity">Stok Miktarı *</label>
                <input type="number" id="quantity" name="quantity" min="0" required
                       value="${not empty product ? product.quantityInStock : ''}"
                       style="width: 100%; padding: 10px; border: 2px solid #D4E4F7; border-radius: 4px; font-size: 14px;">
            </div>
            
            <div class="form-group">
                <label for="imageUrl">Görsel URL</label>
                <input type="url" id="imageUrl" name="imageUrl" 
                       value="${not empty product ? product.imageUrl : ''}"
                       style="width: 100%; padding: 10px; border: 2px solid #D4E4F7; border-radius: 4px; font-size: 14px;">
            </div>
            
            <c:if test="${not empty product}">
                <div class="form-group">
                    <label for="isActive">
                        <input type="checkbox" id="isActive" name="isActive" value="true" 
                               <c:if test="${product.active}">checked</c:if>>
                        Aktif Ürün
                    </label>
                </div>
            </c:if>
            
            <div class="form-actions" style="display: flex; gap: 10px; margin-top: 20px;">
                <button type="submit" class="btn btn-primary" style="padding: 12px 28px;">💾 Kaydet</button>
                <a href="${pageContext.request.contextPath}/admin?action=products" class="btn btn-secondary" style="padding: 12px 28px;">❌ İptal</a>
            </div>
        </form>
    </div>
    
    <jsp:include page="/pages/footer.jsp" />
</body>
</html>
