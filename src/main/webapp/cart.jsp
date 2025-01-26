<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.example.ecomx.DTO.CartDTO" %>
<%@ page import="org.example.ecomx.DTO.ProductDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.DecimalFormat" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Cart</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            padding: 20px;
        }
        .cart-container {
            background: #ffffff;
            border-radius: 8px;
            padding: 30px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .btn-custom {
            background-color: #2c3e50;
            color: white;
            border: none;
        }
        .btn-custom:hover {
            background-color: #34495e;
        }
        .cart-item {
            background: #f1f1f1;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 15px;
        }
        .cart-item:hover {
            background-color: #e0e0e0;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="cart-container">
        <h2 class="mb-4">Your Cart</h2>

        <!-- Back Button -->
        <a href="shop.jsp" class="btn btn-secondary mb-4">← Continue Shopping</a>

        <!-- Cart Items -->
        <%
            DecimalFormat df = new DecimalFormat("#.00");
            List<CartDTO> cartItems = (List<CartDTO>) request.getAttribute("cartItems");
            double totalPrice = 0;

            if (cartItems != null && !cartItems.isEmpty()) {
        %>
        <div class="list-group">
            <%
                for (CartDTO item : cartItems) {
                    ProductDTO product = (ProductDTO) request.getAttribute("product_" + item.getProductId());
                    double itemTotalPrice = product.getPrice() * item.getQuantity();
                    totalPrice += itemTotalPrice;
            %>
            <div class="cart-item list-group-item">
                <h5><%= product.getName() %></h5>
                <p><strong>Price:</strong> $<%= df.format(product.getPrice()) %></p>
                <p><strong>Quantity:</strong> <%= item.getQuantity() %></p>
                <p><strong>Total Price:</strong> $<%= df.format(itemTotalPrice) %></p>
                <a href="update-cart.jsp?cartId=<%= item.getId() %>" class="btn btn-custom">Update Quantity</a>
                <a href="remove-from-cart.jsp?cartId=<%= item.getId() %>" class="btn btn-danger">Remove</a>
            </div>
            <%
                }
            %>
        </div>
        <!-- Cart Total -->
        <div class="mt-4">
            <h4>Total Price: $<%= df.format(totalPrice) %></h4>
            <a href="checkout.jsp" class="btn btn-success w-100">Proceed to Checkout</a>
        </div>
        <%
        } else {
        %>
        <p>Your cart is empty. Start shopping now!</p>
        <a href="shop.jsp" class="btn btn-primary">Go to Shop</a>
        <%
            }
        %>
    </div>
</div>
</body>
</html>
