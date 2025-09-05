<%--
  Created by IntelliJ IDEA.
  User: lakha
  Date: 15-07-2025
  Time: 17:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.Base64" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Lilbrio - Bookstore </title>
    <link rel="icon" type="image/png" href="../User/images/Logo.png">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        .user-label {
            font-weight: bold;
            color: #212529; /* text-dark */
        }
        .user-value {
            font-weight: bold;
            color: #212529;
        }
        .edit-btn {
            font-size: 0.75rem; /* smaller text */
            padding: 4px 12px;  /* smaller padding */
        }
    </style>
</head>
<body>
<jsp:include page="Header.jsp" flush="true"></jsp:include>

<%
    PrintWriter pw = response.getWriter();
    String sessionFname = (String) session.getAttribute("userName");

    if (sessionFname == null) {
%>
<div class="container mt-5">
    <div class="alert alert-warning">Please login first.</div>
</div>
<%
} else {
    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "system");

        String sql = "SELECT * FROM users WHERE FNAME = ?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, sessionFname);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            int userId = rs.getInt("USER_ID");
            String fname = rs.getString("FNAME");
            String lname = rs.getString("LNAME");
            String email = rs.getString("EMAIL");
            String mobile = rs.getString("MOBILE_NO");
            String gender = rs.getString("GENDER");
            String address = rs.getString("ADDRESS");

            byte[] imgBytes = rs.getBytes("IMAGE");
            String imageSrc;
            if (imgBytes != null && imgBytes.length > 0) {
                String base64Image = Base64.getEncoder().encodeToString(imgBytes);
                imageSrc = "data:image/jpeg;base64," + base64Image;
            } else {
                imageSrc = "vendors/images/default-avatar.png";
            }
%>

<div class="container mt-5">
    <div class="row gutters-sm">
        <div class="col-md-4 mb-3">
            <div class="card">
                <div class="card-body text-center">
                    <img src="<%=imageSrc%>" alt="User Image" class="rounded-circle mb-3" width="150">
                    <h4><%=fname + " " + lname%></h4>
                </div>
            </div>
        </div>

        <div class="col-md-8">
            <div class="card mb-3">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0">User Information</h5>
                </div>
                <div class="card-body">

                    <div class="row mb-3">
                        <div class="col-sm-3 user-label">Full Name</div>
                        <div class="col-sm-9 user-value"><%=fname + " " + lname%></div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-sm-3 user-label">Email</div>
                        <div class="col-sm-9 user-value"><%=email%></div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-sm-3 user-label">Phone</div>
                        <div class="col-sm-9 user-value"><%=mobile%></div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-sm-3 user-label">Gender</div>
                        <div class="col-sm-9 user-value"><%=gender%></div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-sm-3 user-label">Address</div>
                        <div class="col-sm-9 user-value"><%=address%></div>
                    </div>

                    <div class="row">
                        <div class="col-sm-6 text-left">
                            <a href="EditUserProfile.jsp?id=<%=userId%>" class="btn btn-primary edit-btn">Edit Profile</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%
            }
            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            pw.println("<div class='container mt-5'><div class='alert alert-danger'>Error: " + e.getMessage() + "</div></div>");
        }
    }
%>

</body>
</html>

