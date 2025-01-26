package org.example.ecomx.Lisiners;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import org.apache.commons.dbcp2.BasicDataSource;

import java.sql.SQLException;

@WebListener
public class MyListener implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        BasicDataSource basicDataSource = new BasicDataSource();
        basicDataSource.setDriverClassName("com.mysql.jdbc.Driver");
        basicDataSource.setUrl("jdbc:mysql://localhost:3306/ecommerce");
        basicDataSource.setUsername("root");
        basicDataSource.setPassword("Ijse@123");
        basicDataSource.setMaxTotal(5);
        basicDataSource.setInitialSize(5);

        //common interface for al servelet
        ServletContext servletContext = sce.getServletContext();
        servletContext.setAttribute("dataSourse",basicDataSource);
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        ServletContext servletContext =sce.getServletContext();
        BasicDataSource ds = (BasicDataSource) servletContext.getAttribute("dataSourse");
        try {
            ds.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
