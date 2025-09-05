package p1;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import java.io.*;
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
        String yearStr = request.getParameter("published_year");
        String qtyStr = request.getParameter("qty");

        int year = (yearStr != null && !yearStr.isEmpty()) ? Integer.parseInt(yearStr) : 0;
        int qty = (qtyStr != null && !qtyStr.isEmpty()) ? Integer.parseInt(qtyStr) : 0;

        Part BookImage = request.getPart("book_image");
        Part AuthorImage = request.getPart("author_image");

        HttpSession session = request.getSession(false);
        int userId = (int) session.getAttribute("userId");


        try {
            Connection con= DBConnection.getConnection();

            String sql = "INSERT INTO BOOK (BOOK_ID, TITLE, AUTHOR, PUBLISHER, CATEGORY, YEAR_PUBLISHED, QNTY, AVAILABLE_QNTY, BOOK_IMAGE,AUTHOR_IMAGE,USER_ID) " +
                    "VALUES (BOOK_ID_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, title);
            ps.setString(2, author);
            ps.setString(3, publisher);
            ps.setString(4, category);
            ps.setInt(5, year);
            ps.setInt(6, qty);
            ps.setInt(7, qty); // available qty = total initially

            if (BookImage != null && BookImage.getSize() > 0) {
                InputStream inputStream = BookImage.getInputStream();
                ps.setBinaryStream(8, inputStream, BookImage.getSize());
            } else {
                ps.setNull(8, Types.BLOB);
            }
            if (AuthorImage != null && AuthorImage.getSize() > 0) {
                InputStream inputStream1 = AuthorImage.getInputStream();
                ps.setBinaryStream(9, inputStream1, AuthorImage.getSize());
            } else {
                ps.setNull(9, Types.BLOB);
            }
            ps.setInt(10, userId);

            int inserted = ps.executeUpdate();

            if (inserted > 0) {
                response.sendRedirect(request.getContextPath() + "/Admin/addCourse.jsp");
            } else {
                out.println("<h3 style='color:red;'>Failed to add book.</h3>");
            }

        } catch (Exception e) {
            e.printStackTrace();
            out.println("<h3 style='color:red;'>Error: " + e.getMessage() + "</h3>");
        }
    }
}
