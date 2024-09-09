<%@ page import="com.google.protobuf.Message" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>

    <%@ include file="links.jsp" %>
    <!-- Additional styles -->
    <style>
        body {
            background-color: #f8f9fa;
        }

        .card {
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .card-header {
            background-color: #007bff;
            color: #ffffff;
            border-bottom: 1px solid #ddd;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
        }

        .card-body {
            padding: 2rem;
        }

        .form-label {
            font-weight: 500;
        }

        .form-text {
            color: #6c757d;
        }

        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }

        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #004085;
        }

        .form-check-label {
            margin-left: 0.5rem;
        }
    </style>
</head>
<body>
<%@ include file="normal_navbar.jsp" %>

<main class="d-flex align-items-center justify-content-center" style="height: 100vh;">
    <div class="container">
        <div class="row">
            <div class="col-md-6 col-lg-4 mx-auto">
                <div class="card">
                    <div class="card-header text-center">
                        <h5><i class="fa-regular fa-user"></i> Login Here</h5>
                    </div>

                    <%-- Kiểm tra và hiển thị thông báo nếu có --%>
                    <%
                        entities.Message m = (  entities.Message) session.getAttribute("msg");
                        if (m != null) {
                            String cssClass = (String) session.getAttribute("cssClass");
                            String content = m.getContent(); // Assuming getContent() returns a String
                    %>
                    <div class="alert <%= cssClass %>" role="alert">
                        <%= content %>
                    </div>
                    <%
                            // Xóa thông báo và lớp CSS sau khi hiển thị
                            session.removeAttribute("msg");
                            session.removeAttribute("cssClass");
                        }
                    %>

                    <div class="card-body">
                        <form action="login" method="post">
                            <div class="mb-3">
                                <label for="email" class="form-label">Email Address</label>
                                <input type="email" class="form-control" id="email" name="email"
                                       placeholder="Enter your email" required>
                                <div id="emailHelp" class="form-text">We'll never share your email with anyone else.
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="password" class="form-label">Password</label>
                                <input type="password" class="form-control" id="password" name="password"
                                       placeholder="Enter your password" required>
                            </div>
                            <div class="mb-3 form-check">
                                <input name="checked" type="checkbox" class="form-check-input" id="rememberMe">
                                <label class="form-check-label" for="rememberMe">Remember me</label>
                            </div>
                            <button type="submit" class="btn btn-primary w-100">Login</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<%@ include file="links.jsp" %>
</body>
</html>
