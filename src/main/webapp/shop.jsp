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
    </style>
</head>
<body>
<div class="container">
    <!-- Search Bar -->
    <div class="search-bar">
        <form action="shop.jsp" method="get">
            <div class="input-group">
                <input type="text" class="form-control" placeholder="Search for products..." name="searchQuery" value="${param.searchQuery}">
                <button class="btn btn-primary" type="submit">Search</button>
            </div>
        </form>
    </div>

    <!-- Product List -->
    <div class="row">
        <c:if test="${not empty products}">
            <c:forEach var="product" items="${products}">
                <div class="col-md-4 mb-4">
                    <div class="product-card">
                        <img src="${product.imageUrl}" alt="${product.name}" class="card-img-top">
                        <div class="product-card-body">
                            <h5 class="product-card-title">${product.name}</h5>
                            <p class="product-card-price">$${product.price}</p>
                            <p class="product-card-description">${product.description}</p>
                            <a href="add-to-cart.jsp?productId=${product.id}" class="btn btn-custom w-100">Add to Cart</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:if>
        <c:if test="${empty products}">
            <div class="col-12">
                <p>No products found for your search. Please try again.</p>
            </div>
        </c:if>
    </div>
</div>

</body>
</html>
