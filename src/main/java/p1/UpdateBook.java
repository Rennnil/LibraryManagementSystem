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
import java.sql.DriverManager;
import java.sql.PreparedStatement;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize = 1024 * 1024 * 20,
        maxRequestSize = 1024 * 1024 * 25
)
@WebServlet(name = "UpdateBook", value = "/UpdateBook")
public class UpdateBook extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        PrintWriter out = response.getWriter();
        response.setContentType("text/html;charset=UTF-8");


        String bookId = request.getParameter("bookId");
        String title = request.getParameter("title");
        String author = request.getParameter("author");
        String publisher = request.getParameter("publisher");
        String category = request.getParameter("category");
        String publishedYear = request.getParameter("publishedyear");
        int qty = Integer.parseInt(request.getParameter("qty"));
        Part imagePart = request.getPart("bookimage");

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "system", "system");

            String sql;
            PreparedStatement ps;

            sql = "UPDATE BOOK SET TITLE = ?, AUTHOR = ?, PUBLISHER = ?, CATEGORY = ?, YEAR_PUBLISHED = ?, QNTY = ?, IMAGE = ? WHERE BOOK_ID = ?";
            ps = con.prepareStatement(sql);
            ps.setString(1, title);
            ps.setString(2, author);
            ps.setString(3, publisher);
            ps.setString(4, category);
            ps.setString(5, publishedYear);
            ps.setInt(6, qty);
            InputStream inputStream = imagePart.getInputStream();
            ps.setBinaryStream(7, inputStream, imagePart.getSize());
            ps.setInt(8, Integer.parseInt(bookId));

            int rowsUpdated = ps.executeUpdate();
            if (rowsUpdated > 0) {
                out.println("Book updated successfully");
            } else {
                out.println("Update failed. Book ID may not exist.");
            }

            ps.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace(out);
        }
    }
}
