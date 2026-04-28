<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Registration - Placement Portal</title>
<style>
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body {
        font-family: 'Segoe UI', sans-serif;
        background: linear-gradient(135deg, #1a1a2e 0%, #16213e 60%, #0f3460 100%);
        min-height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 30px 0;
    }
    .card {
        background: white;
        border-radius: 16px;
        box-shadow: 0 20px 60px rgba(0,0,0,0.4);
        display: flex;
        width: 800px;
        overflow: hidden;
    }
    .left {
        flex: 1;
        background: linear-gradient(160deg, #1a1a2e, #0f3460);
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        padding: 40px;
        color: white;
        text-align: center;
    }
    .left .icon { font-size: 60px; margin-bottom: 20px; }
    .left h1 { font-size: 24px; margin-bottom: 10px; }
    .left p  { font-size: 13px; opacity: 0.75; line-height: 1.7; }
    .right {
        flex: 1;
        padding: 44px 36px;
        display: flex;
        flex-direction: column;
        justify-content: center;
    }
    .right h2 { color: #1a1a2e; margin-bottom: 4px; font-size: 22px; }
    .right p.sub { color: #888; font-size: 13px; margin-bottom: 24px; }
    .form-group { margin-bottom: 15px; }
    .form-group label { display: block; font-size: 13px; color: #444; margin-bottom: 5px; font-weight: 600; }
    .form-group input {
        width: 100%;
        padding: 11px 13px;
        border: 1.5px solid #ddd;
        border-radius: 8px;
        font-size: 14px;
        outline: none;
        transition: border 0.3s;
    }
    .form-group input:focus { border-color: #0f3460; }
    .row { display: flex; gap: 14px; }
    .row .form-group { flex: 1; }
    .btn {
        width: 100%;
        padding: 13px;
        background: linear-gradient(to right, #1a1a2e, #0f3460);
        color: white;
        border: none;
        border-radius: 8px;
        font-size: 15px;
        font-weight: 600;
        cursor: pointer;
        margin-top: 6px;
        transition: opacity 0.3s;
    }
    .btn:hover { opacity: 0.88; }
    .links { margin-top: 16px; text-align: center; font-size: 13px; }
    .links a { color: #0f3460; text-decoration: none; font-weight: 600; }
    .error-msg {
        background: #fdecea;
        color: #c0392b;
        border: 1px solid #f5c6cb;
        border-radius: 8px;
        padding: 10px 14px;
        font-size: 13px;
        margin-bottom: 14px;
    }
</style>
</head>
<body>

<div class="card">
    <div class="left">
        <div class="icon">🛡️</div>
        <h1>Admin Registration</h1>
        <p>Create an admin account to manage the placement portal.</p>
    </div>
    <div class="right">
        <h2>Register as Admin</h2>
        <p class="sub">Fill in the details below</p>

        <% if (request.getAttribute("error") != null) { %>
        <div class="error-msg">${error}</div>
        <% } %>

        <form action="${pageContext.request.contextPath}/admin/registerProcess" method="post">

            <div class="form-group">
                <label>Full Name</label>
                <input type="text" name="name" placeholder="Admin full name" required />
            </div>

            <div class="form-group">
                <label>Email Address</label>
                <input type="email" name="email" placeholder="Admin email" required />
            </div>

            <div class="row">
                <div class="form-group">
                    <label>Username</label>
                    <input type="text" name="username" placeholder="Choose username" required />
                </div>
                <div class="form-group">
                    <label>Password</label>
                    <input type="password" name="password" placeholder="Choose password" required />
                </div>
            </div>

            <button type="submit" class="btn">Register Admin</button>
        </form>

        <div class="links">
            <a href="login">Already registered? Login</a>
        </div>
    </div>
</div>

</body>
</html>
