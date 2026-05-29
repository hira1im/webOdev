<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Urun Duzenle - KUNDURAŞ</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="/pages/header.jsp" />
    
    <div class="container">
        <h2>Urun Duzenle</h2>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        
        <c:if test="${not empty product}">
            <form action="${pageContext.request.contextPath}/products" method="post" class="product-form">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="productId" value="${product.productId}">
                
                <div class="form-group">
                    <label for="categoryId">Kategori:</label>
                    <select id="categoryId" name="categoryId" required>
                        <option value="1" <c:if test="${product.categoryId == 1}">selected</c:if>>Erkek Ayakkabi</option>
                        <option value="2" <c:if test="${product.categoryId == 2}">selected</c:if>>Kadin Ayakkabi</option>
                        <option value="3" <c:if test="${product.categoryId == 3}">selected</c:if>>Cocuk Ayakkabi</option>
                        <option value="4" <c:if test="${product.categoryId == 4}">selected</c:if>>Spor Ayakkabi</option>
                        <option value="5" <c:if test="${product.categoryId == 5}">selected</c:if>>Ayakkabi Aksesuar</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="productName">Urun Adi:</label>
                    <input type="text" id="productName" name="productName" value="${product.productName}" required maxlength="200">
                </div>
                
                <div class="form-group">
                    <label for="description">Aciklama:</label>
                    <textarea id="description" name="description" rows="4" required>${product.description}</textarea>
                </div>
                
                <div class="form-group">
                    <label for="price">Fiyat (TL):</label>
                    <input type="number" id="price" name="price" step="0.01" min="0" value="${product.price}" required>
                </div>
                
                <div class="form-group">
                    <label for="quantity">Stok Miktari:</label>
                    <input type="number" id="quantity" name="quantity" min="0" value="${product.quantityInStock}" required>
                </div>
                
                <div class="form-group">
                    <label for="imageUrl">Gorsel URL:</label>
                    <input type="url" id="imageUrl" name="imageUrl" value="${product.imageUrl}">
                </div>
                
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">Urunu Guncelle</button>
                    <a href="${pageContext.request.contextPath}/products?action=view&id=${product.productId}" class="btn btn-secondary">Iptal</a>
                </div>
            </form>
        </c:if>
        
        <c:if test="${empty product}">
            <div class="alert alert-danger">Urun bulunamadi</div>
            <a href="${pageContext.request.contextPath}/products" class="btn btn-primary">Urunlere Don</a>
        </c:if>
    </div>
    
    <jsp:include page="/pages/footer.jsp" />
</body>
</html>
