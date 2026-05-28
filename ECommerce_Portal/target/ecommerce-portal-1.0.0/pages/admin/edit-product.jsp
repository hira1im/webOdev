<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Product - E-Commerce Portal</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="/pages/header.jsp" />
    
    <div class="container">
        <h2>Edit Product</h2>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>
        
        <c:if test="${not empty product}">
            <form action="${pageContext.request.contextPath}/products" method="post" class="product-form">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="productId" value="${product.productId}">
                
                <div class="form-group">
                    <label for="categoryId">Category:</label>
                    <select id="categoryId" name="categoryId" required>
                        <option value="1" <c:if test="${product.categoryId == 1}">selected</c:if>>Electronics</option>
                        <option value="2" <c:if test="${product.categoryId == 2}">selected</c:if>>Books</option>
                        <option value="3" <c:if test="${product.categoryId == 3}">selected</c:if>>Clothing</option>
                        <option value="4" <c:if test="${product.categoryId == 4}">selected</c:if>>Home & Garden</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="productName">Product Name:</label>
                    <input type="text" id="productName" name="productName" value="${product.productName}" required maxlength="200">
                </div>
                
                <div class="form-group">
                    <label for="description">Description:</label>
                    <textarea id="description" name="description" rows="4" required>${product.description}</textarea>
                </div>
                
                <div class="form-group">
                    <label for="price">Price:</label>
                    <input type="number" id="price" name="price" step="0.01" min="0" value="${product.price}" required>
                </div>
                
                <div class="form-group">
                    <label for="quantity">Quantity in Stock:</label>
                    <input type="number" id="quantity" name="quantity" min="0" value="${product.quantityInStock}" required>
                </div>
                
                <div class="form-group">
                    <label for="imageUrl">Image URL:</label>
                    <input type="url" id="imageUrl" name="imageUrl" value="${product.imageUrl}">
                </div>
                
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">Update Product</button>
                    <a href="${pageContext.request.contextPath}/products?action=view&id=${product.productId}" class="btn btn-secondary">Cancel</a>
                </div>
            </form>
        </c:if>
        
        <c:if test="${empty product}">
            <div class="alert alert-danger">Product not found</div>
            <a href="${pageContext.request.contextPath}/products" class="btn btn-primary">Back to Products</a>
        </c:if>
    </div>
    
    <jsp:include page="/pages/footer.jsp" />
</body>
</html>
