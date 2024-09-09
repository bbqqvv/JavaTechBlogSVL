<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="entities.User" %>
<%@ page import="entities.Message" %>
<%
    // Lấy thông tin người dùng từ session
    User user = (User) session.getAttribute("currentUser");

    // Kiểm tra nếu chưa đăng nhập thì chuyển hướng đến trang login.jsp
    if (user == null) {
        response.sendRedirect("login.jsp");
        return; // Dừng việc xử lý trang
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông tin người dùng</title>

    <%@ include file="links.jsp" %>
    <style>
        body {
            background-color: #f8f9fa;
        }

        .navbar {
            margin-bottom: 1rem;
        }

        .alert {
            margin: 1rem;
        }

        .container {
            margin-top: 2rem;
        }

        .profile-header h1 {
            color: #343a40;
        }

        .btn-logout {
            color: #007bff;
            text-decoration: none;
        }

        .btn-logout:hover {
            text-decoration: underline;
        }

        @media (max-width: 768px) {
            .navbar-nav {
                text-align: center;
            }
            .navbar-nav .nav-link {
                padding: 0.5rem 1rem;
            }
        }
    </style>
</head>
<body>
<!-- Navbar -->
<%@include file="navbar_profile.jsp"%>
<!-- Main Content -->
<main class="container">
    <%
        Message m = (Message) session.getAttribute("msg");
        if (m != null) {
    %>
    <div class="alert <%= m.getCssClass() %>" role="alert">
        <%= m.getContent() %>
    </div>
    <%
            session.removeAttribute("msg");
        }
    %>

    <div class="profile-header">
        <h1>Chào mừng, <%= user.getEmail() %>!</h1>
        <p>Bạn đã đăng nhập thành công.</p>
        <a href="<%= application.getContextPath() %>/login_page.jsp" class="btn-logout">Đăng xuất</a>
    </div>
</main>

<%@ include file="links.jsp" %>
</body>
</html>
