<%-- 
    Document   : login
    Created on : 17 Oct 2026, 07:14:57
    Author     : avina
--%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>POS System - Terminal Login</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f6f9;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .login-container {
            background-color: #ffffff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            width: 350px;
        }
        .login-header {
            text-align: center;
            margin-bottom: 25px;
        }
        .login-header h2 {
            margin: 0;
            color: #2c3e50;
        }
        .login-header p {
            color: #7f8c8d;
            font-size: 14px;
            margin: 5px 0 0 0;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #34495e;
            font-weight: 600;
            font-size: 14px;
        }
        .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 16px;
        }
        .form-group input:focus {
            border-color: #3498db;
            outline: none;
        }
        .btn-submit {
            width: 100%;
            padding: 12px;
            background-color: #2ecc71;
            border: none;
            border-radius: 4px;
            color: white;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.2s;
        }
        .btn-submit:hover {
            background-color: #27ae60;
        }
        .error-message {
            color: #e74c3c;
            background-color: #fde8e7;
            padding: 10px;
            border-radius: 4px;
            margin-bottom: 15px;
            font-size: 14px;
            text-align: center;
        }
    </style>
</head>
<body>

<div class="login-container">
    <div class="login-header">
        <h2>POS Terminal</h2>
        <p>Please log in to open your shift</p>
    </div>

    <!-- Error Handling Section -->
    <% 
        String errorMsg = (String) request.getAttribute("errorMessage");
        if (errorMsg != null) { 
    %>
        <div class="error-message">
            <%= errorMsg %>
        </div>
    <% 
        } 
    %>

    <form action="LoginServlet" method="POST">
        <div class="form-group">
            <label for="username">Username / Cashier ID</label>
            <input type="text" id="username" name="username" required autocomplete="off">
        </div>
        
        <div class="form-group">
            <label for="password">Security PIN / Password</label>
            <input type="password" id="password" name="password" required>
        </div>
        
        <button type="submit" class="btn-submit">Authorize & Open Terminal</button>
    </form>
    
</div>

</body>
</html>
