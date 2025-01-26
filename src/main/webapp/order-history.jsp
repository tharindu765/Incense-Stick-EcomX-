<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order History</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            padding: 20px;
        }
        .order-container {
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
        .order-item {
            background: #f1f1f1;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 15px;
        }
        .order-item:hover {
            background-color: #e0e0e0;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="order-container">
        <h2 class="mb-4">Your Order History</h2>

        <!-- Back Button -->
        <a href="dashboardCustomer.jsp" class="btn btn-secondary mb-4">← Back to Dashboard</a>

        <!-- Order List -->
        <c:if test="${not empty orders}">
            <div class="list-group">
                <c:forEach var="order" items="${orders}">
                    <div class="order-item list-group-item">
                        <h5>Order #${order.id}</h5>
                        <p><strong>Order Date:</strong> ${order.order_date}</p>
                        <p><strong>Total Amount:</strong> $${order.total_amount}</p>
                        <p><strong>Status:</strong> ${order.status}</p>
                        <a href="order-details.jsp?orderId=${order.id}" class="btn btn-custom">View Details</a>
                    </div>
                </c:forEach>
            </div>
        </c:if>

        <c:if test="${empty orders}">
            <p>No orders found.</p>
        </c:if>
    </div>
</div>
</body>
</html>
