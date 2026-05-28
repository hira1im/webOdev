package com.ecommerce.dao;

import com.ecommerce.model.OrderDetail;
import com.ecommerce.util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDetailDAO {

    public boolean addOrderDetail(OrderDetail orderDetail) {
        String sql = "INSERT INTO order_details (order_id, product_id, quantity, unit_price, subtotal) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderDetail.getOrderId());
            ps.setInt(2, orderDetail.getProductId());
            ps.setInt(3, orderDetail.getQuantity());
            ps.setDouble(4, orderDetail.getUnitPrice());
            ps.setDouble(5, orderDetail.getSubtotal());

            int result = ps.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<OrderDetail> getOrderDetailsByOrderId(int orderId) {
        List<OrderDetail> orderDetails = new ArrayList<>();
        String sql = "SELECT * FROM order_details WHERE order_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                orderDetails.add(mapResultSetToOrderDetail(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderDetails;
    }

    public OrderDetail getOrderDetailById(int orderDetailId) {
        String sql = "SELECT * FROM order_details WHERE order_detail_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderDetailId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return mapResultSetToOrderDetail(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateOrderDetail(OrderDetail orderDetail) {
        String sql = "UPDATE order_details SET quantity = ?, unit_price = ?, subtotal = ? WHERE order_detail_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderDetail.getQuantity());
            ps.setDouble(2, orderDetail.getUnitPrice());
            ps.setDouble(3, orderDetail.getSubtotal());
            ps.setInt(4, orderDetail.getOrderDetailId());

            int result = ps.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteOrderDetail(int orderDetailId) {
        String sql = "DELETE FROM order_details WHERE order_detail_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderDetailId);
            int result = ps.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private OrderDetail mapResultSetToOrderDetail(ResultSet rs) throws SQLException {
        OrderDetail orderDetail = new OrderDetail();
        orderDetail.setOrderDetailId(rs.getInt("order_detail_id"));
        orderDetail.setOrderId(rs.getInt("order_id"));
        orderDetail.setProductId(rs.getInt("product_id"));
        orderDetail.setQuantity(rs.getInt("quantity"));
        orderDetail.setUnitPrice(rs.getDouble("unit_price"));
        orderDetail.setSubtotal(rs.getDouble("subtotal"));
        return orderDetail;
    }
}
