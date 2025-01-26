<%@ page import="org.example.ecomx.DTO.ProductDTO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shop - Incense Stick Ecom</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            padding-top: 20px;
        }
        .search-bar {
            max-width: 600px;
            margin: 0 auto 20px;
        }
        .product-card {
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            background-color: #ffffff;
        }
        .product-card img {
            height: 200px;
            object-fit: cover;
            border-top-left-radius: 8px;
            border-top-right-radius: 8px;
        }
        .product-card-body {
            padding: 20px;
        }
        .product-card .btn-custom {
            background-color: #2c3e50;
            color: white;
            border: none;
        }
        .product-card .btn-custom:hover {
            background-color: #34495e;
        }
        .product-card-title {
            font-size: 18px;
            font-weight: bold;
        }
        .product-card-price {
            font-size: 16px;
            color: #27ae60;
        }
        .product-card-description {
            font-size: 14px;
            color: #7f8c8d;
        }
        .featured-products-section {
            margin-top: 40px;
            text-align: center;
        }
        .featured-products-section h2 {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 20px;
        }
        .featured-products-section p {
            font-size: 16px;
            color: #7f8c8d;
        }
        .btn-back {
            margin-top: 20px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            padding: 10px 20px;
            border-radius: 5px;
        }
        .btn-back:hover {
            background-color: #0056b3;
            color: white;
        }
    </style>
</head>
<body>
<div class="container">
    <!-- Back Button -->
    <div>
        <a href="dashboardCustomer.jsp" class="btn-back">← Back to Home</a>
    </div>

    <!-- Search Bar -->
    <div class="search-bar mt-4">
        <form action="shop" method="get">
            <div class="input-group">
                <input type="text" class="form-control" placeholder="Search for products..." name="searchQuery" value="<%= request.getParameter("searchQuery") %>">
                <button class="btn btn-primary" type="submit">Search</button>
            </div>
        </form>
    </div>

    <!-- Product List -->
    <div class="row mt-4">
        <%
            List<org.example.ecomx.DTO.ProductDTO> products = (List<ProductDTO>) request.getAttribute("products");

            if (products != null && !products.isEmpty()) {
                for (org.example.ecomx.DTO.ProductDTO product : products) {
        %>
        <div class="col-md-4 mb-4">
            <div class="product-card">
                <img src="<%= product.getImage() %>" alt="<%= product.getName() %>" class="card-img-top">
                <div class="product-card-body">
                    <h5 class="product-card-title"><%= product.getName() %></h5>
                    <p class="product-card-price">$<%= product.getPrice() %></p>
                    <p class="product-card-description"><%= product.getDescription() %></p>
                    <p class="product-card-category">Category: <%= product.getCategory() %></p>
                    <p class="product-card-stock">Stock: <%= product.getStock() %></p>
                    <a href="add-to-cart.jsp?productId=<%= product.getId() %>" class="btn btn-custom w-100">Add to Cart</a>
                </div>
            </div>
        </div>
        <%
            }
        } else {
        %>
        <div class="col-12 text-center">
            <p class="text-muted">No products found for your search. Please try again.</p>
        </div>
        <%
            }
        %>
    </div>

    <!-- Featured Products Section -->
    <div class="featured-products-section">
        <h2>Featured Products</h2>
        <p>Check out some of our most popular incense sticks:</p>
        <div class="row">
            <div class="col-md-4">
                <div class="product-card">
                    <img src="images/sandalwood.jpg" alt="Sandalwood Incense" class="card-img-top">
                    <div class="product-card-body">
                        <h5 class="product-card-title">Sandalwood Incense</h5>
                        <p class="product-card-price">$10.99</p>
                        <a href="#" class="btn btn-custom w-100">Add to Cart</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="product-card">
                    <img src="images/jasmine.jpg" alt="Jasmine Incense" class="card-img-top">
                    <div class="product-card-body">
                        <h5 class="product-card-title">Jasmine Incense</h5>
                        <p class="product-card-price">$8.99</p>
                        <a href="#" class="btn btn-custom w-100">Add to Cart</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="product-card">
                    <img src="images/rose.jpg" alt="Rose Incense" class="card-img-top">
                    <div class="product-card-body">
                        <h5 class="product-card-title">Rose Incense</h5>
                        <p class="product-card-price">$9.99</p>
                        <a href="#" class="btn btn-custom w-100">Add to Cart</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
