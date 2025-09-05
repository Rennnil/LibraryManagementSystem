package p1;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.DriverManager;
import java.sql.SQLException;

@WebServlet(name = "Connection", value = "/Connection")
public class Connection extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");
        PrintWriter pw= response.getWriter();
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            java.sql.Connection con= DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE","system","system");
            System.out.println("Connection Established");
        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }
}
