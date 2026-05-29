<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>KUNDURAŞ - Ayakkabı Dünyası</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="pages/header.jsp" />

    <div class="container">
        <section class="hero">
            <div>
                <span class="hero-badge">KUNDURAŞ Koleksiyonu</span>
                <h1 class="hero-title">Her adimda konfor, her stilde iddia.</h1>
                <p class="hero-lede">
                    KUNDURAŞ, gunluk, spor ve ozel gun ayakkabilarini bir araya getirir. Kaliteli
                    malzeme, dengeli fiyatlandirma ve guvenli odeme ile yeni koleksiyonumuzu kesfedin.
                </p>

                <% if (session.getAttribute("user") == null) { %>
                    <div class="hero-actions">
                        <a href="${pageContext.request.contextPath}/auth?action=login" class="btn btn-primary">Giris Yap</a>
                        <a href="${pageContext.request.contextPath}/auth?action=register" class="btn btn-success">Kayit Ol</a>
                        <a href="${pageContext.request.contextPath}/products" class="btn btn-secondary">Urunleri Incele</a>
                    </div>
                <% } %>

                <% if (session.getAttribute("user") != null) { %>
                    <div class="hero-actions">
                        <a href="${pageContext.request.contextPath}/products" class="btn btn-primary">Urunleri Incele</a>
                        <a href="${pageContext.request.contextPath}/cart" class="btn btn-secondary">Sepete Git</a>
                    </div>
                <% } %>
            </div>

            <div style="display: grid; gap: 16px;">
                <div class="hero-feature">
                    <h4>Sehir Stili</h4>
                    <p>Ofisten hafta sonuna, her ortam icin dengeli tasarim ve destek.</p>
                </div>
                <div class="hero-feature">
                    <h4>Spor Performans</h4>
                    <p>Hafif taban, nefes alan yuzey ve esnek yapilarla daha uzun adimlar.</p>
                </div>
                <div class="hero-feature">
                    <h4>Bakim & Aksesuar</h4>
                    <p>Ayakkabinizi uzun omurlu tutmak icin temizleme ve bakim urunleri.</p>
                </div>
            </div>
        </section>
    </div>

    <jsp:include page="pages/footer.jsp" />
</body>
</html>
