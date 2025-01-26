package org.example.ecomx.productServlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.dbcp2.BasicDataSource;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet(name = "AddProductServlet", value = "/addProduct")
public class AddProductServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Get form parameters
        String name = req.getParameter("name");
        String description = req.getParameter("description");
        String price = req.getParameter("price");
        String categoryId = req.getParameter("category_id");
        String stock = req.getParameter("stock");
        String imagePath = req.getParameter("image"); // Image path from the form

        System.out.println(name);
        System.out.println(description);
        System.out.println(price);
        System.out.println(categoryId);
        System.out.println(stock);
        System.out.println(imagePath);
        // Save data directly into the database
        BasicDataSource dataSource = (BasicDataSource) getServletContext().getAttribute("dataSourse");

        try (Connection connection = dataSource.getConnection()) {
            String query = "INSERT INTO products (name, description, price, category_id, stock, image_url) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement pstmt = connection.prepareStatement(query);

            pstmt.setString(1, name);
            pstmt.setString(2, description);
            pstmt.setString(3, price);
            pstmt.setString(4, categoryId);
            pstmt.setString(5, stock);
            pstmt.setString(6, imagePath); // Save the image path directly

            pstmt.executeUpdate();
            resp.getWriter().println("Product added successfully!");
        } catch (Exception e) {
            resp.getWriter().println("Error saving product: " + e.getMessage());
        }
    }
}
