package org.example.ecomx.categoryServlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.dbcp2.BasicDataSource;
import org.example.ecomx.DTO.CategoryDTO;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "ListCategoriesServlet", value = "/listCategories")
public class ListCategoriesServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<CategoryDTO> categories = new ArrayList<>();

        BasicDataSource dataSource = (BasicDataSource) getServletContext().getAttribute("dataSourse");

        try (Connection connection = dataSource.getConnection()) {
            String query = "SELECT id, name, description FROM categories";
            PreparedStatement pstmt = connection.prepareStatement(query);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                CategoryDTO category = new CategoryDTO();
                category.setId(rs.getInt("id"));
                category.setName(rs.getString("name"));
                category.setDescription(rs.getString("description"));
                categories.add(category);
            }
            req.setAttribute("categories", categories);
            req.getRequestDispatcher("manage-categories.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().println("Error fetching categories: " + e.getMessage());
        }
    }
}
