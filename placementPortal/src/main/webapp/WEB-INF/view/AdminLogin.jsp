<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Login - Placement Portal</title>
<style>
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body {
        font-family: 'Segoe UI', sans-serif;
        background: linear-gradient(135deg, #1a1a2e 0%, #16213e 60%, #0f3460 100%);
        height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
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
        padding: 50px 40px;
        display: flex;
        flex-direction: column;
        justify-content: center;
    }
    .right h2 { color: #1a1a2e; margin-bottom: 4px; font-size: 22px; }
    .right p.sub { color: #888; font-size: 13px; margin-bottom: 26px; }
    .form-group { margin-bottom: 16px; }
    .form-group label { display: block; font-size: 13px; color: #444; margin-bottom: 5px; font-weight: 600; }
    .form-group input {
        width: 100%;
        padding: 12px 14px;
        border: 1.5px solid #ddd;
        border-radius: 8px;
        font-size: 14px;
        outline: none;
        transition: border 0.3s;
    }
    .form-group input:focus { border-color: #0f3460; }
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
        transition: opacity 0.3s;
        margin-top: 6px;
    }
    .btn:hover { opacity: 0.88; }
    .links { margin-top: 18px; text-align: center; font-size: 13px; }
    .links a { color: #0f3460; text-decoration: none; font-weight: 600; margin: 4px; display: block; }
    .links a:hover { text-decoration: underline; }
    .error-msg {
        background: #fdecea;
        color: #c0392b;
        border: 1px solid #f5c6cb;
        border-radius: 8px;
        padding: 10px 14px;
        font-size: 13px;
        margin-bottom: 14px;
    }
    .success-msg {
        background: #eafaf1;
        color: #1e8449;
        border: 1px solid #a9dfbf;
        border-radius: 8px;
        padding: 10px 14px;
        font-size: 13px;
        margin-bottom: 14px;
    }
    .back-link { text-align: center; margin-top: 12px; font-size: 12px; }
    .back-link a { color: #888; text-decoration: none; }
    .back-link a:hover { color: #0f3460; }
</style>
</head>
<body>

<div class="card">
    <div class="left">
        <div class="icon">🔐</div>
        <h1>Admin Portal</h1>
        <p>Manage students, job postings, and applications from one powerful dashboard.</p>
    </div>
    <div class="right">
        <h2>Admin Login</h2>
        <p class="sub">Sign in with your admin credentials</p>

        <% if (request.getAttribute("error") != null) { %>
        <div class="error-msg">${error}</div>
        <% } %>

        <% if (request.getAttribute("success") != null) { %>
        <div class="success-msg">${success}</div>
        <% } %>

        <form action="${pageContext.request.contextPath}/admin/loginProcess" method="post">
            <div class="form-group">
                <label>Username</label>
                <input type="text" name="username" placeholder="Admin username" required />
            </div>
            <div class="form-group">
                <label>Password</label>
                <input type="password" name="password" placeholder="Admin password" required />
            </div>
            <button type="submit" class="btn">Login as Admin</button>
        </form>

        <div class="links">
            <a href="register">New admin? Register here</a>
        </div>
        <div class="back-link">
            <a href="../login">← Back to Student Login</a>
        </div>
    </div>
</div>

</body>
</html>
