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
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Date;
import java.util.Properties;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,  // 2 MB
        maxFileSize = 1024 * 1024 * 20,       // 20 MB
        maxRequestSize = 1024 * 1024 * 25     // 25 MB
)
@WebServlet(name = "OverdueMailServlet", value = "/OverdueMailServlet")
public class OverdueMailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response); // forward GET → POST
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        Integer issueId = (Integer) request.getAttribute("issueId");
        Integer userId = (Integer) request.getAttribute("userId");

//        Integer issueId = 97;
//        Integer userId = 17;

        System.out.println("IssueID : " +issueId);
        System.out.println("Here is the User : "+userId);

        if (issueId == null || userId == null) {
            response.getWriter().println("<p style='color:red;'>Error: Missing issueId or userId.</p>");
            System.out.println("Missing issueId or userId.");
            return;
        }

        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "system");

            // ✅ Fetch only the overdue book of the logged-in user
            String sql = "SELECT B.TITLE, B.IMAGE, U.EMAIL, IB.DUE_DATE " +
                    "FROM ISSUE_BOOK IB " +
                    "JOIN BOOK B ON IB.BOOK_ID = B.BOOK_ID " +
                    "JOIN USERS U ON IB.USER_ID = U.USER_ID " +
                    "WHERE IB.ISSUE_ID = ? AND IB.USER_ID = ? AND IB.STATUS = 'Overdue'";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, issueId);
            ps.setInt(2, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String title = rs.getString("TITLE");
                byte[] imgBytes = rs.getBytes("IMAGE");
                String userEmail = rs.getString("EMAIL");
                Date dueDate = rs.getDate("DUE_DATE");

                // ✅ Email credentials
                final String from = "renillakhani957@gmail.com"; // your gmail
                final String password = "dovx dlci xdhk fead";   // app password

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
                    message.setSubject("Overdue Book Notice - Action Required!");

                    // ✅ HTML body
                    MimeBodyPart htmlPart = new MimeBodyPart();
                    String htmlMsg = "<div style='font-family:Arial,sans-serif; padding:20px; background:#fff3f3;'>"
                            + "<div style='max-width:600px; margin:auto; background:white; padding:25px; "
                            + "border-radius:10px; border:1px solid #e0b4b4; box-shadow:0 0 10px rgba(0,0,0,0.1);'>"
                            + "<h2 style='color:#c0392b;'>Overdue Book Alert</h2>"
                            + "<p style='font-size:16px;'>Dear Reader,</p>"
                            + "<p style='font-size:15px;'>Our records show that you have not returned the following book:</p>"
                            + "<table style='margin:20px 0; font-size:15px;'>"
                            + "<tr><td style='padding:8px; font-weight:bold;'>Title:</td><td>" + title + "</td></tr>"
                            + "<tr><td style='padding:8px; font-weight:bold;'>Due Date:</td><td>" + dueDate + "</td></tr>"
                            + "<tr><td style='padding:8px; font-weight:bold; color:#c0392b;'>Fine:</td><td>₹100</td></tr>"
                            + "</table>";

                    if (imgBytes != null && imgBytes.length > 0) {
                        htmlMsg += "<div style='margin:20px 0;'>"
                                + "<img src='cid:image_cid' alt='Book Image' "
                                + "style='max-width:150px; border:1px solid #ccc; border-radius:8px;'/>"
                                + "</div>";
                    }

                    htmlMsg += "<p style='font-size:15px; color:#c0392b;'>Since the due date has passed, "
                            + "you are required to pay a fine of ₹100. Please return the book and pay the fine immediately.</p>"
                            + "<p style='color:#333;'>Regards,<br><strong>Library Team</strong></p>"
                            + "<hr style='margin-top:30px;'>"
                            + "<p style='font-size:12px; color:#888;'>This is an automated reminder. Please do not reply.</p>"
                            + "</div></div>";

                    htmlPart.setContent(htmlMsg, "text/html");

                    // ✅ Book image part
                    MimeBodyPart imagePart = new MimeBodyPart();
                    if (imgBytes != null && imgBytes.length > 0) {
                        imagePart.setDataHandler(new DataHandler(new ByteArrayDataSource(imgBytes, "image/jpeg")));
                        imagePart.setHeader("Content-ID", "<image_cid>");
                        imagePart.setDisposition(MimeBodyPart.INLINE);
                    }

                    // ✅ Multipart email
                    Multipart multipart = new MimeMultipart();
                    multipart.addBodyPart(htmlPart);
                    if (imgBytes != null && imgBytes.length > 0) {
                        multipart.addBodyPart(imagePart);
                    }

                    message.setContent(multipart);
                    Transport.send(message);

                    response.getWriter().println("<p style='color:green;'>Overdue mail sent to " + userEmail + " successfully!</p>");

                } catch (MessagingException e) {
                    e.printStackTrace();
                    response.getWriter().println("<p style='color:red;'>Mail sending failed: " + e.getMessage() + "</p>");
                }
            } else {
                response.getWriter().println("<p style='color:orange;'>No overdue book found for this user.</p>");
            }

            con.close();

        } catch (Exception e) {
            response.getWriter().println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
            e.printStackTrace();
        }
    }
}
