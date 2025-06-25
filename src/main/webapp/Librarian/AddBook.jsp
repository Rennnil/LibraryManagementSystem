<%--
  Created by IntelliJ IDEA.
  User: lakha
  Date: 19-06-2025
  Time: 14:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="p1.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.Statement" %>
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

<jsp:include page="HeaderSidebar.jsp" flush="true"></jsp:include>

<div class="main-container">
    <div class="pd-ltr-20 xs-pd-20-10">
        <div class="min-height-200px">
            <div class="page-header">
                <div class="row">
                    <div class="col-md-6 col-sm-12">
                        <div class="title">
                            <h4>DataTable</h4>
                        </div>
                        <nav aria-label="breadcrumb" role="navigation">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item">
                                    <a href="index.jsp">Home</a>
                                </li>
                                <li class="breadcrumb-item active" aria-current="page">
                                    DataTable
                                </li>
                            </ol>
                        </nav>
                    </div>
                    <div class="col-md-6 col-sm-12 text-right">
                        <div>
                            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addCourse">
                                Add Book
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Export Datatable start -->
            <div class="card-box pb-10">
                <div class="h5 pd-20 mb-0">Recent Books</div>
                <table class=" table nowrap  data-table-export ">
                    <thead>
                    <tr>
                        <th class="table-plus">Title</th>
                        <th>Author</th>
                        <th>Publisher</th>
                        <th>Category</th>
                        <th>Published Year</th>
                        <th>Quentity</th>
                        <th>Available Quentity</th>
                        <th class="datatable-nosort">Actions</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        try {
                            Class.forName("oracle.jdbc.driver.OracleDriver");
                            java.sql.Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "system");
                            Statement st=con.createStatement();
                            String sql = "SELECT * FROM BOOK ORDER BY BOOK_ID DESC";
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
                    <tr>
                        <td class="table-plus">
                            <div class="name-avatar d-flex align-items-center">
                                <div class="avatar mr-2 flex-shrink-0">
                                    <img
                                            src="<%= imageSrc %>"
                                            style="width: 50px; height: 50px; object-fit: cover; border-radius: 1000px; box-shadow: 0 0 5px rgba(0,0,0,0.1); display: block;"
                                            alt="Book Cover"
                                    />
                                </div>
                                <div class="book-title">
                                    <div class="weight-600"><%=title%>
                                    </div>
                                </div>
                            </div>
                        </td>
                        <%--                        <td class="book-id"><%=bookId%></td>--%>
                        <td class="book-author"><%=author%></td>
                        <td class="book-publisher"><%=publisher%></td>
                        <td class="book-category"><%=category%></td>
                        <td class="book-year"><%=year%></td>
                        <td class="book-qty"><%=qty%></td>
                        <td class="book-available"><%=available%></td>
                        <td>
                            <div class="table-actions">
                                <a href="#"
                                   class="btn"
                                   data-color="#265ed7"
                                   data-id="<%=bookId%>"
                                   data-toggle="modal"
                                   data-target="#editCourse">
                                    <i class="icon-copy dw dw-edit2"></i>
                                </a>

                                <a href="#"
                                   class="btn open-delete-modal"
                                   data-id="<%=bookId%>"
                                   data-color="#e95959"
                                   data-toggle="modal"
                                   data-target="#deleteModal">
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
            <!-- Export Datatable End -->
        </div>

    </div>
</div>
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
                    Add Book
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
                <form action="../AddBook" method="post" enctype="multipart/form-data">
                    <div class="mb-3">
                        <label for="exampleInputEmail1">Title</label>
                        <input type="text" name="title" class="form-control">
                    </div>
                    <div class="mb-3">
                        <label for="exampleInputPassword1">Author</label>
                        <input type="text" name="author" class="form-control">
                    </div>
                    <div class="mb-3">
                        <label for="exampleInputEmail1">Publisher</label>
                        <input type="text" name="publisher" class="form-control">
                    </div>
                    <div class="mb-3">
                        <label for="exampleInputPassword1">Category</label>
                        <input type="text" name="category" class="form-control">
                    </div>
                    <div class="mb-3">
                        <label for="exampleInputEmail1">Published Year</label>
                        <input type="text" name="publishedyear" class="form-control">
                    </div>
                    <div class="mb-3">
                        <label for="exampleInputPassword1">Qty</label>
                        <input type="number" name="qty" class="form-control">
                    </div>
                    <div class="mb-3">
                        <label for="exampleInputPassword1">Book Image</label>
                        <input type="file" name="bookimage" class="form-control">
                    </div>

                    <div class="d-flex" style="gap: 20px;">
                        <button type="submit" class="btn btn-primary w-75">Add Book</button>
                        <button
                                type="button"
                                class="btn btn-danger w-25"
                                data-dismiss="modal"
                        >
                            Close
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<!--End Add modal start -->

<!-- ============(Edit)=========================================== -->

<div
        class="modal fade bs-example-modal-lg"
        id="editCourse"
        tabindex="-1"
        role="dialog"
        aria-labelledby="myLargeModalLabel"
        aria-hidden="true"
>
    <div class="modal-dialog modal-md modal-dialog-centered">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myLargeModalLabel">
                    Edit Book
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
                <form action="../UpdateBook" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="bookId" id="editBookId">

                    <div class="mb-3">
                        <label for="exampleInputEmail1" >Title</label>
                        <input type="text" name="title" id="editTitle" class="form-control">
                    </div>
                    <div class="mb-3">
                        <label for="exampleInputPassword1">Author</label>
                        <input type="text" name="author" id="editAuthor" class="form-control">
                    </div>
                    <div class="mb-3">
                        <label for="exampleInputEmail1" >Publisher</label>
                        <input type="text" name="publisher" id="editPublisher"  class="form-control" >
                    </div>
                    <div class="mb-3">
                        <label for="exampleInputPassword1">Category</label>
                        <input type="text" name="category" id="editCategory" class="form-control">
                    </div>
                    <div class="mb-3">
                        <label for="exampleInputEmail1" >Published Year</label>
                        <input type="text" name="publishedyear"  id="editYear" class="form-control" >
                    </div>
                    <div class="mb-3">
                        <label for="exampleInputPassword1">Qty</label>
                        <input type="number" name="qty" id="editQty" class="form-control">
                    </div>
                    <div class="mb-3">
                        <label for="exampleInputPassword1">Book Image</label>
                        <input type="file" name="bookimage" class="form-control" >
                    </div>

                    <div class="d-flex" style="gap: 20px;">
                        <button type="submit" class="btn btn-primary w-75">Add Book</button>
                        <button
                                type="button"
                                class="btn btn-danger w-25"
                                data-dismiss="modal"
                        >
                            Close
                        </button>
                    </div>

                </form>
            </div>

        </div>
    </div>
</div>

<!-- ============(Delete)=========================================== -->


<div class="modal fade bs-example-modal-lg" id="deleteModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Delete Book</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body">
                <form action="../DeleteBook" method="get">
                    <p>Are you sure you want to delete this Book ?</p>
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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function () {
        $('.btn').click(function () {
            // Find the closest <tr> of the clicked button
            var row = $(this).closest('tr');

            // Get values from table cells
            var bookId = $(this).data('id');
            var title = row.find('.book-title .weight-600').text().trim();
            var author = row.find('.book-author').text().trim();
            var publisher = row.find('.book-publisher').text().trim();
            var category = row.find('.book-category').text().trim();
            var year = row.find('.book-year').text().trim();
            var qty = row.find('.book-qty').text().trim();

            // Set modal input values
            $('#editBookId').val(bookId);
            $('#editTitle').val(title);
            $('#editAuthor').val(author);
            $('#editPublisher').val(publisher);
            $('#editCategory').val(category);
            $('#editYear').val(year);
            $('#editQty').val(qty);
        });
    });
</script>

<script>
    $(document).ready(function () {
        // When a delete button is clicked
        $('.open-delete-modal').on('click', function () {
            var bookId = $(this).data('id');       // gets book ID from button
            $('#deleteId').val(bookId);            // sets the hidden input value
        });

    });
</script>


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

