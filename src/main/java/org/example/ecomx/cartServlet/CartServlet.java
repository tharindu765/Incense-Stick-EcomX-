package org.example.ecomx.cartServlet;

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

@WebServlet(name = "CartServlet", urlPatterns = {"/add-to-cart"})
public class CartServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Fetch parameters
        int userId = Integer.parseInt(request.getParameter("userId"));
        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        // Get the data source from context
        BasicDataSource dataSource = (BasicDataSource) getServletContext().getAttribute("dataSourse");

        // Insert the cart record
        try (Connection connection = dataSource.getConnection()) {
            String query = "INSERT INTO cart (user_id, product_id, quantity) VALUES (?, ?, ?)";
            PreparedStatement preparedStatement = connection.prepareStatement(query);
            preparedStatement.setInt(1, userId);
            preparedStatement.setInt(2, productId);
            preparedStatement.setInt(3, quantity);

            int rowsAffected = preparedStatement.executeUpdate();

            if (rowsAffected > 0) {
                response.sendRedirect("shop.jsp?success=true");
            } else {
                response.sendRedirect("shop.jsp?error=true");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("shop.jsp?error=true");
        }
    }
}
