package org.example.ecomx.productServlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import org.apache.commons.dbcp2.BasicDataSource;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.PreparedStatement;

@WebServlet(name = "AddProductServlet", value = "/addProduct")
@MultipartConfig // This annotation is required to handle file uploads
public class AddProductServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Get form parameters
        String name = req.getParameter("name");
        String description = req.getParameter("description");
        String price = req.getParameter("price");
        String categoryId = req.getParameter("category_id");
        String stock = req.getParameter("stock");

        // Handle file upload
        Part filePart = req.getPart("image"); // Get the uploaded file
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); // Extract file name

        if (fileName == null || fileName.trim().isEmpty()) {
            resp.getWriter().write("Error: No image file uploaded!");
            return;
        }

        // Define the upload directory
        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir(); // Create the uploads directory if it doesn't exist
        }

        // Save the uploaded file to the uploads directory
        String filePath = uploadPath + File.separator + fileName;
        filePart.write(filePath);

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
            pstmt.setString(6, "uploads/" + fileName); // Save the relative image path

            pstmt.executeUpdate();
            resp.sendRedirect("manageData");
        } catch (Exception e) {
            resp.getWriter().println("Error saving product: " + e.getMessage());
        }
    }
}
