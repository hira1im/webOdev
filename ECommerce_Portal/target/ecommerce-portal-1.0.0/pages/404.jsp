<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>404 - Sayfa Bulunamadı</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .error-container {
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 600px;
            background-color: #f8f9fa;
        }
        .error-content {
            text-align: center;
            background: white;
            padding: 50px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .error-code {
            font-size: 80px;
            font-weight: bold;
            color: #E8A5A5;
            margin: 0;
        }
        .error-message {
            font-size: 24px;
            color: #2C3E50;
            margin: 20px 0;
        }
        .error-description {
            color: #4A6A7A;
            margin: 20px 0 30px 0;
        }
        .btn-group {
            margin-top: 30px;
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            margin: 0 5px;
            border-radius: 4px;
            text-decoration: none;
            font-weight: bold;
        }
        .btn-primary {
            background-color: #4A90E2;
            color: white;
        }
        .btn-primary:hover {
            background-color: #3A7AC8;
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />
    
    <div class="error-container">
        <div class="error-content">
            <h1 class="error-code">404</h1>
            <h2 class="error-message">Sayfa Bulunamadı</h2>
            <p class="error-description">
                Üzgünüz, aradığınız sayfa bulunamıyor ya da taşınmış.
            </p>
            <div class="btn-group">
                <a href="${pageContext.request.contextPath}/" class="btn btn-primary">Ana Sayfaya Git</a>
                <a href="${pageContext.request.contextPath}/pages/products.jsp" class="btn btn-primary">Ürünleri Gör</a>
            </div>
        </div>
    </div>
    
    <jsp:include page="footer.jsp" />
</body>
</html>
            </div>
        </div>
    </div>
    
    <jsp:include page="footer.jsp" />
</body>
</html>
