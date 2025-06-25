<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.PreparedStatement" %><%--
  Created by IntelliJ IDEA.
  User: lakha
  Date: 20-06-2025
  Time: 14:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <!-- Basic Page Info -->
    <meta charset="utf-8" />
    <title>DeskApp - Bootstrap Admin Dashboard HTML Template</title>

    <!-- Site favicon -->
    <link
            rel="apple-touch-icon"
            sizes="180x180"
            href="../vendors/images/apple-touch-icon.png"
    />
    <link
            rel="icon"
            type="image/png"
            sizes="32x32"
            href="../vendors/images/favicon-32x32.png"
    />
    <link
            rel="icon"
            type="image/png"
            sizes="16x16"
            href="../vendors/images/favicon-16x16.png"
    />

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
    <link rel="stylesheet" type="text/css" href="../vendors/styles/core.css" />
    <link
            rel="stylesheet"
            type="text/css"
            href="../vendors/styles/icon-font.min.css"
    />
    <link rel="stylesheet" type="text/css" href="../vendors/styles/style.css" />

    <style>

        .main-body {
            padding: 15px;
        }
        .card {
            box-shadow: 0 1px 3px 0 rgba(0,0,0,.1), 0 1px 2px 0 rgba(0,0,0,.06);
        }

        .card {
            position: relative;
            display: flex;
            flex-direction: column;
            min-width: 0;
            word-wrap: break-word;
            background-color: #ffffff;
            background-clip: border-box;
            border: 0 solid rgba(0,0,0,.125);
            border-radius: .25rem;
        }

        .card-body {
            flex: 1 1 auto;
            min-height: 1px;
            padding: 1rem;
        }

        .gutters-sm {
            margin-right: -8px;
            margin-left: -8px;
        }

        .gutters-sm>.col, .gutters-sm>[class*=col-] {
            padding-right: 8px;
            padding-left: 8px;
        }
        .mb-3, .my-3 {
            margin-bottom: 1rem!important;
        }

        .bg-gray-300 {
            background-color: #e2e8f0;
        }
        .h-100 {
            height: 100%!important;
        }
        .shadow-none {
            box-shadow: none!important;
        }
    </style>

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
            w[l].push({ "gtm.start": new Date().getTime(), event: "gtm.js" });
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

<jsp:include page="HeaderSidebar.jsp" flush="true"></jsp:include>

<div class="main-container">
    <div class="pd-ltr-20 xs-pd-20-10">
        <div class="min-height-200px">
            <div class="page-header">
                <div class="row">
                    <div class="col-md-12 col-sm-12">
                        <div class="title">
                            <h4>Sitemap</h4>
                        </div>
                        <nav aria-label="breadcrumb" role="navigation">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item">
                                    <a href="index.jsp">Home</a>
                                </li>
                                <li class="breadcrumb-item active" aria-current="page">
                                    Sitemap
                                </li>
                            </ol>
                        </nav>
                    </div>
                </div>
            </div>
            <div class="pd-20  mb-30">

                <!-- /Breadcrumb -->
                <%
                    int id=Integer.parseInt(request.getParameter("id"));
                    try {
                        Class.forName("oracle.jdbc.driver.OracleDriver");
                        java.sql.Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "system");
                        String sql = "SELECT * FROM users where USER_ID=?";
                        PreparedStatement pr=con.prepareStatement(sql);
                        pr.setInt(1, id);
                        ResultSet rs = pr.executeQuery();
                        if (rs.next()) {
                            String fname=rs.getString("FNAME");
                            String lname=rs.getString("LNAME");
                            String fullName = fname + " " + lname;
                            String mobile = rs.getString("MOBILE_NO");
                            int roleId = rs.getInt("ROLE_ID");
                            String address = rs.getString("ADDRESS");
                            byte[] imgBytes = rs.getBytes("IMAGE");
                            String base64Image = "";
                            if (imgBytes != null) {
                                base64Image = java.util.Base64.getEncoder().encodeToString(imgBytes);
                            }
                            String imageSrc = "data:image/jpeg;base64," + base64Image;
                %>
                <div class="row gutters-sm">
                    <div class="col-md-4 mb-3">
                        <div class="card">
                            <div class="card-body">
                                <div class="d-flex flex-column align-items-center text-center">
                                    <img src="<%=imageSrc%>" alt="Admin" class="rounded-circle" width="150">
                                    <div class="mt-3">
<%--                                        <h4>Librarian Name</h4>--%>
                                        <p class="text-muted font-size-sm mt-3"><input type="file"></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-8">
                        <div class="card mb-3">
                            <div class="card-body">
                                <div class="row">
                                    <div class="modal-body">
                                        <form method="post" action="EditLibrarian" enctype="multipart/form-data">
                                            <div class="mb-3">
                                                <label for="exampleInputEmail1">First Name</label>
                                                <input type="text" name="fname" value="<%=fname%>" class="form-control">
                                            </div>
                                            <div class="mb-3">
                                                <label for="exampleInputPassword1">Last Name</label>
                                                <input type="text" name="lname" value="<%=lname%>" class="form-control">
                                            </div>
                                            <div class="mb-3">
                                                <label for="exampleInputPassword1">Mobile Number</label>
                                                <input type="text" name="mobile" value="<%=mobile%>" class="form-control">
                                            </div>
                                            <div class="mb-3">
                                                <label for="exampleInputEmail1">Address</label>
                                                <input type="text" name="address" value="<%=address%>" class="form-control">
                                            </div>
                                            <div class="d-flex" style="gap: 20px;">
                                                <input type="submit">
                                                <button type="submit" class="btn btn-primary w-100">Edit Profile</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <%
                        }
                        rs.close();
                        pr.close();
                        con.close();
                    } catch (Exception e) {
                        PrintWriter pw = response.getWriter();
                        pw.println("<tr><td colspan='8'>Error: " + e.getMessage() + "</td></tr>");
                    }
                %>
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
    <!-- Google Tag Manager (noscript) -->
    <noscript
    ><iframe
            src="https://www.googletagmanager.com/ns.html?id=GTM-NXZMQSS"
            height="0"
            width="0"
            style="display: none; visibility: hidden"
    ></iframe
    ></noscript>
    <!-- End Google Tag Manager (noscript) -->
</div>
</body>
</html>



