<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.model.StudentModel" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page isELIgnored="false" %>
<%
    StudentModel user = (StudentModel) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Student Dashboard - Career Bridge</title>
<style>
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body { font-family: 'Segoe UI', sans-serif; background: #f0f2f5; }

    /* Navbar */
    .navbar {
        background: #0a1f44;
        color: white;
        padding: 0 40px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        height: 60px;
        position: sticky;
        top: 0;
        z-index: 100;
        box-shadow: 0 2px 10px rgba(0,0,0,0.2);
    }
    .navbar .brand { font-size: 20px; font-weight: 700; letter-spacing: 1px; }
    .navbar .nav-right { display: flex; align-items: center; gap: 16px; }
    .navbar .user-info { font-size: 13px; opacity: 0.8; }
    .logout-btn {
        background: white;
        color: #0a1f44;
        padding: 7px 16px;
        border-radius: 20px;
        text-decoration: none;
        font-weight: 700;
        font-size: 13px;
        transition: 0.3s;
    }
    .logout-btn:hover { background: #e8eef8; }

    /* Layout */
    .container { max-width: 1100px; margin: 30px auto; padding: 0 20px; }

    /* Welcome Banner */
    .welcome-banner {
        background: linear-gradient(to right, #0a1f44, #1f4ed8);
        color: white;
        border-radius: 14px;
        padding: 24px 30px;
        margin-bottom: 24px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .welcome-banner h2 { font-size: 22px; margin-bottom: 6px; }
    .welcome-banner p { font-size: 13px; opacity: 0.85; }
    .stats { display: flex; gap: 24px; }
    .stat-box {
        background: rgba(255,255,255,0.15);
        border-radius: 10px;
        padding: 12px 20px;
        text-align: center;
        min-width: 80px;
    }
    .stat-box .num { font-size: 22px; font-weight: 700; }
    .stat-box .label { font-size: 11px; opacity: 0.8; }

    /* Cards */
    .card {
        background: white;
        border-radius: 14px;
        box-shadow: 0 4px 14px rgba(0,0,0,0.07);
        margin-bottom: 22px;
        overflow: hidden;
    }
    .card-header {
        background: #f8f9fb;
        border-bottom: 1px solid #eee;
        padding: 16px 24px;
        font-size: 16px;
        font-weight: 700;
        color: #0a1f44;
        display: flex;
        align-items: center;
        gap: 8px;
    }
    .card-body { padding: 20px 24px; }

    /* Search */
    .search-form {
        display: flex;
        gap: 10px;
        align-items: center;
    }
    .search-form input[type="text"] {
        flex: 1;
        padding: 10px 16px;
        border: 1.5px solid #ddd;
        border-radius: 25px;
        font-size: 14px;
        outline: none;
        transition: border 0.3s;
    }
    .search-form input[type="text"]:focus { border-color: #1f4ed8; }
    .search-form button {
        padding: 10px 22px;
        border-radius: 25px;
        border: none;
        background: #0a1f44;
        color: white;
        font-size: 14px;
        font-weight: 600;
        cursor: pointer;
        transition: 0.3s;
    }
    .search-form button:hover { background: #1f4ed8; }
    .search-form a {
        padding: 10px 16px;
        border-radius: 25px;
        border: 1px solid #ddd;
        color: #666;
        font-size: 13px;
        text-decoration: none;
    }

    /* Job Cards */
    .job-list { display: flex; flex-direction: column; gap: 14px; }
    .job-item {
        border: 1.5px solid #eee;
        border-radius: 12px;
        padding: 18px 20px;
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
        transition: box-shadow 0.2s, border-color 0.2s;
    }
    .job-item:hover { box-shadow: 0 4px 16px rgba(0,0,0,0.1); border-color: #1f4ed8; }
    .job-info h4 { font-size: 16px; color: #0a1f44; margin-bottom: 6px; }
    .job-info .meta { display: flex; gap: 16px; flex-wrap: wrap; margin-bottom: 8px; }
    .job-info .meta span {
        font-size: 12px;
        color: #666;
        background: #f0f2f5;
        padding: 3px 10px;
        border-radius: 12px;
    }
    .job-info .desc { font-size: 13px; color: #888; margin-top: 4px; }
    .apply-form { display: flex; flex-direction: column; align-items: flex-end; gap: 8px; min-width: 220px; }
    .apply-form input[type="file"] { font-size: 12px; }
    .apply-btn {
        padding: 9px 20px;
        background: #16a34a;
        color: white;
        border: none;
        border-radius: 20px;
        cursor: pointer;
        font-size: 13px;
        font-weight: 600;
        transition: 0.3s;
    }
    .apply-btn:hover { background: #15803d; }
    .applied-badge {
        padding: 8px 16px;
        background: #dcfce7;
        color: #16a34a;
        border-radius: 20px;
        font-size: 12px;
        font-weight: 600;
    }
    .no-jobs { text-align: center; padding: 30px; color: #888; font-size: 14px; }

    /* Applications Table */
    table { width: 100%; border-collapse: collapse; font-size: 13px; }
    th {
        background: #f0f2f5;
        color: #0a1f44;
        padding: 11px 14px;
        text-align: left;
        font-weight: 700;
    }
    td { padding: 11px 14px; border-bottom: 1px solid #f0f2f5; color: #444; }
    tr:last-child td { border-bottom: none; }
    .badge {
        padding: 4px 12px;
        border-radius: 12px;
        font-size: 11px;
        font-weight: 700;
    }
    .badge-pending  { background: #fef9c3; color: #854d0e; }
    .badge-accepted { background: #dcfce7; color: #166534; }
    .badge-rejected { background: #fee2e2; color: #991b1b; }
    .badge-interview { background: #dbeafe; color: #1e40af; }

    /* Alert */
    .alert {
        padding: 12px 16px;
        border-radius: 8px;
        font-size: 13px;
        margin-bottom: 16px;
    }
    .alert-success { background: #dcfce7; color: #166534; border: 1px solid #bbf7d0; }
    .alert-error   { background: #fee2e2; color: #991b1b; border: 1px solid #fecaca; }
</style>
</head>
<body>

<!-- Navbar -->
<div class="navbar">
    <div class="brand">🎓 Career Bridge</div>
    <div class="nav-right">
        <span class="user-info">Welcome, <%= user.getName() %></span>
        <a href="${pageContext.request.contextPath}/logout">Logout</a>
    </div>
</div>

<div class="container">

    <!-- Welcome Banner -->
    <div class="welcome-banner">
        <div>
            <h2>Hello, <%= user.getName() %> 👋</h2>
            <p><%= user.getEmail() %> &nbsp;|&nbsp; <%= user.getBranch() %> &nbsp;|&nbsp; CGPA: <%= user.getCgpa() %> &nbsp;|&nbsp; <%= user.getCollage() %></p>
        </div>
        <div class="stats">
            <div class="stat-box">
                <div class="num">${totalJobs}</div>
                <div class="label">Open Jobs</div>
            </div>
            <div class="stat-box">
                <div class="num">${appliedCount}</div>
                <div class="label">Applied</div>
            </div>
        </div>
    </div>

    <!-- Alerts -->
    <c:if test="${not empty msg}">
        <div class="alert alert-success">${msg}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-error">${error}</div>
    </c:if>

    <!-- Search Jobs -->
    <div class="card">
        <div class="card-header">🔍 Search Jobs</div>
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/studentDashboard" method="get" class="search-form">
                <input type="text" name="keyword" value="${keyword}" placeholder="Search by job title or company..." />
                <button type="submit">Search</button>
                <a href="/studentDashboard">Clear</a>
            </form>
        </div>
    </div>

    <!-- Available Jobs -->
    <div class="card">
        <div class="card-header">💼 Available Jobs for <%= user.getBranch() %></div>
        <div class="card-body">

            <c:if test="${empty jobs}">
                <div class="no-jobs">
                    <p>No jobs available at the moment. Check back later!</p>
                </div>
            </c:if>

            <div class="job-list">
                <c:forEach var="job" items="${jobs}">
                    <div class="job-item">
                        <div class="job-info">
                            <h4>${job.title}</h4>
                            <div class="meta">
                                <span>🏢 ${job.company}</span>
                                <span>📍 ${job.location}</span>
                                <span>🎓 Min CGPA: ${job.minCgpa}</span>
                                <span>📅 Last Date: ${job.lastDate}</span>
                                <c:if test="${not empty job.salary}">
                                    <span>💰 Salary: ${job.salary}</span>
                                </c:if>
                            </div>
                            <div class="desc">${job.description}</div>
                        </div>
                        <div class="apply-form">
                            <c:choose>
                                <c:when test="${job.minCgpa > user.cgpa}">
                                    <span class="applied-badge" style="background:#fef9c3;color:#854d0e;">⚠️ Min CGPA: ${job.minCgpa}</span>
                                </c:when>
                                <c:otherwise>
                                    <form action="${pageContext.request.contextPath}/applyJobProcess" method="post" enctype="multipart/form-data">
                                        <input type="hidden" name="jobId" value="${job.id}" />
                                        <input type="hidden" name="backlogs" value="No" />
                                        <input type="hidden" name="cgpa" value="${user.cgpa}" />
                                        <label>Upload Resume</label>
                                        <input type="file" name="resume" accept=".pdf,.doc,.docx" required />
                                        <button type="submit" class="apply-btn">Apply Now</button>
                                    </form>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>

    <!-- My Applications -->
    <div class="card">
        <div class="card-header">📋 My Applications</div>
        <div class="card-body">
            <c:if test="${empty myApplications}">
                <div class="no-jobs">You haven't applied to any jobs yet.</div>
            </c:if>
            <c:if test="${not empty myApplications}">
                <table>
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Company / Job</th>
                            <th>Branch</th>
                            <th>CGPA</th>
                            <th>Status</th>
                            <th>Interview Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="app" items="${myApplications}" varStatus="i">
                            <tr>
                                <td>${i.index + 1}</td>
                                <td><strong>${app.studentName}</strong><br/><span style="color:#888;font-size:11px;">Job #${app.jobId}</span></td>
                                <td>${app.branch}</td>
                                <td>${app.cgpa}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${app.status == 'INTERVIEW_SCHEDULED'}">
                                            <span class="badge badge-interview">📅 Interview Scheduled</span>
                                            <c:if test="${not empty app.interviewDate}">
                                                <div style="font-size:11px;color:#1e40af;margin-top:4px;">📅 ${app.interviewDate}</div>
                                            </c:if>
                                        </c:when>
                                        <c:when test="${app.status == 'ACCEPTED'}">
                                            <span class="badge badge-accepted">✅ Accepted</span>
                                        </c:when>
                                        <c:when test="${app.status == 'REJECTED'}">
                                            <span class="badge badge-rejected">❌ Rejected</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-pending">⏳ Pending</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:if test="${not empty app.interviewDate}">${app.interviewDate}</c:if>
                                    <c:if test="${empty app.interviewDate}">—</c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
        </div>
    </div>

    <!-- Notice Board -->
    <div class="card">
        <div class="card-header">📢 Notice Board</div>
        <div class="card-body">
            <ul style="list-style:none; padding:0;">
                <li style="padding:10px 0; border-bottom:1px solid #f0f2f5; font-size:14px;">📌 New job openings added for TCS, Infosys, and Wipro</li>
                <li style="padding:10px 0; border-bottom:1px solid #f0f2f5; font-size:14px;">📌 Resume submission deadline: 30 April</li>
                <li style="padding:10px 0; font-size:14px;">📌 Mock interview sessions starting next Monday</li>
            </ul>
        </div>
    </div>

</div>
</body>
</html>
