<%@ page import="java.io.PrintWriter" %>
<%@ page import="p1.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.Base64" %>
<!DOCTYPE html>
<html>
<head>
    <!-- Basic Page Info -->
    <meta charset="utf-8"/>
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
    <link rel="stylesheet" type="text/css" href="../vendors/styles/core.css"/>
    <link
            rel="stylesheet"
            type="text/css"
            href="../vendors/styles/icon-font.min.css"
    />
    <link
            rel="stylesheet"
            type="text/css"
            href="../src/plugins/cropperjs/dist/cropper.css"
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
            <%
                PrintWriter pw=response.getWriter();
                String sessionFname = (String) session.getAttribute("userName"); // from LoginServlet

                if (sessionFname == null) {
                    pw.println("<h3>Please login first.</h3>");
                } else {
                    try {
                        Class.forName("oracle.jdbc.driver.OracleDriver");
                        java.sql.Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "system");

                        String sql = "SELECT * FROM users WHERE FNAME = ?";
                        PreparedStatement ps = con.prepareStatement(sql);
                        ps.setString(1, sessionFname);
                        ResultSet rs = ps.executeQuery();

                        if (rs.next()) {
                            int userId = rs.getInt("USER_ID");
                            String fname = rs.getString("FNAME");
                            String lname = rs.getString("LNAME");
                            String fullName = fname + " " + lname;
                            String email = rs.getString("EMAIL");
                            String mobile = rs.getString("MOBILE_NO");
                            int roleId = rs.getInt("ROLE_ID");
                            String address = rs.getString("ADDRESS");

                            byte[] imgBytes = rs.getBytes("IMAGE");
                            String imageSrc;
                            if (imgBytes != null && imgBytes.length > 0) {
                                String base64Image = Base64.getEncoder().encodeToString(imgBytes);
                                imageSrc = "data:image/jpeg;base64," + base64Image;
                            } else {
                                imageSrc = request.getContextPath() + "/vendors/images/default-avatar.png"; // fallback image
                            }
            %>
            <div class="pd-20  mb-30">
                <!-- /Breadcrumb -->
                <div class="row gutters-sm">
                    <div class="col-md-4 mb-3">
                        <div class="card">
                            <div class="card-body">
                                <div class="d-flex flex-column align-items-center text-center">
                                    <img src="<%=imageSrc%>" alt="Admin"
                                         class="rounded-circle" width="200">
                                    <div class="mt-3">
                                        <h4><%=fullName%></h4>
<%--                                        <p class="text-muted font-size-sm mt-3">Bay Area, San Francisco, CA</p>--%>
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
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%

                        }
                        rs.close();
                        ps.close();
                        con.close();
                    } catch (Exception e) {
                        pw.println("<tr><td colspan='8'>Error: " + e.getMessage() + "</td></tr>");
                    }
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
<script src="../src/plugins/cropperjs/dist/cropper.js"></script>
<script>
    window.addEventListener("DOMContentLoaded", function () {
        var image = document.getElementById("image");
        var cropBoxData;
        var canvasData;
        var cropper;

        $("#modal")
            .on("shown.bs.modal", function () {
                cropper = new Cropper(image, {
                    autoCropArea: 0.5,
                    dragMode: "move",
                    aspectRatio: 3 / 3,
                    restore: false,
                    guides: false,
                    center: false,
                    highlight: false,
                    cropBoxMovable: false,
                    cropBoxResizable: false,
                    toggleDragModeOnDblclick: false,
                    ready: function () {
                        cropper.setCropBoxData(cropBoxData).setCanvasData(canvasData);
                    },
                });
            })
            .on("hidden.bs.modal", function () {
                cropBoxData = cropper.getCropBoxData();
                canvasData = cropper.getCanvasData();
                cropper.destroy();
            });
    });
</script>
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
