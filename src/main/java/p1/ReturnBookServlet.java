package p1;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.sql.Connection;
import java.time.LocalDate;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,  // 2 MB
        maxFileSize = 1024 * 1024 * 20,       // 20 MB
        maxRequestSize = 1024 * 1024 * 25     // 25 MB
)
@WebServlet(name = "ReturnBookServlet", value = "/ReturnBookServlet")
public class ReturnBookServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int issueId = Integer.parseInt(request.getParameter("issueId"));
        int bookId = Integer.parseInt(request.getParameter("bookId"));
        HttpSession session = request.getSession(false);
        Integer librarianId = (Integer) session.getAttribute("userId");
        PrintWriter out = response.getWriter();
        try {
            Connection con=DBConnection.getConnection();

            // Step 1: Insert into RETURN_BOOK
            String insertSql = "INSERT INTO RETURN_BOOK (RETURN_ID, ISSUE_ID, BOOK_ID, RETURN_DATE, RECEIVED_BY, CONDITION_NOTE) " +
                    "VALUES (RETURN_BOOK_SEQ.NEXTVAL, ?, ?, ?, ?, ?)";
            PreparedStatement psInsert = con.prepareStatement(insertSql);
            psInsert.setInt(1, issueId);
            psInsert.setInt(2, bookId);
            psInsert.setDate(3, Date.valueOf(LocalDate.now())); // today's date
            psInsert.setInt(4, librarianId);
            psInsert.setString(5, "Good condition");
            int insertbook = psInsert.executeUpdate();

            // Step 2: Update ISSUE_BOOK status to 'Returned'
            String updateSql = "UPDATE ISSUE_BOOK SET STATUS = 'Returned' WHERE ISSUE_ID = ?";
            PreparedStatement psUpdate = con.prepareStatement(updateSql);
            psUpdate.setInt(1, issueId);
            int updatebook = psUpdate.executeUpdate();

            if (insertbook > 0 && updatebook > 0) {

                // Step 3: Get Book Title, Image, User Email, User Name, Librarian Name
                String bookSql = "SELECT B.TITLE, B.BOOK_IMAGE, " +
                        "(U.FNAME || ' ' || U.LNAME) AS USERNAME, U.EMAIL, " +
                        "(L.FNAME || ' ' || L.LNAME) AS LIBRARIAN_NAME " +
                        "FROM ISSUE_BOOK IB " +
                        "JOIN BOOK B ON IB.BOOK_ID = B.BOOK_ID " +
                        "JOIN USERS U ON IB.USER_ID = U.USER_ID " +
                        "JOIN USERS L ON IB.LIBRARIAN_ID = L.USER_ID " +
                        "WHERE IB.ISSUE_ID = ?";
                PreparedStatement psBook = con.prepareStatement(bookSql);
                psBook.setInt(1, issueId);
                ResultSet rs = psBook.executeQuery();

                if (rs.next()) {
                    String title = rs.getString("TITLE");
                    byte[] imgBytes = rs.getBytes("BOOK_IMAGE");
                    String userEmail = rs.getString("EMAIL");
                    String userName = rs.getString("USERNAME");
                    String librarianName = rs.getString("LIBRARIAN_NAME");

                    // ✅ Call MailService function here with librarian name
                    try {
                        LibraryMailUtil.sendReturnMail(userName, userEmail, title, imgBytes, librarianName);
                    } catch (Exception e) {
                        e.printStackTrace();
                        System.out.println("❌ Failed to send return mail: " + e.getMessage());
                    }
                }

                // ✅ Update available quantity safely
                String sql = "UPDATE BOOK SET AVAILABLE_QNTY = AVAILABLE_QNTY + 1 WHERE BOOK_ID = ?";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setInt(1, bookId);

                int rows = ps.executeUpdate();
                if (rows > 0) {
                    response.getWriter().println("Available quantity updated successfully!");
                } else {
                    response.getWriter().println("Update failed: Not enough books available.");
                }

                response.sendRedirect(request.getContextPath() + "/User/BorrowedBooks.jsp");
            } else {
                out.println("<script type='text/javascript'>");
                out.println("alert('Book Are Not Returned');");
                out.println("window.location.href='" + request.getContextPath() + "/User/BorrowedBooks.jsp';");
                out.println("</script>");
                //System.out.println("Failed to return the book.");
            }

        } catch (Exception e) {
            response.getWriter().println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
        }
    }
}
