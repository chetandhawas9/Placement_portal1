<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.model.StudentModel" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page isELIgnored="false" %>
<%
    StudentModel user = (StudentModel) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Apply for Job - Career Bridge</title>
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
    .container {
        background: white;
        width: 580px;
        border-radius: 16px;
        box-shadow: 0 20px 60px rgba(0,0,0,0.3);
        overflow: hidden;
    }
    .header {
        background: linear-gradient(to right, #0a1f44, #1f4ed8);
        color: white;
        padding: 24px 30px;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .header h2 { font-size: 20px; }
    .header a { color: white; text-decoration: none; font-size: 13px; opacity: 0.8; }
    .header a:hover { opacity: 1; }
    .body { padding: 28px 30px; }
    .student-info {
        background: #f0f4ff;
        border-radius: 10px;
        padding: 14px 18px;
        margin-bottom: 22px;
        font-size: 13px;
        color: #0a1f44;
        border-left: 4px solid #1f4ed8;
    }
    .student-info strong { display: block; font-size: 15px; margin-bottom: 4px; }
    .form-group { margin-bottom: 18px; }
    .form-group label { display: block; font-size: 13px; color: #444; margin-bottom: 6px; font-weight: 600; }
    .form-group input, .form-group select, .form-group textarea {
        width: 100%;
        padding: 11px 13px;
        border: 1.5px solid #ddd;
        border-radius: 8px;
        font-size: 14px;
        outline: none;
        transition: border 0.3s;
        background: white;
    }
    .form-group input:focus, .form-group select:focus, .form-group textarea:focus { border-color: #1f4ed8; }
    .form-group textarea { resize: vertical; min-height: 80px; }
    .radio-group { display: flex; gap: 20px; margin-top: 8px; }
    .radio-group label { display: flex; align-items: center; gap: 6px; font-size: 14px; color: #444; cursor: pointer; }
    .radio-group input { width: auto; }
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
    .info-note {
        font-size: 12px;
        color: #888;
        margin-top: 5px;
    }
</style>
</head>
<body>

<div class="container">
    <div class="header">
        <h2>📄 Apply for Job</h2>
        <a href="studentDashboard">← Back to Dashboard</a>
    </div>

    <div class="body">

        <div class="student-info">
            <strong><%= user.getName() %></strong>
            <%= user.getEmail() %> &nbsp;|&nbsp; <%= user.getBranch() %> &nbsp;|&nbsp; CGPA: <%= user.getCgpa() %>
        </div>

        <form action="${pageContext.request.contextPath}/applyJobProcess" method="post" enctype="multipart/form-data">

            <div class="form-group">
                <label>Select Job</label>
                <select name="jobId" required>
                    <option value="">-- Select a job --</option>
                    <!-- Jobs are loaded from the dashboard apply form, this is standalone page -->
                </select>
                <div class="info-note">⚠️ Please apply directly from the Dashboard job listings.</div>
            </div>

            <div class="form-group">
                <label>Overall CGPA</label>
                <input type="number" name="cgpa" value="<%= user.getCgpa() %>"
                       step="0.01" min="0" max="10" required />
            </div>

            <div class="form-group">
                <label>Do you have any active backlogs?</label>
                <div class="radio-group">
                    <label><input type="radio" name="backlogs" value="Yes" required /> Yes</label>
                    <label><input type="radio" name="backlogs" value="No" /> No</label>
                </div>
            </div>

            <div class="form-group">
                <label>Upload Resume (PDF / DOC)</label>
                <input type="file" name="resume" accept=".pdf,.doc,.docx" required />
            </div>

            <div class="form-group">
                <label>Cover Letter <span style="color:#aaa;font-weight:400;">(optional)</span></label>
                <textarea name="coverLetter" placeholder="Write a brief cover letter..."></textarea>
            </div>

            <button type="submit" class="btn">Submit Application</button>
        </form>

    </div>
</div>

</body>
</html>
