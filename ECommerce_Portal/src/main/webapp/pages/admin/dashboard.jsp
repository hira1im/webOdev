<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Yönetici Paneli - KUNDURAŞ</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="/pages/header.jsp" />
    
    <div class="container">
        <h2 style="color: #2C3E50; margin-bottom: 30px;">📊 Yönetici Paneli - Özet</h2>
        
        <div class="dashboard-stats" style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 20px; margin-bottom: 40px;">
            <div class="stat-card" style="background: linear-gradient(135deg, #E8F5F0 0%, #D4F0E8 100%); padding: 20px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1);">
                <h3 style="color: #2C5C4F; margin: 0;">📦 Toplam Ürün</h3>
                <p class="stat-number" style="font-size: 2.5em; color: #4A90E2; margin: 10px 0;">${totalProducts}</p>
                <a href="${pageContext.request.contextPath}/admin?action=products" class="btn btn-primary">Ürünleri Yönet</a>
            </div>
            
            <div class="stat-card" style="background: linear-gradient(135deg, #F5E8F0 0%, #F0D4E8 100%); padding: 20px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1);">
                <h3 style="color: #5C2C4F; margin: 0;">🏷️ Toplam Kategori</h3>
                <p class="stat-number" style="font-size: 2.5em; color: #E8A5A5; margin: 10px 0;">${totalCategories}</p>
                <a href="${pageContext.request.contextPath}/admin?action=categories" class="btn btn-primary">Kategorileri Yönet</a>
            </div>
            
            <div class="stat-card" style="background: linear-gradient(135deg, #F0E8F5 0%, #E8D4F0 100%); padding: 20px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1);">
                <h3 style="color: #4F2C5C; margin: 0;">👥 Toplam Kullanıcı</h3>
                <p class="stat-number" style="font-size: 2.5em; color: #72C8B3; margin: 10px 0;">${totalUsers}</p>
                <a href="${pageContext.request.contextPath}/admin?action=users" class="btn btn-primary">Kullanıcıları Yönet</a>
            </div>
            
            <div class="stat-card" style="background: linear-gradient(135deg, #F8F0E8 0%, #F0E8D4 100%); padding: 20px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1);">
                <h3 style="color: #5C4F2C; margin: 0;">📋 Toplam Sipariş</h3>
                <p class="stat-number" style="font-size: 2.5em; color: #A0B0C8; margin: 10px 0;">${totalOrders}</p>
                <a href="${pageContext.request.contextPath}/admin?action=orders" class="btn btn-primary">Siparişleri Yönet</a>
            </div>
        </div>
        
        <div class="admin-actions" style="background: linear-gradient(135deg, #F8F9FA 0%, #F0F3F7 100%); padding: 25px; border-radius: 8px; border-left: 4px solid #4A90E2;">
            <h3 style="color: #2C3E50; margin-top: 0;">⚙️ Hızlı İşlemler</h3>
            <ul style="list-style: none; padding: 0; display: grid; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr)); gap: 10px;">
                <li><a href="${pageContext.request.contextPath}/admin?action=products" class="btn btn-success" style="display: inline-block; width: 100%; text-align: center;">📦 Tüm Ürünleri Görüntüle</a></li>
                <li><a href="${pageContext.request.contextPath}/admin?action=add-product" class="btn btn-primary" style="display: inline-block; width: 100%; text-align: center;">➕ Yeni Ürün Ekle</a></li>
                <li><a href="${pageContext.request.contextPath}/admin?action=categories" class="btn btn-info" style="display: inline-block; width: 100%; text-align: center;">🏷️ Kategorileri Yönet</a></li>
                <li><a href="${pageContext.request.contextPath}/admin?action=orders" class="btn btn-warning" style="display: inline-block; width: 100%; text-align: center;">📋 Siparişleri Görüntüle</a></li>
                <li><a href="${pageContext.request.contextPath}/admin?action=users" class="btn btn-info" style="display: inline-block; width: 100%; text-align: center;">👥 Kullanıcıları Görüntüle</a></li>
            </ul>
        </div>
    </div>
    
    <jsp:include page="/pages/footer.jsp" />
</body>
</html>
