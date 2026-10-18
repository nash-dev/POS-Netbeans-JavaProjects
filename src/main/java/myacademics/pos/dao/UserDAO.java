/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package myacademics.pos.dao;
import myacademics.pos.model.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {

    private static final String SELECT_USER_BY_USERNAME = 
        "SELECT id, username, password_hash, email FROM users WHERE username = ?";

    public User getUserByUsername(String username) {
        User user = null;
        
        // Try-with-resources auto-closes Connection, PreparedStatement, and ResultSet
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_USER_BY_USERNAME)) {
            
            stmt.setString(1, username);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    user = new User();
                    user.setId(rs.getInt("id"));
                    user.setUsername(rs.getString("username"));
                    user.setPassword(rs.getString("password_hash"));
                   
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Replace with a proper logger in production
        }
        
        return user;
    }

    public boolean validateUser(String username, String plainPassword) {
        User user = getUserByUsername(username);
        if (user != null) {
            // Note: In production, compare plainPassword against hashed password (e.g., BCrypt.checkpw)
            return user.getpassword().equals(plainPassword);
        }
        return false;
    }
}