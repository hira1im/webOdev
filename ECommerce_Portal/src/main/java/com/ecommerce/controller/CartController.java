package com.ecommerce.controller;

import com.ecommerce.dao.CartDAO;
import com.ecommerce.dao.ProductDAO;
import com.ecommerce.model.Cart;
import com.ecommerce.model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/cart")
public class CartController extends HttpServlet {
    private CartDAO cartDAO = new CartDAO();
    private ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "view";
        }

        switch (action) {
            case "view":
                viewCart(request, response);
                break;
            case "clear":
                clearCart(request, response);
                break;
            default:
                response.sendRedirect("products");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action) {
            case "add":
                addToCart(request, response);
                break;
            case "remove":
                removeFromCart(request, response);
                break;
            case "update":
                updateCart(request, response);
                break;
            default:
                response.sendRedirect("cart");
                break;
        }
    }

    private void addToCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("auth?action=login");
            return;
        }

        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity") != null ? request.getParameter("quantity") : "1");

        Product product = productDAO.getProductById(productId);
        if (product == null || quantity > product.getQuantityInStock()) {
            request.setAttribute("error", "Invalid quantity or product not available");
            response.sendRedirect("products?action=view&id=" + productId);
            return;
        }

        Cart cart = new Cart(userId, productId, quantity);
        if (cartDAO.addToCart(cart)) {
            response.sendRedirect("cart");
        } else {
            request.setAttribute("error", "Failed to add to cart");
            response.sendRedirect("products?action=view&id=" + productId);
        }
    }

    private void viewCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("auth?action=login");
            return;
        }

        List<Cart> cartItems = cartDAO.getCartByUserId(userId);
        request.setAttribute("cartItems", cartItems);
        request.getRequestDispatcher("/pages/cart.jsp").forward(request, response);
    }

    private void removeFromCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int cartId = Integer.parseInt(request.getParameter("cartId"));
        cartDAO.removeFromCart(cartId);
        response.sendRedirect("cart");
    }

    private void updateCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int cartId = Integer.parseInt(request.getParameter("cartId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        if (quantity > 0) {
            cartDAO.updateCartQuantity(cartId, quantity);
        } else {
            cartDAO.removeFromCart(cartId);
        }
        response.sendRedirect("cart");
    }

    private void clearCart(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId != null) {
            cartDAO.clearUserCart(userId);
        }
        response.sendRedirect("products");
    }
}
