package org.example.ecomx.categoryServlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.dbcp2.BasicDataSource;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet(name = "CreateCategoryServlet", value = "/CreateCategoryServlet")
public class CreateCategoryServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String description = req.getParameter("description");

        BasicDataSource dataSource = (BasicDataSource) getServletContext().getAttribute("dataSourse");

        try {
            Connection connection = dataSource.getConnection();
            String query = "INSERT INTO categories (name, description) VALUES (?, ?)";
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setString(1, name);
            pstmt.setString(2, description);

            int rowsInserted = pstmt.executeUpdate();
            if (rowsInserted > 0) {
                resp.sendRedirect("listCategories");
            } else {
                resp.getWriter().println("Error adding category.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().println("Error: " + e.getMessage());
        }
    }
}
