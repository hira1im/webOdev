<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Alisveris Sepeti - KUNDURAŞ</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="/pages/header.jsp" />
    
    <div class="container">
        <h2 style="color: #2C3E50;">Alışveriş Sepeti</h2>
        
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
        <% } %>
        
        <% 
            @SuppressWarnings("unchecked")
            java.util.List<?> cartItems = (java.util.List<?>) request.getAttribute("cartItems");
            if (cartItems != null && !cartItems.isEmpty()) {
        %>
                <table class="table">
                    <thead>
                        <tr>
                            <th>Ürün ID</th>
                            <th>Miktar</th>
                            <th>Eklenme Tarihi</th>
                            <th>İşlem</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                            for (Object item : cartItems) {
                                try {
                                    java.lang.reflect.Field f1 = item.getClass().getDeclaredField("productId");
                                    java.lang.reflect.Field f2 = item.getClass().getDeclaredField("quantity");
                                    java.lang.reflect.Field f3 = item.getClass().getDeclaredField("cartId");
                                    java.lang.reflect.Field f4 = item.getClass().getDeclaredField("addedAt");
                                    f1.setAccessible(true); f2.setAccessible(true); f3.setAccessible(true); f4.setAccessible(true);
                                    Object productId = f1.get(item);
                                    Object quantity = f2.get(item);
                                    Object cartId = f3.get(item);
                                    Object addedAt = f4.get(item);
                        %>
                            <tr>
                                <td><%= productId %></td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/cart" method="post" style="display:inline;">
                                        <input type="hidden" name="action" value="update">
                                        <input type="hidden" name="cartId" value="<%= cartId %>">
                                        <input type="number" name="quantity" value="<%= quantity %>" min="1">
                                        <button type="submit" class="btn btn-small btn-primary">Güncelle</button>
                                    </form>
                                </td>
                                <td><%= sdf.format(addedAt) %></td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/cart" method="post" style="display:inline;">
                                        <input type="hidden" name="action" value="remove">
                                        <input type="hidden" name="cartId" value="<%= cartId %>">
                                        <button type="submit" class="btn btn-danger">Kaldır</button>
                                    </form>
                                </td>
                            </tr>
                        <% } catch (Exception e) {} } %>
                    </tbody>
                </table>
                
                <div class="cart-actions">
                    <a href="${pageContext.request.contextPath}/products" class="btn btn-primary">Alisverise Devam Et</a>
                    <a href="${pageContext.request.contextPath}/cart?action=clear" class="btn btn-danger">Sepeti Temizle</a>
                    <a href="${pageContext.request.contextPath}/pages/checkout.jsp" class="btn btn-success">Odeme Sayfasina Git</a>
                </div>
        <% } else { %>
                <p style="color: #2C3E50; text-align: center;">Sepetiniz bos. <a href="${pageContext.request.contextPath}/products">Alisverise basla!</a></p>
        <% } %>
    </div>
    
    <jsp:include page="/pages/footer.jsp" />
</body>
</html>
