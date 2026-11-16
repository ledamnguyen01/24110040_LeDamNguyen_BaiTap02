package vn.iotstar.connection;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    private final String serverName = "localhost";
    private final String dbName = "ShoppingServiceMVC";
    private final String portNumber = "1433";
    private final String instance = "";
    private final String userID = "sa";
    private final String password = "1234@a$";

    public Connection getConnection() throws Exception {
        Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        
        String url;
        if (instance == null || instance.trim().isEmpty()) {
            url = "jdbc:sqlserver://" + serverName + ":" + portNumber + ";encrypt=true;trustServerCertificate=true;databaseName=" + dbName;
        } else {
            url = "jdbc:sqlserver://" + serverName + ":" + portNumber + "\\" + instance + ";encrypt=true;trustServerCertificate=true;databaseName=" + dbName;
        }
        
        try {
            return DriverManager.getConnection(url, userID, password);
        } catch (Exception e) {
            // Fallback for local connection if port 1433 is not restarted yet
            String fallbackUrl = "jdbc:sqlserver://" + serverName + ";integratedSecurity=true;encrypt=true;trustServerCertificate=true;databaseName=" + dbName;
            try {
                return DriverManager.getConnection(fallbackUrl);
            } catch (Exception ex) {
                throw e;
            }
        }
    }

    public static void main(String[] args) {
        try {
            DBConnection db = new DBConnection();
            Connection conn = db.getConnection();
            if (conn != null) {
                System.out.println("Kết nối Database thành công!");
                conn.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
