<%--
  Created by IntelliJ IDEA.
  User: lakha
  Date: 16-06-2025
  Time: 21:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>

    <!-- Basic Page Info -->
    <meta charset="utf-8"/>
    <title>Lilbrio - Bookstore </title>
    <link rel="icon" type="image/png" href="../User/images/Logo.png">

    <!-- Site favicon -->
<%--    <link--%>
<%--            rel="apple-touch-icon"--%>
<%--            sizes="180x180"--%>
<%--            href="vendors/images/apple-touch-icon.png"--%>
<%--    />--%>
<%--    <link--%>
<%--            rel="icon"--%>
<%--            type="image/png"--%>
<%--            sizes="32x32"--%>
<%--            href="vendors/images/favicon-32x32.png"--%>
<%--    />--%>
<%--    <link--%>
<%--            rel="icon"--%>
<%--            type="image/png"--%>
<%--            sizes="16x16"--%>
<%--            href="vendors/images/favicon-16x16.png"--%>
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
    <link rel="stylesheet" type="text/css" href="vendors/styles/core.css"/>
    <link
            rel="stylesheet"
            type="text/css"
            href="vendors/styles/icon-font.min.css"
    />
    <link
            rel="stylesheet"
            type="text/css"
            href="src/plugins/datatables/css/dataTables.bootstrap4.min.css"
    />
    <link
            rel="stylesheet"
            type="text/css"
            href="src/plugins/datatables/css/responsive.bootstrap4.min.css"
    />
    <link rel="stylesheet" type="text/css" href="vendors/styles/style.css"/>

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

    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Registration - HR Book Store</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
    <style>
        html, body {
            height: 100vh;
            margin: 0;
            overflow: hidden;
        }
        .register {
            background: -webkit-linear-gradient(left, #3931af, #00c6ff);
            margin-top: 3%;
            padding: 3%;
        }
        .register-left {
            text-align: center;
            color: #fff;
            margin-top: 4%;
        }
        .register-left input {
            border: none;
            border-radius: 1.5rem;
            padding: 2%;
            width: 60%;
            background: #f8f9fa;
            font-weight: bold;
            color: #383d41;
            margin-top: 30%;
            margin-bottom: 3%;
            cursor: pointer;
        }
        .register-right {
            background: #f8f9fa;
            border-top-left-radius: 10% 50%;
            border-bottom-left-radius: 10% 50%;
        }
        .register-left img {
            margin-top: 15%;
            margin-bottom: 5%;
            width: 25%;
            animation: mover 1s infinite alternate;
        }
        @keyframes mover {
            0% { transform: translateY(0); }
            100% { transform: translateY(-20px); }
        }
        .register-left p {
            font-weight: lighter;
            padding: 12%;
            margin-top: -9%;
        }
        .register .register-form {
            padding: 5% 10% 2% 10%;
            margin-top: 1%;
        }
        .btnRegister {
            display: block;
            margin: 30px auto 0 auto;
            border: none;
            border-radius: 1.5rem;
            padding: 4%;
            background: #0062cc;
            color: #fff;
            font-weight: 600;
            width: 80%;
            cursor: pointer;
        }
        .register-heading {
            text-align: center;
            margin-top: 2%;
            margin-bottom: 1%;
            color: #495057;
        }
    </style>
</head>
<body>

<div class="pre-loader">
    <div class="pre-loader-box">
        <div class="loader-logo">
            <img src="./User/images/Logo.png" alt=""/>
        </div>
        <div class="loader-progress" id="progress_div">
            <div class="bar" id="bar1" style="background-color: #ff6b6b;"></div>
        </div>
        <div class="percent" id="percent1">0%</div>
        <div class="loading-text">Loading...</div>
    </div>
</div>

<div class="container register">
    <div class="row">
        <!-- Left Panel -->
        <div class="col-md-3 register-left">
            <img src="https://image.ibb.co/n7oTvU/logo_white.png" alt=""/>
            <h3>Welcome To <br>Lilbrio</h3>
            <a href="Login.jsp"><input type="submit" value="Login"/></a><br/>
        </div>

        <!-- Right Panel -->
        <div class="col-md-9 register-right">
            <div class="tab-content" id="myTabContent">
                <div class="tab-pane fade show active" id="home" role="tabpanel">
                    <h3 class="register-heading">Registration Form</h3>

                    <!-- Centered Form -->
                    <div class="row justify-content-center">
                        <div class="col-md-8">
                            <form class="register-form" action="Register" method="post" enctype="multipart/form-data">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <input type="text" name="firstname" class="form-control" placeholder="First Name *" required />
                                        </div>
                                        <div class="form-group">
                                            <input type="text" name="lastname" class="form-control" placeholder="Last Name *" required />
                                        </div>
                                        <div class="form-group">
                                            <input type="text" name="mobile" minlength="10" maxlength="10" class="form-control" placeholder="Your Phone *" required />
                                        </div>
                                        <div class="form-group">
                                            <input type="text" name="address" class="form-control" placeholder="Your Address *" required >
                                        </div>
                                        <div class="form-group">
                                            <label class="radio inline">
                                                <input type="radio" name="gender" value="male" checked>
                                                <span> Male </span>
                                            </label>
                                            <label class="radio inline">
                                                <input type="radio" name="gender" value="female">
                                                <span>Female </span>
                                            </label>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-group">
                                            <input type="email" name="email" class="form-control" placeholder="Your Email *" required />
                                        </div>
                                        <div class="form-group">
                                            <input type="password" name="password" class="form-control" placeholder="Password *" required />
                                        </div>
                                        <div class="form-group">
                                            <select class="form-control" name="role" required>
                                                <option class="hidden" selected disabled>Role</option>
                                                <option value="1">Admin</option>
                                                <option value="2">Librarian</option>
                                                <option value="3">Student</option>
                                            </select>
                                        </div>
                                        <div class="form-group">
                                            <input type="file" name="userimage" class="form-control" required />
                                        </div>
                                        <input type="submit" class="btnRegister" value="Register"/>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- js -->
<script src="vendors/scripts/core.js"></script>
<script src="vendors/scripts/script.min.js"></script>
<script src="vendors/scripts/process.js"></script>
<script src="vendors/scripts/layout-settings.js"></script>
<script src="src/plugins/apexcharts/apexcharts.min.js"></script>
<script src="src/plugins/datatables/js/jquery.dataTables.min.js"></script>
<script src="src/plugins/datatables/js/dataTables.bootstrap4.min.js"></script>
<script src="src/plugins/datatables/js/dataTables.responsive.min.js"></script>
<script src="src/plugins/datatables/js/responsive.bootstrap4.min.js"></script>
<script src="vendors/scripts/dashboard3.js"></script>
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

</body>
</html>

