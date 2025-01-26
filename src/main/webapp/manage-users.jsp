<%@ page import="org.example.ecomx.DTO.UserDTO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Users</title>
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
        .back-button {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>

<div class="container my-5">
    <!-- Back Button -->
    <div class="back-button">
        <a href="dashboardAdmin.jsp" class="btn btn-secondary">← Back</a>
    </div>

    <!-- Page Header -->
    <div class="page-header mb-4">
        <h1>Manage Users</h1>
        <p>Here you can view, add, edit, or manage user statuses.</p>
    </div>

    <!-- Add User and Reload Buttons -->
    <div class="mb-3">
        <button class="btn btn-custom" data-bs-toggle="modal" data-bs-target="#addUserModal">Add New User</button>
        <a href="manage-users" class="btn btn-primary">Reload</a>
    </div>

    <!-- Users Table -->
    <div class="card">
        <div class="card-body">
            <table class="table table-striped">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Role</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody id="usersTableBody">
                <%
                    List<UserDTO> users = (List<UserDTO>) request.getAttribute("usersTable");
                    if (users != null && !users.isEmpty()) {
                        for (UserDTO user : users) {
                %>
                <tr id="userRow-<%= user.getId() %>">
                    <td><%= user.getId() %></td>
                    <td><%= user.getName() %></td>
                    <td><%= user.getEmail() %></td>
                    <td><%= user.getRole() %></td>
                    <td id="status-<%= user.getId() %>"><%= user.isStatus() ? "Active" : "Inactive" %></td>
                    <td>
                        <button class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#editUserModal"
                                onclick="editUser(<%= user.getId() %>, '<%= user.getName() %>', '<%= user.getEmail() %>', '<%= user.getRole() %>', <%= user.isStatus() %>)">Edit</button>
                        <button id="toggleStatusBtn-<%= user.getId() %>" class="btn btn-<%= user.isStatus() ? "danger" : "success" %>"
                                onclick="toggleUserStatus(<%= user.getId() %>, <%= user.isStatus() %>)">
                            <%= user.isStatus() ? "Deactivate" : "Activate" %>
                        </button>
                    </td>
                </tr>
                <%
                    }
                } else {
                %>
                <tr>
                    <td colspan="6" class="text-center">No users found.</td>
                </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Add User Modal -->
<div class="modal fade" id="addUserModal" tabindex="-1" aria-labelledby="addUserModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addUserModalLabel">Add New User</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="addUserServlet" method="POST">
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="userName" class="form-label">Name</label>
                        <input type="text" class="form-control" id="userName" name="name" required>
                    </div>
                    <div class="mb-3">
                        <label for="userEmail" class="form-label">Email</label>
                        <input type="email" class="form-control" id="userEmail" name="email" required>
                    </div>
                    <div class="mb-3">
                        <label for="userPassword" class="form-label">Password</label>
                        <input type="password" class="form-control" id="userPassword" name="password" required>
                    </div>
                    <div class="mb-3">
                        <label for="userRole" class="form-label">Role</label>
                        <select class="form-select" id="userRole" name="role" required>
                            <option value="CUSTOMER">Customer</option>
                            <option value="ADMIN">Admin</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="userStatus" class="form-label">Status</label>
                        <select class="form-select" id="userStatus" name="status" required>
                            <option value="true">Active</option>
                            <option value="false">Inactive</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-custom">Add User</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Edit User Modal -->
<div class="modal fade" id="editUserModal" tabindex="-1" aria-labelledby="editUserModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editUserModalLabel">Edit User</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="editUserServlet" method="POST">
                <div class="modal-body">
                    <input type="hidden" id="editUserId" name="id">
                    <div class="mb-3">
                        <label for="editUserName" class="form-label">Name</label>
                        <input type="text" class="form-control" id="editUserName" name="name" required>
                    </div>
                    <div class="mb-3">
                        <label for="editUserEmail" class="form-label">Email</label>
                        <input type="email" class="form-control" id="editUserEmail" name="email" required>
                    </div>
                    <div class="mb-3">
                        <label for="editUserRole" class="form-label">Role</label>
                        <select class="form-select" id="editUserRole" name="role" required>
                            <option value="CUSTOMER">Customer</option>
                            <option value="ADMIN">Admin</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="editUserStatus" class="form-label">Status</label>
                        <select class="form-select" id="editUserStatus" name="status" required>
                            <option value="true">Active</option>
                            <option value="false">Inactive</option>
                        </select>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-custom">Update User</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="js/jquery-3.7.1.min.js"></script>

<script>
    function editUser(id, name, email, role, status) {
        document.getElementById('editUserId').value = id;
        document.getElementById('editUserName').value = name;
        document.getElementById('editUserEmail').value = email;
        document.getElementById('editUserRole').value = role;
        document.getElementById('editUserStatus').value = status ? "true" : "false";
    }

    function toggleUserStatus(id, currentStatus) {
        const confirmAction = confirm(`Are you sure you want to ${currentStatus ? "deactivate" : "activate"} this user?`);
        if (confirmAction) {
            const newStatus = !currentStatus;
            document.getElementById(`status-${id}`).innerText = newStatus ? "Active" : "Inactive";
            const toggleBtn = document.getElementById(`toggleStatusBtn-${id}`);
            toggleBtn.innerText = newStatus ? "Deactivate" : "Activate";
            toggleBtn.className = `btn btn-${newStatus ? "danger" : "success"}`;

            // Call the server-side servlet to update the status
            window.location.href = `toggleUserStatusServlet?id=${id}&status=${newStatus}`;
        }
    }
</script>

</body>
</html>