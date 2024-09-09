package helper;

import java.sql.*;

public class ConnectionProvider {

    private static Connection con;

    public static Connection getConnection() {
        try {
            if (con == null) {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3308/techBlog", "root", "Vanbui262004@");
                System.out.println("Connected to the database!");
            }



        }catch (Exception e) {
            e.printStackTrace();
        }

        return con;
    }

}
