package p1;

import javax.servlet.annotation.WebServlet;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Connection;

@WebServlet(name = "DBConnection", value = "/DBConnection")

public class DBConnection {

    private static final String URL = "jdbc:oracle:thin:@localhost:1521:XE";
    private static final String USER = "system";
    private static final String PASSWORD = "system";
    private static final String DRIVER = "oracle.jdbc.driver.OracleDriver";

    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName(DRIVER);
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
