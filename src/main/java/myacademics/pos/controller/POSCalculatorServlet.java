package org.servlets.pos;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

// Maps the endpoint to the front-end fetch API URL target
@WebServlet("/pos-calculator")
public class POSCalculatorServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // Read JSON payload sent from UI script
            StringBuilder sb = new StringBuilder();
            BufferedReader reader = request.getReader();
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
            
            String jsonInput = sb.toString();
            
            // Basic extraction (Assuming syntax pattern: {"price":XX,"quantity":XX})
            double price = Double.parseDouble(jsonInput.replaceAll(".*\"price\":\\s*([^,}\\s]+).*", "$1"));
            int quantity = Integer.parseInt(jsonInput.replaceAll(".*\"quantity\":\\s*([^,}\\s]+).*", "$1"));

            // Perform POS Business Logic Calculations
            double subtotal = price * quantity;
            double taxRate = 0.15; // 15% flat retail tax
            double tax = subtotal * taxRate;
            double total = subtotal + tax;

            // Generate clean JSON response format back to frontend script
            String jsonResponse = String.format(
                "{\"success\": true, \"subtotal\": \"%.2f\", \"tax\": \"%.2f\", \"total\": \"%.2f\"}",
                subtotal, tax, total
            );
            
            out.print(jsonResponse);
            
        } catch (Exception e) {
            out.print("{\"success\": false, \"message\": \"Invalid calculation criteria inputs.\"}");
        } finally {
            out.flush();
        }
    }
}
