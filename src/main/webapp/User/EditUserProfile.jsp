<%--
  Created by IntelliJ IDEA.
  User: lakha
  Date: 15-07-2025
  Time: 18:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Base64" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Lilbrio - Bookstore </title>
    <link rel="icon" type="image/png" href="../User/images/Logo.png">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        /* Global font and spacing adjustments */
        body {
            font-size: 14px;
        }

        /* Form inputs and controls */
        .form-control,
        .form-control-file,
        .form-check-input {
            font-size: 14px;
            padding: 0.3rem 0.5rem;
            height: auto;
        }

        /* Form labels and header titles */
        .form-group label,
        .card-header h5 {
            font-size: 14px;
            font-weight: 500;
            margin-bottom: 0.25rem;
        }

        /* Card container */
        .card {
            margin-bottom: 15px;
            border: 1px solid #dee2e6;
            border-radius: 0.25rem;
        }

        /* Card header style */
        .card-header {
            padding: 0.5rem 1rem;
            background-color: #007bff;
            color: white;
            border-bottom: 1px solid #dee2e6;
        }

        /* Card body padding */
        .card-body {
            padding: 1rem;
        }

        /* Enlarged circular profile image */
        .rounded-circle {
            width: 150px;
            height: 150px;
            object-fit: cover;
            border: 2px solid #ccc;
        }

        /* File input spacing */
        .form-control-file {
            margin-top: 10px;
        }

        /* Layout container size */
        .container {
            max-width: 960px;
        }

        /* Right-align submit button */
        .form-group.text-right {
            text-align: right;
        }

        /* Small submit button styling */
        .btn-sm {
            padding: 0.3rem 0.75rem;
            font-size: 0.875rem;
        }
    </style>

</head>
<body>
<jsp:include page="Header.jsp" flush="true" />

<%
    PrintWriter pw= response.getWriter();
    String id = request.getParameter("id");
    String fname = "", lname = "", email = "", mobile = "", address = "";
    String imageSrc = "vendors/images/default-avatar.png";

    try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "system");

        PreparedStatement ps = con.prepareStatement("SELECT * FROM users WHERE USER_ID = ?");
        ps.setString(1, id);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            fname = rs.getString("FNAME");
            lname = rs.getString("LNAME");
            email = rs.getString("EMAIL");
            mobile = rs.getString("MOBILE_NO");
            address = rs.getString("ADDRESS");

            byte[] imgBytes = rs.getBytes("IMAGE");
            if (imgBytes != null && imgBytes.length > 0) {
                imageSrc = "data:image/jpeg;base64," + Base64.getEncoder().encodeToString(imgBytes);
            }
        }

        rs.close();
        ps.close();
        con.close();
    } catch (Exception e) {
        pw.println("<div class='container mt-3'><div class='alert alert-danger'>Error: " + e.getMessage() + "</div></div>");
    }
%>

<div class="container mt-3">
    <form method="post" action="../EditUserProfileServlet" enctype="multipart/form-data">
        <input type="hidden" name="id" value="<%=id%>" />
        <div class="row">
            <!-- Left: Image Upload -->
            <div class="col-md-4">
                <div class="card text-center">
                    <div class="card-body">
                        <img src="<%=imageSrc%>" alt="User Image" class="rounded-circle mb-2">
                        <input type="file" name="editimage" class="form-control-file mt-2" />
                    </div>
                </div>
            </div>

            <!-- Right: Form -->
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0">Edit User Profile</h5>
                    </div>
                    <div class="card-body">
                        <div class="form-row">
                            <div class="form-group col-sm-6">
                                <label>First Name</label>
                                <input type="text" name="fname" value="<%=fname%>" class="form-control" required>
                            </div>
                            <div class="form-group col-sm-6">
                                <label>Last Name</label>
                                <input type="text" name="lname" value="<%=lname%>" class="form-control" required>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group col-sm-6">
                                <label>Email</label>
                                <input type="email" name="email" value="<%=email%>" class="form-control" required>
                            </div>
                            <div class="form-group col-sm-6">
                                <label>Mobile</label>
                                <input type="text" name="mobile" value="<%=mobile%>" class="form-control" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label>Address</label>
                            <input type="text" name="address" value="<%=address%>" class="form-control" />
                        </div>

                        <div class="form-group text-right mb-0">
                            <button type="submit" class="btn btn-sm btn-primary">Update Profile</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>

</body>
</html>




