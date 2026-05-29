<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giris - KUNDURAŞ</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="container login-container">
        <div class="login-box">
            <h2>KUNDURAŞ Giris</h2>
            
            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
            <% } %>
            
            <% if (request.getAttribute("message") != null) { %>
                <div class="alert alert-success"><%= request.getAttribute("message") %></div>
            <% } %>
            
            <form action="${pageContext.request.contextPath}/auth" method="post">
                <input type="hidden" name="action" value="login">
                
                <div class="form-group">
                    <label for="username">Kullanıcı Adı:</label>
                    <input type="text" id="username" name="username" required>
                </div>
                
                <div class="form-group">
                    <label for="password">Şifre:</label>
                    <input type="password" id="password" name="password" required>
                </div>
                
                <button type="submit" class="btn btn-primary">Giriş Yap</button>
            </form>
            
            <p>Hesabin yok mu? <a href="${pageContext.request.contextPath}/auth?action=register">Kayit ol</a></p>
        </div>
    </div>
</body>
</html>
