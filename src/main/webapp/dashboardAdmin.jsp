<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Incense Stick Ecom</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .sidebar {
            background-color: #2c3e50;
            color: white;
            height: 100vh;
            padding-top: 30px;
            position: fixed;
            width: 250px;
        }
        .sidebar a {
            color: white;
            text-decoration: none;
            padding: 15px;
            display: block;
        }
        .sidebar a:hover {
            background-color: #34495e;
            border-radius: 5px;
        }
        .main-content {
            margin-left: 270px; /* Adjusted to provide space for the sidebar */
            padding: 30px;
        }
        .dashboard-header {
            background-color: #f1f1f1;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        .card {
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
            height: 100%;
        }
        .card-body {
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }
        .section-header {
            margin-bottom: 30px;
        }
        .btn-custom {
            background-color: #2c3e50;
            color: white;
            border: none;
        }
        .btn-custom:hover {
            background-color: #34495e;
        }
        .card-text {
            flex-grow: 1; /* Ensures the text doesn't squash the buttons */
        }
        .right-sidebar {
            position: fixed;
            right: 0;
            top: 80px; /* Adjusted to not overlap with header */
            width: 300px;
            padding: 20px;
            box-shadow: -2px 0 5px rgba(0, 0, 0, 0.1);
        }
        .right-sidebar .card {
            height: 100%;
            margin-bottom: 20px;
        }
        .recent-orders {
            font-size: 1.2rem;
        }
        .recent-orders ul {
            list-style-type: none;
            padding: 0;
        }
        .recent-orders li {
            background-color: #eaf4fc;
            padding: 15px;
            margin-bottom: 15px;
            border-radius: 5px;
        }
    </style>
</head>
<body>

<!-- Sidebar -->
<div class="sidebar">
    <h3 class="text-center text-white">Admin Dashboard</h3>
    <ul class="nav flex-column">
        <li class="nav-item">
            <a href="dashboardAdmin.jsp" class="nav-link">Dashboard</a>
        </li>
        <li class="nav-item">
            <a href="manage-products.jsp" class="nav-link">Manage Products</a>
        </li>
        <li class="nav-item">
            <a href="manage-categories.jsp" class="nav-link">Manage Categories</a>
        </li>
        <li class="nav-item">
            <a href="manage-users.jsp" class="nav-link">Manage Users</a>
        </li>
        <li class="nav-item">
            <a href="index.jsp" class="nav-link">Logout</a>
        </li>
    </ul>
</div>

<!-- Main Content -->
<div class="main-content">
    <!-- Dashboard Header -->
    <div class="dashboard-header mb-4">
        <h1>Welcome Back, Admin!</h1>
        <p>Here's an overview of your store. Manage products, categories, and users from here.</p>
    </div>

    <!-- Manage Products Section -->
    <div class="section-header">
        <h2>Manage Products</h2>
        <div class="row">
            <div class="col-md-4">
                <div class="card p-3 d-flex">
                    <h4 class="text-center">Add New Product</h4>
                    <p class="text-center card-text">Add new incense products to your store.</p>
                    <div class="text-center">
                        <a href="add-product.jsp" class="btn btn-custom w-100">Add Product</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card p-3 d-flex">
                    <h4 class="text-center">View All Products</h4>
                    <p class="text-center card-text">See and manage all your products.</p>
                    <div class="text-center">
                        <a href="view-products.jsp" class="btn btn-custom w-100">View Products</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Manage Categories Section -->
    <div class="section-header">
        <h2>Manage Categories</h2>
        <div class="row">
            <div class="col-md-4">
                <div class="card p-3 d-flex">
                    <h4 class="text-center">Add New Category</h4>
                    <p class="text-center card-text">Add new categories for your incense products.</p>
                    <div class="text-center">
                        <a href="add-category.jsp" class="btn btn-custom w-100">Add Category</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card p-3 d-flex">
                    <h4 class="text-center">View Categories</h4>
                    <p class="text-center card-text">Browse and manage your categories.</p>
                    <div class="text-center">
                        <a href="view-categories.jsp" class="btn btn-custom w-100">View Categories</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Recent Orders Section -->
    <div class="section-header mb-5">
        <h2>Recent Orders</h2>
        <div class="recent-orders">
            <ul>
                <li>
                    <strong>Order #2451</strong><br>
                    <span>Status: Pending</span><br>
                    <span>Amount: $99.99</span>
                </li>
                <li>
                    <strong>Order #2450</strong><br>
                    <span>Status: Completed</span><br>
                    <span>Amount: $35.75</span>
                </li>
                <li>
                    <strong>Order #2449</strong><br>
                    <span>Status: Shipped</span><br>
                    <span>Amount: $52.30</span>
                </li>
            </ul>
        </div>
    </div>

</div>

<!-- Right Sidebar -->
<div class="right-sidebar">
    <div class="card">
        <div class="card-body">
            <h5 class="card-title">Quick Stats</h5>
            <ul class="list-unstyled">
                <li><strong>Products:</strong> 120</li>
                <li><strong>Categories:</strong> 5</li>
                <li><strong>Users:</strong> 350</li>
            </ul>
        </div>
    </div>

</div>

</body>
</html>
