<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: lakha
  Date: 22-06-2025
  Time: 12:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<div class="pre-loader">
    <div class="pre-loader-box">
        <div class="loader-logo">
            <img src="../vendors/images/deskapp-logo.svg" alt=""/>
        </div>
        <div class="loader-progress" id="progress_div">
            <div class="bar" id="bar1"></div>
        </div>
        <div class="percent" id="percent1">0%</div>
        <div class="loading-text">Loading...</div>
    </div>
</div>

<%
    HttpSession session1 = request.getSession(false);
    String name = null;
    String image = null;

    if (session != null) {
        name = (String) session1.getAttribute("userName");
        image = (String) session1.getAttribute("image");

        // Optional: Debug
        // out.println("Session: name = " + name + ", image = " + image + "<br>");
    }
%>

<div class="header">
    <div class="header-left">
        <div class="menu-icon bi bi-list"></div>
    </div>

    <% if (name != null) { %> <!-- Only check name -->
    <div class="header-right">
        <div class="user-info-dropdown">
            <div class="dropdown">
                <a class="dropdown-toggle" href="#" role="button" data-toggle="dropdown">
                <span class="user-icon">
                    <img src="<%= (image != null) ? image : "#" %>"
                         alt="Profile"
                         style="width: 48px; height: 48px; border-radius: 50%; object-fit: cover;" />
                </span>
                    <span class="user-name"><%= name %></span>
                </a>
                <div class="dropdown-menu dropdown-menu-right dropdown-menu-icon-list">
                    <a class="dropdown-item" href="profile.jsp">
                        <i class="dw dw-user1"></i> Profile
                    </a>
                    <a class="dropdown-item" href="<%= request.getContextPath() %>/LogoutServlet">
                        <i class="dw dw-logout"></i> Log Out
                    </a>
                </div>
            </div>
        </div>
    </div>
    <% } else { %>
    <div class="header-right">
        <p style="color: red;">Session expired or user not logged in.</p>
    </div>
    <% } %>
</div>

<div class="right-sidebar">

    <div class="right-sidebar-body customscroll">
        <div class="right-sidebar-body-content">
            <div class="sidebar-btn-group pb-30 mb-10">
                <a
                        href="javascript:void(0);"
                        class="btn btn-outline-primary header-white active"
                >White</a
                >
            </div>

            <div class="sidebar-btn-group pb-30 mb-10">
                <a
                        href="javascript:void(0);"
                        class="btn btn-outline-primary sidebar-light"
                >White</a
                >
            </div>
        </div>
    </div>
</div>

<div class="left-side-bar">
    <div class="brand-logo">
        <a href="index.jsp">
            <img src="../vendors/images/deskapp-logo.svg" alt="" class="dark-logo"/>
            <img
                    src="../vendors/images/deskapp-logo-white.svg"
                    alt=""
                    class="light-logo"
            />
        </a>
        <div class="close-sidebar" data-toggle="left-sidebar-close">
            <i class="ion-close-round"></i>
        </div>
    </div>
    <div class="menu-block customscroll">
        <div class="sidebar-menu">
            <ul id="accordion-menu">
                <li>
                    <a href="index.jsp" class="dropdown-toggle no-arrow">
								<span class="micon bi bi-house"></span
                                ><span class="mtext">Dashboard</span>
                    </a>
                </li>
                <li class="dropdown">
                    <a href="javascript:" class="dropdown-toggle">
								<span class="micon bi bi-person-lines-fill"></span
                                ><span class="mtext">Librarian</span>
                    </a>
                    <ul class="submenu">
                        <li><a href="ManageLibrarian.jsp">Manage Librarian</a></li>
                    </ul>
                    <ul class="submenu">
                        <li><a href="faculty.jsp">Librarianes List</a></li>
                    </ul>
                </li>
                <li class="dropdown">
                    <a href="javascript:" class="dropdown-toggle">
								<span class="micon bi bi-journal-bookmark"></span
                                ><span class="mtext">Books</span>
                    </a>
                    <ul class="submenu">
                        <li><a href="addCourse.jsp">Add Books</a></li>
                    </ul>
                    <ul class="submenu">
                        <li><a href="course.jsp">Books List</a></li>
                    </ul>
                </li>
                <li>
                    <a href="studentQuery.jsp" class="dropdown-toggle no-arrow">
                        <span class="micon bi bi-mortarboard-fill"></span>
                        <span class="mtext">Students</span>
                    </a>
                </li>
                <li>
                    <a href="profile.jsp" class="dropdown-toggle no-arrow">
                        <span class="micon bi-person-circle"></span>
                        <span class="mtext">Profile</span>
                    </a>
                </li>
                <li>
                    <div class="dropdown-divider"></div>
                </li>
            </ul>
        </div>
    </div>
</div>

<div class="mobile-menu-overlay"></div>
</body>
</html>
