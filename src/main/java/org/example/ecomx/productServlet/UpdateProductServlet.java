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

@WebServlet(name = "UpdateProductServlet", value = "/updateProduct")
public class UpdateProductServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        String name = req.getParameter("name");
        String description = req.getParameter("description");
        double price = Double.parseDouble(req.getParameter("price"));
        String category = req.getParameter("category");
        int stock = Integer.parseInt(req.getParameter("stock"));
        String image = req.getParameter("image");  // Handle file upload separately

        BasicDataSource dataSource = (BasicDataSource) getServletContext().getAttribute("dataSourse");

        try (Connection connection = dataSource.getConnection()) {
            String query = "UPDATE products SET name = ?, description = ?, price = ?, category_id = ?, stock = ?, image_url = ? WHERE id = ?";
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setString(1, name);
            pstmt.setString(2, description);
            pstmt.setDouble(3, price);
            pstmt.setString(4, category);
            pstmt.setInt(5, stock);
            pstmt.setString(6, image);
            pstmt.setInt(7, id);

            pstmt.executeUpdate();
            resp.sendRedirect("manageData");  // Redirect back to product list
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().println("Error updating product: " + e.getMessage());
        }
    }
}
