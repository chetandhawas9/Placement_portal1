<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Placement Portal - Student Login</title>

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

    /* Left side image */
    .left {
        width: 50%;
        background: url('https://images.unsplash.com/photo-1522202176988-66273c2fd55f') no-repeat center;
        background-size: cover;
    }

    /* Right side form */
    .right {
        width: 50%;
        display: flex;
        justify-content: center;
        align-items: center;
        background: white;
    }

    .login-box {
        width: 350px;
    }

    h2 {
        text-align: center;
        color: #2a5298;
        margin-bottom: 5px;
    }

    h4 {
        text-align: center;
        color: gray;
        margin-bottom: 20px;
    }

    input[type="text"], input[type="password"] {
        width: 100%;
        padding: 12px;
        margin: 10px 0;
        border: 1px solid #ccc;
        border-radius: 6px;
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
    }
</style>

</head>
<body>

<div class="container">

    <!-- Left image -->
    <div class="left"></div>

    <!-- Right login form -->
    <div class="right">
        <div class="login-box">

            <h2>Placement Portal</h2>
            <h4>Student Login</h4>

           <%--  <div class="error">
                ${errorMessage}
            </div> --%>

            <form action="${pageContext.request.contextPath}/loginProcess" method="post">
                <input type="text" name="username" placeholder="Enter Username" required />
                <input type="password" name="password" placeholder="Enter Password" required />

                <input type="submit" value="Login" />
            </form>

            <div class="links">
                <a href="register">New user? Register here</a>
                <a href="${pageContext.request.contextPath}/forgot">Forgot Password?</a>
            </div>

        </div>
    </div>

</div>

</body>
</html>