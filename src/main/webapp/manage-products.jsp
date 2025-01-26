<%@ page import="org.example.ecomx.DTO.CategoryDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.ecomx.DTO.ProductDTO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Products</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .page-header {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        .card {
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }
        .table img {
            width: 50px;
            height: 50px;
            object-fit: cover;
        }
        .btn-custom {
            background-color: #2c3e50;
            color: white;
            border: none;
        }
        .btn-custom:hover {
            background-color: #34495e;
        }
        .modal-header {
            background-color: #2c3e50;
            color: white;
        }
        .action-buttons {
            display: flex;
            gap: 0.5rem;
        }
        .reload-category-btn {
            margin-left: 10px;
            display: inline-block;
        }
    </style>
</head>
<body>
<div class="container my-5">
    <!-- Back Button -->
    <div class="mb-3">
        <a href="dashboardAdmin.jsp" class="btn btn-secondary">← Back</a>
    </div>

    <!-- Page Header -->
    <div class="page-header mb-4">
        <h1>Manage Products</h1>
        <p>Here you can view, add, edit, or delete products in the inventory.</p>
    </div>

    <!-- Add Product and Reload Buttons -->
    <div class="d-flex justify-content-between mb-3">
        <button class="btn btn-custom" data-bs-toggle="modal" data-bs-target="#addProductModal">Add New Product</button>
        <a href="listProducts" class="btn btn-primary">Reload Table</a>
    </div>

    <!-- Product Table -->
    <div class="card">
        <div class="card-body">
            <table class="table table-striped">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Description</th>
                    <th>Price</th>
                    <th>Category</th>
                    <th>Stock</th>
                    <th>Image</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody id="productTableBody">
                <%
                    List<ProductDTO> products = (List<ProductDTO>) request.getAttribute("products");
                    if (products != null && !products.isEmpty()) {
                        for (ProductDTO product : products) {
                %>
                <tr id="productRow-<%= product.getId() %>">
                    <td><%= product.getId() %></td>
                    <td><%= product.getName() %></td>
                    <td><%= product.getDescription() %></td>
                    <td><%= product.getPrice() %></td>
                    <td><%= product.getCategory() %></td>
                    <td><%= product.getStock() %></td>
                    <td>
                        <img src="<%= product.getImage() != null ? product.getImage() : "default.png" %>" alt="Product Image">
                    </td>
                    <td>
                        <div class="d-flex gap-2">
                            <button class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#editProductModal"
                                    onclick="editProduct('<%= product.getId() %>', '<%= product.getName() %>', '<%= product.getDescription() %>', '<%= product.getPrice() %>', '<%= product.getCategory() %>', '<%= product.getStock() %>', '<%= product.getImage() %>')">
                                Edit
                            </button>
                            <button id="deleteProductBtn-<%= product.getId() %>" class="btn btn-danger"
                                    onclick="deleteProduct(<%= product.getId() %>)">
                                Delete
                            </button>
                        </div>
                    </td>
                </tr>
                <%
                    }
                } else {
                %>
                <tr>
                    <td colspan="8" class="text-center">No products found.</td>
                </tr>
                <%
                    }
                %>
                </tbody>

            </table>
        </div>
    </div>
</div>

<!-- Add Product Modal -->
<div class="modal fade" id="addProductModal" tabindex="-1" aria-labelledby="addProductModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addProductModalLabel">Add New Product</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="addProduct" method="POST">
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="productName" class="form-label">Name</label>
                        <input type="text" class="form-control" id="productName" name="name" required>
                    </div>
                    <div class="mb-3">
                        <label for="productDescription" class="form-label">Description</label>
                        <textarea class="form-control" id="productDescription" name="description" rows="3" required></textarea>
                    </div>
                    <div class="mb-3">
                        <label for="productPrice" class="form-label">Price</label>
                        <input type="number" class="form-control" id="productPrice" name="price" step="0.01" required>
                    </div>
                    <div class="mb-3">
                        <label for="productCategory" class="form-label">Category</label>
                        <div class="d-flex">
                            <select class="form-select" id="productCategory" name="category_id" required>
                                <%
                                    List<CategoryDTO> categories = (List<CategoryDTO>) request.getAttribute("categories");
                                    if (categories != null && !categories.isEmpty()) {
                                        for (CategoryDTO category : categories) {
                                %>
                                <option value="<%= category.getId() %>"><%= category.getName() %></option>
                                <%
                                    }
                                } else {
                                %>
                                <option value="">No categories available</option>
                                <%
                                    }
                                %>
                            </select>
                            <button type="button" class="btn btn-secondary reload-category-btn" onclick="window.location.href='http://localhost:8080/ecomx_war_exploded/loadCategories'">Reload Categories</button>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="productStock" class="form-label">Stock</label>
                        <input type="number" class="form-control" id="productStock" name="stock" required>
                    </div>
                    <div class="mb-3">
                        <label for="productImage" class="form-label">Image</label>
                        <input type="file" class="form-control" id="productImage" name="image" accept="image/*">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-custom">Add Product</button>
                </div>
            </form>
        </div>
    </div>
</div>


<div class="modal fade" id="editProductModal" tabindex="-1" aria-labelledby="editProductModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editProductModalLabel">Edit Product</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="updateProduct" method="POST" >
                <div class="modal-body">
                    <input type="hidden" id="editProductId" name="id">
                    <div class="mb-3">
                        <label for="editProductName" class="form-label">Name</label>
                        <input type="text" class="form-control" id="editProductName" name="name" required>
                    </div>
                    <div class="mb-3">
                        <label for="editProductDescription" class="form-label">Description</label>
                        <textarea class="form-control" id="editProductDescription" name="description" rows="3" required></textarea>
                    </div>
                    <div class="mb-3">
                        <label for="editProductPrice" class="form-label">Price</label>
                        <input type="number" class="form-control" id="editProductPrice" name="price" step="0.01" required>
                    </div>
                    <div class="mb-3">
                        <label for="editProductCategory" class="form-label">Category</label>
                        <select class="form-select" id="editProductCategory" name="category_id" required>
                            <%-- Dynamically populate categories here --%>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="editProductStock" class="form-label">Stock</label>
                        <input type="number" class="form-control" id="editProductStock" name="stock" required>
                    </div>
                    <div class="mb-3">
                        <label for="editProductImage" class="form-label">Image</label>
                        <input type="file" class="form-control" id="editProductImage" name="image" accept="image/*">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-custom">Update Product</button>
                </div>
            </form>
        </div>
    </div>
</div>
<script>
    function editProduct(id, name, description, price, category, stock, image) {
        // Populate modal form with product details for editing
        document.getElementById('editProductId').value = id;
        document.getElementById('editProductName').value = name;
        document.getElementById('editProductDescription').value = description;
        document.getElementById('editProductPrice').value = price;
        document.getElementById('editProductCategory').value = category;
        document.getElementById('editProductStock').value = stock;
    }

    function deleteProduct(id) {
        if (confirm("Are you sure you want to delete this product?")) {
            window.location.href = `deleteProduct?id=${id}`;
        }
    }
</script>
</body>
</html>
