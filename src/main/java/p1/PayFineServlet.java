package p1;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Date;
import java.time.LocalDate;

@WebServlet("/PayFineServlet")
public class PayFineServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Read hidden input fields
        int issueId = Integer.parseInt(request.getParameter("issueId"));
        int userId = Integer.parseInt(request.getParameter("userId"));
        int librarianId = Integer.parseInt(request.getParameter("librarianId"));

        // Read card details
        String cardNumber = request.getParameter("cardNumber");
        String payeeName = request.getParameter("cardName");
        String exMonth = request.getParameter("cardMonth");
        String exYear = request.getParameter("cardYear");
        int cvv = Integer.parseInt(request.getParameter("CVV"));

        PreparedStatement ps = null;

        try {
            Connection con=DBConnection.getConnection();

            // ✅ Update FINE table (not insert)
            String sql = "UPDATE FINE " +
                    "SET STATUS = ?, PAID_DATE = ?, CARD_NUMBER = ?, PAYEE_NAME = ?, " +
                    "    EX_MONTH = ?, EX_YEAR = ?, CVV = ?, LIBRARIAN_ID = ? " +
                    "WHERE ISSUE_ID = ? AND USER_ID = ?";

            ps = con.prepareStatement(sql);
            ps.setString(1, "Paid");
            ps.setDate(2, Date.valueOf(LocalDate.now())); // current date
            ps.setString(3, cardNumber);
            ps.setString(4, payeeName);
            ps.setString(5, exMonth);
            ps.setString(6, exYear);
            ps.setInt(7, cvv);
            ps.setInt(8, librarianId);
            ps.setInt(9, issueId);
            ps.setInt(10, userId);

            int rowsUpdated = ps.executeUpdate();
            if (rowsUpdated > 0) {
                System.out.println("Fine payment updated successfully!");
                response.sendRedirect(request.getContextPath() + "/User/BorrowedBooks.jsp?status=success");
            } else {
                response.sendRedirect(request.getContextPath() + "/Payment/Card.jsp?status=failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
