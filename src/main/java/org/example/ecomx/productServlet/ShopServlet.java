package org.example.ecomx.productServlet;

import org.example.ecomx.DTO.ProductDTO;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.dbcp2.BasicDataSource;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/shop")
public class ShopServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ServletContext context = getServletContext();
        BasicDataSource dataSource = (BasicDataSource) context.getAttribute("dataSourse");

        List<ProductDTO> products = new ArrayList<>();
        String searchQuery = request.getParameter("searchQuery");

        try (Connection connection = dataSource.getConnection()) {
            String sql = "SELECT p.id, p.name, p.description, p.price, c.name AS category, p.stock, p.image_url " +
                    "FROM products p " +
                    "LEFT JOIN categories c ON p.category_id = c.id " +
                    "WHERE p.stock > 0";
            if (searchQuery != null && !searchQuery.isEmpty()) {
                sql += " AND p.name LIKE ?";
            }

            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                if (searchQuery != null && !searchQuery.isEmpty()) {
                    statement.setString(1, "%" + searchQuery + "%");
                }

                try (ResultSet resultSet = statement.executeQuery()) {
                    while (resultSet.next()) {
                        ProductDTO product = new ProductDTO();
                        product.setId(resultSet.getInt("id"));
                        product.setName(resultSet.getString("name"));
                        product.setDescription(resultSet.getString("description"));
                        product.setPrice(resultSet.getDouble("price"));
                        product.setCategory(resultSet.getString("category"));
                        product.setStock(resultSet.getInt("stock"));
                        product.setImage(resultSet.getString("image_url"));

                        products.add(product);
                    }
                }
            }
        } catch (Exception e) {
            throw new ServletException("Error retrieving products", e);
        }

        // Attach the products list to the request
        request.setAttribute("products", products);

        // Forward to the JSP page
        RequestDispatcher dispatcher = request.getRequestDispatcher("shop.jsp");
        dispatcher.forward(request, response);
    }
}
