<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>POS System Calculator</title>
    <style>
        body { font-family: Arial, sans-serif; display: flex; gap: 20px; padding: 20px; }
        .calculator { border: 1px solid #ccc; padding: 15px; border-radius: 8px; width: 250px; }
        .display { width: 100%; height: 40px; text-align: right; margin-bottom: 10px; font-size: 1.2rem; }
        .keys { display: grid; grid-template-columns: repeat(4, 1fr); gap: 5px; }
        button { padding: 15px; font-size: 1rem; cursor: pointer; }
        .cart { border: 1px solid #ccc; padding: 15px; width: 300px; border-radius: 8px; }
    </style>
</head>
<body>

    <!-- POS Calculator UI -->
    <div class="calculator">
        <h3>POS Keypad</h3>
        <input type="text" id="calc-display" class="display" value="0" readonly />
        <div class="keys">
            <button onclick="appendNum('7')">7</button><button onclick="appendNum('8')">8</button><button onclick="appendNum('9')">9</button><button onclick="clearDisplay()">C</button>
            <button onclick="appendNum('4')">4</button><button onclick="appendNum('5')">5</button><button onclick="appendNum('6')">6</button><button onclick="setMode('price')">Price</button>
            <button onclick="appendNum('1')">1</button><button onclick="appendNum('2')">2</button><button onclick="appendNum('3')">3</button><button onclick="setMode('qty')">Qty</button>
            <button onclick="appendNum('0')">0</button><button onclick="appendNum('.')">.</button><button onclick="addToCart()" style="grid-column: span 2; background-color: #28a745; color: white;">Add Item</button>
        </div>
    </div>

    <!-- Checkout Cart UI -->
    <div class="cart">
        <h3>Current Order</h3>
        <div id="cart-details">No items added yet.</div>
        <hr>
        <button id="checkout-btn" onclick="processCheckout()" style="width: 100%; padding: 10px; background-color: #007bff; color: white;">Process Payment</button>
        <h4 id="receipt-display" style="margin-top: 15px; color: green;"></h4>
    </div>

    <script>
        let currentInput = "";
        let currentPrice = 0.00;
        let currentQty = 1;

        function appendNum(num) {
            currentInput += num;
            document.getElementById('calc-display').value = currentInput;
        }

        function clearDisplay() {
            currentInput = "";
            document.getElementById('calc-display').value = "0";
        }

        function setMode(mode) {
            if(mode === 'price') {
                currentPrice = parseFloat(currentInput) || 0.00;
                alert("Base Price set to: \$" + currentPrice.toFixed(2));
            } else if(mode === 'qty') {
                currentQty = parseInt(currentInput) || 1;
                alert("Quantity set to: " + currentQty);
            }
            clearDisplay();
        }

        function addToCart() {
            if(currentPrice === 0) {
                currentPrice = parseFloat(currentInput) || 0.00;
            }
            if (currentPrice > 0) {
                document.getElementById('cart-details').innerHTML = `Item: $${currentPrice.toFixed(2)} x ${currentQty}`;
                clearDisplay();
            } else {
                alert("Please enter a valid price first.");
            }
        }

        // Send cart data to Tomcat backend Servlet using AJAX
        function processCheckout() {
            if(currentPrice <= 0) return alert("Cart is empty!");

            const payload = {
                price: currentPrice,
                quantity: currentQty
            };

            fetch('pos-calculator', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(payload)
            })
            .then(response => response.json())
            .then(data => {
                if(data.success) {
                    document.getElementById('receipt-display').innerHTML = 
                        `Success!<br>Subtotal: $${data.subtotal}<br>Tax (15%): $${data.tax}<br>Total Due: $${data.total}`;
                } else {
                    document.getElementById('receipt-display').innerHTML = "Error: " + data.message;
                }
            })
            .catch(err => console.error('Error handling checkout:', err));
        }
    </script>
</body>
</html>
