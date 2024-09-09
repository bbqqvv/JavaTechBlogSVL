<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error 404 - Page Not Found</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f2f2f2;
            color: #333;
            text-align: center;
            padding: 50px;
        }
        h1 {
            font-size: 3em;
            color: #d9534f;
            margin-bottom: 20px;
        }
        p {
            font-size: 1.2em;
            color: #6c757d;
        }
        img {
            width: 150px;
            height: auto;
            margin-bottom: 30px;
        }
        a {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #5bc0de;
            color: #fff;
            text-decoration: none;
            font-size: 1.1em;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }
        a:hover {
            background-color: #31b0d5;
        }
        .container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }
        .container img {
            max-width: 100%;
        }
    </style>
</head>
<body>
<div class="container">
    <img src="<%=application.getContextPath()%>/img/70515910726734841.jpg" alt="404 Not Found">
    <h1>Oops! Page Not Found</h1>
    <p>Sorry, the page you are looking for does not exist.</p>
    <a href="/index.jsp">Return to Home</a>
</div>
</body>
</html>
