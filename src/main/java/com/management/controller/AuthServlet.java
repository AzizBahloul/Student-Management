package com.management.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

// Removed @WebServlet annotation
public class AuthServlet extends HttpServlet {
    private static final String USERNAME = "teacher";  // hardcoded username for simplicity
    private static final String PASSWORD = "password"; // hardcoded password for simplicity

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (USERNAME.equals(username) && PASSWORD.equals(password)) {
            // Login successful, create session
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            response.sendRedirect("studentList.jsp"); // Redirect to main page
        } else {
            // Login failed, send error message back to login page
            request.setAttribute("errorMessage", "Invalid username or password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("logout".equals(action)) {
            HttpSession session = request.getSession(false); // Fetch existing session
            if (session != null) {
                session.invalidate(); // Invalidate session to log out
            }
            response.sendRedirect("login.jsp"); // Redirect to login page
        } else {
            response.sendRedirect("login.jsp"); // Default redirection to login page
        }
    }
}
