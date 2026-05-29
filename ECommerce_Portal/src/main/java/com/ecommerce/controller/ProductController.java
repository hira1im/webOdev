package com.ecommerce.controller;

import com.ecommerce.dao.CategoryDAO;
import com.ecommerce.dao.ProductDAO;
import com.ecommerce.model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/products")
public class ProductController extends HttpServlet {
    private ProductDAO productDAO = new ProductDAO();
    private CategoryDAO categoryDAO = new CategoryDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "view":
                viewProduct(request, response);
                break;
            case "category":
                viewByCategory(request, response);
                break;
            case "search":
                searchProducts(request, response);
                break;
            default:
                listProducts(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action) {
            case "add":
                addProduct(request, response);
                break;
            case "update":
                updateProduct(request, response);
                break;
            case "delete":
                deleteProduct(request, response);
                break;
            default:
                response.sendRedirect("products");
                break;
        }
    }

    private void listProducts(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Product> products = productDAO.getAllProducts();
        request.setAttribute("products", products);
        request.getRequestDispatcher("/pages/products.jsp").forward(request, response);
    }

    private void viewProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int productId = Integer.parseInt(request.getParameter("id"));
        Product product = productDAO.getProductById(productId);
        request.setAttribute("product", product);
        request.getRequestDispatcher("/pages/product-detail.jsp").forward(request, response);
    }

    private void viewByCategory(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int categoryId = Integer.parseInt(request.getParameter("id"));
        List<Product> products = productDAO.getProductsByCategory(categoryId);
        request.setAttribute("products", products);
        request.getRequestDispatcher("/pages/products.jsp").forward(request, response);
    }

    private void searchProducts(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        List<Product> products = productDAO.searchProducts(keyword);
        request.setAttribute("products", products);
        request.setAttribute("keyword", keyword);
        request.getRequestDispatcher("/pages/products.jsp").forward(request, response);
    }

    private void addProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Object userRole = request.getSession().getAttribute("userRole");
        if (userRole == null || !"ADMIN".equals(userRole)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        String productName = request.getParameter("productName");
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String imageUrl = request.getParameter("imageUrl");

        Product product = new Product(categoryId, productName, description, price, quantity);
        product.setImageUrl(imageUrl);

        if (productDAO.addProduct(product)) {
            response.sendRedirect("products");
        } else {
            request.setAttribute("error", "Failed to add product");
            request.getRequestDispatcher("/pages/admin/add-product.jsp").forward(request, response);
        }
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Object userRole = request.getSession().getAttribute("userRole");
        if (userRole == null || !"ADMIN".equals(userRole)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        int productId = Integer.parseInt(request.getParameter("productId"));
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        String productName = request.getParameter("productName");
        String description = request.getParameter("description");
        double price = Double.parseDouble(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String imageUrl = request.getParameter("imageUrl");

        Product product = new Product(categoryId, productName, description, price, quantity);
        product.setProductId(productId);
        product.setImageUrl(imageUrl);

        if (productDAO.updateProduct(product)) {
            response.sendRedirect("products?action=view&id=" + productId);
        } else {
            request.setAttribute("error", "Failed to update product");
            request.getRequestDispatcher("/pages/admin/edit-product.jsp").forward(request, response);
        }
    }

    private void deleteProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Object userRole = request.getSession().getAttribute("userRole");
        if (userRole == null || !"ADMIN".equals(userRole)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        int productId = Integer.parseInt(request.getParameter("id"));
        if (productDAO.deleteProduct(productId)) {
            response.sendRedirect("products");
        } else {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
