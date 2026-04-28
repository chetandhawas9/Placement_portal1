<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Career Bridge - Placement Portal</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f5f7fa;
        }

        /* Navbar */
        .navbar {
            background: #0a1f44;
            color: white;
            padding: 15px 40px;
            display: flex;
            
            justify-content: space-between;
            align-items: center;
        }
        .navbar h1 { margin: 0; letter-spacing: 1px; font-size: 22px; }
        .nav-links a {
            color: #0a1f44;
            text-decoration: none;
            margin-left: 12px;
            padding: 8px 18px;
            border-radius: 20px;
            background: white;
            transition: all 0.3s ease;
            font-weight: bold;
            font-size: 14px;
        }
        .nav-links a:hover { background: #1f4ed8; color: white; }

        /* Hero */
        .hero {
            background: linear-gradient(to right, #0a1f44, #1f4ed8);
            color: white;
            text-align: center;
            padding: 80px 20px;
        }
        .hero h2 { margin-bottom: 12px; font-size: 36px; }
        .hero p { font-size: 18px; opacity: 0.88; margin-bottom: 28px; }
        .hero-btns a {
            display: inline-block;
            margin: 6px;
            padding: 12px 28px;
            border-radius: 25px;
            font-size: 15px;
            font-weight: 700;
            text-decoration: none;
            transition: 0.3s;
        }
        .btn-white { background: white; color: #0a1f44; }
        .btn-white:hover { background: #e8eef8; }
        .btn-outline { border: 2px solid white; color: white; }
        .btn-outline:hover { background: white; color: #0a1f44; }

        /* Features */
        .features {
            display: flex;
            justify-content: center;
            gap: 24px;
            flex-wrap: wrap;
            padding: 50px 40px;
            background: #f5f7fa;
        }
        .feature-box {
            background: white;
            width: 240px;
            padding: 28px 22px;
            border-radius: 14px;
            box-shadow: 0 6px 20px rgba(0,0,0,0.08);
            text-align: center;
            transition: transform 0.3s;
        }
        .feature-box:hover { transform: translateY(-8px); }
        .feature-box .icon { font-size: 40px; margin-bottom: 14px; }
        .feature-box h3 { color: #0a1f44; margin-bottom: 8px; font-size: 16px; }
        .feature-box p { color: #888; font-size: 13px; line-height: 1.6; }

        /* Placed Students */
        .cards {
            padding: 50px 40px;
            text-align: center;
            background: white;
        }
        .cards h2 { margin-bottom: 30px; color: #0a1f44; font-size: 26px; }
        .card-container {
            display: flex;
            justify-content: center;
            gap: 24px;
            flex-wrap: wrap;
        }
        .card {
            background: #f5f7fa;
            width: 220px;
            padding: 22px;
            border-radius: 14px;
            box-shadow: 0 4px 14px rgba(0,0,0,0.08);
            transition: all 0.3s;
        }
        .card:hover { transform: translateY(-8px); box-shadow: 0 10px 25px rgba(0,0,0,0.15); }
        .card .avatar {
            width: 70px;
            height: 70px;
            border-radius: 50%;
            background: linear-gradient(135deg, #0a1f44, #1f4ed8);
            margin: 0 auto 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
            color: white;
        }
        .card h3 { color: #0a1f44; font-size: 15px; margin-bottom: 4px; }
        .card .company { color: #1f4ed8; font-size: 13px; font-weight: 600; }
        .card .branch { color: #888; font-size: 12px; margin-top: 4px; }

        /* Footer */
        .footer {
            background: #0a1f44;
            color: white;
            text-align: center;
            padding: 20px;
            font-size: 13px;
            opacity: 0.9;
        }
    </style>
</head>
<body>

    <!-- Navbar -->
    <div class="navbar">
        <h1>🎓 Placement Portal</h1>
        <div class="nav-links">
            <a href="login">Student Login</a>
            <a href="register">Register</a>
            <a href="admin/login">Admin</a>
        </div>
    </div>

    <!-- Hero -->
    <div class="hero">
        <h2>Career Bridge</h2>
        <p>Connecting talented students with top companies.<br>Your dream job starts here.</p>
        <div class="hero-btns">
            <a href="register" class="btn-white">Get Started</a>
            <a href="login" class="btn-outline">Login</a>
        </div>
    </div>

    <!-- Features -->
    <div class="features">
        <div class="feature-box">
            <div class="icon">🏢</div>
            <h3>Top Companies</h3>
            <p>Apply to leading companies like TCS, Infosys, Wipro, and more.</p>
        </div>
        <div class="feature-box">
            <div class="icon">🔍</div>
            <h3>Smart Job Search</h3>
            <p>Find jobs matching your branch, CGPA, and skills instantly.</p>
        </div>
        <div class="feature-box">
            <div class="icon">📄</div>
            <h3>Easy Apply</h3>
            <p>Upload your resume and apply to multiple jobs in seconds.</p>
        </div>
        <div class="feature-box">
            <div class="icon">📊</div>
            <h3>Track Applications</h3>
            <p>Monitor your application status from your personal dashboard.</p>
        </div>
    </div>

    <!-- Placed Students -->
    <div class="cards">
        <h2>🏆 Our Successfully Placed Students</h2>
        <div class="card-container">
            <div class="card">
                <div class="avatar">👨‍💻</div>
                <h3>Harsh Magar</h3>
                <div class="company">Placed at TCS</div>
                <div class="branch">CSE | CGPA: 8.9</div>
            </div>
            <div class="card">
                <div class="avatar">👨‍🔬</div>
                <h3>Chetan DhaWas</h3>
                <div class="company">Placed at Infosys</div>
                <div class="branch">IT | CGPA: 8.5</div>
            </div>
            <div class="card">
                <div class="avatar">👨‍🔬</div>
                <h3>sachin aneboinWad </h3>
                <div class="company">Placed at Wipro</div>
                <div class="branch">ENTC | CGPA: 8.2</div>
            </div>
            <div class="card">
                <div class="avatar">👨‍🔬</div>
                <h3>Devesh Patharbe</h3>
                <div class="company">Placed at Cognizant</div>
                <div class="branch">CSE | CGPA: 9.1</div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <div class="footer">
        &copy; 2025 Career Bridge Placement Portal. All rights reserved.
    </div>

</body>
</html>
