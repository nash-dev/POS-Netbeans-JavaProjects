<%-- 
    Document   : logout
    Created on : 20 Oct 2026, 08:32:20
    Author     : avina
--%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Logout Page</title>
    </head>
    <body>
        <h1>Logout Redirecting ...</h1>
    </body>
    
</html>


<%
    // Session Guard: Redirect anonymous access attempts back to the gateway
        session.invalidate();
        response.sendRedirect("login.jsp");
       
%>