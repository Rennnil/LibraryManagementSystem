package p1;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.sql.Connection;

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
            Connection con = DBConnection.getConnection();

            String sql = "SELECT u.USER_ID, u.IMAGE, u.FNAME, u.LNAME,u.ROLE_ID, r.ROLE_NAME " +
                    "FROM USERS u JOIN ROLE r ON u.ROLE_ID = r.ROLE_ID " +
                    "WHERE u.EMAIL = ? AND u.PASSWORD = ?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                int roleId = rs.getInt("ROLE_ID");
                String role = rs.getString("ROLE_NAME").toLowerCase();
                String fname = rs.getString("FNAME");
                byte[] imgBytes = rs.getBytes("IMAGE");
                int userId = rs.getInt("USER_ID");
                String imageSrc;

                if (imgBytes != null && imgBytes.length > 0) {
                    String base64Image = java.util.Base64.getEncoder().encodeToString(imgBytes);
                    imageSrc = "data:image/jpeg;base64," + base64Image;
                } else {
                    imageSrc = request.getContextPath() + "../webapp/User/pic-3.jpg"; // corrected fallback path
                }

                HttpSession session = request.getSession();
                session.setAttribute("userId",userId);
                session.setAttribute("userName", fname);
                session.setAttribute("image", imageSrc);
                session.setAttribute("role", role);
                session.setAttribute("roleId", roleId);

                String contextPath = request.getContextPath();

                switch (role) {
                    case "admin":
                        response.sendRedirect(contextPath + "/Admin/index.jsp");
                        break;
                    case "librarian":
                        response.sendRedirect(contextPath + "/Librarian/index.jsp");
                        break;
                    case "student":
                        response.sendRedirect(contextPath + "/User/index.jsp");
                        break;
                    default:
                        out.println("<h3 style='color:red;'>Unknown role: " + role + "</h3>");
                }
            } else {
                out.println("<script type='text/javascript'>");
                out.println("alert('Invalid Email or Password.');");
                out.println("window.location.href='" + request.getContextPath() + "/User/index.jsp';");
                out.println("</script>");
//                out.println("<h3 style='color:red;'>Invalid email or password.</h3>");
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<h3 style='color:red;'>Error: " + e.getMessage() + "</h3>");
        }
    }
}
