<%@ page import="java.util.Base64" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.PrintWriter" %><%--
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
    <title>Lilbrio - Bookstore </title>
    <link rel="icon" type="image/png" href="../User/images/Logo.png">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <h2 class="mb-4">Search Results for "<%= searchTerm %>"</h2>
    <div class="row">
        <%
            try {
                Class.forName("oracle.jdbc.driver.OracleDriver");
                conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "your_username", "your_password");

                String sql = "SELECT * FROM books WHERE LOWER(title) LIKE ? OR LOWER(author) LIKE ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, "%" + searchTerm.toLowerCase() + "%");
                pstmt.setString(2, "%" + searchTerm.toLowerCase() + "%");
                rs = pstmt.executeQuery();

                boolean hasBooks = false;

                while (rs.next()) {
                    hasBooks = true;
                    String title = rs.getString("title");
                    String author = rs.getString("author");
                    String category = rs.getString("category");
                    String description = rs.getString("description");
                    int rating = rs.getInt("rating");

                    StringBuilder starHtml = new StringBuilder();
                    for (int i = 1; i <= rating; i++) starHtml.append("<i class='fas fa-star text-warning'></i> ");
                    for (int i = rating + 1; i <= 5; i++) starHtml.append("<i class='far fa-star text-warning'></i> ");

                    String categoryNormalized = category != null ? category.trim().toLowerCase() : "";
                    String categoryClass;
                    switch (categoryNormalized) {
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
        <div class="col-md-4 mb-4">
            <div class="card h-100 shadow-sm">
                <div class="card-body">
                    <h5 class="card-title"><%= title %></h5>
                    <h6 class="card-subtitle mb-2 text-muted">by <%= author %></h6>
                    <span class="badge <%= categoryClass %>"><%= category %></span>
                    <p class="card-text mt-2"><%= description %></p>
                </div>
                <div class="card-footer">
                    <%= starHtml.toString() %>
                </div>
            </div>
        </div>
        <%
            }

            if (!hasBooks) {
        %>
        <div class="col-12">
            <div class="alert alert-warning text-center">No books found for "<%= searchTerm %>"</div>
        </div>
        <%
                }

            } catch (Exception e) {
                pw.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
            } finally {
                try { if (rs != null) rs.close(); } catch (Exception e) {}
                try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
                try { if (conn != null) conn.close(); } catch (Exception e) {}
            }
        %>
    </div>
</div>

</body>
</html>
