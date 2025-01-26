<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Home - Incense Stick Ecom</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        .card {
            height: 100%;
        }
        .section-spacing {
            margin-top: 50px;
        }
        .info-card {
            background-color: #f8f9fa;
        }
        .products .card {
            background-color: #eaf4fc;
        }
        .categories .card {
            background-color: #fde7e0;
        }
        .info-card .card {
            background-color: #fff7d6;
        }
        .section-header {
            margin-bottom: 30px;
        }
    </style>
</head>
<body>
<header class="bg-dark text-white py-3">
    <div class="container d-flex justify-content-between align-items-center">
        <h1 class="h3">Incense Stick Ecom</h1>
        <nav>
            <a href="login.jsp" class="text-white text-decoration-none mx-2">Login</a>
            <a href="register.jsp" class="text-white text-decoration-none mx-2">Register</a>
        </nav>
    </div>
</header>

<div class="hero bg-light text-center py-5">
    <div class="container">
        <h2>Welcome to the Best Incense Stick Store!</h2>
        <p>Your one-stop shop for premium incense sticks.</p>
        <a href="dashboardAdmin.jsp" class="btn btn-dark mt-3">Explore Now</a>
    </div>
</div>

<div class="products container section-spacing" id="products">
    <h3 class="text-center section-header">Our Products</h3>
    <div class="row">
        <div class="col-md-4">
            <div class="card shadow-sm">
                <div class="card-body text-center">
                    <h3 class="card-title">Sandalwood Incense</h3>
                    <p class="card-text">Experience the calming scent of sandalwood.</p>
                    <p class="card-text fw-bold">Price: $5.99</p>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card shadow-sm">
                <div class="card-body text-center">
                    <h3 class="card-title">Rose Incense</h3>
                    <p class="card-text">Fill your space with the sweet fragrance of roses.</p>
                    <p class="card-text fw-bold">Price: $6.99</p>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card shadow-sm">
                <div class="card-body text-center">
                    <h3 class="card-title">Lavender Incense</h3>
                    <p class="card-text">Relax and unwind with lavender's soothing aroma.</p>
                    <p class="card-text fw-bold">Price: $7.49</p>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="categories container section-spacing">
    <h3 class="text-center section-header">Available Categories</h3>
    <div class="row">
        <div class="col-md-4">
            <div class="card shadow-sm h-100">
                <div class="card-body text-center">
                    <h3 class="card-title">Floral</h3>
                    <p class="card-text">Browse our wide range of floral incense sticks.</p>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card shadow-sm h-100">
                <div class="card-body text-center">
                    <h3 class="card-title">Woody</h3>
                    <p class="card-text">Discover the earthy fragrances of woody incense.</p>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card shadow-sm h-100">
                <div class="card-body text-center">
                    <h3 class="card-title">Fruity</h3>
                    <p class="card-text">Enjoy the sweet and tangy fruity scents.</p>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="info-card container text-center py-3 section-spacing">
    <h3 class="text-center section-header">Why Choose Us?</h3>
    <div class="row">
        <div class="col-md-4">
            <div class="card shadow-sm">
                <div class="card-body">
                    <h3 class="card-title">Fast Delivery</h3>
                    <p class="card-text">Get your orders delivered within 2-3 business days!</p>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card shadow-sm">
                <div class="card-body">
                    <h3 class="card-title">100% Natural</h3>
                    <p class="card-text">Our incense sticks are made from natural ingredients.</p>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card shadow-sm">
                <div class="card-body">
                    <h3 class="card-title">Customer Support</h3>
                    <p class="card-text">24/7 support to assist you with your needs.</p>
                </div>
            </div>
        </div>
    </div>
</div>

<footer class="bg-dark text-white text-center py-3">
    <p>&copy; 2025 Incense Stick Ecom. All rights reserved.</p>
</footer>
</body>
</html>
