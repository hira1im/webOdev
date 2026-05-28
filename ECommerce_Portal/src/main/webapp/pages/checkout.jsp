<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ödeme - E-Commerce Portal</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="header.jsp" />
    
    <div class="container">
        <h2 style="color: #2C3E50;">Ödeme</h2>
        
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
        <% } %>
        
        <div style="background-color: white; padding: 30px; border-radius: 8px;">
            <form action="orders" method="post">
                <input type="hidden" name="action" value="checkout">
                
                <div class="form-group">
                    <label for="shippingAddress">Kargo Adresi:</label>
                    <textarea id="shippingAddress" name="shippingAddress" rows="5" required placeholder="Lütfen tam kargo adresinizi girin"></textarea>
                </div>
                
                <div style="margin-top: 30px;">
                    <button type="submit" class="btn btn-success" style="padding: 12px 30px; font-size: 16px;">Siparişi Tamamla</button>
                    <a href="${pageContext.request.contextPath}/pages/cart.jsp" class="btn btn-primary" style="margin-left: 10px; padding: 12px 30px; font-size: 16px;">Sepete Dön</a>
                </div>
            </form>
        </div>
    </div>
    
    <jsp:include page="footer.jsp" />
</body>
</html>
