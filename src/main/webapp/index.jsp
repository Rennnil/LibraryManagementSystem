<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
</head>
<body>
<h1><%= "Hello World!" %>
</h1>
<br/>
<a href="hello-servlet">Hello Servlet</a>


<%
    HttpSession session1 = request.getSession(false); // don't create if not exists
    String userName = null;
    String image = null;

    if (session1 != null) {
        userName = (String) session1.getAttribute("userName");
        image = (String) session1.getAttribute("image");
    }
%>

<% if (userName != null) { %>
<h2>Welcome, <%= userName %>!</h2>
<img src="<%= image %>" alt="Profile Image" width="100" height="100" style="border-radius:50px;">
<% } else { %>
<h2>Welcome, Guest!</h2>
<p>Please <a href="login.jsp">log in</a> to access your dashboard.</p>
<% } %>

</body>
</html>