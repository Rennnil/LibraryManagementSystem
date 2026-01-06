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
import java.sql.*;
import java.time.LocalDate;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,  // 2 MB
        maxFileSize = 1024 * 1024 * 20,       // 20 MB
        maxRequestSize = 1024 * 1024 * 25     // 25 MB
)

@WebServlet(name = "IssueBookServlet", value = "/IssueBookServlet")

public class IssueBookServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HttpSession session = request.getSession(false);
            Integer userId = (Integer) session.getAttribute("userId");

            if (userId == null) {
                response.sendRedirect("Login.jsp");
                return;
            }
            PrintWriter out=response.getWriter();

            int bookId = Integer.parseInt(request.getParameter("bookId"));
            int librarianID = Integer.parseInt(request.getParameter("userId"));

            LocalDate issueDate = LocalDate.now();
            LocalDate dueDate = issueDate.plusDays(10);

            Connection con=DBConnection.getConnection();

            String sql = "INSERT INTO ISSUE_BOOK (ISSUE_ID, LIBRARIAN_ID ,USER_ID, BOOK_ID, ISSUE_DATE, DUE_DATE, STATUS) " +
                    "VALUES (ISSUE_BOOK_SEQ.NEXTVAL,?, ?, ?, ?, ?, ?)";

            //PreparedStatement ps = con.prepareStatement(sql);
            PreparedStatement ps = con.prepareStatement(sql, new String[]{"ISSUE_ID"});
            ps.setInt(1, librarianID);
            ps.setInt(2, userId);
            ps.setInt(3, bookId);
            ps.setDate(4, Date.valueOf(issueDate));
            ps.setDate(5, Date.valueOf(dueDate));
            ps.setString(6, "Issued");

            System.out.println(userId + " " + bookId + " " + issueDate + " " + dueDate);


            int rows = ps.executeUpdate();

            int issueId = -1;
            if (rows > 0) {
                ResultSet rsKeys = ps.getGeneratedKeys();
                if (rsKeys.next()) {
                    issueId = rsKeys.getInt(1);  // ✅ This is the ISSUE_ID just inserted
                }
            }
            if (issueId != -1) {
                GetBookDetails.getIssuedBooks(issueId); // fetch details & send email
                response.sendRedirect(request.getContextPath() + "/User/BorrowedBooks.jsp");

            } else {
                out.println("<script type='text/javascript'>");
                out.println("alert('Book Are Not Issued');");
                out.println("window.location.href='" + request.getContextPath() + "/User/index.jsp';");
                out.println("</script>");
                response.getWriter().println("Failed to issue book.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
