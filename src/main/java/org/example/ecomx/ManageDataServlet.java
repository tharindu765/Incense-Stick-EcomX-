package org.example.ecomx;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.dbcp2.BasicDataSource;
import org.example.ecomx.DTO.CategoryDTO;
import org.example.ecomx.DTO.ProductDTO;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/manageData")
public class ManageDataServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Initialize lists for categories and products
        List<CategoryDTO> categories = new ArrayList<>();
        List<ProductDTO> products = new ArrayList<>();

        // Get the dataSource from the ServletContext
        BasicDataSource dataSource = (BasicDataSource) getServletContext().getAttribute("dataSourse");

        // Connect to the database and retrieve both categories and products
        try (Connection conn = dataSource.getConnection()) {
            // Fetch categories
            String categoryQuery = "SELECT id, name FROM categories";
            try (PreparedStatement categoryStmt = conn.prepareStatement(categoryQuery);
                 ResultSet categoryRs = categoryStmt.executeQuery()) {
                while (categoryRs.next()) {
                    categories.add(new CategoryDTO(categoryRs.getInt("id"), categoryRs.getString("name")));
                }
            }

            // Fetch products
            String productQuery = "SELECT id, name, description, price, category_id, stock, image_url FROM products";
            try (PreparedStatement productStmt = conn.prepareStatement(productQuery);
                 ResultSet productRs = productStmt.executeQuery()) {
                while (productRs.next()) {
                    ProductDTO product = new ProductDTO();
                    product.setId(productRs.getInt("id"));
                    product.setName(productRs.getString("name"));
                    product.setDescription(productRs.getString("description"));
                    product.setPrice(productRs.getDouble("price"));
                    product.setCategory(productRs.getString("category_id"));
                    product.setStock(productRs.getInt("stock"));
                    product.setImage(productRs.getString("image_url"));
                    products.add(product);
                }
            }

            // Set attributes for categories and products
            req.setAttribute("categories", categories);
            req.setAttribute("products", products);

            // Forward to JSP
            req.getRequestDispatcher("manage-products.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().println("Error fetching data: " + e.getMessage());
        }
    }
}
