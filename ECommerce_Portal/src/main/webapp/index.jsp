<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hoşgeldiniz - E-Commerce Portal</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="pages/header.jsp" />
    
    <div class="container">
        <h1 style="text-align: center; margin: 40px 0; color: #6B5089;">E-Commerce Portal'a Hoşgeldiniz</h1>
        
        <div style="background-color: white; padding: 40px; border-radius: 12px; text-align: center; box-shadow: 0 4px 15px rgba(147, 112, 219, 0.15);">
            <p style="font-size: 18px; margin-bottom: 20px; color: #4A3A6B;">
                Yüksek kaliteli ürünleri inanılmaz fiyatlarla keşfet. Geniş katalogumuzda gezinerek aradığın ürünü bul.
            </p>
            
            <% if (session.getAttribute("user") == null) { %>
                <div style="margin: 30px 0;">
                    <p style="margin-bottom: 30px; font-size: 16px; color: #6B5089; font-weight: 600;">Alışverişe başlamaya hazır mısın?</p>
                    <a href="${pageContext.request.contextPath}/pages/login.jsp" class="btn btn-primary" style="margin-right: 15px;">Giriş Yap</a>
                    <a href="${pageContext.request.contextPath}/pages/register.jsp" class="btn btn-success">Kayıt Ol</a>
                </div>
            <% } %>
            
            <% if (session.getAttribute("user") != null) { %>
                <div style="margin: 30px 0;">
                    <p style="margin-bottom: 30px; font-size: 16px; color: #6B5089; font-weight: 600;">Ürünlerimizi keşfetmeye başla!</p>
                    <a href="${pageContext.request.contextPath}/products" class="btn btn-primary">Ürünleri Gör</a>
                </div>
            <% } %>
        </div>
    </div>
    
    <jsp:include page="pages/footer.jsp" />
</body>
</html>
