<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.io.PrintWriter" %>
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
    <link rel="stylesheet" type="text/css" href="../vendors/styles/style.css"/>

    <style>
        .ag-format-container {
            width: 1142px;
            margin: 0 auto;
        }

        .ag-courses_box {
            width: 1200px;
            display: -webkit-box;
            display: -ms-flexbox;
            display: flex;
            -webkit-box-align: start;
            -ms-flex-align: start;
            align-items: flex-start;
            -ms-flex-wrap: wrap;
            flex-wrap: wrap;

            padding: 50px 0;
        }

        .ag-courses_item {
            -ms-flex-preferred-size: calc(33.33333% - 30px);
            flex-basis: calc(33.33333% - 30px);

            margin: 0 15px 30px;

            overflow: hidden;

            border-radius: 28px;
        }

        .ag-courses-item_link {
            display: block;
            padding: 30px 20px;
            background-color: #121212;

            overflow: hidden;

            position: relative;
        }

        .ag-courses-item_link:hover,
        .ag-courses-item_link:hover .ag-courses-item_date {
            text-decoration: none;
            color: #fff;
        }

        .ag-courses-item_link:hover .ag-courses-item_bg {
            -webkit-transform: scale(10);
            -ms-transform: scale(10);
            transform: scale(10);
        }

        .ag-courses-item_title {
            min-height: 55px;
            margin: 0px;

            overflow: hidden;

            font-weight: bold;
            font-size: 24px;
            color: #fff;

            z-index: 2;
            position: relative;
        }

        .ag-courses-item_date-box {
            font-size: 18px;
            color: #fff;

            z-index: 2;
            position: relative;
        }

        .ag-courses-item_date {
            font-weight: bold;
            color: #f9b234;

            -webkit-transition: color 0.5s ease;
            -o-transition: color 0.5s ease;
            transition: color 0.5s ease;
        }

        .ag-courses-item_bg {
            height: 128px;
            width: 128px;
            background-color: #f9b234;

            z-index: 1;
            position: absolute;
            top: -75px;
            right: -75px;

            border-radius: 50%;

            -webkit-transition: all 0.5s ease;
            -o-transition: all 0.5s ease;
            transition: all 0.5s ease;
        }

        .ag-courses_item:nth-child(2n) .ag-courses-item_bg {
            background-color: #3ecd5e;
        }

        .ag-courses_item:nth-child(3n) .ag-courses-item_bg {
            background-color: #04ebad;
        }

        .ag-courses_item:nth-child(4n) .ag-courses-item_bg {
            background-color: #952aff;
        }

        .ag-courses_item:nth-child(5n) .ag-courses-item_bg {
            background-color: #cd3e94;
        }

        .ag-courses_item:nth-child(6n) .ag-courses-item_bg {
            background-color: #4c49ea;
        }

        @media only screen and (max-width: 979px) {
            .ag-courses_item {
                -ms-flex-preferred-size: calc(50% - 30px);
                flex-basis: calc(50% - 30px);
            }

            .ag-courses-item_title {
                font-size: 24px;
            }
        }

        @media only screen and (max-width: 767px) {
            .ag-format-container {
                width: 96%;
            }
        }

        @media only screen and (max-width: 639px) {
            .ag-courses_item {
                -ms-flex-preferred-size: 100%;
                flex-basis: 100%;
            }

            .ag-courses-item_title {
                min-height: 72px;
                line-height: 1;

                font-size: 20px;
            }

            .ag-courses-item_link {
                padding: 22px 40px;
            }

            .ag-courses-item_date-box {
                font-size: 16px;
            }
        }

        .course-img-cover {
            height: 200px; /* Set the desired height */
            width: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
            overflow: hidden; /* Ensure the image doesn't overflow */
        }

        .course-img {
            width: 100%; /* Ensure the image fills the entire width of the container */
            height: 100%; /* Ensure the image fills the entire height of the container */
            object-fit: cover; /* Scale the image while preserving its aspect ratio */
        }

        .fac-img-cover {
            position: absolute;
            height: 70px;
            width: 70px;
            bottom: 10px;
            right: 10px;
            /* border: transparent; */
            border-radius: 50%;
            overflow: hidden;
        }

        .fac-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .ag-courses-item_date-box:last-child {
            margin-top: 10px;
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
                            <h4>Product</h4>
                        </div>
                        <nav aria-label="breadcrumb" role="navigation">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item">
                                    <a href="index.jsp">Home</a>
                                </li>
                                <li class="breadcrumb-item active" aria-current="page">
                                    Product
                                </li>
                            </ol>
                        </nav>
                    </div>
                </div>
            </div>

            <div class="product-wrap">
                <div class="product-list">
                    <ul class="row">
                        <%
                            try {
                                Class.forName("oracle.jdbc.driver.OracleDriver");
                                java.sql.Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "system");
                                Statement st=con.createStatement();
                                String sql = "SELECT * FROM BOOK";
                                ResultSet rs = st.executeQuery(sql);
                                while (rs.next()) {
                                    int bookId = rs.getInt("BOOK_ID");
                                    String title = rs.getString("TITLE");
                                    String author = rs.getString("AUTHOR");
                                    String publisher = rs.getString("PUBLISHER");
                                    String category = rs.getString("CATEGORY");
                                    int year = rs.getInt("YEAR_PUBLISHED");
                                    int qty = rs.getInt("QNTY");
                                    int available = rs.getInt("AVAILABLE_QNTY");
                                    byte[] imgBytes = rs.getBytes("IMAGE");
                                    String base64Image = java.util.Base64.getEncoder().encodeToString(imgBytes);
                                    String imageSrc = "data:image/jpeg;base64," + base64Image;
                        %>
                        <a href="playlist.jsp?id=<%=bookId%>" class="ag-courses_item">
                            <div class="ag-courses_item">
                                <div class="course-img-cover">
                                    <img class="course-img" src="<%=imageSrc%>" alt=""/>
                                    <div class="fac-img-cover">
                                        <img class="fac-img" src="pic-1.jpg" alt=""/>
                                    </div>
                                </div>
                                <div class="ag-courses-item_link">
                                    <div class="ag-courses-item_bg"></div>

                                    <div class="ag-courses-item_title"><%=title%></div>

                                    <div class="ag-courses-item_date-box">
                                        Author :
                                        <span class="ag-courses-item_date"><%=publisher%></span>
                                    </div>
                                    <div class="ag-courses-item_date-box">
                                        Published Year :
                                        <span class="ag-courses-item_date"><%=year%></span>
                                    </div>
                                </div>
                            </div>
                        </a>
                        <%
                                }
                                rs.close();
                                st.close();
                                con.close();
                            } catch (Exception e) {
                                PrintWriter pw = response.getWriter();
                                pw.println("<tr><td colspan='8'>Error: " + e.getMessage() + "</td></tr>");
                            }
                        %>
                    </ul>
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
