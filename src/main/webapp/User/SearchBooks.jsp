<%@ page import="java.util.Base64" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.PrintWriter" %>
<%--
  Created by IntelliJ IDEA.
  User: lakha
  Date: 04-08-2025
  Time: 12:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    PrintWriter pw=response.getWriter();
    String searchTerm = request.getParameter("s");
    if (searchTerm == null || searchTerm.trim().isEmpty()) {
        searchTerm = "";
    }

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
%>
<!DOCTYPE html>
<html>
<head>
    <title>Lilbrio - Bookstore</title>
    <link rel="icon" type="image/png" href="../User/images/Logo.png">

    <!-- Bootstrap & Font Awesome -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        body { background: #eef1f7; }
        .card {
            border: none; border-radius: 14px;
            transition: all 0.3s ease-in-out;
            box-shadow: 0 5px 15px rgba(0,0,0,0.08);
            height: 100%;
        }
        .card:hover { transform: translateY(-4px); box-shadow: 0 10px 20px rgba(0,0,0,0.12); }
        .card-img-top {
            height: 220px; width: 100%; object-fit: contain;
            padding: 10px; background-color: #f9f9f9;
            border-top-left-radius: 14px; border-top-right-radius: 14px;
        }
        .card-body { padding: 0.75rem; background-color: #fff; }
        .book-title { font-weight: 600; font-size: 1rem; color: #212529; margin-bottom: 0.4rem; }
        .book-meta { font-size: 0.75rem; color: #666; margin-bottom: 0.3rem; }
        .card-footer {
            background: #f8f9fa; border-top: 1px solid #e9ecef;
            border-bottom-left-radius: 14px; border-bottom-right-radius: 14px;
            padding: 0.75rem 0.5rem; text-align: center;
        }
        .btn-outline-primary { border-radius: 20px; font-size: 0.8rem; padding: 6px 16px; }
    </style>
</head>

<body>
<jsp:include page="Header.jsp" flush="true"></jsp:include>

<div class="container mt-4">

    <div class="row">
        <%
            Connection con = null;
            int count = 0;

            try {
                Class.forName("oracle.jdbc.driver.OracleDriver");
                con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "system");

                String sql;
                if (searchTerm != null && !searchTerm.trim().isEmpty()) {
                    sql = "SELECT * FROM BOOK WHERE LOWER(TITLE) LIKE ? OR LOWER(AUTHOR) LIKE ?";
                    pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, "%" + searchTerm.toLowerCase() + "%");
                    pstmt.setString(2, "%" + searchTerm.toLowerCase() + "%");
                } else {
                    sql = "SELECT * FROM BOOK";
                    pstmt = con.prepareStatement(sql);
                }

                rs = pstmt.executeQuery();
                boolean hasResults = false;

                while (rs.next()) {
                    hasResults = true;
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

        // Rating stars
        int fullStars = (int) rating;
        boolean halfStar = (rating - fullStars) >= 0.5;
        int emptyStars = 5 - fullStars - (halfStar ? 1 : 0);
        StringBuilder starHtml = new StringBuilder();
        for (int i = 0; i < fullStars; i++) starHtml.append("<i class='fas fa-star text-warning'></i> ");
        if (halfStar) starHtml.append("<i class='fas fa-star-half-alt text-warning'></i> ");
        for (int i = 0; i < emptyStars; i++) starHtml.append("<i class='far fa-star text-warning'></i> ");

        // Category color
        String categoryClass;
        switch (category.trim().toLowerCase()) {
            case "novels": categoryClass = "bg-primary text-white"; break;
            case "romance": case "rommance": categoryClass = "bg-danger text-white"; break;
            case "children": case "children's fiction": categoryClass = "bg-warning text-dark"; break;
            case "dystopian": categoryClass = "bg-dark text-white"; break;
            case "history": categoryClass = "bg-success text-white"; break;
            case "horror": categoryClass = "bg-secondary text-white"; break;
            case "mystery": case "mystery/thriller": categoryClass = "bg-info text-white"; break;
            case "mythology": categoryClass = "bg-light text-dark border"; break;
            default: categoryClass = "bg-secondary text-white";
        }
    %>
    <div class="col-md-3 mb-4">
        <div class="card h-100 d-flex flex-column justify-content-between">
            <img src="<%= imageSrc %>" class="card-img-top" alt="Book Image">
            <div class="card-body">
                <%
                    // Safely truncate the title to 15 characters
                    String displayTitle = "";
                    if (title != null) {
                        displayTitle = title.length() > 15 ? title.substring(0, 15) + "..." : title;
                    } else {
                        displayTitle = "No Title";
                    }
                %>

                <!-- Show only first 15 chars + ... -->
                <h5 class="book-title" title="<%= title %>"><%= displayTitle %></h5>

                <p class="book-meta">
                    <i class="fas fa-user text-muted"></i>
                    <strong>Author:</strong> <%= author %>
                </p>

                <p class="book-meta">
                    <i class="fas fa-building text-muted"></i>
                    <strong>Publisher:</strong> <%= publisher %>
                </p>

                <span class="badge rounded-pill <%= categoryClass %> mb-2">
                <i class="fas fa-tag"></i> <%= category %>
            </span>

                <p class="book-meta">
                    <i class="fas fa-calendar-alt text-muted"></i>
                    <strong>Year:</strong> <%= year %>
                </p>

                <p class="book-meta">
                    <strong>Rating:</strong> <%= starHtml.toString() %>
                </p>

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

        if (!hasResults) {
    %>
    <div class="col-12">
        <div class="alert alert-warning text-center">
            No books found for "<%= searchTerm %>"
        </div>
    </div>
    <%
            }

        } catch (Exception e) {
            pw.println("<div class='alert alert-danger mt-4'>Error: " + e.getMessage() + "</div>");
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception ex) {}
            try { if (pstmt != null) pstmt.close(); } catch (Exception ex) {}
            try { if (con != null) con.close(); } catch (Exception ex) {}
        }
    %>
</div>
</div>

<!-- Bootstrap JS -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

