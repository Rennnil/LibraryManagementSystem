<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %>
<%--
  Created by IntelliJ IDEA.
  User: lakha
  Date: 15-07-2025
  Time: 11:47
  To change this template use File | Settings | File Templates.
--%>

<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Base64" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Lilbrio - Bookstore </title>
    <link rel="icon" type="image/png" href="../User/images/Logo.png">

    <!-- Bootstrap & Font Awesome -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        body {
            background: #eef1f7;
        }

        .card {
            border: none;
            border-radius: 14px;
            transition: all 0.3s ease-in-out;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
            height: 100%;
        }

        .card:hover {
            transform: translateY(-4px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.12);
        }

        .card-img-top {
            height: 220px;
            width: 100%;
            object-fit: contain;
            padding: 10px;
            background-color: #f9f9f9;
            border-top-left-radius: 14px;
            border-top-right-radius: 14px;
        }

        .card-body {
            padding: 0.75rem;
            background-color: #fff;
        }

        .book-title {
            font-weight: 600;
            font-size: 1rem;
            color: #212529;
            margin-bottom: 0.4rem;
        }

        .book-meta {
            font-size: 0.75rem;
            color: #666;
            margin-bottom: 0.3rem;
        }

        .badge-category {
            background-color: #17a2b8;
            font-size: 0.7rem;
            padding: 3px 6px;
            border-radius: 10px;
        }

        .card-footer {
            background: #f8f9fa;
            border-top: 1px solid #e9ecef;
            border-bottom-left-radius: 14px;
            border-bottom-right-radius: 14px;
            padding: 0.75rem 0.5rem;
            text-align: center;
        }

        .btn-outline-primary {
            border-radius: 20px;
            font-size: 0.8rem;
            padding: 6px 16px;
        }
    </style>
</head>
<body>

<jsp:include page="Header.jsp" flush="true"></jsp:include>

<div class="container mt-4">
    <div class="row">

        <%
            PrintWriter pw = response.getWriter();
            Connection con = null;
            Statement st = null;
            ResultSet rs = null;
            int count = 0;

            try {
                Class.forName("oracle.jdbc.driver.OracleDriver");
                con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "system");
                st = con.createStatement();
                rs = st.executeQuery("SELECT * FROM BOOK");

                while (rs.next()) {
                    if (count > 0 && count % 4 == 0) {
        %>
    </div>
    <div class="row">
        <%
            }

            int bookId = rs.getInt("BOOK_ID");
            int userId = rs.getInt("USER_ID");
            String title = rs.getString("TITLE");
            String author = rs.getString("AUTHOR");
            String publisher = rs.getString("PUBLISHER");
            String category = rs.getString("CATEGORY");
            int year = rs.getInt("YEAR_PUBLISHED");
            int qty = rs.getInt("QNTY");
            int available = rs.getInt("AVAILABLE_QNTY");
            double rating = rs.getDouble("RATING");
            byte[] imgBytes = rs.getBytes("BOOK_IMAGE");
            String imageSrc = "data:image/jpeg;base64," + Base64.getEncoder().encodeToString(imgBytes);

            int fullStars = (int) rating;
            boolean halfStar = (rating - fullStars) >= 0.5;
            int emptyStars = 5 - fullStars - (halfStar ? 1 : 0);

            StringBuilder starHtml = new StringBuilder();
            for (int i = 0; i < fullStars; i++) {
                starHtml.append("<i class='fas fa-star text-warning'></i> ");
            }
            if (halfStar) {
                starHtml.append("<i class='fas fa-star-half-alt text-warning'></i> ");
            }
            for (int i = 0; i < emptyStars; i++) {
                starHtml.append("<i class='far fa-star text-warning'></i> ");
            }

            // Normalize and assign color class based on category
            String categoryNormalized = category.trim().toLowerCase();
            String categoryClass = "";

            switch (categoryNormalized) {
                case "novels":
                    categoryClass = "bg-primary text-white";
                    break;
                case "romance":
                case "rommance":
                    categoryClass = "bg-danger text-white";
                    break;
                case "children":
                case "children's fiction":
                    categoryClass = "bg-warning text-dark";
                    break;
                case "dystopian":
                    categoryClass = "bg-dark text-white";
                    break;
                case "history":
                    categoryClass = "bg-success text-white";
                    break;
                case "horror":
                    categoryClass = "bg-secondary text-white";
                    break;
                case "mystery":
                case "mystery/thriller":
                    categoryClass = "bg-info text-white";
                    break;
                case "mythology":
                    categoryClass = "bg-light text-dark border";
                    break;
                default:
                    categoryClass = "bg-secondary text-white";
                    break;
            }
        %>

        <div class="col-md-3 mb-4">
            <div class="card h-100 d-flex flex-column justify-content-between">
                <img src="<%= imageSrc %>" class="card-img-top" alt="Book Image">
                <div class="card-body">
                    <%
                        String displayTitle = title;
                        if (title != null && title.length() > 15) {
                            displayTitle = title.substring(0, 15) + "...";
                        }
                    %>
                    <h5 class="book-title" title="<%= title %>"><%= displayTitle %></h5>
                    <p class="book-meta"><i class="fas fa-user text-muted"></i> <strong>Author:</strong> <%= author %></p>
                    <p class="book-meta"><i class="fas fa-building text-muted"></i> <strong>Publisher:</strong> <%= publisher %></p>
                    <span class="badge rounded-pill <%= categoryClass %> mb-2">
                        <i class="fas fa-tag"></i> <%= category %>
                    </span>
                    <p class="book-meta"><i class="fas fa-calendar-alt text-muted"></i> <strong>Year:</strong> <%= year %></p>
                    <p class="book-meta"><strong>Rating:</strong> <%= starHtml.toString() %></p>
                    <p class="book-meta">
                        <i class="fas fa-check-circle text-success"></i>
                        <strong><%= available %></strong> / <%= qty %> Available
                    </p>
                </div>
                <div class="card-footer">
                    <form method="post" action="../IssueBookServlet">
                        <input type="hidden" name="bookId" value="<%= bookId %>">
                        <input type="hidden" name="userId" value="<%= userId %>">
                        <button class="btn btn-outline-primary" type="submit">
                            <i class="fas fa-book-reader"></i> Borrow
                        </button>
                    </form>
                </div>
            </div>
        </div>

        <%
                    count++;
                }
            } catch (Exception e) {
                pw.println("<div class='alert alert-danger mt-4'>Error: " + e.getMessage() + "</div>");
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (st != null) st.close();
                    if (con != null) con.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        %>

    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>



