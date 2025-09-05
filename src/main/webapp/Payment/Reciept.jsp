<%@ page import="java.sql.*" %>
<%@ page import="java.io.PrintWriter" %><%--
  Created by IntelliJ IDEA.
  User: lakha
  Date: 31-08-2025
  Time: 16:12
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Lilbrio - Payment Invoice</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@4.4.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="shortcut icon" href="../assets/images/favicon.ico">

    <style type="text/css">
        body {
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            color: #484b51;
            background-color: #f8f9fa;
        }

        .page-content {
            box-shadow: rgba(100, 100, 111, 0.2) 0px 7px 29px 0px;
            padding: 20px;
            background-color: #fff;
        }

        .page-header {
            margin: 0 0 1rem;
            padding-bottom: 1rem;
            padding-top: .5rem;
            border-bottom: 1px dotted #e2e2e2;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header-left {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .header-left img {
            height: 40px;
        }
    </style>
</head>
<body>
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet"/>
<div class="container page-content" id="invoice">
    <div class="page-header">
        <div class="header-left">
            <!-- Replace src with your logo path -->
            <img src="../vendors/images/Logo.png" alt="Lilbrio Logo">
        </div>
        <div class="page-tools">
            <div class="action-buttons">
                <!-- Download Button -->
                <a class="btn btn-light mx-1px" href="#" onclick="downloadInvoice()">
                    <i class="fa fa-download text-success"></i>
                </a>
                <a class="btn btn-light mx-1px" href="../User/BorrowedBooks.jsp">
                    <i class="fa fa-times text-danger"></i>
                </a>
            </div>
        </div>
    </div>

    <div class="container px-0">
        <div class="row mt-4">
            <div class="col-12 col-lg-12">
                <%
                    PrintWriter pw = response.getWriter();
                    String issueId = request.getParameter("issueId");
                    if(issueId != null){
                        Connection con = null;
                        PreparedStatement ps = null;
                        ResultSet rs = null;
                        try{
                            Class.forName("oracle.jdbc.driver.OracleDriver");
                            con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","system","system");

                            String sql = "SELECT u.FNAME, u.LNAME, u.EMAIL, u.MOBILE_NO, " +
                                    "b.TITLE, b.AUTHOR, b.PUBLISHER, b.AUTHOR_IMAGE, " +
                                    "i.ISSUE_DATE, f.AMOUNT, f.STATUS, " +
                                    "lu.FNAME || ' ' || lu.LNAME AS LIBRARIAN_NAME " + // ✅ Librarian Name
                                    "FROM ISSUE_BOOK i " +
                                    "JOIN USERS u ON i.USER_ID = u.USER_ID " +
                                    "JOIN BOOK b ON i.BOOK_ID = b.BOOK_ID " +
                                    "LEFT JOIN FINE f ON i.ISSUE_ID = f.ISSUE_ID " +
                                    "JOIN USERS lu ON i.LIBRARIAN_ID = lu.USER_ID " + // ✅ Join Librarian
                                    "WHERE i.ISSUE_ID=?";
                            ps = con.prepareStatement(sql);
                            ps.setInt(1, Integer.parseInt(issueId));
                            rs = ps.executeQuery();

                            if(rs.next()){
                                String username = rs.getString("FNAME")+" "+rs.getString("LNAME");
                                String email = rs.getString("EMAIL");
                                String mobile = rs.getString("MOBILE_NO");
                                String bookTitle = rs.getString("TITLE");
                                double amount = rs.getDouble("AMOUNT");
                                Date issueDate = rs.getDate("ISSUE_DATE");
                                String librarianName = rs.getString("LIBRARIAN_NAME"); // ✅ Fetch Librarian
                                byte[] imgBytes = rs.getBytes("AUTHOR_IMAGE");
                                String imageSrc = (imgBytes != null)
                                        ? "data:image/jpeg;base64,"+java.util.Base64.getEncoder().encodeToString(imgBytes)
                                        : "../vendors/images/no-book.png";
                %>

                <!-- USER INFO -->
                <div class="row">
                    <div class="col-sm-6">
                        <div><b>User :</b> <%= username %></div>
                        <div><b>Mobile :</b> <%= mobile %></div>
                    </div>
                    <div class="col-sm-6 text-right">
                        <div><b>Invoice ID :</b> <%= issueId %></div>
                        <div><b>Issue Date :</b> <%= issueDate %></div>
                    </div>
                </div>

                <!-- BOOK DETAILS -->
                <div class="mt-4">
                    <div class="row py-2 text-white" style="background-color:#ff6b6b;">
                        <div class="col-1">#</div>
                        <div class="col-2">Image</div>
                        <div class="col-4">Book Name</div>
                        <div class="col-2">Librarian</div> <!-- ✅ Librarian Column -->
                        <div class="col-1">Qty</div>
                        <div class="col-2">Amount</div>
                    </div>
                    <div class="row py-2 border-bottom">
                        <div class="col-1">1</div>
                        <div class="col-2">
                            <img src="<%= imageSrc %>" alt="Book Image" height="50">
                        </div>
                        <div class="col-4"><%= bookTitle %></div>
                        <div class="col-2"><%= librarianName %></div> <!-- ✅ Display Librarian -->
                        <div class="col-1">1</div>
                        <div class="col-2">₹<%= amount %></div>
                    </div>

                    <!-- USER CONTACT -->
                    <div class="row mt-4">
                        <div class="col-sm-6">
                            <div><b>Contact Us :</b> managelibrary01@gmail.com</div>
                        </div>
                        <div class="col-sm-6 text-right">
                            <div><b>Total :</b> ₹<%= amount %></div>
                        </div>
                    </div>
                </div>

                <%
                            } else {
                                pw.println("<p class='text-danger'>No data found for Issue ID "+issueId+"</p>");
                            }
                        } catch(Exception e){
                            e.printStackTrace();
                            pw.println("<p class='text-danger'>Error: "+e.getMessage()+"</p>");
                        } finally {
                            if(rs!=null) try{rs.close();}catch(Exception ex){}
                            if(ps!=null) try{ps.close();}catch(Exception ex){}
                            if(con!=null) try{con.close();}catch(Exception ex){}
                        }
                    } else {
                        pw.println("<p class='text-danger'>Issue ID missing!</p>");
                    }
                %>
            </div>
        </div>
    </div>


</div>

<!-- html2pdf library -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>

<script>
    function downloadInvoice() {
        const element = document.getElementById('invoice');
        const opt = {
            margin: 0.5,
            filename: 'Invoice.pdf',
            image: {type: 'jpeg', quality: 0.98},
            html2canvas: {scale: 2},
            jsPDF: {unit: 'in', format: 'a4', orientation: 'portrait'}
        };
        html2pdf().set(opt).from(element).save();
    }
</script>
</body>
</html>
