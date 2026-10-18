/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package myacademics.pos.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author avina
 */

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet{

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password"); // In production, evaluate hashed passwords
        
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        // Database credentials setup
        String dbURL = "jdbc:postgresql://localhost:5432/pos";
        String dbUser = "postgres";
        String dbPass = "Password01";
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPass);
            
            // Querying matching record
            String query = "SELECT * FROM users WHERE username=? AND passwordHash=?";
            ps = conn.prepareStatement(query);
            ps.setString(1, username);
            ps.setString(2, password);
            
            rs = ps.executeQuery();
            
            if (rs.next()) {
                // Authentication Successful
                HttpSession session = request.getSession();
                session.setAttribute("user", username);
                session.setAttribute("role", rs.getString("role")); // e.g., 'Cashier' or 'Manager'
                
                // Redirect user to the main interactive POS dashboard
                response.sendRedirect("dashboard.jsp");
            } else {
                // Authentication Failed
                request.setAttribute("errorMessage", "Invalid Username or Terminal PIN.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database Connection Error.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } finally {
            // Memory and resource cleanup
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
}
    

