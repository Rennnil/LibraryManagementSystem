<%--
  Created by IntelliJ IDEA.
  User: lakha
  Date: 17-07-2025
  Time: 12:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Base64" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="javax.mail.MessagingException" %>
<%@ page import="p1.LibraryMailUtil" %>
<%@ page import="p1.GetBookDetails" %>
<%@ page import="p1.GetBookDetails" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Lilbrio - Bookstore </title>
    <link rel="icon" type="image/png" href="../User/images/Logo.png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <style>
        .table-container {
            background: #fff;
            border-radius: 12px;
            padding: 20px;
            margin: 40px auto;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
            max-width: 1150px;
        }
        th, td {
            background-clip: padding-box;
            text-align: center !important;
            vertical-align: middle !important;
            font-size: 14px;
        }
        th {
            background-color: #ff6b6b !important;
            color: #fff !important;
            font-weight: 600;
        }
        .book-img {
            width: 50px;
            height: 50px;
            object-fit: cover;
            border-radius: 5px;
        }
        .fa-download {
            color: #ff6b6b;
            font-size: 18px;
        }
        .fa-download:hover {
            color: #d9534f;
        }
        .btn-sm {
            font-size: 13px;
            padding: 4px 10px;
            border-radius: 20px;
        }
    </style>
</head>
<body>

<jsp:include page="Header.jsp" flush="true"></jsp:include>

<%
    PrintWriter pw = response.getWriter();
    HttpSession session1 = request.getSession(false);
    Integer userId = (session1 != null) ? (Integer) session1.getAttribute("userId") : null;

    if (userId == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    boolean refreshNeeded = false;   // ✅ flag for re-fetch

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "system");

        // ✅ Update Overdue
        String sql1 = "UPDATE ISSUE_BOOK SET STATUS = 'Overdue' " +
                "WHERE STATUS != 'Returned' AND SYSDATE > (ISSUE_DATE + 1)";
        ps = con.prepareStatement(sql1);
        ps.executeUpdate();
        ps.close();

        // ✅ Initial fetch
        rs = GetBookDetails.getBorrowedBooks(userId);

        // ✅ First loop (only check overdue & insert fines, no display)
        while (rs.next()) {
            int issueId = rs.getInt("ISSUE_ID");
            int librarianId = rs.getInt("LIBRARIAN_ID");
            String bookStatus = rs.getString("BOOK_STATUS");
            String fineStatus = rs.getString("FINE_STATUS");
            String librarianName = rs.getString("LIBRARIAN_NAME");
            String userEmail = rs.getString("USER_EMAIL");
            String userName = rs.getString("USER_NAME");
            String title = rs.getString("TITLE");
            java.sql.Date issueDate = rs.getDate("ISSUE_DATE");
            java.sql.Date dueDate = rs.getDate("DUE_DATE");
            byte[] imgBytes = rs.getBytes("IMAGE");

            if ("Overdue".equalsIgnoreCase(bookStatus)) {
                String checkSql = "SELECT COUNT(*) FROM FINE WHERE ISSUE_ID = ?";
                PreparedStatement checkPs = con.prepareStatement(checkSql);
                checkPs.setInt(1, issueId);
                ResultSet checkRs = checkPs.executeQuery();

                boolean exists = false;
                if (checkRs.next()) {
                    exists = (checkRs.getInt(1) > 0);
                }
                checkRs.close();
                checkPs.close();

                if (!exists) {
                    // Insert Fine
                    int amount = 100;
                    String status = "Unpaid";
                    String sql2 = "INSERT INTO FINE (FINE_ID, USER_ID, ISSUE_ID, AMOUNT, STATUS, LIBRARIAN_ID) " +
                            "VALUES (FINE_SEQ.nextval, ?, ?, ?, ?, ?)";
                    PreparedStatement insertPs = con.prepareStatement(sql2);
                    insertPs.setInt(1, userId);
                    insertPs.setInt(2, issueId);
                    insertPs.setInt(3, amount);
                    insertPs.setString(4, status);
                    insertPs.setInt(5, librarianId);
                    insertPs.executeUpdate();
                    insertPs.close();

                    // Send Mail
                    try {
                        LibraryMailUtil.sendOverdueMail(userName, userEmail, title, imgBytes, issueDate, dueDate, librarianName);
                        System.out.println("📧 Overdue mail sent to " + userEmail);
                    } catch (MessagingException me) {
                        me.printStackTrace();
                    }

                    refreshNeeded = true; // ✅ set flag
                }
            }
        }
        rs.close();

        if (refreshNeeded) {
            rs = GetBookDetails.getBorrowedBooks(userId);
        } else {
            rs = GetBookDetails.getBorrowedBooks(userId);
        }

        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
%>

<div class="container table-container">
    <h4 class="mb-3 text-center">
        <i class="fa-solid fa-book-open-reader text-danger me-2"></i> Borrowed Books
    </h4>
    <div class="table-responsive">
        <table class="table table-bordered table-sm align-middle text-center">
            <thead>
            <tr>
                <th>Book Image</th>
                <th>Book Title</th>
                <th>Issue Date</th>
                <th>Due Date</th>
                <th>Return Date</th>
                <th>Librarian</th>
                <th>Book Status</th>
                <th>Fine Status</th>
                <th>Invoice</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody>
            <%
                boolean hasData = false;
                while (rs.next()) {
                    hasData = true;

                    int issueId = rs.getInt("ISSUE_ID");
                    int bookId = rs.getInt("BOOK_ID");
                    int librarianId = rs.getInt("LIBRARIAN_ID");
                    String title = rs.getString("TITLE");
                    java.sql.Date issueDate = rs.getDate("ISSUE_DATE");
                    java.sql.Date dueDate = rs.getDate("DUE_DATE");
                    java.sql.Date returnDate = rs.getDate("RETURN_DATE");
                    String bookStatus = rs.getString("BOOK_STATUS");
                    String fineStatus = rs.getString("FINE_STATUS");
                    String librarian = rs.getString("LIBRARIAN_NAME");
                    byte[] imgBytes = rs.getBytes("IMAGE");

                    String imageSrc = "images/no-book.png";
                    if (imgBytes != null && imgBytes.length > 0) {
                        imageSrc = "data:image/jpeg;base64," + Base64.getEncoder().encodeToString(imgBytes);
                    }

                    String bookBadge = "badge ";
                    if ("Issued".equalsIgnoreCase(bookStatus)) bookBadge += "bg-warning text-dark";
                    else if ("Returned".equalsIgnoreCase(bookStatus)) bookBadge += "bg-success";
                    else if ("Overdue".equalsIgnoreCase(bookStatus)) bookBadge += "bg-danger";
                    else bookBadge += "bg-secondary";

                    String fineBadge = "badge ";
                    if ("Paid".equalsIgnoreCase(fineStatus)) fineBadge += "bg-success";
                    else if ("Unpaid".equalsIgnoreCase(fineStatus)) fineBadge += "bg-danger";
                    else fineBadge += "bg-secondary";
            %>
            <tr>
                <td><img src="<%= imageSrc %>" alt="Book" class="book-img"></td>
                <td>
                    <%
                        String displayTitle = title;
                        if (title != null && title.length() > 15) {
                            displayTitle = title.substring(0, 15) + "...";
                        }
                    %>
                    <%= displayTitle %>
                </td>
<%--                <td><%= title %></td>--%>
                <td><%= (issueDate != null) ? sdf.format(issueDate) : "--" %></td>
                <td><%= (dueDate != null) ? sdf.format(dueDate) : "--" %></td>
                <td><%= (returnDate != null) ? sdf.format(returnDate) : "--" %></td>
                <td><%= (librarian != null && !librarian.isEmpty()) ? librarian : "--" %></td>
                <td><span class="<%= bookBadge %> px-2 py-1"><%= bookStatus %></span></td>
                <td><span class="<%= fineBadge %> px-2 py-1"><%= (fineStatus != null) ? fineStatus : "--" %></span></td>
                <td>
                    <%
                        if ("Paid".equalsIgnoreCase(fineStatus)) {
                    %>
                    <a href="../Payment/Reciept.jsp?issueId=<%= issueId %>">
                        <i class="fa-solid fa-download"></i>
                    </a>
                    <%
                    } else {
                    %>
                    <span class="text-muted">—</span>
                    <%
                        }
                    %>
                </td>
                <td>
                    <%
                        if ("Issued".equalsIgnoreCase(bookStatus)) {
                    %>
                    <form action="../ReturnBookServlet" method="post" style="display:inline;">
                        <input type="hidden" name="bookId" value="<%= bookId %>">
                        <input type="hidden" name="issueId" value="<%= issueId %>">
                        <button type="submit" class="btn btn-sm btn-outline-primary">Return</button>
                    </form>
                    <%
                    } else if ("Overdue".equalsIgnoreCase(bookStatus) && "Unpaid".equalsIgnoreCase(fineStatus)) {
                    %>
                    <form action="../Payment/Card.jsp" method="post" style="display:inline;">
                        <input type="hidden" name="bookId" value="<%= bookId %>">
                        <input type="hidden" name="issueId" value="<%= issueId %>">
                        <input type="hidden" name="librarianId" value="<%= librarianId %>">
                        <input type="hidden" name="userId" value="<%= userId %>">
                        <button type="submit" class="btn btn-sm btn-outline-danger">Pay</button>
                    </form>
                    <%
                    } else {
                    %>
                    <span class="text-muted">—</span>
                    <%
                        }
                    %>
                </td>
            </tr>
            <%
                }

                if (!hasData) {
            %>
            <tr>
                <td colspan="10" class="text-center text-muted">No borrowed books yet.</td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
</div>

<%
    } catch (Exception e) {
        pw.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
        e.printStackTrace();
    } finally {
        if(rs != null) rs.close();
        if(ps != null) ps.close();
        if(con != null) con.close();
    }
%>



</body>
</html>


