<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kayit Ol - KUNDURAŞ</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container register-container">
        <div class="register-box">
            <h2>KUNDURAŞ Kayit</h2>
            
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
            <% } %>
            
            <form action="${pageContext.request.contextPath}/auth" method="post">
                <input type="hidden" name="action" value="register">
                
                <div class="form-group">
                    <label for="fullName">Tam Adı:</label>
                    <input type="text" id="fullName" name="fullName" required>
                </div>
                
                <div class="form-group">
                    <label for="username">Kullanıcı Adı:</label>
                    <input type="text" id="username" name="username" required>
                </div>
                
                <div class="form-group">
                    <label for="email">E-mail:</label>
                    <input type="email" id="email" name="email" required>
                </div>
                
                <div class="form-group">
                    <label for="password">Şifre:</label>
                    <input type="password" id="password" name="password" required>
                </div>
                
                <div class="form-group">
                    <label for="confirmPassword">Şifre (Tekrar):</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" required>
                </div>
                
                <button type="submit" class="btn btn-primary">Kayıt Ol</button>
            </form>
            
            <p>Zaten hesabin var mi? <a href="${pageContext.request.contextPath}/auth?action=login">Giris yap</a></p>
        </div>
    </div>
</body>
</html>
