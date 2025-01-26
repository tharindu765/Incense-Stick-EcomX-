package org.example.ecomx.customerServlet;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.dbcp2.BasicDataSource;
import org.example.ecomx.DTO.UserDTO;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Retrieve form data
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        PrintWriter out = response.getWriter();

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            // Retrieve the DataSource from ServletContext
            ServletContext servletContext = getServletContext();
            BasicDataSource dataSource = (BasicDataSource) servletContext.getAttribute("dataSourse");

            // Get a connection from the connection pool
            connection = dataSource.getConnection();

            // Check if email already exists
            String checkQuery = "SELECT COUNT(*) FROM users WHERE email = ?";
            preparedStatement = connection.prepareStatement(checkQuery);
            preparedStatement.setString(1, email);
            ResultSet resultSet = preparedStatement.executeQuery();
            resultSet.next();

            if (resultSet.getInt(1) > 0) {
                // Email already exists
                out.println("<script>alert('Email already exists. Please use a different email.'); window.location.href='register.jsp';</script>");
                return;
            }

            // Create a UserDTO object
            UserDTO userDTO = new UserDTO();
            userDTO.setName(name);
            userDTO.setEmail(email);
            userDTO.setPassword(password); // Note: Hash the password in production
            userDTO.setRole("CUSTOMER");
            userDTO.setStatus(true);

            // Insert user into the database
            String insertQuery = "INSERT INTO users (name, email, password, role, status) VALUES (?, ?, ?, ?, ?)";
            preparedStatement = connection.prepareStatement(insertQuery);
            preparedStatement.setString(1, userDTO.getName());
            preparedStatement.setString(2, userDTO.getEmail());
            preparedStatement.setString(3, userDTO.getPassword());
            preparedStatement.setString(4, userDTO.getRole());
            preparedStatement.setBoolean(5, userDTO.isStatus());

            int rowsInserted = preparedStatement.executeUpdate();
            if (rowsInserted > 0) {
                // Success
                out.println("<script>alert('Registration successful! You can now log in.'); window.location.href='login.jsp';</script>");
            } else {
                // Failure
                out.println("<script>alert('Error occurred during registration. Please try again.'); window.location.href='register.jsp';</script>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('An error occurred: " + e.getMessage() + "'); window.location.href='register.jsp';</script>");
        } finally {
            try {
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close(); // Return the connection to the pool
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
}
