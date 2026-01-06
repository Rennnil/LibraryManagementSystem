<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="p1.DBConnection" %>
<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: lakha
  Date: 19-06-2025
  Time: 13:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <!-- Basic Page Info -->
    <meta charset="utf-8"/>
    <title>Lilbrio - Bookstore </title>
    <link rel="icon" type="image/png" href="../User/images/Logo.png">

    <!-- Site favicon -->
<%--    <link--%>
<%--            rel="apple-touch-icon"--%>
<%--            sizes="180x180"--%>
<%--            href="../vendors/images/apple-touch-icon.png"--%>
<%--    />--%>
<%--    <link--%>
<%--            rel="icon"--%>
<%--            type="image/png"--%>
<%--            sizes="32x32"--%>
<%--            href="../vendors/images/favicon-32x32.png"--%>
<%--    />--%>
<%--    <link--%>
<%--            rel="icon"--%>
<%--            type="image/png"--%>
<%--            sizes="16x16"--%>
<%--            href="../vendors/images/favicon-16x16.png"--%>
<%--    />--%>

    <!-- Mobile Specific Metas -->
    <meta
            name="viewport"
            content="width=device-width, initial-scale=1, maximum-scale=1"
    />

    <!-- Google Font -->
    <link
            href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap"
            rel="stylesheet"
    />
    <!-- CSS -->
    <link rel="stylesheet" type="text/css" href="../vendors/styles/core.css"/>
    <link
            rel="stylesheet"
            type="text/css"
            href="../vendors/styles/icon-font.min.css"
    />
    <link
            rel="stylesheet"
            type="text/css"
            href="../src/plugins/datatables/css/dataTables.bootstrap4.min.css"
    />
    <link
            rel="stylesheet"
            type="text/css"
            href="../src/plugins/datatables/css/responsive.bootstrap4.min.css"
    />
    <link rel="stylesheet" type="text/css" href="../vendors/styles/style.css"/>

    <!-- Global site tag (gtag.js) - Google Analytics -->
    <script
            async
            src="https://www.googletagmanager.com/gtag/js?id=G-GBZ3SGGX85"
    ></script>
    <script
            async
            src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js?client=ca-pub-2973766580778258"
            crossorigin="anonymous"
    ></script>
    <script>
        window.dataLayer = window.dataLayer || [];

        function gtag() {
            dataLayer.push(arguments);
        }

        gtag("js", new Date());

        gtag("config", "G-GBZ3SGGX85");
    </script>
    <!-- Google Tag Manager -->
    <script>
        (function (w, d, s, l, i) {
            w[l] = w[l] || [];
            w[l].push({"gtm.start": new Date().getTime(), event: "gtm.js"});
            var f = d.getElementsByTagName(s)[0],
                j = d.createElement(s),
                dl = l != "dataLayer" ? "&l=" + l : "";
            j.async = true;
            j.src = "https://www.googletagmanager.com/gtm.js?id=" + i + dl;
            f.parentNode.insertBefore(j, f);
        })(window, document, "script", "dataLayer", "GTM-NXZMQSS");
    </script>
    <!-- End Google Tag Manager -->
</head>
<body>

<jsp:include page="HeaderSideBar.jsp" flush="true"></jsp:include>

<%@ page import="java.sql.*,java.text.DecimalFormat,java.io.*" %>
<%@ page import="p1.DBConnection" %>

<%
    PrintWriter pw = response.getWriter();
    int totalBooks = 0, issuedBooks = 0, returnedBooks = 0;
    double totalFines = 0.0;
    DecimalFormat df = new DecimalFormat("#,##0.00");

    Integer librarianId = (Integer) session.getAttribute("userId");

    if (librarianId == null) {
        pw.println("<h3 style='color:red'>Session expired! Please <a href='../login.jsp'>login</a> again.</h3>");
        return;
    }

    try {
        Connection con = DBConnection.getConnection();
        PreparedStatement ps;
        ResultSet rs;

        // Total Books added by librarian
        ps = con.prepareStatement("SELECT COUNT(*) FROM BOOK WHERE USER_ID=?");
        ps.setInt(1,librarianId);
        rs = ps.executeQuery();
        if (rs.next()) totalBooks = rs.getInt(1);
        rs.close(); ps.close();

        // Issued Books processed by librarian
        ps = con.prepareStatement("SELECT COUNT(*) FROM ISSUE_BOOK WHERE STATUS='Issued' AND LIBRARIAN_ID=?");
        ps.setInt(1,librarianId);
        rs = ps.executeQuery();
        if (rs.next()) issuedBooks = rs.getInt(1);
        rs.close(); ps.close();

        // Returned Books processed by librarian
        ps = con.prepareStatement("SELECT COUNT(*) FROM ISSUE_BOOK WHERE STATUS='Returned' AND LIBRARIAN_ID=?");
        ps.setInt(1,librarianId);
        rs = ps.executeQuery();
        if (rs.next()) returnedBooks = rs.getInt(1);
        rs.close(); ps.close();

        // Total fines recorded by librarian
        ps = con.prepareStatement("SELECT NVL(SUM(AMOUNT),0) FROM FINE WHERE LIBRARIAN_ID=?");
        ps.setInt(1,librarianId);
        rs = ps.executeQuery();
        if (rs.next()) totalFines = rs.getDouble(1);
        rs.close(); ps.close();

        con.close();
    } catch (Exception e) {
        pw.println("<h3 style='color:red'>Error fetching dashboard data: " + e.getMessage() + "</h3>");
    }
%>

<div class="main-container">
    <div class="xs-pd-20-10 pd-ltr-20">
        <div class="title pb-20"><h2 class="h3 mb-0">Library Overview</h2></div>
        <div class="row pb-10">
            <!-- Total Books -->
            <div class="col-xl-3 col-lg-3 col-md-6 mb-20">
                <div class="card-box height-100-p widget-style3">
                    <div class="d-flex flex-wrap">
                        <div class="widget-data">
                            <div class="weight-700 font-24 text-dark"><%= totalBooks %></div>
                            <div class="font-14 text-secondary weight-500">Total Books</div>
                        </div>
                        <div class="widget-icon"><i class="icon-copy ti-book"></i></div>
                    </div>
                </div>
            </div>
            <!-- Issued Books -->
            <div class="col-xl-3 col-lg-3 col-md-6 mb-20">
                <div class="card-box height-100-p widget-style3">
                    <div class="d-flex flex-wrap">
                        <div class="widget-data">
                            <div class="weight-700 font-24 text-dark"><%= issuedBooks %></div>
                            <div class="font-14 text-secondary weight-500">Issued Books</div>
                        </div>
                        <div class="widget-icon"><i class="icon-copy ti-export"></i></div>
                    </div>
                </div>
            </div>
            <!-- Returned Books -->
            <div class="col-xl-3 col-lg-3 col-md-6 mb-20">
                <div class="card-box height-100-p widget-style3">
                    <div class="d-flex flex-wrap">
                        <div class="widget-data">
                            <div class="weight-700 font-24 text-dark"><%= returnedBooks %></div>
                            <div class="font-14 text-secondary weight-500">Returned Books</div>
                        </div>
                        <div class="widget-icon"><i class="icon-copy ti-import"></i></div>
                    </div>
                </div>
            </div>
            <!-- Total Fines -->
            <div class="col-xl-3 col-lg-3 col-md-6 mb-20">
                <div class="card-box height-100-p widget-style3">
                    <div class="d-flex flex-wrap">
                        <div class="widget-data">
                            <div class="weight-700 font-24 text-dark">₹<%= df.format(totalFines) %></div>
                            <div class="font-14 text-secondary weight-500">Total Fines</div>
                        </div>
                        <div class="widget-icon"><i class="icon-copy fa fa-money"></i></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- welcome modal start -->


<!-- welcome modal end -->
<!-- js -->
<script src="../vendors/scripts/core.js"></script>
<script src="../vendors/scripts/script.min.js"></script>
<script src="../vendors/scripts/process.js"></script>
<script src="../vendors/scripts/layout-settings.js"></script>
<script src="../src/plugins/apexcharts/apexcharts.min.js"></script>
<script src="../src/plugins/datatables/js/jquery.dataTables.min.js"></script>
<script src="../src/plugins/datatables/js/dataTables.bootstrap4.min.js"></script>
<script src="../src/plugins/datatables/js/dataTables.responsive.min.js"></script>
<script src="../src/plugins/datatables/js/responsive.bootstrap4.min.js"></script>
<script src="../vendors/scripts/dashboard3.js"></script>
<!-- Google Tag Manager (noscript) -->
<noscript
>
    <iframe
            src="https://www.googletagmanager.com/ns.html?id=GTM-NXZMQSS"
            height="0"
            width="0"
            style="display: none; visibility: hidden"
    ></iframe
    >
</noscript>
<!-- End Google Tag Manager (noscript) -->
</body>
</html>

