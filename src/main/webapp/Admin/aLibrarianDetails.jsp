<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.*" %>
<%@ page import="p1.DBConnection" %>
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
    <link rel="stylesheet" type="text/css" href="../vendors/styles/style.css"/>

    <style>

        .main-body {
            padding: 15px;
        }

        .card {
            box-shadow: 0 1px 3px 0 rgba(0, 0, 0, .1), 0 1px 2px 0 rgba(0, 0, 0, .06);
        }

        .card {
            position: relative;
            display: flex;
            flex-direction: column;
            min-width: 0;
            word-wrap: break-word;
            background-color: #ffffff;
            background-clip: border-box;
            border: 0 solid rgba(0, 0, 0, .125);
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

        .gutters-sm > .col, .gutters-sm > [class*=col-] {
            padding-right: 8px;
            padding-left: 8px;
        }

        .mb-3, .my-3 {
            margin-bottom: 1rem !important;
        }

        .bg-gray-300 {
            background-color: #e2e8f0;
        }

        .h-100 {
            height: 100% !important;
        }

        .shadow-none {
            box-shadow: none !important;
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

<div class="main-container">
    <div class="pd-ltr-20 xs-pd-20-10">
        <div class="min-height-200px">
            <div class="page-header">
                <div class="row">
                    <div class="col-md-12 col-sm-12">
                        <div class="title">
                            <h4>Librarian Details</h4>
                        </div>
                        <nav aria-label="breadcrumb" role="navigation">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item">
                                    <a href="index.jsp">Home</a>
                                </li>
                                <li class="breadcrumb-item active" aria-current="page">
                                    Librarian Details
                                </li>
                            </ol>
                        </nav>
                    </div>
                </div>
            </div>
            <div class="pd-20  mb-30">


                <!-- /Breadcrumb -->

                <div class="row gutters-sm">
                    <%
                        int id = Integer.parseInt(request.getParameter("id"));
                        try {
                            Connection con= DBConnection.getConnection();
                            String sql = "SELECT * FROM users where USER_ID=? ";
                            PreparedStatement pr = con.prepareStatement(sql);
                            pr.setInt(1, id);
                            ResultSet rs = pr.executeQuery();

                            if (rs.next()) {
                                String fullName = rs.getString("FNAME") + " " + rs.getString("LNAME");
                                String email = rs.getString("EMAIL");
                                String password = rs.getString("password");
                                String mobile = rs.getString("MOBILE_NO");
                                String gender = rs.getString("GENDER");
                                int roleId = rs.getInt("ROLE_ID");
                                String address = rs.getString("ADDRESS");
                                byte[] imgBytes = rs.getBytes("IMAGE");
                                String base64Image = java.util.Base64.getEncoder().encodeToString(imgBytes);
                                String UserImage = "data:image/jpeg;base64," + base64Image;
                                java.sql.Date createdAt = rs.getDate("CREATED_AT");
                    %>
                    <div class="col-md-4 mb-3">
                        <div class="card">
                            <div class="card-body">
                                <div class="d-flex flex-column align-items-center text-center">
                                    <img src="<%=UserImage%>" alt="Admin"
                                         class="rounded-circle" width="150">
                                    <div class="mt-3">
                                        <h4><%=fullName%>
                                        </h4>

                                        <p class="text-muted font-size-sm mt-3">Bay Area, San Francisco, CA</p>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-8">
                        <div class="card mb-3">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-sm-3">
                                        <h6 class="mb-0">Email</h6>
                                    </div>
                                    <div class="col-sm-9 text-secondary">
                                        <%=email%>
                                    </div>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="col-sm-3">
                                        <h6 class="mb-0">Password</h6>
                                    </div>
                                    <div class="col-sm-9 text-secondary">
                                        <%=password%>
                                    </div>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="col-sm-3">
                                        <h6 class="mb-0">Phone</h6>
                                    </div>
                                    <div class="col-sm-9 text-secondary">
                                        <%=mobile%>
                                    </div>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="col-sm-3">
                                        <h6 class="mb-0">Address</h6>
                                    </div>
                                    <div class="col-sm-9 text-secondary">
                                        <%=address%>
                                    </div>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="col-sm-3">
                                        <h6 class="mb-0">Join Date</h6>
                                    </div>
                                    <div class="col-sm-9 text-secondary">
                                        <%=createdAt%>
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
</div>
</body>
</html>
