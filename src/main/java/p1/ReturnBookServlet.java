package p1;

import javax.activation.DataHandler;
import javax.mail.*;
import javax.mail.internet.*;
import javax.mail.util.ByteArrayDataSource;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.sql.Connection;
import java.time.LocalDate;
import java.util.Base64;
import java.util.Properties;

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

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "system");

            // Step 1: Insert into RETURN_BOOK
            String insertSql = "INSERT INTO RETURN_BOOK (RETURN_ID, ISSUE_ID,BOOK_ID, RETURN_DATE, RECEIVED_BY, CONDITION_NOTE) " +
                    "VALUES (RETURN_BOOK_SEQ.NEXTVAL, ?, ?, ?, ?, ?)";
            PreparedStatement psInsert = con.prepareStatement(insertSql);
            psInsert.setInt(1, issueId);
            psInsert.setInt(2, bookId);
            psInsert.setDate(3, Date.valueOf(LocalDate.now())); // today's date
            psInsert.setInt(4, librarianId);
            psInsert.setString(5, "Good condition"); // Optional: dynamic input

            int insertbook = psInsert.executeUpdate();

            // Step 2: Update ISSUE_BOOK status to 'Returned'
            String updateSql = "UPDATE ISSUE_BOOK SET STATUS = 'Returned' WHERE ISSUE_ID = ?";
            PreparedStatement psUpdate = con.prepareStatement(updateSql);
            psUpdate.setInt(1, issueId);
            int updatebook = psUpdate.executeUpdate();

            if (insertbook > 0 && updatebook > 0) {

                // Step 3: Get Book Title, Image, and User Email
                String bookSql = "SELECT B.TITLE, B.IMAGE, U.EMAIL FROM ISSUE_BOOK IB " +
                        "JOIN BOOK B ON IB.BOOK_ID = B.BOOK_ID " +
                        "JOIN USERS U ON IB.USER_ID = U.USER_ID " +
                        "WHERE IB.ISSUE_ID = ?";
                PreparedStatement psBook = con.prepareStatement(bookSql);
                psBook.setInt(1, issueId);
                ResultSet rs = psBook.executeQuery();

                if (rs.next()) {
                    String title = rs.getString("TITLE");
                    byte[] imgBytes = rs.getBytes("IMAGE");
                    String userEmail = rs.getString("EMAIL");
                    String currentDate = LocalDate.now().toString();

                    // Step 4: Send Email with inline image
                    final String from = "renillakhani957@gmail.com"; // Replace with your email
                    final String password = "dovx dlci xdhk fead";   // Use Gmail app password

                    Properties props = new Properties();
                    props.put("mail.smtp.host", "smtp.gmail.com");
                    props.put("mail.smtp.port", "587");
                    props.put("mail.smtp.auth", "true");
                    props.put("mail.smtp.starttls.enable", "true");

                    Session mailSession = Session.getInstance(props, new Authenticator() {
                        protected PasswordAuthentication getPasswordAuthentication() {
                            return new PasswordAuthentication(from, password);
                        }
                    });

                    try {
                        Message message = new MimeMessage(mailSession);
                        message.setFrom(new InternetAddress(from));
                        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(userEmail));
                        message.setSubject(" Book Returned - Thank You!");

                        // HTML part
                        MimeBodyPart htmlPart = new MimeBodyPart();
                        String htmlMsg = "<div style='font-family:Arial,sans-serif; padding:20px; background:#f4f4f4;'>"
                                + "<div style='max-width:600px; margin:auto; background:white; padding:25px; border-radius:10px; box-shadow:0 0 10px rgba(0,0,0,0.1);'>"
                                + "<h2 style='color:#27ae60;'>Book Return Confirmation</h2>"
                                + "<p style='font-size:16px;'>Dear Reader,</p>"
                                + "<p style='font-size:15px;'>We’re pleased to inform you that your book has been successfully returned.</p>"
                                + "<table style='margin:20px 0; font-size:15px;'>"
                                + "<tr><td style='padding:8px; font-weight:bold;'>Title:</td><td>" + title + "</td></tr>"
                                + "<tr><td style='padding:8px; font-weight:bold;'>Returned On:</td><td>" + currentDate + "</td></tr>"
                                + "</table>";
                        if (imgBytes != null && imgBytes.length > 0) {
                            htmlMsg += "<div style='margin:20px 0;'>"
                                    + "<img src='cid:image_cid' alt='Book Image' style='max-width:150px; border:1px solid #ccc; border-radius:8px;'/>"
                                    + "</div>";
                        }
                        htmlMsg += "<p style='font-size:15px;'>We hope you enjoyed reading! Feel free to borrow another book anytime.</p>"
                                + "<p style='color:#333;'>Best regards,<br><strong>Library Team</strong></p>"
                                + "<hr style='margin-top:30px;'>"
                                + "<p style='font-size:12px; color:#888;'>This is an automated message. Please do not reply.</p>"
                                + "</div></div>";
                        htmlPart.setContent(htmlMsg, "text/html");

                        // Image part
                        MimeBodyPart imagePart = new MimeBodyPart();
                        if (imgBytes != null && imgBytes.length > 0) {
                            imagePart.setDataHandler(new DataHandler(new ByteArrayDataSource(imgBytes, "image/jpeg")));
                            imagePart.setHeader("Content-ID", "<image_cid>");
                            imagePart.setDisposition(MimeBodyPart.INLINE);
                        }

                        // Multipart setup
                        Multipart multipart = new MimeMultipart();
                        multipart.addBodyPart(htmlPart);
                        if (imgBytes != null && imgBytes.length > 0) {
                            multipart.addBodyPart(imagePart);
                        }

                        message.setContent(multipart);
                        Transport.send(message);

                    } catch (MessagingException e) {
                        e.printStackTrace();
                    }
                }

                response.sendRedirect(request.getContextPath() + "/User/BorrowedBooks.jsp");
            } else {
                System.out.println("Failed to return the book.");
            }

        } catch (Exception e) {
            response.getWriter().println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
        }
    }
}
