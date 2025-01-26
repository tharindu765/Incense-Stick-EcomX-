package org.example.ecomx.userServlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.dbcp2.BasicDataSource;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/toggleUserStatusServlet")
public class ToggleUserStatusServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get user ID and status from the request
        String userIdParam = request.getParameter("id");
        String statusParam = request.getParameter("status");

        // Initialize the BasicDataSource (retrieved from the ServletContext)
        BasicDataSource dataSource = (BasicDataSource) getServletContext().getAttribute("dataSourse");

        try {
            // Parse the request parameters
            int userId = Integer.parseInt(userIdParam);
            boolean newStatus = Boolean.parseBoolean(statusParam);

            // Update the user's status in the database
            boolean isUpdated = updateUserStatus(dataSource, userId, newStatus);

            // Redirect based on the result
            if (isUpdated) {
                response.sendRedirect("manage-users?message=User status updated successfully");
            } else {
                response.sendRedirect("manage-users?error=Failed to update user status");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("manage-users?error=Invalid parameters or internal error");
        }
    }

    private boolean updateUserStatus(BasicDataSource dataSource, int userId, boolean status) {
        String query = "UPDATE users SET status = ? WHERE id = ?";

        try (Connection connection = dataSource.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            // Set the parameters for the query
            preparedStatement.setBoolean(1, status);
            preparedStatement.setInt(2, userId);

            // Execute the query and return if at least one row was updated
            int rowsAffected = preparedStatement.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
