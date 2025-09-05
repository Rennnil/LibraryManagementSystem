package p1;

import javax.mail.MessagingException;
import java.sql.*;

public class GetBookDetails {

    // ✅ Function to get borrowed books for a user
    public static ResultSet getBorrowedBooks(int userId) throws SQLException {

        try {
            Connection con = DBConnection.getConnection();

            String sql = "SELECT IB.ISSUE_ID, IB.LIBRARIAN_ID, IB.BOOK_ID, B.BOOK_IMAGE AS IMAGE, B.TITLE, " +
                    "IB.ISSUE_DATE, IB.DUE_DATE, IB.STATUS AS BOOK_STATUS, " +
                    "LU.EMAIL AS LIBRARIAN_EMAIL, LU.FNAME || ' ' || LU.LNAME AS LIBRARIAN_NAME, " +
                    "UU.EMAIL AS USER_EMAIL, UU.FNAME || ' ' || UU.LNAME AS USER_NAME, " +
                    "RB.RETURN_DATE, " +
                    "F.STATUS AS FINE_STATUS, F.AMOUNT AS FINE_AMOUNT " +
                    "FROM ISSUE_BOOK IB " +
                    "LEFT JOIN BOOK B ON IB.BOOK_ID = B.BOOK_ID " +
                    "LEFT JOIN USERS LU ON IB.LIBRARIAN_ID = LU.USER_ID " +
                    "LEFT JOIN USERS UU ON IB.USER_ID = UU.USER_ID " +
                    "LEFT JOIN RETURN_BOOK RB ON IB.ISSUE_ID = RB.ISSUE_ID " +
                    "LEFT JOIN FINE F ON IB.ISSUE_ID = F.ISSUE_ID " +
                    "WHERE IB.USER_ID = ?";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);

            return ps.executeQuery();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public static void getIssuedBooks(int issueId) {
        String sql = "SELECT u.FNAME, u.LNAME, u.EMAIL, " +
                "       b.TITLE, b.BOOK_IMAGE, " +
                "       i.ISSUE_DATE, i.DUE_DATE, " +
                "       l.FNAME AS LIBRARIAN_FNAME, l.LNAME AS LIBRARIAN_LNAME " +
                "FROM ISSUE_BOOK i " +
                "JOIN USERS u ON i.USER_ID = u.USER_ID " +
                "JOIN BOOK b ON i.BOOK_ID = b.BOOK_ID " +
                "JOIN USERS l ON i.LIBRARIAN_ID = l.USER_ID " +
                "WHERE i.ISSUE_ID = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, issueId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // ✅ User details
                String userName = rs.getString("FNAME") + " " + rs.getString("LNAME");
                String userEmail = rs.getString("EMAIL");

                // ✅ Book details
                String title = rs.getString("TITLE");
                byte[] imgBytes = rs.getBytes("BOOK_IMAGE");

                // ✅ Dates
                Date issueDate = rs.getDate("ISSUE_DATE");
                Date dueDate = rs.getDate("DUE_DATE");

                // ✅ Librarian details
                String librarianName = rs.getString("LIBRARIAN_FNAME") + " " + rs.getString("LIBRARIAN_LNAME");

                // ✅ Call your existing function
                LibraryMailUtil.sendIssueMail(userName, userEmail, title, imgBytes, issueDate, dueDate, librarianName);

                System.out.println("Issue Book Mail are send to : "+userEmail);
            } else {
                System.out.println("⚠️ No issue record found for ISSUE_ID = " + issueId);
            }

        } catch (SQLException | ClassNotFoundException | MessagingException e) {
            e.printStackTrace();
        }
    }

}

