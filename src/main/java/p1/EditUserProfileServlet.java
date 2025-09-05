package p1;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.*;
import java.util.Base64;
import java.sql.Connection;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,  // 2 MB
        maxFileSize = 1024 * 1024 * 20,       // 20 MB
        maxRequestSize = 1024 * 1024 * 25     // 25 MB
)
@WebServlet(name = "EditUserProfileServlet", value = "/EditUserProfileServlet")
public class EditUserProfileServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        int id = Integer.parseInt(request.getParameter("id"));
        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String email = request.getParameter("email");
        String mobile = request.getParameter("mobile");
        String address = request.getParameter("address");
        Part imagePart = request.getPart("editimage");

        PreparedStatement ps = null;

        try {
            Connection con=DBConnection.getConnection();
            if (imagePart != null && imagePart.getSize() > 0) {
                String sql = "UPDATE USERS SET FNAME = ?, LNAME = ?, EMAIL = ?, MOBILE_NO = ?, ADDRESS = ?, IMAGE = ? WHERE USER_ID = ?";
                ps = con.prepareStatement(sql);
                ps.setString(1, fname);
                ps.setString(2, lname);
                ps.setString(3, email);
                ps.setString(4, mobile);
                ps.setString(5, address);
                InputStream inputStream = imagePart.getInputStream();
                ps.setBinaryStream(6, inputStream, (int) imagePart.getSize());
                ps.setInt(7, id);
            } else {
                String sql = "UPDATE USERS SET FNAME = ?, LNAME = ?, EMAIL = ?, MOBILE_NO = ?, ADDRESS = ? WHERE USER_ID = ?";
                ps = con.prepareStatement(sql);
                ps.setString(1, fname);
                ps.setString(2, lname);
                ps.setString(3, email);
                ps.setString(4, mobile);
                ps.setString(5, address);
                ps.setInt(6, id);
            }

            int result = ps.executeUpdate();

            if (result > 0) {
                response.sendRedirect(request.getContextPath() + "/User/index.jsp");
            } else {
                out.println("<h3 style='color:red;'>Update failed.</h3>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<h3 style='color:red;'>Exception: " + e.getMessage() + "</h3>");
        }
    }
}
