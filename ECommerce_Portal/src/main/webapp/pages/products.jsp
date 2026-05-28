<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ürünler - E-Commerce Portal</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="header.jsp" />
    
    <div class="container">
        <h2 style="color: #6B5089;">Ürünler</h2>
        
        <div class="search-box">
            <form action="products" method="get">
                <input type="hidden" name="action" value="search">
                <input type="text" name="keyword" placeholder="Ürün ara...">
                <button type="submit" class="btn btn-primary">Ara</button>
            </form>
        </div>
        
        <div class="products-grid">
            <% if (request.getAttribute("products") != null && !((java.util.List) request.getAttribute("products")).isEmpty()) { %>
                <% java.util.List<?> products = (java.util.List<?>) request.getAttribute("products"); %>
                <% for (Object product : products) { %>
                    <div class="product-card">
                        <div class="product-image">
                            <!-- Ürün görüntüsü -->
                        </div>
                        <div class="product-info">
                            <!-- Ürün bilgileri -->
                        </div>
                    </div>
                <% } %>
            <% } else { %>
                                <c:if test="${product.quantityInStock <= 0}">
                                    <button class="btn btn-danger" disabled>Out of Stock</button>
                        </div>
                    </div>
                <% } %>
            <% } else { %>
                    <p style="grid-column: 1 / -1; text-align: center; color: #6B5089;">Ürün bulunamadı.</p>
            <% } %>
        </div>
    </div>
    
    <jsp:include page="footer.jsp" />
</body>
</html>
