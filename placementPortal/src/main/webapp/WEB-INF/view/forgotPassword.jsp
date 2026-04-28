<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Placement Portal - Forgot Password</title>

<style>
    body {
        margin: 0;
        font-family: 'Segoe UI', sans-serif;
        background: linear-gradient(to right, #1e3c72, #2a5298);
    }

    .container {
        display: flex;
        height: 100vh;
    }

    .left {
        width: 50%;
        background: url('https://images.unsplash.com/photo-1522202176988-66273c2fd55f') no-repeat center;
        background-size: cover;
    }

    .right {
        width: 50%;
        display: flex;
        justify-content: center;
        align-items: center;
        background: white;
    }

    .box {
        width: 360px;
    }

    h2 {
        text-align: center;
        color: #2a5298;
        margin-bottom: 5px;
    }

    h4 {
        text-align: center;
        color: gray;
        margin-bottom: 10px;
    }

    p.desc {
        text-align: center;
        color: #555;
        font-size: 14px;
        margin-bottom: 20px;
    }

    input[type="email"] {
        width: 100%;
        padding: 12px;
        margin: 10px 0;
        border: 1px solid #ccc;
        border-radius: 6px;
        box-sizing: border-box;
        font-size: 14px;
    }

    input[type="submit"] {
        width: 100%;
        padding: 12px;
        background: #2a5298;
        border: none;
        color: white;
        font-size: 16px;
        border-radius: 6px;
        cursor: pointer;
        margin-top: 5px;
    }

    input[type="submit"]:hover {
        background: #1e3c72;
    }

    .links {
        margin-top: 15px;
        text-align: center;
    }

    .links a {
        display: block;
        margin: 5px;
        text-decoration: none;
        color: #2a5298;
        font-weight: bold;
    }

    .links a:hover {
        text-decoration: underline;
    }

    .error {
        color: red;
        text-align: center;
        background: #fff0f0;
        border: 1px solid #ffcccc;
        padding: 10px;
        border-radius: 6px;
        margin-bottom: 12px;
        font-size: 14px;
    }

    .success {
        color: green;
        text-align: center;
        background: #f0fff0;
        border: 1px solid #c3e6c3;
        padding: 10px;
        border-radius: 6px;
        margin-bottom: 12px;
        font-size: 14px;
    }

    .icon {
        text-align: center;
        font-size: 48px;
        margin-bottom: 10px;
    }
</style>

</head>
<body>

<div class="container">

    <div class="left"></div>

    <div class="right">
        <div class="box">

            <div class="icon">🔑</div>
            <h2>Forgot Password?</h2>
            <h4>Placement Portal</h4>
            <p class="desc">Enter your registered email address. We will send your password directly to that email.</p>

            <!-- Error Message -->
            <% if (request.getAttribute("error") != null) { %>
                <div class="error">${error}</div>
            <% } %>

            <!-- Success Message -->
            <% if (request.getAttribute("success") != null) { %>
                <div class="success">${success}</div>
            <% } %>

            <form action="${pageContext.request.contextPath}/forgotPasswordProcess" method="post">
                <input type="email" name="email" placeholder="Enter your registered email" required />
                <input type="submit" value="Send Password to Email" />
            </form>

            <div class="links">
                <a href="${pageContext.request.contextPath}/login">&#8592; Back to Login</a>
                <a href="${pageContext.request.contextPath}/register">New user? Register here</a>
            </div>

        </div>
    </div>

</div>

</body>
</html>
