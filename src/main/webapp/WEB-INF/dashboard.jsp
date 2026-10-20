<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%-- any content can be specified here e.g.: --%>
<%
    // Session Guard: Redirect anonymous access attempts back to the gateway
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <script src="POS\src\main\webapp\WEB-INF\javascript\CalcScripts.js"></script>    
    <title>POS Dashboard</title>
</head>
<body>
    <h1>Welcome to the Point of Sale Terminal, <%= session.getAttribute("user") %>!</h1>
    <p>Role Authorized: <%= session.getAttribute("role") %></p>
    <iframe>
    <input type="text" id="calc-display" class="display" value="0" readonly />

    <button onclick="appendNum('1')"type="submit" class="calculator" id="btnOne" name="1">1</button>
    <button onclick="appendNum('2')"type="submit" class="calculator" id="btnTwo" name="2">2</button>
    <button onclick="appendNum('3')"type="submit" class="calculator" id="btnThree" name="3">3</button>
    <button onclick="appendNum('4')"type="submit" class="calculator" id="btnFour" name="4">4</button>         
    <button onclick="appendNum('5')"type="submit" class="calculator" id="btnFive" name="5">5</button>
    <button onclick="appendNum('6')"type="submit" class="calculator" id="btnSix" name="6">6</button>
    <button onclick="appendNum('7')"type="submit" class="calculator" id="btnSeven" name="7">7</button>
    <button onclick="appendNum('8')"type="submit" class="calculator" id="btnEight" name="8">8</button>
    <button onclick="appendNum('9')"type="submit" class="calculator" id="btnNine" name="9">9</button>
    <button onclick="appendNum('0')"type="submit" class="calculator" id="btnZero" name="0">0</button>
    <button onclick="appendNum('.')"type="submit" class="calculator" id="btnDot" name=".">,</button>
    <button onclick="addToCart()" style="grid-column: span 2; background-color: #28a745; color: white;">Add Item</button>
    <button type="submit" class="calculator" id="btnEquals" name="Equals">Equals</button>
    <button type="submit" class="calculator" id="btnSum" name="Sum">Sum</button>
    <button type="submit" class="calculator" id="btnMulitply" name="Multiply">Multiply</button>
    <button type="submit" class="calculator" id="btnUnits" name="Units">Unit</button>
    <button type="submit" class="calculator" id="btnErrorCorrect" name="ErrorCorrect">Error Correct</button>
    <button type="submit" class="calculator" id="btnClear" name="Clear">Clear</button>
    <button type="submit" class="calculator" id="btnTotal" name="Total">Total</button>
    
    <button type="submit" class="items" id="btnPLU" name="PLU">PLU</button>
    <button type="submit" class="items" id="btnBurger1" name="Burger1">Burger1</button>
    <button type="submit" class="items" id="btnBurger2" name="Burger2">Burger2</button>
    <button type="submit" class="items" id="btnBurger3" name="Burger3">Burger3</button>
    <button type="submit" class="items" id="btnBurger4" name="Burger4">Burger4</button>
        
    </iframe>
    <hr>
    <!-- POS business operations elements go here -->
    <a href="logout.jsp">Close Register & Sign Out</a>
    
    <button id="btnLogout" name="Logout">Logout</button>
</body>
</html>
