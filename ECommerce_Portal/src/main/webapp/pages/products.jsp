<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Urunler - KUNDURAŞ</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="/pages/header.jsp" />

    <div class="container">
        <h2 style="color: #2b2620;">KUNDURAŞ Urunleri</h2>

        <div class="search-box">
            <form action="${pageContext.request.contextPath}/products" method="get">
                <input type="hidden" name="action" value="search">
                <input type="text" name="keyword" placeholder="Ayakkabi ara..." value="${keyword}">
                <button type="submit" class="btn btn-primary">Ara</button>
            </form>
        </div>

        <div class="products-grid">
            <c:choose>
                <c:when test="${not empty products}">
                    <c:forEach items="${products}" var="product">
                        <div class="product-card">
                            <div class="product-image">
                                <c:choose>
                                    <c:when test="${empty product.imageUrl}">
                                        <img src="${pageContext.request.contextPath}/images/placeholder-shoe.svg" alt="Gorsel yok">
                                    </c:when>
                                    <c:when test="${fn:startsWith(product.imageUrl, 'http')}">
                                        <img src="${product.imageUrl}" alt="${product.productName}">
                                    </c:when>
                                    <c:when test="${fn:startsWith(product.imageUrl, '/')}">
                                        <img src="${pageContext.request.contextPath}${product.imageUrl}" alt="${product.productName}">
                                    </c:when>
                                    <c:otherwise>
                                        <img src="${pageContext.request.contextPath}/${product.imageUrl}" alt="${product.productName}">
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="product-info">
                                <span class="product-tag">${product.categoryName}</span>
                                <h3>${product.productName}</h3>
                                <p class="product-description">${product.description}</p>
                                <p class="product-price">
                                    <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₺" />
                                </p>
                                <p class="product-stock">Stok: ${product.quantityInStock}</p>

                                <c:choose>
                                    <c:when test="${product.quantityInStock > 0}">
                                        <form action="${pageContext.request.contextPath}/cart" method="post">
                                            <input type="hidden" name="action" value="add">
                                            <input type="hidden" name="productId" value="${product.productId}">
                                            <input type="number" name="quantity" value="1" min="1" max="${product.quantityInStock}">
                                            <button type="submit" class="btn btn-primary">Sepete Ekle</button>
                                        </form>
                                    </c:when>
                                    <c:otherwise>
                                        <button class="btn btn-danger" disabled>Stokta Yok</button>
                                    </c:otherwise>
                                </c:choose>

                                <a href="${pageContext.request.contextPath}/products?action=view&id=${product.productId}" class="btn btn-secondary">Detaylari Gor</a>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <p style="grid-column: 1 / -1; text-align: center; color: #5a4d41;">Urun bulunamadi.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <jsp:include page="/pages/footer.jsp" />
</body>
</html>
