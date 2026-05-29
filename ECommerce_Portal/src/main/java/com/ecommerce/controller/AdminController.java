package com.ecommerce.controller;

import com.ecommerce.dao.*;
import com.ecommerce.model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin")
public class AdminController extends HttpServlet {
    private OrderDAO orderDAO = new OrderDAO();
    private ProductDAO productDAO = new ProductDAO();
    private CategoryDAO categoryDAO = new CategoryDAO();
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Admin role kontrolü
        Object userRole = request.getSession().getAttribute("userRole");
        if (userRole == null || !"ADMIN".equals(userRole)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            action = "dashboard";
        }

        switch (action) {
            case "dashboard":
                showDashboard(request, response);
                break;
            case "products":
                showProducts(request, response);
                break;
            case "add-product":
                showAddProduct(request, response);
                break;
            case "edit-product":
                showEditProduct(request, response);
                break;
            case "categories":
                showCategories(request, response);
                break;
            case "add-category":
                showAddCategory(request, response);
                break;
            case "edit-category":
                showEditCategory(request, response);
                break;
            case "orders":
                showOrders(request, response);
                break;
            case "order-detail":
                showOrderDetail(request, response);
                break;
            case "users":
                showUsers(request, response);
                break;
            default:
                showDashboard(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Admin role kontrolü
        Object userRole = request.getSession().getAttribute("userRole");
        if (userRole == null || !"ADMIN".equals(userRole)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            action = "dashboard";
        }

        switch (action) {
            case "add-product":
                handleAddProduct(request, response);
                break;
            case "update-product":
                handleUpdateProduct(request, response);
                break;
            case "delete-product":
                handleDeleteProduct(request, response);
                break;
            case "add-category":
                handleAddCategory(request, response);
                break;
            case "update-category":
                handleUpdateCategory(request, response);
                break;
            case "delete-category":
                handleDeleteCategory(request, response);
                break;
            case "update-order-status":
                handleUpdateOrderStatus(request, response);
                break;
            default:
                showDashboard(request, response);
                break;
        }
    }

    // ========== GET Methods ==========
    
    private void showDashboard(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int totalOrders = orderDAO.getAllOrders().size();
        int totalProducts = productDAO.getAllProducts().size();
        int totalCategories = categoryDAO.getAllCategories().size();
        int totalUsers = userDAO.getAllUsers().size();

        request.setAttribute("totalOrders", totalOrders);
        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("totalCategories", totalCategories);
        request.setAttribute("totalUsers", totalUsers);

        request.getRequestDispatcher("/pages/admin/dashboard.jsp").forward(request, response);
    }

    private void showProducts(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Product> products = productDAO.getAllProducts();
        request.setAttribute("products", products);
        request.getRequestDispatcher("/pages/admin/products.jsp").forward(request, response);
    }

    private void showAddProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Category> categories = categoryDAO.getAllCategories();
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/pages/admin/add-product.jsp").forward(request, response);
    }

    private void showEditProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        Product product = productDAO.getProductById(productId);
        List<Category> categories = categoryDAO.getAllCategories();
        request.setAttribute("product", product);
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/pages/admin/add-product.jsp").forward(request, response);
    }

    private void showCategories(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Category> categories = categoryDAO.getAllCategories();
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/pages/admin/categories.jsp").forward(request, response);
    }

    private void showAddCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/pages/admin/category-form.jsp").forward(request, response);
    }

    private void showEditCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        Category category = categoryDAO.getCategoryById(categoryId);
        request.setAttribute("category", category);
        request.getRequestDispatcher("/pages/admin/category-form.jsp").forward(request, response);
    }

    private void showOrders(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Order> orders = orderDAO.getAllOrders();
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("/pages/admin/orders-list.jsp").forward(request, response);
    }

    private void showOrderDetail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        Order order = orderDAO.getOrderById(orderId);
        List<OrderDetail> items = orderDAO.getOrderDetails(orderId);
        request.setAttribute("order", order);
        request.setAttribute("orderItems", items);
        request.getRequestDispatcher("/pages/admin/order-detail.jsp").forward(request, response);
    }

    private void showUsers(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<User> users = userDAO.getAllUsers();
        request.setAttribute("users", users);
        request.getRequestDispatcher("/pages/admin/user-management.jsp").forward(request, response);
    }

    // ========== POST Methods ==========

    private void handleAddProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productName = request.getParameter("productName");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        String imageUrl = request.getParameter("imageUrl");

        if (productName == null || productName.isEmpty() || price < 0 || quantity < 0) {
            request.setAttribute("error", "Lütfen tüm gerekli alanları doğru şekilde doldurunuz");
            showAddProduct(request, response);
            return;
        }

        Product product = new Product();
        product.setProductName(productName);
        product.setDescription(description);
        product.setPrice(price);
        product.setQuantityInStock(quantity);
        product.setCategoryId(categoryId);
        product.setImageUrl(imageUrl);
        product.setActive(true);

        if (productDAO.addProduct(product)) {
            request.setAttribute("successMessage", "Ürün başarıyla eklendi");
            showProducts(request, response);
        } else {
            request.setAttribute("error", "Ürün eklenirken hata oluştu");
            showAddProduct(request, response);
        }
    }

    private void handleUpdateProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        String productName = request.getParameter("productName");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        String imageUrl = request.getParameter("imageUrl");
        boolean isActive = request.getParameter("isActive") != null;

        Product product = new Product();
        product.setProductId(productId);
        product.setProductName(productName);
        product.setDescription(description);
        product.setPrice(price);
        product.setQuantityInStock(quantity);
        product.setCategoryId(categoryId);
        product.setImageUrl(imageUrl);
        product.setActive(isActive);

        if (productDAO.updateProduct(product)) {
            request.setAttribute("successMessage", "Ürün başarıyla güncellendi");
            showProducts(request, response);
        } else {
            request.setAttribute("error", "Ürün güncellenirken hata oluştu");
            showProducts(request, response);
        }
    }

    private void handleDeleteProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("productId"));
        productDAO.deleteProduct(productId);
        response.sendRedirect(request.getContextPath() + "/admin?action=products");
    }

    private void handleAddCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String categoryName = request.getParameter("categoryName");
        String description = request.getParameter("description");

        if (categoryName == null || categoryName.isEmpty()) {
            request.setAttribute("error", "Kategori adı boş olamaz");
            showAddCategory(request, response);
            return;
        }

        Category category = new Category();
        category.setCategoryName(categoryName);
        category.setDescription(description);
        category.setActive(true);

        if (categoryDAO.addCategory(category)) {
            response.sendRedirect(request.getContextPath() + "/admin?action=categories");
        } else {
            request.setAttribute("error", "Kategori eklenirken hata oluştu");
            showAddCategory(request, response);
        }
    }

    private void handleUpdateCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        String categoryName = request.getParameter("categoryName");
        String description = request.getParameter("description");
        boolean isActive = request.getParameter("isActive") != null;

        Category category = new Category();
        category.setCategoryId(categoryId);
        category.setCategoryName(categoryName);
        category.setDescription(description);
        category.setActive(isActive);

        if (categoryDAO.updateCategory(category)) {
            response.sendRedirect(request.getContextPath() + "/admin?action=categories");
        }
    }

    private void handleDeleteCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        categoryDAO.deleteCategory(categoryId);
        response.sendRedirect(request.getContextPath() + "/admin?action=categories");
    }

    private void handleUpdateOrderStatus(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String status = request.getParameter("status");
        orderDAO.updateOrderStatus(orderId, status);
        response.sendRedirect(request.getContextPath() + "/admin?action=order-detail&orderId=" + orderId);
    }
}
