/**
 * Author: S69935
 * Document: DBUtil.java
 */

package java.dao;

import java.sql.*;

public class DBUtil {

    private static final String JDBC_URL = System.getenv("DB_URL");
    private static final String JDBC_USERNAME = System.getenv("DB_USER");
    private static final String JDBC_PASSWORD = System.getenv("DB_PASS");

    public static Connection initializeDatabase() throws SQLException, ClassNotFoundException {
        if (JDBC_URL == null || JDBC_USERNAME == null || JDBC_PASSWORD == null) {
            throw new SQLException("Missing DB environment variables. Make sure DB_URL, DB_USER, and DB_PASS are set.");
        }

        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
    }
    
}
