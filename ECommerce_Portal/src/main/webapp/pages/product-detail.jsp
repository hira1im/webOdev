<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Urun Detayi - KUNDURAŞ</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="/pages/header.jsp" />
    
    <div class="container">
        <c:if test="${not empty product}">
            <div style="background-color: white; padding: 30px; border-radius: 8px;">
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 30px;">
                    <div>
                        <c:choose>
                            <c:when test="${empty product.imageUrl}">
                                <img src="${pageContext.request.contextPath}/images/placeholder-shoe.svg" alt="Gorsel yok" style="width: 100%; border-radius: 8px;">
                            </c:when>
                            <c:when test="${fn:startsWith(product.imageUrl, 'http')}">
                                <img src="${product.imageUrl}" alt="${product.productName}" style="width: 100%; border-radius: 8px;">
                            </c:when>
                            <c:when test="${fn:startsWith(product.imageUrl, '/')}">
                                <img src="${pageContext.request.contextPath}${product.imageUrl}" alt="${product.productName}" style="width: 100%; border-radius: 8px;">
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/${product.imageUrl}" alt="${product.productName}" style="width: 100%; border-radius: 8px;">
                            </c:otherwise>
                        </c:choose>
                    </div>
                    
                    <div>
                        <h2 style="color: #2C3E50;">${product.productName}</h2>
                        <p style="color: #666; margin: 20px 0;">${product.description}</p>
                        
                        <p style="font-size: 24px; color: #1f6d5e; font-weight: bold; margin: 20px 0;">
                            <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₺"/>
                        </p>
                        
                        <p style="margin: 20px 0;">
                            <strong>Stok:</strong> ${product.quantityInStock}
                        </p>
                        
                        <c:if test="${product.quantityInStock > 0}">
                            <form action="${pageContext.request.contextPath}/cart" method="post" style="margin: 20px 0;">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="productId" value="${product.productId}">
                                
                                <div style="margin: 20px 0;">
                                    <label for="quantity">Miktar:</label>
                                    <input type="number" id="quantity" name="quantity" value="1" min="1" max="${product.quantityInStock}" style="width: 100px;">
                                </div>
                                
                                <button type="submit" class="btn btn-success" style="padding: 15px 30px; font-size: 16px;">Sepete Ekle</button>
                            </form>
                        </c:if>
                        
                        <c:if test="${product.quantityInStock <= 0}">
                            <button class="btn btn-danger" disabled style="padding: 15px 30px; font-size: 16px;">Stokta Yok</button>
                        </c:if>
                    </div>
                </div>
            </div>
            
            <div style="margin-top: 20px;">
                <a href="${pageContext.request.contextPath}/products" class="btn btn-primary">Urunlere Don</a>
            </div>
        </c:if>
        
        <c:if test="${empty product}">
            <p style="color: #2C3E50;">Urun bulunamadi. <a href="${pageContext.request.contextPath}/products">Tum urunleri gor</a></p>
        </c:if>
    </div>

    <jsp:include page="/pages/footer.jsp" />
</body>
</html>
