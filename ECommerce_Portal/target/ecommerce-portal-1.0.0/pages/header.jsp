<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    Object user = session.getAttribute("user");
    Object userRole = session.getAttribute("userRole");
    Object username = session.getAttribute("username");
%>
<header class="header">
    <div class="header-container">
        <div class="logo">
            <h1><a href="${pageContext.request.contextPath}/">KUNDURAŞ</a></h1>
        </div>
        
        <nav class="navbar">
            <ul class="nav-list">
                <li><a href="${pageContext.request.contextPath}/products">Ürünler</a></li>
                <li><a href="${pageContext.request.contextPath}/cart">Sepet</a></li>
                
                <% if (user != null) { %>
                    <li><a href="${pageContext.request.contextPath}/orders">Siparişlerim</a></li>
                    
                    <% if ("ADMIN".equals(userRole)) { %>
                        <li><a href="${pageContext.request.contextPath}/admin">Yönetici Paneli</a></li>
                    <% } %>
                    
                    <li style="color: #4A90E2; font-weight: 600;">Hoşgeldin, <%= username %>!</li>
                    <li><a href="${pageContext.request.contextPath}/auth?action=logout" class="btn btn-danger" style="padding: 8px 16px;">Çıkış Yap</a></li>
                <% } %>
                
                <% if (user == null) { %>
                    <li style="margin-left: auto;"><a href="${pageContext.request.contextPath}/auth?action=login" class="btn btn-primary" style="padding: 8px 16px;">Giris Yap</a></li>
                    <li><a href="${pageContext.request.contextPath}/auth?action=register" class="btn btn-success" style="padding: 8px 16px;">Kayit Ol</a></li>
                <% } %>
            </ul>
        </nav>
    </div>
</header>
