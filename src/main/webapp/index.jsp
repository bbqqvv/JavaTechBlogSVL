<%@ page import="java.sql.Connection" %>
<%@ page import="helper.ConnectionProvider" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tech Blog</title>

    <%@include file="links.jsp" %>
</head>
<body>

<%@ include file="normal_navbar.jsp" %>

<div class="container-fluid p-0 banner-background">
    <div class="jumbotron">
        <div class="container">
            <h1 class="display-4">Welcome, Friends</h1>
            <h3>Tech Blog</h3>
            <p>Welcome to the world of technology</p>
            <a class="btn btn-outline-light me-2"><i class="fa-solid fa-play"></i> Start! It's Free</a>
            <a href="<%=application.getContextPath()%>/login_page.jsp" class="btn btn-outline-light"><i class="fa-regular fa-user"></i> Login</a>
        </div>
    </div>
</div>

<!-- Cards Section -->
<div class="container mt-5">
    <div class="row">
        <!-- Card 1 -->
        <div class="col-md-4 mb-4">
            <div class="card h-100">
                <img src="https://via.placeholder.com/300x200" class="card-img-top" alt="Java Programming">
                <div class="card-body">
                    <h5 class="card-title">Java Programming</h5>
                    <p class="card-text">Explore the world of Java programming with examples, tips, and best practices.</p>
                    <a href="#" class="btn btn-primary">Read more</a>
                </div>
            </div>
        </div>
        <!-- Card 2 -->
        <div class="col-md-4 mb-4">
            <div class="card h-100">
                <img src="https://via.placeholder.com/300x200" class="card-img-top" alt="Web Development">
                <div class="card-body">
                    <h5 class="card-title">Web Development</h5>
                    <p class="card-text">Learn about the latest trends and technologies in web development.</p>
                    <a href="#" class="btn btn-primary">Read more</a>
                </div>
            </div>
        </div>
        <!-- Card 3 -->
        <div class="col-md-4 mb-4">
            <div class="card h-100">
                <img src="https://via.placeholder.com/300x200" class="card-img-top" alt="Machine Learning">
                <div class="card-body">
                    <h5 class="card-title">Machine Learning</h5>
                    <p class="card-text">Dive into machine learning with tutorials and hands-on projects.</p>
                    <a href="#" class="btn btn-primary">Read more</a>
                </div>
            </div>
        </div>
    </div>
</div>
<%@include file="links.jsp" %>

</body>
</html>
