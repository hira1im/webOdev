package com.ecommerce.controller;

import com.ecommerce.dao.UserDAO;
import com.ecommerce.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/auth")
public class AuthController extends HttpServlet {
    private UserDAO userDAO = new UserDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "login";
        }
        
        switch (action) {
            case "login":
                showLoginPage(request, response);
                break;
            case "register":
                showRegisterPage(request, response);
                break;
            case "logout":
                logout(request, response);
                break;
            default:
                showLoginPage(request, response);
                break;
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "login";
        }
        
        switch (action) {
            case "login":
                loginUser(request, response);
                break;
            case "register":
                registerUser(request, response);
                break;
            default:
                response.sendRedirect("auth?action=login");
                break;
        }
    }
    
    private void showLoginPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/pages/login.jsp").forward(request, response);
    }
    
    private void showRegisterPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/pages/register.jsp").forward(request, response);
    }
    
    private void loginUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // Validate input
        if (username == null || username.trim().isEmpty() || 
            password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Kullanici adi ve sifre zorunludur");
            request.getRequestDispatcher("/pages/login.jsp").forward(request, response);
            return;
        }
        
        // Attempt login
        User user = userDAO.loginUser(username, password);
        
        if (user != null) {
            // Login successful - set session attributes
            HttpSession session = request.getSession();
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("user", user);
            session.setAttribute("username", user.getUsername());
            session.setAttribute("userRole", user.getRole());
            
            // Redirect based on role
            if ("ADMIN".equals(user.getRole())) {
                response.sendRedirect("admin?action=dashboard");
            } else {
                response.sendRedirect("index.jsp");
            }
        } else {
            // Login failed
            request.setAttribute("error", "Kullanici adi veya sifre hatali");
            request.getRequestDispatcher("/pages/login.jsp").forward(request, response);
        }
    }
    
    private void registerUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String email = request.getParameter("email");
        String fullName = request.getParameter("fullName");
        
        // Validate input
        if (username == null || username.trim().isEmpty()) {
            request.setAttribute("error", "Kullanici adi zorunludur");
            request.getRequestDispatcher("/pages/register.jsp").forward(request, response);
            return;
        }
        
        if (password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Sifre zorunludur");
            request.getRequestDispatcher("/pages/register.jsp").forward(request, response);
            return;
        }
        
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Sifreler eslesmiyor");
            request.getRequestDispatcher("/pages/register.jsp").forward(request, response);
            return;
        }
        
        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "E-posta zorunludur");
            request.getRequestDispatcher("/pages/register.jsp").forward(request, response);
            return;
        }
        
        if (fullName == null || fullName.trim().isEmpty()) {
            request.setAttribute("error", "Ad soyad zorunludur");
            request.getRequestDispatcher("/pages/register.jsp").forward(request, response);
            return;
        }
        
        // Create new user
        User newUser = new User(username, password, email, fullName);
        
        boolean registrationSuccess = userDAO.registerUser(newUser);
        
        if (registrationSuccess) {
            // Registration successful - set message and redirect to login
            request.setAttribute("message", "Kayit basarili. Lutfen giris yapin.");
            request.getRequestDispatcher("/pages/login.jsp").forward(request, response);
        } else {
            // Registration failed (possibly duplicate username)
            request.setAttribute("error", "Kayit basarisiz. Kullanici adi kullaniliyor olabilir.");
            request.getRequestDispatcher("/pages/register.jsp").forward(request, response);
        }
    }
    
    private void logout(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Invalidate session
        HttpSession session = request.getSession();
        session.invalidate();
        
        // Redirect to login page
        response.sendRedirect("auth?action=login");
    }
}
