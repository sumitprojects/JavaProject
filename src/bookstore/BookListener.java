/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bookstore;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * Web application lifecycle listener.
 *
 * @author student
 */
public class BookListener implements ServletContextListener {
    Connection jdbcConnection = null;
    String sqlfile;
    
    @Override
    public void contextInitialized(ServletContextEvent sce) {
       try {
            ServletContext context = sce.getServletContext();
            sqlfile = sce.getServletContext().getRealPath("/bookstore.sql");
            String jdbcURL = context.getInitParameter("jdbcURL");
            String jdbcUsername = context.getInitParameter("jdbcUsername");
            String jdbcPassword = context.getInitParameter("jdbcPassword");
           try {
               Class.forName("com.mysql.jdbc.Driver");
           } catch (ClassNotFoundException e) {
               throw new SQLException(e);
           }
           jdbcConnection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
            
            resetDatabase(jdbcConnection);
        } catch (SQLException ex) {
            Logger.getLogger(BookListener.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        
    }
    public void resetDatabase(Connection jdbcConnection) throws SQLException {
        String s = new String();
        StringBuffer sb = new StringBuffer();
        
        try {
            FileReader fr = new FileReader(new File(sqlfile));
            // be sure to not have line starting with "--" or "/*" or any other non aplhabetical character
            try (BufferedReader br = new BufferedReader(fr)) {
                while ((s = br.readLine()) != null) {
                    sb.append(s);
                }
            }

            // here is our splitter ! We use ";" as a delimiter for each request
            // then we are sure to have well formed statements
            String[] inst = sb.toString().split(";");

            try (Statement st = jdbcConnection.createStatement()) {
                for (String inst1 : inst) {
                    // we ensure that there is no spaces before or after the request string
                    // in order to not execute empty statements
                    if (!inst1.trim().equals("")) {
                        st.executeUpdate(inst1);
                        System.out.println(">>" + inst1);
                    }
                }
            }
            jdbcConnection.close();
        } catch (IOException | SQLException e) {
            System.out.println("*** Error : " + e.toString());
            System.out.println("*** ");
            System.out.println("*** Error : ");
            System.out.println("################################################");
            System.out.println(sb.toString());
        }

    }
}
