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

@WebServlet(name = "AddUserServlet", value = "/addUserServlet")
public class AddUserServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String role = req.getParameter("role");
        boolean status = Boolean.parseBoolean(req.getParameter("status"));

        BasicDataSource dataSource = (BasicDataSource) getServletContext().getAttribute("dataSourse");

        try (Connection connection = dataSource.getConnection()) {
            String query = "INSERT INTO users (name, email, password, role, status) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setString(1, name);
            pstmt.setString(2, email);
            pstmt.setString(3, password);
            pstmt.setString(4, role);
            pstmt.setBoolean(5, status);

            int rowsInserted = pstmt.executeUpdate();
            if (rowsInserted > 0) {
                resp.sendRedirect("manage-users");
            } else {
                resp.getWriter().println("Error adding user.");
            }
        } catch (SQLException e) {
            resp.getWriter().println("Database error: " + e.getMessage());
        }
    }
}
