package org.example.ecomx.userServlet;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.dbcp2.BasicDataSource;
import org.example.ecomx.DTO.UserDTO;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "UserListServlet", value = "/manage-users")
public class UserListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("UserListServlet invoked");
        List<UserDTO> userList = new ArrayList<>();

        // Get the DataSource from the ServletContext
        BasicDataSource dataSource = (BasicDataSource) getServletContext().getAttribute("dataSourse");

        try (Connection connection = dataSource.getConnection();
             PreparedStatement pstm = connection.prepareStatement("SELECT * FROM users");
             ResultSet rs = pstm.executeQuery()) {

            while (rs.next()) {
                int id = rs.getInt("id"); // Retrieve the ID column
                String name = rs.getString("name");
                String email = rs.getString("email");
                String password = rs.getString("password");
                String role = rs.getString("role");
                boolean status = rs.getBoolean("status");

                userList.add(new UserDTO(id, name, email, password, role, status)); // Pass ID to the DTO
            }

            // Set the user list attribute
            req.setAttribute("usersTable", userList);

            RequestDispatcher rd = req.getRequestDispatcher("/manage-users.jsp");
            rd.forward(req, resp);

        } catch (SQLException e) {
            resp.getWriter().println("Database error: " + e.getMessage());
        }
    }
}
