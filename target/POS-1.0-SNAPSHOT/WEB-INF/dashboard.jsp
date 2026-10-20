<%-- any content can be specified here e.g.: --%>

<%
    // Session Guard: Redirect anonymous access attempts back to the gateway
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>POS Dashboard</title>
</head>
<body>
    <h1>Welcome to the Point of Sale Terminal, <%= session.getAttribute("user") %>!</h1>
    <p>Role Authorized: <%= session.getAttribute("role") %></p>
    <hr>
    <!-- POS business operations elements go here -->
    <a href="logout.jsp">Close Register & Sign Out</a>
    
    <button id="btnLogout" name="Logout">Logout</button>
</body>
</html>
