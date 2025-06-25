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

@WebServlet(name = "AddBook", value = "/AddBook")
public class AddBook extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        request.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String publisher = request.getParameter("publisher");
        String category = request.getParameter("category");
        String yearStr = request.getParameter("publishedyear");
        String qtyStr = request.getParameter("qty");

        int year = (yearStr != null && !yearStr.isEmpty()) ? Integer.parseInt(yearStr) : 0;
        int qty = (qtyStr != null && !qtyStr.isEmpty()) ? Integer.parseInt(qtyStr) : 0;

        Part imagePart = request.getPart("bookimage");

        Connection con = null;
        PreparedStatement ps = null;

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "system");

            String sql = "INSERT INTO BOOK (BOOK_ID, TITLE, AUTHOR, PUBLISHER, CATEGORY, YEAR_PUBLISHED, QNTY, AVAILABLE_QNTY, IMAGE) " +
                    "VALUES (BOOK_ID_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?)";

            ps = con.prepareStatement(sql);
            ps.setString(1, title);
            ps.setString(2, author);
            ps.setString(3, publisher);
            ps.setString(4, category);
            ps.setInt(5, year);
            ps.setInt(6, qty);
            ps.setInt(7, qty); // available qty = total initially

            if (imagePart != null && imagePart.getSize() > 0) {
                InputStream inputStream = imagePart.getInputStream();
                ps.setBinaryStream(8, inputStream, imagePart.getSize()); // ✅ Streaming the image
            } else {
                ps.setNull(8, Types.BLOB);
            }

            int inserted = ps.executeUpdate();

            if (inserted > 0) {
                response.sendRedirect(request.getContextPath() + "/Admin/addCourse.jsp");
            } else {
                out.println("<h3 style='color:red;'>Failed to add book.</h3>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<h3 style='color:red;'>Error: " + e.getMessage() + "</h3>");
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
}
