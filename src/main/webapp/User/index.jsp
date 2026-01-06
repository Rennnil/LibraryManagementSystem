<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.util.Base64" %>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
    <title>Lilbrio - Bookstore </title>
    <link rel="icon" type="image/png" href="../User/images/Logo.png">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="format-detection" content="telephone=no">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="author" content="">
    <meta name="keywords" content="">
    <meta name="description" content="">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="style.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css"/>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Nunito:ital,wght@0,200..1000;1,200..1000&display=swap"
          rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: #ffecea;
        }

        footer {
            background: #f49892;
            color: #fff;
            padding: 50px 20px 20px;
        }

        .footer-container {
            width: 90%;
            margin: auto;
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
            gap: 30px;
        }

        .footer-col {
            flex: 1 1 250px;
        }

        .footer-col h3 {
            margin-bottom: 20px;
            font-size: 20px;
            color: #fff;
            position: relative;
        }

        .footer-col h3::after {
            content: "";
            display: block;
            width: 50px;
            height: 2px;
            background: #fff;
            margin-top: 8px;
        }

        .footer-col a {
            color: #fff;
            text-decoration: none;
            line-height: 1.8;
            font-size: 15px;
            transition: 0.3s;
            display: block;
        }

        .footer-col a:hover {
            color: #25262A;
        }

        .contact-info div {
            display: flex;
            align-items: center;
            margin-bottom: 12px;
        }

        .contact-info i {
            color: #fff;
            margin-right: 10px;
            font-size: 18px;
        }

        /* Query Form */
        .query-form {
            margin-top: 15px;
        }

        .query-form input,
        .query-form textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: none;
            border-radius: 5px;
            outline: none;
            font-family: inherit;
            resize: none;
        }

        .query-form button {
            background: #25262A;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            font-weight: 500;
            transition: 0.3s;
        }

        .query-form button:hover {
            background: #fff;
            color: #25262A;
        }

        .social-icons {
            margin-top: 20px;
        }

        .social-icons a {
            display: inline-block;
            width: 40px;
            height: 40px;
            background: #fff;
            color: #f49892;
            text-align: center;
            line-height: 40px;
            border-radius: 50%;
            margin-right: 10px;
            transition: 0.3s;
        }

        .social-icons a:hover {
            background: #25262A;
            color: #fff;
        }

        .footer-bottom {
            text-align: center;
            border-top: 1px solid #fff;
            margin-top: 30px;
            padding-top: 15px;
            color: #fff;
            font-size: 14px;
        }

        @media (max-width: 768px) {
            .footer-container {
                flex-direction: column;
                align-items: center;
                text-align: center;
            }

            .contact-info div {
                justify-content: center;
            }

            .social-icons a {
                margin: 5px;
            }
        }
    </style>
</head>
<body>
<svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
    <symbol id="search" xmlns="http://www.w3.org/2000/symbolsvg" viewBox="0 0 24 24">
        <path fill="currentColor" fill-rule="evenodd"
              d="M11.5 2.75a8.75 8.75 0 1 0 0 17.5a8.75 8.75 0 0 0 0-17.5M1.25 11.5c0-5.66 4.59-10.25 10.25-10.25S21.75 5.84 21.75 11.5c0 2.56-.939 4.902-2.491 6.698l3.271 3.272a.75.75 0 1 1-1.06 1.06l-3.272-3.271A10.21 10.21 0 0 1 11.5 21.75c-5.66 0-10.25-4.59-10.25-10.25"
              clip-rule="evenodd"/>
    </symbol>
    <symbol id="user" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
        <path fill="currentColor" fill-rule="evenodd"
              d="M12 1.25a4.75 4.75 0 1 0 0 9.5a4.75 4.75 0 0 0 0-9.5M8.75 6a3.25 3.25 0 1 1 6.5 0a3.25 3.25 0 0 1-6.5 0M12 12.25c-2.313 0-4.445.526-6.024 1.414C4.42 14.54 3.25 15.866 3.25 17.5v.102c-.001 1.162-.002 2.62 1.277 3.662c.629.512 1.51.877 2.7 1.117c1.192.242 2.747.369 4.773.369s3.58-.127 4.774-.369c1.19-.24 2.07-.605 2.7-1.117c1.279-1.042 1.277-2.5 1.276-3.662V17.5c0-1.634-1.17-2.96-2.725-3.836c-1.58-.888-3.711-1.414-6.025-1.414M4.75 17.5c0-.851.622-1.775 1.961-2.528c1.316-.74 3.184-1.222 5.29-1.222c2.104 0 3.972.482 5.288 1.222c1.34.753 1.961 1.677 1.961 2.528c0 1.308-.04 2.044-.724 2.6c-.37.302-.99.597-2.05.811c-1.057.214-2.502.339-4.476.339c-1.974 0-3.42-.125-4.476-.339c-1.06-.214-1.68-.509-2.05-.81c-.684-.557-.724-1.293-.724-2.601"
              clip-rule="evenodd"/>
    </symbol>
    <symbol xmlns="http://www.w3.org/2000/svg" id="alt-arrow-right-outline" viewBox="0 0 24 24">
        <path fill="currentColor" fill-rule="evenodd"
              d="M8.512 4.43a.75.75 0 0 1 1.057.082l6 7a.75.75 0 0 1 0 .976l-6 7a.75.75 0 0 1-1.138-.976L14.012 12L8.431 5.488a.75.75 0 0 1 .08-1.057"
              clip-rule="evenodd"/>
    </symbol>
    <symbol xmlns="http://www.w3.org/2000/svg" id="alt-arrow-left-outline" viewBox="0 0 24 24">
        <path fill="currentColor" fill-rule="evenodd"
              d="M15.488 4.43a.75.75 0 0 1 .081 1.058L9.988 12l5.581 6.512a.75.75 0 1 1-1.138.976l-6-7a.75.75 0 0 1 0-.976l6-7a.75.75 0 0 1 1.057-.081"
              clip-rule="evenodd"/>
    </symbol>
    <symbol xmlns="http://www.w3.org/2000/svg" id="quality" viewBox="0 0 16 16">
        <path
                d="M9.669.864 8 0 6.331.864l-1.858.282-.842 1.68-1.337 1.32L2.6 6l-.306 1.854 1.337 1.32.842 1.68 1.858.282L8 12l1.669-.864 1.858-.282.842-1.68 1.337-1.32L13.4 6l.306-1.854-1.337-1.32-.842-1.68L9.669.864zm1.196 1.193.684 1.365 1.086 1.072L12.387 6l.248 1.506-1.086 1.072-.684 1.365-1.51.229L8 10.874l-1.355-.702-1.51-.229-.684-1.365-1.086-1.072L3.614 6l-.25-1.506 1.087-1.072.684-1.365 1.51-.229L8 1.126l1.356.702 1.509.229z"/>
        <path d="M4 11.794V16l4-1 4 1v-4.206l-2.018.306L8 13.126 6.018 12.1 4 11.794z"/>
    </symbol>
    <symbol xmlns="http://www.w3.org/2000/svg" id="price-tag" viewBox="0 0 16 16">
        <path d="M6 4.5a1.5 1.5 0 1 1-3 0 1.5 1.5 0 0 1 3 0zm-1 0a.5.5 0 1 0-1 0 .5.5 0 0 0 1 0z"/>
        <path
                d="M2 1h4.586a1 1 0 0 1 .707.293l7 7a1 1 0 0 1 0 1.414l-4.586 4.586a1 1 0 0 1-1.414 0l-7-7A1 1 0 0 1 1 6.586V2a1 1 0 0 1 1-1zm0 5.586 7 7L13.586 9l-7-7H2v4.586z"/>
    </symbol>
    <symbol xmlns="http://www.w3.org/2000/svg" id="shield-plus" viewBox="0 0 16 16">
        <path
                d="M5.338 1.59a61.44 61.44 0 0 0-2.837.856.481.481 0 0 0-.328.39c-.554 4.157.726 7.19 2.253 9.188a10.725 10.725 0 0 0 2.287 2.233c.346.244.652.42.893.533.12.057.218.095.293.118a.55.55 0 0 0 .101.025.615.615 0 0 0 .1-.025c.076-.023.174-.061.294-.118.24-.113.547-.29.893-.533a10.726 10.726 0 0 0 2.287-2.233c1.527-1.997 2.807-5.031 2.253-9.188a.48.48 0 0 0-.328-.39c-.651-.213-1.75-.56-2.837-.855C9.552 1.29 8.531 1.067 8 1.067c-.53 0-1.552.223-2.662.524zM5.072.56C6.157.265 7.31 0 8 0s1.843.265 2.928.56c1.11.3 2.229.655 2.887.87a1.54 1.54 0 0 1 1.044 1.262c.596 4.477-.787 7.795-2.465 9.99a11.775 11.775 0 0 1-2.517 2.453 7.159 7.159 0 0 1-1.048.625c-.28.132-.581.24-.829.24s-.548-.108-.829-.24a7.158 7.158 0 0 1-1.048-.625 11.777 11.777 0 0 1-2.517-2.453C1.928 10.487.545 7.169 1.141 2.692A1.54 1.54 0 0 1 2.185 1.43 62.456 62.456 0 0 1 5.072.56z"/>
        <path
                d="M8 4.5a.5.5 0 0 1 .5.5v1.5H10a.5.5 0 0 1 0 1H8.5V9a.5.5 0 0 1-1 0V7.5H6a.5.5 0 0 1 0-1h1.5V5a.5.5 0 0 1 .5-.5z"/>
    </symbol>
    <symbol xmlns="http://www.w3.org/2000/svg" id="star-fill" viewBox="0 0 24 24">
        <path fill="currentColor"
              d="M9.153 5.408C10.42 3.136 11.053 2 12 2c.947 0 1.58 1.136 2.847 3.408l.328.588c.36.646.54.969.82 1.182c.28.213.63.292 1.33.45l.636.144c2.46.557 3.689.835 3.982 1.776c.292.94-.546 1.921-2.223 3.882l-.434.507c-.476.557-.715.836-.822 1.18c-.107.345-.071.717.001 1.46l.066.677c.253 2.617.38 3.925-.386 4.506c-.766.582-1.918.051-4.22-1.009l-.597-.274c-.654-.302-.981-.452-1.328-.452c-.347 0-.674.15-1.328.452l-.596.274c-2.303 1.06-3.455 1.59-4.22 1.01c-.767-.582-.64-1.89-.387-4.507l.066-.676c.072-.744.108-1.116 0-1.46c-.106-.345-.345-.624-.821-1.18l-.434-.508c-1.677-1.96-2.515-2.941-2.223-3.882c.293-.941 1.523-1.22 3.983-1.776l.636-.144c.699-.158 1.048-.237 1.329-.45c.28-.213.46-.536.82-1.182z"/>
    </symbol>
    <symbol xmlns="http://www.w3.org/2000/svg" id="star-empty" viewBox="0 0 16 16">
        <path
                d="M2.866 14.85c-.078.444.36.791.746.593l4.39-2.256 4.389 2.256c.386.198.824-.149.746-.592l-.83-4.73 3.522-3.356c.33-.314.16-.888-.282-.95l-4.898-.696L8.465.792a.513.513 0 0 0-.927 0L5.354 5.12l-4.898.696c-.441.062-.612.636-.283.95l3.523 3.356-.83 4.73zm4.905-2.767-3.686 1.894.694-3.957a.565.565 0 0 0-.163-.505L1.71 6.745l4.052-.576a.525.525 0 0 0 .393-.288L8 2.223l1.847 3.658a.525.525 0 0 0 .393.288l4.052.575-2.906 2.77a.565.565 0 0 0-.163.506l.694 3.957-3.686-1.894a.503.503 0 0 0-.461 0z"/>
    </symbol>
    <symbol xmlns="http://www.w3.org/2000/svg" id="star-half" viewBox="0 0 16 16">
        <path
                d="M5.354 5.119 7.538.792A.516.516 0 0 1 8 .5c.183 0 .366.097.465.292l2.184 4.327 4.898.696A.537.537 0 0 1 16 6.32a.548.548 0 0 1-.17.445l-3.523 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256a.52.52 0 0 1-.146.05c-.342.06-.668-.254-.6-.642l.83-4.73L.173 6.765a.55.55 0 0 1-.172-.403.58.58 0 0 1 .085-.302.513.513 0 0 1 .37-.245l4.898-.696zM8 12.027a.5.5 0 0 1 .232.056l3.686 1.894-.694-3.957a.565.565 0 0 1 .162-.505l2.907-2.77-4.052-.576a.525.525 0 0 1-.393-.288L8.001 2.223 8 2.226v9.8z"/>
    </symbol>
    <symbol xmlns="http://www.w3.org/2000/svg" id="quote" viewBox="0 0 24 24">
        <path fill="currentColor" d="m15 17l2-4h-4V6h7v7l-2 4h-3Zm-9 0l2-4H4V6h7v7l-2 4H6Z"/>
    </symbol>
    <symbol xmlns="http://www.w3.org/2000/svg" id="facebook" viewBox="0 0 24 24">
        <path fill="currentColor"
              d="M9.198 21.5h4v-8.01h3.604l.396-3.98h-4V7.5a1 1 0 0 1 1-1h3v-4h-3a5 5 0 0 0-5 5v2.01h-2l-.396 3.98h2.396v8.01Z"/>
    </symbol>
    <symbol xmlns="http://www.w3.org/2000/svg" id="youtube" viewBox="0 0 32 32">
        <path fill="currentColor"
              d="M29.41 9.26a3.5 3.5 0 0 0-2.47-2.47C24.76 6.2 16 6.2 16 6.2s-8.76 0-10.94.59a3.5 3.5 0 0 0-2.47 2.47A36.13 36.13 0 0 0 2 16a36.13 36.13 0 0 0 .59 6.74a3.5 3.5 0 0 0 2.47 2.47c2.18.59 10.94.59 10.94.59s8.76 0 10.94-.59a3.5 3.5 0 0 0 2.47-2.47A36.13 36.13 0 0 0 30 16a36.13 36.13 0 0 0-.59-6.74ZM13.2 20.2v-8.4l7.27 4.2Z"/>
    </symbol>
    <symbol xmlns="http://www.w3.org/2000/svg" id="twitter" viewBox="0 0 256 256">
        <path fill="currentColor"
              d="m245.66 77.66l-29.9 29.9C209.72 177.58 150.67 232 80 232c-14.52 0-26.49-2.3-35.58-6.84c-7.33-3.67-10.33-7.6-11.08-8.72a8 8 0 0 1 3.85-11.93c.26-.1 24.24-9.31 39.47-26.84a110.93 110.93 0 0 1-21.88-24.2c-12.4-18.41-26.28-50.39-22-98.18a8 8 0 0 1 13.65-4.92c.35.35 33.28 33.1 73.54 43.72V88a47.87 47.87 0 0 1 14.36-34.3A46.87 46.87 0 0 1 168.1 40a48.66 48.66 0 0 1 41.47 24H240a8 8 0 0 1 5.66 13.66Z"/>
    </symbol>
    <symbol xmlns="http://www.w3.org/2000/svg" id="instagram" viewBox="0 0 256 256">
        <path fill="currentColor"
              d="M128 80a48 48 0 1 0 48 48a48.05 48.05 0 0 0-48-48Zm0 80a32 32 0 1 1 32-32a32 32 0 0 1-32 32Zm48-136H80a56.06 56.06 0 0 0-56 56v96a56.06 56.06 0 0 0 56 56h96a56.06 56.06 0 0 0 56-56V80a56.06 56.06 0 0 0-56-56Zm40 152a40 40 0 0 1-40 40H80a40 40 0 0 1-40-40V80a40 40 0 0 1 40-40h96a40 40 0 0 1 40 40ZM192 76a12 12 0 1 1-12-12a12 12 0 0 1 12 12Z"/>
    </symbol>
    <symbol xmlns="http://www.w3.org/2000/svg" id="linkedin" viewBox="0 0 24 24">
        <path fill="currentColor"
              d="M6.94 5a2 2 0 1 1-4-.002a2 2 0 0 1 4 .002zM7 8.48H3V21h4V8.48zm6.32 0H9.34V21h3.94v-6.57c0-3.66 4.77-4 4.77 0V21H22v-7.93c0-6.17-7.06-5.94-8.72-2.91l.04-1.68z"/>
    </symbol>
    <symbol xmlns="http://www.w3.org/2000/svg" id="nav-icon" viewBox="0 0 16 16">
        <path
                d="M14 10.5a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0 0 1h3a.5.5 0 0 0 .5-.5zm0-3a.5.5 0 0 0-.5-.5h-7a.5.5 0 0 0 0 1h7a.5.5 0 0 0 .5-.5zm0-3a.5.5 0 0 0-.5-.5h-11a.5.5 0 0 0 0 1h11a.5.5 0 0 0 .5-.5z"/>
    </symbol>
    <symbol xmlns="http://www.w3.org/2000/svg" id="close" viewBox="0 0 16 16">
        <path
                d="M2.146 2.854a.5.5 0 1 1 .708-.708L8 7.293l5.146-5.147a.5.5 0 0 1 .708.708L8.707 8l5.147 5.146a.5.5 0 0 1-.708.708L8 8.707l-5.146 5.147a.5.5 0 0 1-.708-.708L7.293 8 2.146 2.854Z"/>
    </symbol>
    <symbol xmlns="http://www.w3.org/2000/svg" id="navbar-icon" viewBox="0 0 16 16">
        <path
                d="M14 10.5a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0 0 1h3a.5.5 0 0 0 .5-.5zm0-3a.5.5 0 0 0-.5-.5h-7a.5.5 0 0 0 0 1h7a.5.5 0 0 0 .5-.5zm0-3a.5.5 0 0 0-.5-.5h-11a.5.5 0 0 0 0 1h11a.5.5 0 0 0 .5-.5z"/>
    </symbol>
</svg>

<div id="preloader" class="preloader-container">
    <div class="book">
        <div class="inner">
            <div class="left"></div>
            <div class="middle"></div>
            <div class="right"></div>
        </div>
        <ul>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
            <li></li>
        </ul>
    </div>
</div>

<jsp:include page="Header.jsp" flush="true"></jsp:include>


<section id="billboard" class="position-relative d-flex align-items-center py-5 bg-light-gray"
         style="background-image: url(images/banner-image-bg.jpg); background-size: cover; background-repeat: no-repeat; background-position: center; height: 800px;">
    <div class="position-absolute end-0 pe-0 pe-xxl-5 me-0 me-xxl-5 swiper-next main-slider-button-next">
        <svg class="chevron-forward-circle d-flex justify-content-center align-items-center p-2" width="80" height="80">
            <use xlink:href="#alt-arrow-right-outline"></use>
        </svg>
    </div>
    <div class="position-absolute start-0 ps-0 ps-xxl-5 ms-0 ms-xxl-5 swiper-prev main-slider-button-prev">
        <svg class="chevron-back-circle d-flex justify-content-center align-items-center p-2" width="80" height="80">
            <use xlink:href="#alt-arrow-left-outline"></use>
        </svg>
    </div>

    <div class="swiper main-swiper">
        <div class="swiper-wrapper d-flex align-items-center">

            <%
                PrintWriter pw = response.getWriter();
                try {
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    Connection con = DriverManager.getConnection(
                            "jdbc:oracle:thin:@localhost:1521:XE", "system", "system");
                    Statement st = con.createStatement();

                    // Fetch top 3 highest rated books
                    ResultSet rs = st.executeQuery(
                            "SELECT * FROM (SELECT * FROM BOOK ORDER BY RATING DESC) WHERE ROWNUM <= 3");

                    while (rs.next()) {
                        String title = rs.getString("TITLE");
                        String author = rs.getString("AUTHOR");
                        byte[] imgBytes = rs.getBytes("BOOK_IMAGE");

                        String imageSrc = "";
                        if (imgBytes != null && imgBytes.length > 0) {
                            String base64Image = Base64.getEncoder().encodeToString(imgBytes);
                            imageSrc = "data:image/jpeg;base64," + base64Image;
                        }
            %>

            <div class="swiper-slide">
                <div class="container">
                    <div class="row d-flex flex-column-reverse flex-md-row align-items-center">
                        <!-- Left: Book Text Info -->
                        <div class="col-md-5 offset-md-1 mt-5 mt-md-0 text-center text-md-start">
                            <div class="banner-content">
                                <h2><%= title %></h2>
                                <p>By <%= author %> - Highly Rated!</p>
<%--                                <a href="BookDetails.jsp?title=<%= java.net.URLEncoder.encode(title, "UTF-8") %>"--%>
<%--                                   class="btn btn-primary mt-3">--%>
<%--                                    View Details--%>
<%--                                </a>--%>
                            </div>
                        </div>

                        <!-- Right: Book Image -->
                        <div class="col-md-6 text-center">
                            <div class="image-holder p-3">
                                <% if (!imageSrc.isEmpty()) { %>
                                <img src="<%= imageSrc %>" class="img-fluid rounded shadow"
                                     alt="Book Image"
                                     style="max-height: 450px; max-width: 100%; object-fit: contain;">
                                <% } else { %>
                                <img src="images/default-book.jpg" class="img-fluid rounded shadow"
                                     alt="No Image"
                                     style="max-height: 450px;">
                                <% } %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <%
                    }
                    rs.close();
                    st.close();
                    con.close();
                } catch (Exception e) {
                    pw.println("<div class='text-danger'>Error: " + e.getMessage() + "</div>");
                }
            %>

        </div>
    </div>

</section>


<section id="best-selling-items" class="position-relative padding-large ">
    <div class="container">
        <div class="section-title d-md-flex justify-content-between align-items-center mb-4">
            <h3 class="d-flex align-items-center">Top Rated Books</h3>
            <a href="TopRatedBooks.jsp" class="btn">View All</a>
        </div>

        <div class="swiper product-swiper">
            <div class="swiper-wrapper">

                <%
                    try {
                        Class.forName("oracle.jdbc.driver.OracleDriver");
                        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "system");
                        Statement st = con.createStatement();
                        ResultSet rs = st.executeQuery("SELECT BOOK_ID, TITLE, AUTHOR, RATING, BOOK_IMAGE FROM BOOK WHERE RATING >= 4");

                        while (rs.next()) {
                            int bookId = rs.getInt("BOOK_ID");
                            String title = rs.getString("TITLE");
                            String author = rs.getString("AUTHOR");
                            float rating = rs.getFloat("RATING");

                            byte[] imgBytes = rs.getBytes("BOOK_IMAGE");
                            String base64Image = Base64.getEncoder().encodeToString(imgBytes);
                            String imageSrc = "data:image/jpeg;base64," + base64Image;
                %>

                <div class="swiper-slide">
                    <div class="card position-relative border rounded-3"
                         style="height: 400px; padding: 16px; overflow: hidden;">
                        <img src="<%= imageSrc %>"
                             style="height: 270px; width: 100%; object-fit: cover;"
                             class="img-fluid shadow-sm" alt="Book Image">

                        <h6 style="margin-top: 12px; margin-bottom: 0; font-weight: bold;">
                            <a href="BookDetails.jsp?id=<%=bookId%>"><%= title %></a>
                        </h6>

                        <p style="margin: 8px 0; font-size: 14px; color: #6c757d;"><%= author %></p>

                        <div style="display: flex; align-items: center; color: #ffc107;">
                            <%
                                int fullStars = (int) rating;
                                for (int i = 0; i < fullStars; i++) {
                            %>
                            <svg class="star star-fill" style="width: 20px; height: 20px;">
                                <use xlink:href="#star-fill"></use>
                            </svg>
                            <%
                                }
                                for (int i = fullStars; i < 5; i++) {
                            %>
                            <svg class="star star-outline" style="width: 20px; height: 20px; color: #ccc;">
                                <use xlink:href="#star-outline"></use>
                            </svg>
                            <%
                                }
                            %>
                        </div>
                    </div>
                </div>

                <%
                        }
                        rs.close();
                        st.close();
                        con.close();
                    } catch (Exception e) {
                        pw.println("<div class='text-danger'>Error: " + e.getMessage() + "</div>");
                    }
                %>

            </div> <!-- .swiper-wrapper -->
        </div> <!-- .swiper -->
    </div> <!-- .container -->
</section>


<section id="categories" class="padding-large pt-0">
    <div class="container">
        <div class="section-title overflow-hidden mb-4">
            <h3 class="d-flex align-items-center">Categories</h3>
        </div>
        <div class="row">
            <div class="col-md-4">
                <div class="card mb-4 border-0 rounded-3 position-relative">
                    <a href="index.jsp">
                        <img src="images/category1.jpg" class="img-fluid rounded-3" alt="cart item">
                        <h6 class=" position-absolute bottom-0 bg-primary m-4 py-2 px-3 rounded-3"><a href="index.jsp"
                                                                                                      class="text-white">Romance</a>
                        </h6>
                    </a>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card text-center mb-4 border-0 rounded-3">
                    <a href="index.jsp">
                        <img src="images/category2.jpg" class="img-fluid rounded-3" alt="cart item">
                        <h6 class=" position-absolute bottom-0 bg-primary m-4 py-2 px-3 rounded-3"><a href="index.jsp"
                                                                                                      class="text-white">History</a>
                        </h6>
                    </a>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card text-center mb-4 border-0 rounded-3">
                    <a href="index.jsp">
                        <img src="images/category3.jpg" class="img-fluid rounded-3" alt="cart item">
                        <h6 class=" position-absolute bottom-0 bg-primary m-4 py-2 px-3 rounded-3"><a href="index.jsp"
                                                                                                      class="text-white">Chindren</a>
                        </h6>
                    </a>
                </div>
            </div>
        </div>
    </div>
</section>


<section id="latest-posts" class="padding-large">
    <div class="container">
        <div class="section-title d-md-flex justify-content-between align-items-center mb-4">
            <h3 class="d-flex align-items-center">Latest Books</h3>
        </div>
        <div class="row">
            <%
                try {
                    Class.forName("oracle.jdbc.driver.OracleDriver");
                    Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "system");
                    Statement st = con.createStatement();

                    String sql = "SELECT * FROM (SELECT * FROM BOOK ORDER BY BOOK_ID DESC) WHERE ROWNUM <= 4";
                    ResultSet rs = st.executeQuery(sql);

                    while (rs.next()) {
                        String title = rs.getString("TITLE");
                        String author = rs.getString("AUTHOR");
                        byte[] imageBytes = rs.getBytes("BOOK_IMAGE");

                        String base64Image = "";
                        if (imageBytes != null) {
                            base64Image = Base64.getEncoder().encodeToString(imageBytes);
                        }
            %>
            <div class="col-md-3 posts mb-4">
                <img src="data:image/jpeg;base64,<%=base64Image%>" alt="Book Image"
                     style="width: 100%; height: 250px; object-fit: cover; border-radius: 12px;" />
                <h4 class="card-title mb-2 text-capitalize text-dark"><a href="BookDetails.jsp"><%=title%></a></h4>
                <p class="mb-2">by <strong><%=author%></strong></p>
            </div>
            <%
                    }
                    rs.close();
                    st.close();
                    con.close();
                } catch (Exception e) {
                    pw.println("<p>Error: " + e.getMessage() + "</p>");
                }
            %>
        </div>
    </div>
</section>


<footer id="footer" style="background:#f49892;color:#fff;padding:50px 20px 20px;font-family:'Poppins',sans-serif;overflow-x:hidden;">
    <div style="width:95%;margin:auto;display:flex;justify-content:space-between;align-items:flex-start;gap:40px;flex-wrap:nowrap;">

        <!-- Quick Links -->
        <div style="flex:1;">
            <h3 style="margin-bottom:20px;font-size:20px;color:#fff;">Quick Links</h3>
            <div style="width:50px;height:2px;background:#fff;margin-top:8px;margin-bottom:12px;"></div>
            <a href="" style="color:#fff;text-decoration:none;line-height:1.8;font-size:15px;display:block;">Home</a>
            <a href="#" style="color:#fff;text-decoration:none;line-height:1.8;font-size:15px;display:block;">About</a>
            <a href="#" style="color:#fff;text-decoration:none;line-height:1.8;font-size:15px;display:block;">Book</a>
            <a href="#" style="color:#fff;text-decoration:none;line-height:1.8;font-size:15px;display:block;">Category</a>
        </div>

        <!-- Contact Info -->
        <div style="flex:1;">
            <h3 style="margin-bottom:20px;font-size:20px;color:#fff;">Contact Us</h3>
            <div style="width:50px;height:2px;background:#fff;margin-top:8px;margin-bottom:12px;"></div>
            <div style="display:flex;align-items:center;margin-bottom:12px;">
                <i class="fa-solid fa-location-dot" style="color:#fff;margin-right:10px;font-size:18px;"></i>
                <span>45 Knowledge Avenue, City Library, India</span>
            </div>
            <div style="display:flex;align-items:center;margin-bottom:12px;">
                <i class="fa-solid fa-phone" style="color:#fff;margin-right:10px;font-size:18px;"></i>
                <span>+91 9173545212</span>
            </div>
            <div style="display:flex;align-items:center;margin-bottom:12px;">
                <i class="fa-solid fa-envelope" style="color:#fff;margin-right:10px;font-size:18px;"></i>
                <span>lilbriomanagement@gmail.com</span>
            </div>
        </div>

        <!-- Send Your Query -->
        <div style="flex:1;">
            <h3 style="margin-bottom:20px;font-size:20px;color:#fff;">Send Your Query</h3>
            <div style="width:50px;height:2px;background:#fff;margin-top:8px;margin-bottom:12px;"></div>
            <form action="../SendQueryServlet" method="post">
                <input type="text" name="name" placeholder="Your Name" required
                       style="width:100%;padding:10px;margin-bottom:10px;border:none;border-radius:5px;outline:none;font-family:inherit;">
                <input type="email" name="email" placeholder="Your Email" required
                       style="width:100%;padding:10px;margin-bottom:10px;border:none;border-radius:5px;outline:none;font-family:inherit;">
                <textarea rows="3" name="query" placeholder="Enter your query..." required
                          style="width:100%;padding:10px;margin-bottom:10px;border:none;border-radius:5px;outline:none;font-family:inherit;resize:none;"></textarea>
                <button type="submit"
                        style="background:#25262A;color:#fff;border:none;padding:10px 20px;border-radius:5px;cursor:pointer;font-weight:500;">
                    Send
                </button>
            </form>

        </div>

        <!-- Follow Us -->
        <div style="flex:1;">
            <h3 style="margin-bottom:20px;font-size:20px;color:#fff;">Follow Us</h3>
            <div style="width:50px;height:2px;background:#fff;margin-top:8px;margin-bottom:12px;"></div>
            <div style="display:flex;align-items:center;gap:10px;">
                <a href="#" style="display:inline-block;width:40px;height:40px;background:#fff;color:#f49892;text-align:center;line-height:40px;border-radius:50%;text-decoration:none;">
                    <i class="fa-brands fa-facebook-f"></i>
                </a>
                <a href="#" style="display:inline-block;width:40px;height:40px;background:#fff;color:#f49892;text-align:center;line-height:40px;border-radius:50%;text-decoration:none;">
                    <i class="fa-brands fa-twitter"></i>
                </a>
                <a href="#" style="display:inline-block;width:40px;height:40px;background:#fff;color:#f49892;text-align:center;line-height:40px;border-radius:50%;text-decoration:none;">
                    <i class="fa-brands fa-instagram"></i>
                </a>
                <a href="#" style="display:inline-block;width:40px;height:40px;background:#fff;color:#f49892;text-align:center;line-height:40px;border-radius:50%;text-decoration:none;">
                    <i class="fa-brands fa-linkedin-in"></i>
                </a>
            </div>
        </div>
    </div>

    <div style="text-align:center;border-top:1px solid #fff;margin-top:30px;padding-top:15px;color:#fff;font-size:14px;">
        <p>© LilBRiO | All Rights Reserved.</p>
    </div>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
</footer>

</body>
</html>