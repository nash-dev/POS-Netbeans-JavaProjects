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
        "SELECT id, username, password_hash, email FROM User WHERE username = ?";
    private static final String CREATE_USER_BY_USERNAME = 
            "INSERT INTO id, username, password_hash FROM User";
    private static final String UPDATE_USER = 
            "UPDATE User SET username, passowrd_hash FROM User";
    private static final String DELETE_USER = 
            "DELETE FROM users where id=?";
    
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
    public boolean validateUser(String username, String plainPassword) 
    {
        User user = getUserByUsername(username);
        if (user != null) {
            // Note: In production, compare plainPassword against hashed password (e.g., BCrypt.checkpw)
            return user.getpassword().equals(plainPassword);
        }
        return false;
    }
    public boolean deleteUser(int id)
    {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(DELETE_USER))       
        {
            stmt.setInt(1, id);
            return stmt.executeUpdate()>0;
        }
             catch (SQLException e) {
        e.printStackTrace(); 
        }
        return false;
    }

    public void createUser(User user) throws SQLException
    {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(CREATE_USER_BY_USERNAME))       
        {
            try(ResultSet rs = stmt.executeQuery()){
                if(rs.next())
                {
                    stmt.setString(1,user.getUsername());
                    stmt.setString(2,user.getpassword());
                }
        }
            catch (SQLException e) {
            e.printStackTrace(); // Replace with a proper logger in production                
        }
        }
    }
    public void updateUser(User user,int id, String username, String passwordHash) throws SQLException 
    {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(UPDATE_USER))       
        {
            try(ResultSet rs = stmt.executeQuery()){
                if(rs.next())
                {
                    stmt.setInt(1, id);
                    stmt.setString(2, username);
                    stmt.setString(3, passwordHash);
                }
            }
            catch (SQLException e) {
            e.printStackTrace(); // Replace with a proper logger in production            
        }  
        }
    }
}