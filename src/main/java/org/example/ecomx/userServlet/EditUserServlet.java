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

@WebServlet(name = "EditUserServlet", value = "/editUserServlet")
public class EditUserServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String role = req.getParameter("role");
        boolean status = Boolean.parseBoolean(req.getParameter("status"));

        BasicDataSource dataSource = (BasicDataSource) getServletContext().getAttribute("dataSourse");

        try (Connection connection = dataSource.getConnection()) {
            String query = "UPDATE users SET name = ?, email = ?, role = ?, status = ? WHERE id = ?";
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setString(1, name);
            pstmt.setString(2, email);
            pstmt.setString(3, role);
            pstmt.setBoolean(4, status);
            pstmt.setInt(5, id);

            int rowsUpdated = pstmt.executeUpdate();
            if (rowsUpdated > 0) {
                resp.sendRedirect("manage-users");
            } else {
                resp.getWriter().println("Error updating user.");
            }
        } catch (SQLException e) {
            resp.getWriter().println("Database error: " + e.getMessage());
        }
    }
}
