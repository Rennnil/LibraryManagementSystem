package p1;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.*;
import java.sql.Connection;


@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,  // 2 MB
        maxFileSize = 1024 * 1024 * 20,       // 20 MB
        maxRequestSize = 1024 * 1024 * 25     // 25 MB
)
@WebServlet(name = "EditProfileServlet", value = "/EditProfileServlet")

public class EditProfileServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        PrintWriter out = response.getWriter();
        response.setContentType("text/html");

        int id= Integer.parseInt(request.getParameter("id"));
        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String mobile = request.getParameter("mobile");
        String address = request.getParameter("address");
        Part imagePart = request.getPart("editimage");

        PreparedStatement ps;

        try{

            Connection con= DBConnection.getConnection();

            if (imagePart != null && imagePart.getSize() > 0) {
                String sql = "UPDATE USERS SET FNAME = ?, LNAME = ?, MOBILE_NO = ?, ADDRESS = ?, IMAGE = ? WHERE USER_ID = ?";
                ps = con.prepareStatement(sql);
                ps.setString(1, fname);
                ps.setString(2, lname);
                ps.setString(3, mobile);
                ps.setString(4, address);
                InputStream inputStream = imagePart.getInputStream();
                ps.setBinaryStream(5, inputStream, imagePart.getSize());
                ps.setInt(6, id);
            } else {
                String sql = "UPDATE USERS SET FNAME = ?, LNAME = ?, MOBILE_NO = ?, ADDRESS = ? WHERE USER_ID = ?";
                ps = con.prepareStatement(sql);
                ps.setString(1, fname);
                ps.setString(2, lname);
                ps.setString(3, mobile);
                ps.setString(4, address);
                ps.setInt(5, id);
            }

            int result = ps.executeUpdate();
            if (result > 0) {
                //out.println("<h3 style='color:green;'>Update successful!</h3>");
                PreparedStatement p2 = con.prepareStatement("SELECT FNAME, LNAME, IMAGE FROM USERS WHERE USER_ID = ?");
                p2.setInt(1, id);
                ResultSet rs2 = p2.executeQuery();
                if (rs2.next()) {
                    String updatedFname = rs2.getString("FNAME");
                    String updatedLname = rs2.getString("LNAME");
                    byte[] updatedImageBytes = rs2.getBytes("IMAGE");

                    // Convert image to base64
                    String base64Image = "";
                    if (updatedImageBytes != null) {
                        base64Image = java.util.Base64.getEncoder().encodeToString(updatedImageBytes);
                    }
                    String imageSrc = "data:image/jpeg;base64," + base64Image;

                    // Update session values
                    request.getSession().setAttribute("fname", updatedFname);
                    request.getSession().setAttribute("lname", updatedLname);
                    request.getSession().setAttribute("image", imageSrc);
                }
                rs2.close();
                p2.close();

                // Now redirect
                response.sendRedirect(  request.getContextPath()+"/Librarian/Profile.jsp");
            } else {
                out.println("<h3 style='color:red;'>Registration failed.</h3>");
            }
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace(); // Not just throw
            out.println("<h3 style='color:red;'>Exception: " + e.getMessage() + "</h3>");
        }
    }
}
