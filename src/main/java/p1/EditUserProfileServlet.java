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
                // Fetch updated user info (including image) from DB
                String fetchSql = "SELECT FNAME, IMAGE FROM USERS WHERE USER_ID = ?";
                PreparedStatement fetchPs = con.prepareStatement(fetchSql);
                fetchPs.setInt(1, id);
                ResultSet rs = fetchPs.executeQuery();

                if (rs.next()) {
                    String updatedName = rs.getString("FNAME");

                    // Convert image BLOB to Base64 string
                    Blob blob = rs.getBlob("IMAGE");
                    String base64Image = null;
                    if (blob != null) {
                        byte[] imgBytes = blob.getBytes(1, (int) blob.length());
                        base64Image = "data:image/jpeg;base64," + Base64.getEncoder().encodeToString(imgBytes);
                    }

                    // Update session
                    HttpSession session = request.getSession();
                    session.setAttribute("userName", updatedName);
                    session.setAttribute("image", base64Image);
                }

                response.sendRedirect(request.getContextPath() + "/User/index.jsp");
            } else {
                out.println("<script type='text/javascript'>");
                out.println("alert('User Profile Is Not Edited');");
                out.println("window.location.href='" + request.getContextPath() + "/User/index.jsp';");
                out.println("</script>");
                //out.println("<h3 style='color:red;'>Update failed.</h3>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<h3 style='color:red;'>Exception: " + e.getMessage() + "</h3>");
        }
    }
}
