package epbackend;

import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBConnector {

    final static private String db_url = "jdbc:mysql://localhost:3306/exchangeplatform";
    final static private String db_worker_name = "service_access_1";
    final static private String db_worker_password = "letmein";

    public static void main(String[] args) {
        Connection test_conn = getCon();
    }

    public static Connection getCon() {
        Connection connection = null;
        try {

            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(db_url, db_worker_name, db_worker_password);
            System.out.println("connected.....");
            
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(DBConnector.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(DBConnector.class.getName()).log(Level.SEVERE, null, ex);
        }
        return connection;
    }
}