<%--
  Created by IntelliJ IDEA.
  User: lakha
  Date: 19-06-2025
  Time: 14:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

<jsp:include page="HeaderSidebar.jsp" flush="true"></jsp:include>

<div class="main-container">
    <div class="pd-ltr-20 xs-pd-20-10">
        <div class="min-height-200px">
            <div class="page-header">
                <div class="row">
                    <div class="col-md-6 col-sm-12">
                        <div class="title">
                            <h4>Chat</h4>
                        </div>
                        <nav aria-label="breadcrumb" role="navigation">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item">
                                    <a href="index.jsp">Home</a>
                                </li>
                                <li class="breadcrumb-item active" aria-current="page">
                                    Chat
                                </li>
                            </ol>
                        </nav>
                    </div>
                </div>
            </div>
            <div class="card-box pb-10">
                <div class="h5 pd-20 mb-0">Fined Books</div>
                <table class=" table nowrap  data-table-export ">
                    <thead>
                    <tr>
                        <th class="table-plus">Book Name</th>
                        <th>Student Name</th>
                        <th>Librarian Name </th>
                        <th>Amount</th>
                        <th> Status</th>
                        <th>Reason</th>
                        <th class="datatable-nosort">Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td class="table-plus">
                            <div class="name-avatar d-flex align-items-center">
                                <div class="avatar mr-2 flex-shrink-0">
                                    <img
                                            src="pic-3.jpg"
                                            class="border-radius-100 shadow"
                                            width="40"
                                            height="40"
                                            alt=""
                                    />
                                </div>
                                <div class="txt">
                                    <div class="weight-600">Book Name</div>
                                </div>
                            </div>
                        </td>
                        <td>Student name</td>
                        <td>Librarian name</td>
                        <td>Amount</td>
                        <td>Status</td>
                        <td>Reason</td>
                        <!-- <td>
                            <span
                                class="badge badge-pill"
                                data-bgcolor="#e7ebf5"
                                data-color="#265ed7"
                                >Typhoid</span
                            >
                        </td> -->
                        <td>
                            <div class="table-actions">

                                <a href="" class="btn" data-color="#e95959"
                                   data-toggle="modal" data-target="#deleteModal"
                                ><i class="icon-copy dw dw-delete-3"></i
                                ></a>
                            </div>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<!-- welcome modal start -->

<!-- ============(Delete)=========================================== -->

<div class="modal fade bs-example-modal-lg" id="deleteModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Delete Student</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body">
                <form action="DeleteServlet" method="post">
                    <p>Are you sure you want to delete this ?</p>
                    <input type="hidden" name="id" id="deleteId">
                    <button type="submit" class="btn btn-danger">Delete</button>
                    <button
                            type="button"
                            class="btn btn-light w-25"
                            data-dismiss="modal"
                    >
                        Close
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

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
