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

@WebServlet(name = "DeactivateUserServlet", value = "/deactivateUserServlet")
public class DeactivateUserServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));

        BasicDataSource dataSource = (BasicDataSource) getServletContext().getAttribute("dataSourse");

        try (Connection connection = dataSource.getConnection()) {
            String query = "UPDATE users SET status = false WHERE id = ?";
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, id);

            int rowsUpdated = pstmt.executeUpdate();
            if (rowsUpdated > 0) {
                resp.sendRedirect("manage-users");
            } else {
                resp.getWriter().println("Error deactivating user.");
            }
        } catch (SQLException e) {
            resp.getWriter().println("Database error: " + e.getMessage());
        }
    }
}
