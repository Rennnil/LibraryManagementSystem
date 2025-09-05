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
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Borrowed Books</title>
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

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "system");

        String sql1="UPDATE ISSUE_BOOK SET STATUS = 'Overdue' WHERE STATUS != 'Returned' AND SYSDATE > (ISSUE_DATE + 1)";
        ps=con.prepareStatement(sql1);
        ps.executeUpdate();


        String sql = "SELECT IB.ISSUE_ID, IB.LIBRARIAN_ID, IB.BOOK_ID, B.AUTHOR_IMAGE AS IMAGE, B.TITLE, " +
                "IB.ISSUE_DATE, IB.DUE_DATE, IB.STATUS AS BOOK_STATUS, " +
                "U.FNAME || ' ' || U.LNAME AS LIBRARIAN_NAME, RB.RETURN_DATE, " +
                "F.STATUS AS FINE_STATUS, F.AMOUNT AS FINE_AMOUNT " +
                "FROM ISSUE_BOOK IB " +
                "LEFT JOIN BOOK B ON IB.BOOK_ID = B.BOOK_ID " +
                "LEFT JOIN USERS U ON IB.LIBRARIAN_ID = U.USER_ID " +
                "LEFT JOIN RETURN_BOOK RB ON IB.ISSUE_ID = RB.ISSUE_ID " +
                "LEFT JOIN FINE F ON IB.ISSUE_ID = F.ISSUE_ID " +
                "WHERE IB.USER_ID = ?";

        ps = con.prepareStatement(sql);
        ps.setInt(1, userId);
        rs = ps.executeQuery();
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
                    Date issueDate = rs.getDate("ISSUE_DATE");
                    Date dueDate = rs.getDate("DUE_DATE");
                    Date returnDate = rs.getDate("RETURN_DATE");
                    String bookStatus = rs.getString("BOOK_STATUS");
                    String fineStatus = rs.getString("FINE_STATUS");
                    Double fineAmount = rs.getDouble("FINE_AMOUNT");
                    if (rs.wasNull()) fineAmount = 0.0;
                    String librarian = rs.getString("LIBRARIAN_NAME");
                    byte[] imgBytes = rs.getBytes("IMAGE");

                    String imageSrc = "images/no-book.png";
                    if (imgBytes != null && imgBytes.length > 0) {
                        imageSrc = "data:image/jpeg;base64," + Base64.getEncoder().encodeToString(imgBytes);
                    }

                    // Book Status Badge
                    String bookBadge = "badge ";
                    if ("Issued".equalsIgnoreCase(bookStatus)) bookBadge += "bg-warning text-dark";
                    else if ("Returned".equalsIgnoreCase(bookStatus)) bookBadge += "bg-success";
                    else if ("Overdue".equalsIgnoreCase(bookStatus)) bookBadge += "bg-danger";
                    else bookBadge += "bg-secondary";

                    // Fine Status Badge
                    String fineBadge = "badge ";
                    if ("Paid".equalsIgnoreCase(fineStatus)) fineBadge += "bg-success";
                    else if ("Unpaid".equalsIgnoreCase(fineStatus)) fineBadge += "bg-danger";
                    else fineBadge += "bg-secondary";

                    // Insert in Fine table only if not already inserted
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

                            // Forward to OverdueMailServlet to send email
                            request.setAttribute("issueId", issueId);
                            request.setAttribute("userId", userId);
                            request.getRequestDispatcher("OverdueMailServlet").forward(request, response);
                        }
                    }
            %>
            <tr>
                <td><img src="<%= imageSrc %>" alt="Book" class="book-img"></td>
                <td><%= title %></td>
                <td><%= (issueDate != null) ? sdf.format(issueDate) : "--" %></td>
                <td><%= (dueDate != null) ? sdf.format(dueDate) : "--" %></td>
                <td><%= (returnDate != null) ? sdf.format(returnDate) : "--" %></td>
                <td><%= (librarian != null && !librarian.isEmpty()) ? librarian : "--" %></td>
                <td><span class="<%= bookBadge %> px-2 py-1"><%= bookStatus %></span></td>
                <td><span class="<%= fineBadge %> px-2 py-1"><%= (fineStatus != null) ? fineStatus : "--" %></span></td>
                <td>
                    <%
                        if (fineAmount > 0) {
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
                        // Show Return button only for Issued books
                        if ("Issued".equalsIgnoreCase(bookStatus)) {
                    %>
                    <form action="../ReturnBookServlet" method="post" style="display:inline;">
                        <input type="hidden" name="bookId" value="<%= bookId %>">
                        <input type="hidden" name="issueId" value="<%= issueId %>">
                        <button type="submit" class="btn btn-sm btn-outline-primary">Return</button>
                    </form>
                    <%
                    }
                    // Show Pay button only if fine is Unpaid and book is Overdue
                    else if ("Overdue".equalsIgnoreCase(bookStatus) && "Unpaid".equalsIgnoreCase(fineStatus)) {
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


