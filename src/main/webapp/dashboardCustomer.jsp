<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Customer Dashboard - Incense Stick Ecom</title>
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

    /* Right Sidebar Styles */
    .right-sidebar {
      position: fixed;
      right: -300px; /* Initially hidden */
      top: 80px; /* Adjusted to not overlap with header */
      width: 300px;
      padding: 20px;
      box-shadow: -2px 0 5px rgba(0, 0, 0, 0.1);
      transition: right 0.3s ease; /* Smooth transition */
    }
    .right-sidebar.show {
      right: 0; /* Show when the class 'show' is added */
    }
    .right-sidebar .card {
      height: 100%;
      margin-bottom: 20px;
    }

    /* Arrow Button to Toggle Sidebar */
    .toggle-sidebar-btn {
      position: fixed;
      top: 100px;
      right: 10px;
      background-color: #2c3e50;
      color: white;
      border: none;
      padding: 10px 15px;
      border-radius: 50%;
      cursor: pointer;
    }
    .toggle-sidebar-btn:hover {
      background-color: #34495e;
    }
  </style>
</head>
<body>

<!-- Sidebar -->
<div class="sidebar">
  <h3 class="text-center text-white">Customer Dashboard</h3>
  <ul class="nav flex-column">
    <li class="nav-item">
      <a href="dashboardCustomer.jsp" class="nav-link">Dashboard</a>
    </li>
    <li class="nav-item">
      <a href="order-history.jsp" class="nav-link">Order History</a>
    </li>
    <li class="nav-item">
      <a href="profile-settings.jsp" class="nav-link">Profile Settings</a>
    </li>
    <li class="nav-item">
      <a href="cart.jsp" class="nav-link">Cart</a> <!-- Added Cart link -->
    </li>
    <li class="nav-item">
      <a href="shop" class="nav-link">shop</a>
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
    <h1>Welcome Back, [Customer Name]!</h1>
    <p>We're so happy to have you back. Explore your orders, update your profile, and keep track of your favorite incense products.</p>
  </div>

  <!-- Order History Section -->
  <div class="section-header">
    <h2>Your Order History</h2>
    <div class="row">
      <div class="col-md-6">
        <div class="card p-3">
          <h4>Order #2451</h4>
          <p>Status: Shipped</p>
          <p>Date: January 10, 2025</p>
          <a href="order-details.jsp?orderId=2451" class="btn btn-custom w-100">View Details</a>
        </div>
      </div>
      <div class="col-md-6">
        <div class="card p-3">
          <h4>Order #2450</h4>
          <p>Status: Completed</p>
          <p>Date: January 5, 2025</p>
          <a href="order-details.jsp?orderId=2450" class="btn btn-custom w-100">View Details</a>
        </div>
      </div>
      <div class="col-md-6">
        <div class="card p-3">
          <h4>Order #2449</h4>
          <p>Status: Pending</p>
          <p>Date: December 28, 2024</p>
          <a href="order-details.jsp?orderId=2449" class="btn btn-custom w-100">View Details</a>
        </div>
      </div>
    </div>
  </div>

  <!-- Profile Section -->
  <div class="section-header">
    <h2>Your Profile</h2>
    <div class="row">
      <div class="col-md-12">
        <div class="card p-3">
          <h4>[Customer Name]</h4>
          <p>Email: customer@example.com</p>
          <p>Phone: +1 (123) 456-7890</p>
          <a href="profile-settings.jsp" class="btn btn-custom w-100">Edit Profile</a>
        </div>
      </div>
    </div>
  </div>

</div>

<!-- Right Sidebar -->
<div class="right-sidebar">
  <div class="card">
    <div class="card-body">
      <h5 class="card-title">Quick Links</h5>
      <ul class="list-unstyled">
        <li><a href="shop" class="text-decoration-none">Browse Products</a></li>
        <li><a href="customer-support.jsp" class="text-decoration-none">Customer Support</a></li>
        <li><a href="order-history.jsp" class="text-decoration-none">Order History</a></li>
      </ul>
    </div>
  </div>
</div>

<!-- Toggle Button for Right Sidebar -->
<button class="toggle-sidebar-btn" onclick="toggleSidebar()">&#8594;</button>

<script>
  // Function to toggle the sidebar visibility
  function toggleSidebar() {
    const rightSidebar = document.querySelector('.right-sidebar');
    rightSidebar.classList.toggle('show');

    // Change the button text when clicked
    const toggleBtn = document.querySelector('.toggle-sidebar-btn');
    if (rightSidebar.classList.contains('show')) {
      toggleBtn.innerHTML = '&#8592;'; // Left arrow when sidebar is visible
    } else {
      toggleBtn.innerHTML = '&#8594;'; // Right arrow when sidebar is hidden
    }
  }
</script>

</body>
</html>
