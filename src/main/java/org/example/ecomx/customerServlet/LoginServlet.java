package org.example.ecomx.customerServlet;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.apache.commons.dbcp2.BasicDataSource;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Retrieve login form data
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

            // Query to validate user credentials
            String loginQuery = "SELECT id, name, email, role FROM users WHERE email = ? AND password = ? AND status = true";
            preparedStatement = connection.prepareStatement(loginQuery);
            preparedStatement.setString(1, email);
            preparedStatement.setString(2, password); // Note: Hash password in production and validate it

            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                // User found, create a session
                HttpSession session = request.getSession();
                session.setAttribute("userId", resultSet.getInt("id"));
                session.setAttribute("userName", resultSet.getString("name"));
                session.setAttribute("userEmail", resultSet.getString("email"));
                session.setAttribute("userRole", resultSet.getString("role"));

                // Redirect to a dashboard or home page
                response.sendRedirect("dashboardCustomer.jsp");
            } else {
                // User not found or invalid credentials
                out.println("<script>alert('Invalid email or password. Please try again.'); window.location.href='login.jsp';</script>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<script>alert('An error occurred: " + e.getMessage() + "'); window.location.href='login.jsp';</script>");
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
