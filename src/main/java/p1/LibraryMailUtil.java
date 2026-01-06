package p1;

import javax.activation.DataHandler;
import javax.mail.*;
import javax.mail.internet.*;
import javax.mail.util.ByteArrayDataSource;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.Properties;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,  // 2 MB
        maxFileSize = 1024 * 1024 * 20,       // 20 MB
        maxRequestSize = 1024 * 1024 * 25     // 25 MB
)
@WebServlet(name = "LibraryMailUtil", value = "/LibraryMailUtil")

public class LibraryMailUtil {

    // ✅ Email credentials
    private static final String FROM = "lilbriomanagement@gmail.com";
    private static final String PASSWORD = "lpli qccb tdvu tuxq";   // Gmail App Password

    // ✅ Common mail session
    private static Session getSession() {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        return Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM, PASSWORD);
            }
        });
    }

    // 1. Return Book Mail (Green Theme)
    public static void sendReturnMail(String userName, String userEmail, String title, byte[] imgBytes, String librarianName) throws MessagingException {
        Session session = getSession();
        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(FROM));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(userEmail));
        message.setSubject("✅ Book Returned - Thank You!");

        // Format date correctly
        LocalDate currentDate = LocalDate.now();
        String currentDateStr = currentDate.format(DateTimeFormatter.ofPattern("dd-MM-yyyy"));

        String htmlMsg = "<div style='font-family:Arial,sans-serif; background:#f4fff4; padding:20px;'>"
                + "<div style='max-width:600px; margin:auto; background:#fff; border:1px solid #b2d8b2; "
                + "border-radius:10px; padding:25px; box-shadow:0 0 8px rgba(0,0,0,0.08);'>"

                + "<h2 style='color:#27ae60; margin-bottom:15px;'>Book Return Confirmation</h2>"
                + "<p>Dear " + userName + ",</p>"
                + "<p>We are pleased to inform you that your book has been successfully returned.</p>"

                + "<table style='width:100%; border-collapse:collapse; font-size:15px; margin-bottom:20px;'>"
                + "<tr><td style='padding:8px; font-weight:bold;'>Title :</td><td>" + title + "</td></tr>"
                + "<tr><td style='padding:8px; font-weight:bold;'>Returned On :</td><td>" + currentDateStr + "</td></tr>"
                + "<tr><td style='padding:8px; font-weight:bold;'>Issued By :</td><td>" + librarianName + "</td></tr>"
                + "</table>";

        if (imgBytes != null && imgBytes.length > 0) {
            htmlMsg += "<div style='text-align:center; margin:20px 0;'>"
                    + "<img src='cid:image_cid' alt='Book Image' style='max-width:180px; border:1px solid #ccc; border-radius:10px;'/>"
                    + "</div>";
        }

        htmlMsg += "<p style='color:#27ae60;'>We hope you enjoyed reading! Feel free to borrow another book anytime.</p>"
                + "<p>Regards,<br><strong>Lilbrio Team</strong></p>"
                + "</div></div>";

        sendMultipartMail(message, htmlMsg, imgBytes);
        System.out.println("✅ Return mail sent to " + userEmail);
    }

    // 2. Issue Book Mail (Yellow  Theme)
    public static void sendIssueMail(String userName, String userEmail, String title, byte[] imgBytes, Date issueDate, Date dueDate,String librarianName) throws MessagingException {
            Session session = getSession();
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(userEmail));
            message.setSubject("📖 Book Issued Successfully!");

            String issueDateStr = (issueDate != null) ? new SimpleDateFormat("dd-MM-yyyy").format(issueDate) : "--";
            String dueDateStr = (dueDate != null) ? new SimpleDateFormat("dd-MM-yyyy").format(dueDate) : "--";

            String htmlMsg = "<div style='font-family:Arial,sans-serif; background:#fffbe6; padding:20px;'>"
                    + "<div style='max-width:600px; margin:auto; background:#fff; border:1px solid #ffd966; "
                    + "border-radius:10px; padding:25px; box-shadow:0 0 8px rgba(0,0,0,0.08);'>"

                    + "<h2 style='color:#d4ac0d; margin-bottom:15px;'>Book Issue Confirmation</h2>"
                    + "<p>Dear " + userName + ",</p>"
                    + "<p>Your book has been issued successfully. Please find the details below:</p>"

                    + "<table style='width:100%; border-collapse:collapse; font-size:15px; margin-bottom:20px;'>"
                    + "<tr><td style='padding:8px; font-weight:bold;'>Title :</td><td>" + title + "</td></tr>"
                    + "<tr><td style='padding:8px; font-weight:bold;'>Issue Date :</td><td>" + issueDateStr + "</td></tr>"
                    + "<tr><td style='padding:8px; font-weight:bold;'>Due Date :</td><td>" + dueDateStr + "</td></tr>"
                    + "<tr><td style='padding:8px; font-weight:bold;'>Librarian :</td><td>" + librarianName + "</td></tr>"
                    + "</table>";

            if (imgBytes != null && imgBytes.length > 0) {
                htmlMsg += "<div style='text-align:center; margin:20px 0;'>"
                        + "<img src='cid:image_cid' alt='Book Image' style='max-width:180px; border:1px solid #ccc; border-radius:10px;'/>"
                        + "</div>";
            }

            htmlMsg += "<p style='color:#d4ac0d;'>Please make sure to return the book by the due date to avoid fines.</p>"
                    + "<p> Regards,<br><strong>Lilbrio Team</strong></p>"
                    + "</div></div>";

            sendMultipartMail(message, htmlMsg, imgBytes);
            System.out.println("✅ Issue mail sent to " + userEmail);
        }

    // 3. Overdue Mail (Red Theme)
    public static void sendOverdueMail(String userName, String userEmail, String title, byte[] imgBytes, Date issueDate, Date dueDate, String librarianName) throws MessagingException {
        Session session = getSession();
        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(FROM));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(userEmail));
        message.setSubject("📚 Overdue Book Notice - Action Required!");

        String dueDateStr = (dueDate != null) ? new SimpleDateFormat("dd-MM-yyyy").format(dueDate) : "--";
        String issueDateStr = (issueDate != null) ? new SimpleDateFormat("dd-MM-yyyy").format(issueDate) : "--";

        String htmlMsg = "<div style='font-family:Arial,sans-serif; background:#fff3f3; padding:20px;'>"
                + "<div style='max-width:600px; margin:auto; background:#fff; border:1px solid #e0b4b4; "
                + "border-radius:10px; padding:25px; box-shadow:0 0 8px rgba(0,0,0,0.08);'>"

                + "<h2 style='color:#c0392b; margin-bottom:15px;'>Overdue Book Alert</h2>"
                + "<p>Dear " + userName + ",</p>"
                + "<p>Our records show that you have not returned the following book:</p>"

                + "<table style='width:100%; border-collapse:collapse; font-size:15px; margin-bottom:20px;'>"
                + "<tr><td style='padding:8px; font-weight:bold;'>Title :</td><td>" + title + "</td></tr>"
                + "<tr><td style='padding:8px; font-weight:bold;'>Issue Date :</td><td>" + issueDateStr + "</td></tr>"
                + "<tr><td style='padding:8px; font-weight:bold;'>Due Date :</td><td>" + dueDateStr + "</td></tr>"
                + "<tr><td style='padding:8px; font-weight:bold;'>Librarian :</td><td>"+librarianName+"</td></tr>"
                + "<tr><td style='padding:8px; font-weight:bold; color:#c0392b;'>Fine :</td><td>Rs.100</td></tr>"
                + "</table>";

        if (imgBytes != null && imgBytes.length > 0) {
            htmlMsg += "<div style='text-align:center; margin:20px 0;'>"
                    + "<img src='cid:image_cid' alt='Book Image' style='max-width:180px; border:1px solid #ccc; border-radius:10px;'/>"
                    + "</div>";
        }

        htmlMsg += "<p style='color:#c0392b;'>Since the due date has passed, you are required to pay a fine of Rs.100. "
                + "Please return the book and pay the fine immediately.</p>"
                + "<p>Regards,<br><strong>Lilbrio Team</strong></p>"
                + "</div></div>";

        sendMultipartMail(message, htmlMsg, imgBytes);
        System.out.println("✅ Overdue mail sent to " + userEmail);
    }


    private static void sendMultipartMail(Message message, String htmlMsg, byte[] imgBytes) throws MessagingException {
        MimeBodyPart htmlPart = new MimeBodyPart();
        htmlPart.setContent(htmlMsg, "text/html");

        Multipart multipart = new MimeMultipart();
        multipart.addBodyPart(htmlPart);

        if (imgBytes != null && imgBytes.length > 0) {
            MimeBodyPart imagePart = new MimeBodyPart();
            imagePart.setDataHandler(new DataHandler(new ByteArrayDataSource(imgBytes, "image/jpeg")));
            imagePart.setHeader("Content-ID", "<image_cid>");
            imagePart.setDisposition(MimeBodyPart.INLINE);
            multipart.addBodyPart(imagePart);
        }

        message.setContent(multipart);
        Transport.send(message);
    }
}
