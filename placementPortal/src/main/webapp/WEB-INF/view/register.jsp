<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Placement Portal - Student Registration</title>
<style>
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body {
        font-family: 'Segoe UI', sans-serif;
        background: linear-gradient(135deg, #0a1f44 0%, #1f4ed8 100%);
        min-height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
        padding: 30px 0;
    }
    .card {
        background: white;
        border-radius: 16px;
        box-shadow: 0 20px 60px rgba(0,0,0,0.3);
        display: flex;
        width: 860px;
        overflow: hidden;
    }
    .left {
        flex: 1;
        background: linear-gradient(160deg, #0a1f44, #1f4ed8);
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        padding: 40px;
        color: white;
        text-align: center;
    }
    .left .icon { font-size: 60px; margin-bottom: 20px; }
    .left h1 { font-size: 26px; margin-bottom: 12px; }
    .left p  { font-size: 13px; opacity: 0.8; line-height: 1.7; }
    .right {
        flex: 1;
        padding: 40px 36px;
        overflow-y: auto;
    }
    .right h2 { color: #0a1f44; margin-bottom: 4px; font-size: 22px; }
    .right p.sub { color: #888; font-size: 13px; margin-bottom: 22px; }
    .row { display: flex; gap: 14px; }
    .row .form-group { flex: 1; }
    .form-group { margin-bottom: 15px; }
    .form-group label { display: block; font-size: 13px; color: #444; margin-bottom: 5px; font-weight: 600; }
    .form-group input, .form-group select {
        width: 100%;
        padding: 11px 13px;
        border: 1.5px solid #ddd;
        border-radius: 8px;
        font-size: 14px;
        transition: border 0.3s;
        outline: none;
        background: white;
    }
    .form-group input:focus, .form-group select:focus { border-color: #1f4ed8; }
    .btn {
        width: 100%;
        padding: 13px;
        background: linear-gradient(to right, #0a1f44, #1f4ed8);
        color: white;
        border: none;
        border-radius: 8px;
        font-size: 15px;
        font-weight: 600;
        cursor: pointer;
        transition: opacity 0.3s;
        margin-top: 6px;
    }
    .btn:hover { opacity: 0.9; }
    .links { margin-top: 16px; text-align: center; font-size: 13px; }
    .links a { color: #1f4ed8; text-decoration: none; font-weight: 600; }
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
</style>
</head>
<body>

<div class="card">
    <div class="left">
        <div class="icon">📝</div>
        <h1>Create Your Account</h1>
        <p>Join thousands of students who found their dream jobs through Career Bridge.</p>
    </div>
    <div class="right">
        <h2>Student Registration</h2>
        <p class="sub">Fill in the details below to get started</p>

        <% if (request.getAttribute("error") != null) { %>
        <div class="error-msg">${error}</div>
        <% } %>

        <form action="${pageContext.request.contextPath}/registerProcess" method="post">

            <div class="row">
                <div class="form-group">
                    <label>Full Name</label>
                    <input type="text" name="name" placeholder="Full name" required />
                </div>
                <div class="form-group">
                    <label>Email Address</label>
                    <input type="email" name="email" placeholder="Email address" required />
                </div>
            </div>

            <div class="row">
                <div class="form-group">
                    <label>Username</label>
                    <input type="text" name="username" placeholder="Choose a username" required />
                </div>
                <div class="form-group">
                    <label>Password</label>
                    <input type="password" name="password" placeholder="Choose a password" required />
                </div>
            </div>

            <div class="row">
                <div class="form-group">
                    <label>Phone Number</label>
                    <input type="text" name="phone" placeholder="10-digit phone number" required />
                </div>
                <div class="form-group">
                    <label>CGPA</label>
                    <input type="number" name="cgpa" placeholder="e.g. 8.5" step="0.01" min="0" max="10" required />
                </div>
            </div>

            <div class="row">
                <div class="form-group">
                    <label>Branch</label>
                    <select name="branch" required>
                        <option value="">Select Branch</option>
                        <option value="CSE">Computer Science (CSE)</option>
                        <option value="IT">Information Technology (IT)</option>
                        <option value="ENTC">Electronics And Telecom (ENTC)</option>
                        <option value="MECH">Mechanical (MECH)</option>
                        <option value="CIVIL">Civil Engineering</option>
                    </select>
                </div>
                <div class="form-group">
                    <label>College Name</label>
                    <input type="text" name="collage" placeholder="Your college name" required />
                </div>
            </div>

            <button type="submit" class="btn">Register Now</button>
        </form>

        <div class="links">
            <a href="login">Already have an account? Login</a>
        </div>
    </div>
</div>

</body>
</html>
