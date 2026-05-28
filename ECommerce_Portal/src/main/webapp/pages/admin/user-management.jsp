<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kullanıcı Yönetimi - KUNDURAŞ</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .table-responsive { overflow-x: auto; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #D4E4F7; }
        th { background-color: #5A7A8A; color: white; }
        tr:hover { background-color: #F8F9FA; }
        .badge { padding: 6px 12px; border-radius: 20px; font-size: 12px; font-weight: bold; }
        .badge-admin { background-color: #E8A5A5; color: white; }
        .badge-user { background-color: #72C8B3; color: white; }
        .badge-active { background-color: #72C8B3; color: white; }
        .badge-inactive { background-color: #A0B0C8; color: white; }
    </style>
</head>
<body>
    <jsp:include page="/pages/header.jsp" />
    
    <div class="container">
        <h2 style="color: #2C3E50; margin-bottom: 30px;">👥 Kullanıcı Yönetimi</h2>
        
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success" style="background-color: #E8F5F0; color: #2C5C4F; padding: 12px; border-left: 4px solid #72C8B3; margin-bottom: 20px;">
                ✅ ${successMessage}
            </div>
        </c:if>
        
        <div class="table-responsive">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Kullanıcı Adı</th>
                        <th>Ad Soyad</th>
                        <th>E-posta</th>
                        <th>Telefon</th>
                        <th>Rol</th>
                        <th>Durum</th>
                        <th>Kayıt Tarihi</th>
                    </tr>
                </thead>
                <tbody>
                    <c:if test="${empty users}">
                        <tr>
                            <td colspan="8" style="text-align: center; color: #888; padding: 30px;">
                                Kullanıcı bulunamadı
                            </td>
                        </tr>
                    </c:if>
                    <c:forEach var="user" items="${users}">
                        <tr>
                            <td>#${user.userId}</td>
                            <td><strong>${user.username}</strong></td>
                            <td>${user.fullName}</td>
                            <td>${user.email}</td>
                            <td>${empty user.phone ? '-' : user.phone}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${user.role == 'ADMIN'}">
                                        <span class="badge badge-admin">⚙️ Admin</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-user">👤 Kullanıcı</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:if test="${user.active}">
                                    <span class="badge badge-active">✅ Aktif</span>
                                </c:if>
                                <c:if test="${!user.active}">
                                    <span class="badge badge-inactive">⛔ Pasif</span>
                                </c:if>
                            </td>
                            <td><fmt:formatDate value="${user.createdAt}" pattern="dd.MM.yyyy" /></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
        
        <div style="margin-top: 30px; text-align: center;">
            <p style="color: #888;">Toplam Kullanıcı: <strong style="color: #4A90E2;">${users.size()}</strong></p>
        </div>
    </div>
    
    <jsp:include page="/pages/footer.jsp" />
</body>
</html>
