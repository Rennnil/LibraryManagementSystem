package p1;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize = 1024 * 1024 * 20,
        maxRequestSize = 1024 * 1024 * 25
)
@WebServlet(name = "LoginServlet", value = "/LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html");
        request.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection con = DriverManager.getConnection(
                    "jdbc:oracle:thin:@localhost:1521:XE", "system", "system");

            String sql = "SELECT u.USER_ID, u.IMAGE, u.FNAME, u.LNAME, r.ROLE_NAME " +
                    "FROM USERS u JOIN ROLE r ON u.ROLE_ID = r.ROLE_ID " +
                    "WHERE u.EMAIL = ? AND u.PASSWORD = ?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String role = rs.getString("ROLE_NAME").toLowerCase();
                String fname = rs.getString("FNAME");

                byte[] imgBytes = rs.getBytes("IMAGE");
                String imageSrc;

                if (imgBytes != null && imgBytes.length > 0) {
                    String base64Image = java.util.Base64.getEncoder().encodeToString(imgBytes);
                    imageSrc = "data:image/jpeg;base64," + base64Image;
                } else {
                    imageSrc = request.getContextPath() + "/vendors/images/default-avatar.png"; // corrected fallback path
                }

                HttpSession session = request.getSession();
                session.setAttribute("userName", fname);
                session.setAttribute("image", imageSrc);

                String contextPath = request.getContextPath();

                switch (role) {
                    case "admin":
                        response.sendRedirect(contextPath + "/Admin/index.jsp");
                        break;
                    case "librarian":
                        response.sendRedirect(contextPath + "/Librarian/index.jsp");
                        break;
                    case "student":
                        response.sendRedirect(contextPath + "/index.jsp");
                        break;
                    default:
                        out.println("<h3 style='color:red;'>Unknown role: " + role + "</h3>");
                }
            } else {
                out.println("<h3 style='color:red;'>Invalid email or password.</h3>");
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<h3 style='color:red;'>Error: " + e.getMessage() + "</h3>");
        }
    }
}
