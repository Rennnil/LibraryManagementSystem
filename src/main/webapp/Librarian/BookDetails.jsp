<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.*" %>
<%@ page import="p1.DBConnection" %>
<%@ page import="java.awt.print.Book" %>
<!DOCTYPE html>
<html>
<head>
    <!-- Basic Page Info -->
    <meta charset="utf-8"/>
    <title>Lilbrio - Bookstore </title>
    <link rel="icon" type="image/png" href="../User/images/Logo.png">

    <style>
        /* Optionally, you can move these styles to an external CSS file for better organization */
        .demo {
            justify-content: center;
            text-align: center;
            display: flex;
            flex-direction: column;
            align-items: center; /* Centers items horizontally within the container */
        }

        /* Styling for profile image */
        .profile-img {
            width: 100px;
            height: 100px;
            border-radius: 50%; /* Make the image circular */
            object-fit: cover; /* Ensure the image covers the container */
            margin-bottom: 5px;
            /* Add shadow and border */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Subtle shadow effect */
            border: 3px solid #0c0404; /* White border around the image */
            transition: transform 0.3s ease, box-shadow 0.3s ease; /* Smooth transition on hover */
        }

        /* Hover effect for profile image */
        .profile-img:hover {
            transform: scale(1.1); /* Scale up the image on hover */
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2); /* Increase shadow size on hover */
        }


        #overflow-hidden {
            overflow: scroll;
            overflow-x: hidden;
            white-space: wrap;
            text-overflow: ellipsis;
            height: 200px;
        }

        ::-webkit-scrollbar {
            width: 5px;
        }

        /* Track */
        ::-webkit-scrollbar-track {
            background: #f1f1f1;
        }

        /* Handle */
        ::-webkit-scrollbar-thumb {
            background: #a7a7a7;
        }

        /* Handle on hover */
        ::-webkit-scrollbar-thumb:hover {
            background: #a7a7a7;
        }

    </style>
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
    <!-- Slick Slider css -->
    <link rel="stylesheet" type="text/css" href="../src/plugins/slick/slick.css"/>
    <!-- bootstrap-touchspin css -->
    <link
            rel="stylesheet"
            type="text/css"
            href="../src/plugins/bootstrap-touchspin/jquery.bootstrap-touchspin.css"
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
                            <h4>Product Detail</h4>
                        </div>
                        <nav aria-label="breadcrumb" role="navigation">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item">
                                    <a href="index.jsp">Home</a>
                                </li>
                                <li class="breadcrumb-item active" aria-current="page">
                                    Product Detail
                                </li>
                            </ol>
                        </nav>
                    </div>
                </div>
            </div>
            <div class="product-wrap">
                <div class="product-detail-wrap mb-30">
                    <%
                        //int bookId = rs.getInt("BOOK_ID");
                        int id=Integer.parseInt(request.getParameter("id"));

                        try {
                            Connection con= DBConnection.getConnection();
                            String sql = "SELECT * FROM BOOK WHERE BOOK_ID = ?"; // Adjust the query as needed
                            PreparedStatement pr=con.prepareStatement(sql);
                            pr.setInt(1, id); // Assuming bookId is passed as a request parameter
                            ResultSet rs = pr.executeQuery();
                            while (rs.next()) {
                                int bookId = rs.getInt("BOOK_ID");
                                String title = rs.getString("TITLE");
                                String author = rs.getString("AUTHOR");
                                String publisher = rs.getString("PUBLISHER");
                                String category = rs.getString("CATEGORY");
                                int year = rs.getInt("YEAR_PUBLISHED");
                                int qty = rs.getInt("QNTY");
                                int available = rs.getInt("AVAILABLE_QNTY");
                                byte[] imgBytes = rs.getBytes("BOOK_IMAGE");
                                String base64Image = java.util.Base64.getEncoder().encodeToString(imgBytes);
                                String BookImage = "data:image/jpeg;base64," + base64Image;
                                byte[] imgBytes1 = rs.getBytes("AUTHOR_IMAGE");
                                String base64Image1 = java.util.Base64.getEncoder().encodeToString(imgBytes1);
                                String AuthorImage = "data:image/jpeg;base64," + base64Image1;
                    %>
                    <div class="row">
                        <div class="col-lg-3 col-md-12 col-sm-12 mt-3">
                            <div class="product-detail-desc pd-20 card-box height-100-p" style="height: 400px; display: flex; align-items: center; justify-content: center;">
                                <img src="<%=BookImage%>" alt="Book Image"
                                     style="max-height: 100%; max-width: 100%; object-fit: contain; border-radius: 10px;">
                            </div>
                        </div>

                        <div class="col-lg-9 col-md-12 col-sm-12 mt-3">
                            <div class="product-detail-desc pd-20 card-box height-100-p">
                                <div>
                                    <div class="demo p-4" style="background-image: url('https://i.makeagif.com/media/6-21-2021/Ml33kt.gif');border-radius: 10px;color: white;justify-content: center;background-repeat: no-repeat;
											background-attachment: fixed;
											background-size: cover; text-align: center; display: flex; flex-direction: column; align-items: center;">
                                        <img class="profile-img" src="<%=AuthorImage%>" alt="">
                                        <div>
                                            <h3 style="font-size: large; margin-top: 10px; color: white;"><%=author%></h3>
                                            <!-- <span>Published Year</span> -->
                                        </div>
                                    </div>
                                    <div class="details mt-3" id="overflow-hidden">
                                        <h4 style="font-size: large; margin-top: 15px;">&#128073; Book Details</h4>

                                        <ul class="list-group list-group-flush mt-2">
                                            <li class="list-group-item">
                                                <strong>Title:</strong> <%=title%>
                                            </li>
                                            <li class="list-group-item">
                                                <strong>Publisher:</strong> <%=publisher%>
                                            </li>
                                            <li class="list-group-item">
                                                <strong>Category:</strong>
                                                <span class="badge badge-info"><%=category%></span>
                                            </li>
                                            <li class="list-group-item">
                                                <strong>Published Year:</strong> <%=year%>
                                            </li>
                                            <li class="list-group-item">
                                                <strong>Quantity:</strong>
                                                <span class="badge badge-secondary"><%=qty%></span>
                                            </li>
                                            <li class="list-group-item">
                                                <strong>Available:</strong>
                                                <% if (available > 0) { %>
                                                <span class="badge badge-success"><%=available%> In Stock</span>
                                                <% } else { %>
                                                <span class="badge badge-danger">Out of Stock</span>
                                                <% } %>
                                            </li>
                                        </ul>
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
</div>
<!-- welcome modal start -->


<!-- welcome modal end -->
<!-- js -->
<script src="../vendors/scripts/core.js"></script>
<script src="../vendors/scripts/script.min.js"></script>
<script src="../vendors/scripts/process.js"></script>
<script src="../vendors/scripts/layout-settings.js"></script>
<!-- Slick Slider js -->
<script src="../src/plugins/slick/slick.min.js"></script>
<!-- bootstrap-touchspin js -->
<script src="../src/plugins/bootstrap-touchspin/jquery.bootstrap-touchspin.js"></script>
<script>
    jQuery(document).ready(function () {
        jQuery(".product-slider").slick({
            slidesToShow: 1,
            slidesToScroll: 1,
            arrows: true,
            infinite: true,
            speed: 1000,
            fade: true,
            asNavFor: ".product-slider-nav",
        });
        jQuery(".product-slider-nav").slick({
            slidesToShow: 3,
            slidesToScroll: 1,
            asNavFor: ".product-slider",
            dots: false,
            infinite: true,
            arrows: false,
            speed: 1000,
            centerMode: true,
            focusOnSelect: true,
        });
        $("input[name='demo3_22']").TouchSpin({
            initval: 1,
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
