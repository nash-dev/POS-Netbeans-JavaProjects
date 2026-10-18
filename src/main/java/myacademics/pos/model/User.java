/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package myacademics.pos.model;

/**
 *
 * @author avina
 */
public class User {
    private int id;
    private String username;
    private String passwordHash;
   
    public User(){}
    
    public User(int id, String username, String passwordHash)
    {
        this.id = id;
        this.username = username;
        this.passwordHash = passwordHash;
    }
    public int getId(){return id;}
    public void setId(int id){this.id = id;}
    public String getUsername(){return username;}
    public void setUsername(String username){this.username = username;}
    public String getpassword(){return passwordHash;}
    public void setPassword(String passwordHash){this.passwordHash = passwordHash;}
  
            
    
     
}
