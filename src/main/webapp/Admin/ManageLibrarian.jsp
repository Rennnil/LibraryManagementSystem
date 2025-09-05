<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="p1.DBConnection" %><%--
  Created by IntelliJ IDEA.
  User: lakha
  Date: 17-06-2025
  Time: 12:58
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

<jsp:include page="HeaderSideBar.jsp" flush="true"></jsp:include>

<div class="main-container">
    <div class="pd-ltr-20 xs-pd-20-10">
        <div class="min-height-200px">
            <div class="page-header">
                <div class="row">
                    <div class="col-md-6 col-sm-12">
                        <div class="title">
                            <h4>Add Librarian</h4>
                        </div>
                        <nav aria-label="breadcrumb" role="navigation">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item">
                                    <a href="index.jsp">Home</a>
                                </li>
                                <li class="breadcrumb-item active" aria-current="page">
                                    Add Librarian
                                </li>
                            </ol>
                        </nav>
                    </div>
                    <div class="col-md-6 col-sm-12 text-right">
                        <div>
                            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addCourse">
                                Add Librarian
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="card-box pb-10">
                <div class="h5 pd-20 mb-0">Recent Librarian</div>
                <table class=" table nowrap  data-table-export ">
                    <thead>
                    <tr>
                        <th class="table-plus">Name</th>
                        <th>Email</th>
                        <th>Password</th>
                        <th>Mobile Number</th>
                        <th>Address</th>
                        <th>Join Date</th>
                        <th class="datatable-nosort">Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%

                        try {
                            Connection con= DBConnection.getConnection();
                            Statement st = con.createStatement();
                            String sql = "SELECT * FROM users where ROLE_ID=2";
                            ResultSet rs = st.executeQuery(sql);

                            while (rs.next()) {
                                int userId = rs.getInt("USER_ID");
                                String fullName = rs.getString("FNAME") + " " + rs.getString("LNAME");
                                String email = rs.getString("EMAIL");
                                String password = rs.getString("password");
                                String mobile = rs.getString("MOBILE_NO");
                                String gender = rs.getString("GENDER");
                                int roleId = rs.getInt("ROLE_ID");
                                String address = rs.getString("ADDRESS");
                                byte[] imgBytes = rs.getBytes("USER_IMAGE");
                                String base64Image = "";
                                if (imgBytes != null) {
                                    base64Image = java.util.Base64.getEncoder().encodeToString(imgBytes);
                                }
                                String UserImage = "data:image/jpeg;base64," + base64Image;
                                java.sql.Date createdAt = rs.getDate("CREATED_AT");

                    %>
                    <tr>
                        <td class="table-plus">
                            <div class="name-avatar d-flex align-items-center">
                                <div class="avatar mr-2 flex-shrink-0">
                                    <img
                                            src="<%=UserImage%>"
                                            class="border-radius-100 shadow"
                                            width="40"
                                            height="40"
                                            alt=""
                                    />
                                </div>
                                <div class="txt">
                                    <div class="weight-600"><%=fullName%>
                                    </div>
                                </div>
                            </div>
                        </td>
                        <td><%=email%>
                        </td>
                        <td><%=password%>
                        </td>
                        <td><%=mobile%>
                        </td>
                        <td><%=address%>
                        </td>
                        <td><%=createdAt%>
                        </td>
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

                                <a href="#" class="btn deleteBtn"
                                   data-id="<%=userId%>"
                                   data-toggle="modal" data-target="#deleteModal">
                                    <i class="icon-copy dw dw-delete-3"></i>
                                </a>
                            </div>
                        </td>
                    </tr>
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
                    </tbody>
                </table>
            </div>
        </div>

    </div>
</div>
<!-- welcome modal start -->

<!-- Add modal start -->
<div
        class="modal fade bs-example-modal-lg"
        id="addCourse"
        tabindex="-1"
        role="dialog"
        aria-labelledby="myLargeModalLabel"
        aria-hidden="true"
>
    <div class="modal-dialog modal-md modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myLargeModalLabel">
                    Add Librarian
                </h4>
                <button
                        type="button"
                        class="close"
                        data-dismiss="modal"
                        aria-hidden="true"
                >
                    x
                </button>
            </div>
            <div class="modal-body">
                <form class="register-form" action="../Register" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="source" value="admin"/>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <input type="text" name="firstname" class="form-control" placeholder="First Name *"
                                       required/>
                            </div>
                            <div class="form-group">
                                <input type="text" name="lastname" class="form-control" placeholder="Last Name *"
                                       required/>
                            </div>
                            <div class="form-group">
                                <input type="text" name="mobile" minlength="10" maxlength="10" class="form-control"
                                       placeholder="Your Phone *" required/>
                            </div>
                            <div class="form-group">
                                <input type="text" name="address" class="form-control" placeholder="Your Address *"
                                       required>
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
                                <input type="email" name="email" class="form-control" placeholder="Your Email *"
                                       required/>
                            </div>
                            <div class="form-group">
                                <input type="password" name="password" class="form-control" placeholder="Password *"
                                       required/>
                            </div>
                            <div class="form-group">
                                <select class="form-control" name="role" required>
                                    <option class="hidden" selected disabled>Role</option>
                                    <option value="2">Librarian</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <input type="file" name="userimage" class="form-control" required/>
                            </div>
                            <div class="d-flex" style="gap: 20px;">
                                <input type="submit" value="Add" class="btn btn-primary w-75"/>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<!--End Add modal start -->


<!-- ============(Delete)=========================================== -->

<div class="modal fade bs-example-modal-lg" id="deleteModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Delete Student</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body">
                <form action="../DeleteUserServlet" method="post">
                    <p>Are you sure you want to delete this Librarian ?</p>
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
<script>
        document.addEventListener('DOMContentLoaded', function () {
        const deleteButtons = document.querySelectorAll('.deleteBtn');
        const deleteIdInput = document.getElementById('deleteId');

        deleteButtons.forEach(btn => {
        btn.addEventListener('click', function () {
        const userId = this.getAttribute('data-id');
        deleteIdInput.value = userId;
    });
    });
    });
</script>

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


