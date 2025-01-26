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

@WebServlet("/loadCategories")
public class LoadCategoriesServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("calloadCatergory");
        ArrayList<CategoryDTO> categories = new ArrayList<>();
        BasicDataSource dataSource = (BasicDataSource) getServletContext().getAttribute("dataSourse");
        try (Connection conn = dataSource.getConnection()) {
            String sql = "SELECT id, name FROM categories";
            try (PreparedStatement ps = conn.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    categories.add(new CategoryDTO(rs.getInt("id"), rs.getString("name")));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        req.setAttribute("categories", categories);
        req.getRequestDispatcher("manage-products.jsp").forward(req, resp);
    }
}
