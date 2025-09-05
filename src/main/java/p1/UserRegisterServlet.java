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
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.Types;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,  // 2 MB
        maxFileSize = 1024 * 1024 * 20,       // 20 MB
        maxRequestSize = 1024 * 1024 * 25     // 25 MB
)
@WebServlet(name = "UserRegisterServlet", value = "/UserRegisterServlet")

public class UserRegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String fname = request.getParameter("firstname");
        String lname = request.getParameter("lastname");
        String gender = request.getParameter("gender");
        String mobile = request.getParameter("mobile");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String address = request.getParameter("address");
        int roleStr = 3;

        Part imagePart = request.getPart("userimage");

        try {
            Connection con=DBConnection.getConnection();

            String sql = "INSERT INTO USERS (USER_ID, FNAME, LNAME, EMAIL, PASSWORD, MOBILE_NO, GENDER, ADDRESS, IMAGE,ROLE_ID) " +
                    "VALUES (USERS_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, fname);
            ps.setString(2, lname);
            ps.setString(3, email);
            ps.setString(4, password);
            ps.setString(5, mobile);
            ps.setString(6, gender);
            ps.setString(7, address);


            if (imagePart != null && imagePart.getSize() > 0) {
                InputStream inputStream = imagePart.getInputStream();
                ps.setBinaryStream(8, inputStream, imagePart.getSize()); // ✅ Streaming the image
            } else {
                ps.setNull(8, Types.BLOB);
            }
            ps.setInt(9, roleStr);

            int result = ps.executeUpdate();
            if (result > 0) {
                    response.sendRedirect(request.getContextPath() + "/User/index.jsp");
            } else {
                out.println("<h3 style='color:red;'>Registration failed.</h3>");
            }
            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<h3 style='color:red;'>Error: " + e.getMessage() + "</h3>");
        }

    }
}
