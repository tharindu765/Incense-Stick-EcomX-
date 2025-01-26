<%@ page import="org.example.ecomx.DTO.CategoryDTO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Categories</title>
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
        .form-control, .btn {
            border-radius: 8px;
        }
        .back-button {
            margin-bottom: 20px;
        }
        .btn-custom {
            background-color: #2c3e50;
            color: white;
            border: none;
        }
        .btn-custom:hover {
            background-color: #34495e;
        }
    </style>
</head>
<body>

<div class="container my-4">
    <!-- Back Button -->
    <div class="back-button">
        <a href="dashboardAdmin.jsp" class="btn btn-secondary">← Back</a>
    </div>

    <!-- Page Header -->
    <div class="page-header text-center mb-4">
        <h1>Manage Categories</h1>
        <p>View, add, and manage categories for your store.</p>
    </div>

    <!-- Add Category and Reload Buttons -->
    <div class="mb-3">
        <a href="listCategories" class="btn btn-primary">Reload</a>
        <button class="btn btn-custom" data-bs-toggle="modal" data-bs-target="#addCategoryModal">Add New Category</button>
    </div>

    <!-- Categories Table -->
    <div class="card p-4">
        <h2 class="mb-3">Existing Categories</h2>
        <table class="table table-striped table-hover">
            <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Description</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <%-- Fetching category data from the backend --%>
            <%
                List<CategoryDTO> categories = (List<CategoryDTO>) request.getAttribute("categories");
                if (categories != null && !categories.isEmpty()) {
                    for (CategoryDTO category : categories) {
            %>
            <tr>
                <td><%= category.getId() %></td>
                <td><%= category.getName() %></td>
                <td><%= category.getDescription() %></td>
                <td>
                    <!-- Edit Button -->
                    <button class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#editCategoryModal"
                            onclick="editCategory(<%= category.getId() %>, '<%= category.getName() %>', '<%= category.getDescription() %>')">Edit</button>

                    <!-- Delete Button -->
                    <a href="DeleteCategoryServlet?id=<%= category.getId() %>" class="btn btn-sm btn-danger"
                       onclick="return confirm('Are you sure you want to delete this category?')">Delete</a>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="4" class="text-center">No categories found.</td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>

</div>

<!-- Add Category Modal -->
<div class="modal fade" id="addCategoryModal" tabindex="-1" aria-labelledby="addCategoryModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addCategoryModalLabel">Add New Category</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="CreateCategoryServlet" method="POST">
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="categoryName" class="form-label">Category Name</label>
                        <input type="text" class="form-control" id="categoryName" name="name" required>
                    </div>
                    <div class="mb-3">
                        <label for="categoryDescription" class="form-label">Category Description</label>
                        <textarea class="form-control" id="categoryDescription" name="description" rows="3"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-custom">Add Category</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Edit Category Modal -->
<div class="modal fade" id="editCategoryModal" tabindex="-1" aria-labelledby="editCategoryModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editCategoryModalLabel">Edit Category</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="UpdateCategoryServlet" method="POST">
                <div class="modal-body">
                    <input type="hidden" id="editCategoryId" name="id">
                    <div class="mb-3">
                        <label for="editCategoryName" class="form-label">Category Name</label>
                        <input type="text" class="form-control" id="editCategoryName" name="name" required>
                    </div>
                    <div class="mb-3">
                        <label for="editCategoryDescription" class="form-label">Category Description</label>
                        <textarea class="form-control" id="editCategoryDescription" name="description" rows="3"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-custom">Update Category</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="js/jquery-3.7.1.min.js"></script>

<script>
    function editCategory(id, name, description) {
        document.getElementById('editCategoryId').value = id;
        document.getElementById('editCategoryName').value = name;
        document.getElementById('editCategoryDescription').value = description;
    }
</script>

</body>
</html>