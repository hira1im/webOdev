package com.ecommerce.controller;

import com.ecommerce.dao.*;
import com.ecommerce.model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/orders")
public class OrderController extends HttpServlet {
    private OrderDAO orderDAO = new OrderDAO();
    private OrderDetailDAO orderDetailDAO = new OrderDetailDAO();
    private CartDAO cartDAO = new CartDAO();
    private ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "view":
                viewOrder(request, response);
                break;
            case "admin-list":
                adminListOrders(request, response);
                break;
            default:
                listUserOrders(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action) {
            case "checkout":
                checkout(request, response);
                break;
            case "updateStatus":
                updateOrderStatus(request, response);
                break;
            default:
                response.sendRedirect("orders");
                break;
        }
    }

    private void listUserOrders(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("auth?action=login");
            return;
        }

        List<Order> orders = orderDAO.getOrdersByUserId(userId);
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("/pages/orders.jsp").forward(request, response);
    }

    private void viewOrder(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("id"));
        Order order = orderDAO.getOrderById(orderId);
        List<OrderDetail> orderDetails = orderDetailDAO.getOrderDetailsByOrderId(orderId);

        request.setAttribute("order", order);
        request.setAttribute("orderDetails", orderDetails);
        request.getRequestDispatcher("/pages/order-detail.jsp").forward(request, response);
    }

    private void adminListOrders(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Object userRole = request.getSession().getAttribute("userRole");
        if (userRole == null || !"ADMIN".equals(userRole)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        List<Order> orders = orderDAO.getAllOrders();
        request.setAttribute("orders", orders);
        request.getRequestDispatcher("/pages/admin/orders-list.jsp").forward(request, response);
    }

    private void checkout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("auth?action=login");
            return;
        }

        String shippingAddress = request.getParameter("shippingAddress");

        if (shippingAddress == null || shippingAddress.trim().isEmpty()) {
            request.setAttribute("error", "Shipping address is required");
            request.getRequestDispatcher("/pages/checkout.jsp").forward(request, response);
            return;
        }

        List<Cart> cartItems = cartDAO.getCartByUserId(userId);

        if (cartItems.isEmpty()) {
            request.setAttribute("error", "Cart is empty");
            response.sendRedirect("cart");
            return;
        }

        double totalAmount = 0;
        for (Cart item : cartItems) {
            Product product = productDAO.getProductById(item.getProductId());
            if (product != null) {
                totalAmount += product.getPrice() * item.getQuantity();
            }
        }

        Order order = new Order(userId, totalAmount, shippingAddress);
        int orderId = orderDAO.addOrder(order);

        if (orderId > 0) {
            for (Cart item : cartItems) {
                Product product = productDAO.getProductById(item.getProductId());
                if (product != null) {
                    OrderDetail detail = new OrderDetail(orderId, item.getProductId(), item.getQuantity(), product.getPrice());
                    orderDetailDAO.addOrderDetail(detail);

                    product.setQuantityInStock(product.getQuantityInStock() - item.getQuantity());
                    productDAO.updateProduct(product);
                }
            }

            cartDAO.clearUserCart(userId);
            response.sendRedirect("orders?action=view&id=" + orderId);
        } else {
            request.setAttribute("error", "Checkout failed");
            request.getRequestDispatcher("/pages/checkout.jsp").forward(request, response);
        }
    }

    private void updateOrderStatus(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Object userRole = request.getSession().getAttribute("userRole");
        if (userRole == null || !"ADMIN".equals(userRole)) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String status = request.getParameter("status");

        if (orderDAO.updateOrderStatus(orderId, status)) {
            response.sendRedirect("orders?action=view&id=" + orderId);
        } else {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
