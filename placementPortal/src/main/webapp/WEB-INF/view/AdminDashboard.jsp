<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.model.AdminModel" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page isELIgnored="false" %>
<%
    AdminModel admin = (AdminModel) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect("../admin/login");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard - Placement Portal</title>
<style>
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body { font-family: 'Segoe UI', sans-serif; background: #f0f2f5; }

    .navbar {
        background: #1a1a2e; color: white;
        padding: 0 40px; display: flex; justify-content: space-between;
        align-items: center; height: 60px;
        position: sticky; top: 0; z-index: 100;
        box-shadow: 0 2px 10px rgba(0,0,0,0.3);
    }
    .navbar .brand { font-size: 18px; font-weight: 700; }
    .navbar .nav-right { display: flex; align-items: center; gap: 14px; }
    .navbar .admin-name { font-size: 13px; opacity: 0.8; }
    .logout-btn {
        background: white; color: #1a1a2e;
        padding: 7px 15px; border-radius: 20px;
        text-decoration: none; font-weight: 700; font-size: 13px;
    }
    .logout-btn:hover { background: #e8eef8; }

    .tab-nav {
        background: white; border-bottom: 1px solid #e5e7eb;
        display: flex; padding: 0 40px;
        box-shadow: 0 1px 4px rgba(0,0,0,0.05);
    }
    .tab-btn {
        padding: 16px 20px; border: none; background: none;
        font-size: 14px; font-weight: 600; color: #888;
        cursor: pointer; border-bottom: 3px solid transparent; transition: 0.2s;
    }
    .tab-btn.active, .tab-btn:hover { color: #1a1a2e; border-bottom-color: #1a1a2e; }

    .container { max-width: 1200px; margin: 28px auto; padding: 0 20px; }

    .stats-row { display: flex; gap: 18px; margin-bottom: 24px; }
    .stat-card {
        flex: 1; background: white; border-radius: 14px;
        padding: 22px 24px; box-shadow: 0 4px 14px rgba(0,0,0,0.06);
        display: flex; align-items: center; gap: 16px;
    }
    .stat-icon { font-size: 34px; }
    .stat-info .num { font-size: 26px; font-weight: 800; color: #1a1a2e; }
    .stat-info .label { font-size: 13px; color: #888; margin-top: 2px; }

    .card {
        background: white; border-radius: 14px;
        box-shadow: 0 4px 14px rgba(0,0,0,0.06);
        margin-bottom: 24px; overflow: hidden;
    }
    .card-header {
        background: #f8f9fb; border-bottom: 1px solid #eee;
        padding: 15px 22px; font-size: 15px; font-weight: 700; color: #1a1a2e;
        display: flex; justify-content: space-between; align-items: center;
    }
    .card-body { padding: 20px 22px; }

    /* Search bar */
    .search-bar {
        display: flex; gap: 10px; align-items: center; margin-bottom: 16px;
    }
    .search-bar input[type="text"] {
        flex: 1; padding: 9px 16px; border: 1.5px solid #ddd;
        border-radius: 25px; font-size: 14px; outline: none;
        transition: border 0.3s;
    }
    .search-bar input[type="text"]:focus { border-color: #1a1a2e; }
    .search-bar button {
        padding: 9px 20px; border-radius: 25px; border: none;
        background: #1a1a2e; color: white; font-size: 13px;
        font-weight: 600; cursor: pointer; transition: 0.3s;
    }
    .search-bar button:hover { background: #0f3460; }
    .search-bar a {
        padding: 9px 14px; border-radius: 25px; border: 1px solid #ddd;
        color: #666; font-size: 13px; text-decoration: none;
    }
    .search-bar a:hover { background: #f5f5f5; }

    .form-row { display: flex; gap: 10px; flex-wrap: wrap; align-items: flex-end; }
    .form-row .fg { display: flex; flex-direction: column; gap: 4px; }
    .form-row label { font-size: 12px; color: #555; font-weight: 600; }
    .form-row input, .form-row select, .form-row textarea {
        padding: 9px 12px; border: 1.5px solid #ddd;
        border-radius: 8px; font-size: 13px; outline: none;
        transition: border 0.3s; background: white;
    }
    .form-row input:focus, .form-row select:focus { border-color: #1a1a2e; }
    .form-row textarea { resize: vertical; height: 60px; min-width: 200px; }

    .btn-primary {
        padding: 9px 20px; background: #1a1a2e; color: white;
        border: none; border-radius: 8px; font-size: 13px;
        font-weight: 600; cursor: pointer; transition: 0.3s;
        text-decoration: none; display: inline-block;
    }
    .btn-primary:hover { background: #0f3460; }
    .btn-danger {
        padding: 6px 13px; background: #dc2626; color: white;
        border: none; border-radius: 6px; font-size: 12px;
        font-weight: 600; cursor: pointer; text-decoration: none;
        display: inline-block; transition: 0.3s;
    }
    .btn-danger:hover { background: #b91c1c; }
    .btn-sm {
        padding: 5px 12px; border: none; border-radius: 6px;
        font-size: 12px; font-weight: 600; cursor: pointer; transition: 0.2s;
    }
    .btn-accept { background: #dcfce7; color: #166534; }
    .btn-reject { background: #fee2e2; color: #991b1b; }
    .btn-schedule { background: #dbeafe; color: #1e40af; }

    table { width: 100%; border-collapse: collapse; font-size: 13px; }
    th {
        background: #f8f9fb; color: #1a1a2e;
        padding: 11px 14px; text-align: left;
        font-weight: 700; border-bottom: 2px solid #eee;
    }
    td { padding: 11px 14px; border-bottom: 1px solid #f0f2f5; color: #444; vertical-align: middle; }
    tr:last-child td { border-bottom: none; }
    tr:hover td { background: #fafbff; }

    .badge { padding: 3px 10px; border-radius: 12px; font-size: 11px; font-weight: 700; }
    .badge-pending  { background: #fef9c3; color: #854d0e; }
    .badge-accepted { background: #dcfce7; color: #166534; }
    .badge-rejected { background: #fee2e2; color: #991b1b; }
    .badge-interview { background: #dbeafe; color: #1e40af; }

    .tab-content { display: none; }
    .tab-content.active { display: block; }

    .alert { padding: 11px 16px; border-radius: 8px; font-size: 13px; margin-bottom: 18px; }
    .alert-success { background: #dcfce7; color: #166534; border: 1px solid #bbf7d0; }

    /* Schedule interview modal */
    .modal-overlay {
        display: none; position: fixed; top: 0; left: 0;
        width: 100%; height: 100%; background: rgba(0,0,0,0.5);
        z-index: 999; align-items: center; justify-content: center;
    }
    .modal-overlay.open { display: flex; }
    .modal {
        background: white; border-radius: 16px; padding: 32px;
        width: 420px; box-shadow: 0 20px 60px rgba(0,0,0,0.3);
    }
    .modal h3 { color: #1a1a2e; font-size: 18px; margin-bottom: 6px; }
    .modal p { color: #888; font-size: 13px; margin-bottom: 20px; }
    .modal .form-group { margin-bottom: 16px; }
    .modal .form-group label { display: block; font-size: 13px; color: #444; font-weight: 600; margin-bottom: 6px; }
    .modal .form-group input {
        width: 100%; padding: 11px 13px; border: 1.5px solid #ddd;
        border-radius: 8px; font-size: 14px; outline: none;
    }
    .modal .form-group input:focus { border-color: #1a1a2e; }
    .modal-actions { display: flex; gap: 10px; justify-content: flex-end; margin-top: 6px; }
    .btn-cancel {
        padding: 10px 20px; background: #f5f5f5; color: #666;
        border: none; border-radius: 8px; font-size: 13px;
        font-weight: 600; cursor: pointer;
    }
    .btn-confirm {
        padding: 10px 20px; background: #1a1a2e; color: white;
        border: none; border-radius: 8px; font-size: 13px;
        font-weight: 600; cursor: pointer;
    }
    .interview-date-cell { color: #1e40af; font-weight: 600; font-size: 12px; }

    .no-results { text-align:center; color:#888; padding: 30px; font-size: 14px; }
</style>

<script>
function showTab(tabId) {
    document.querySelectorAll('.tab-content').forEach(t => t.classList.remove('active'));
    document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
    document.getElementById(tabId).classList.add('active');
    event.target.classList.add('active');
    // Update hidden activeTab field in any search forms
    document.querySelectorAll('.activeTabInput').forEach(el => el.value = tabId);
}

function openScheduleModal(appId, studentName) {
    document.getElementById('modalAppId').value = appId;
    document.getElementById('modalStudentName').textContent = studentName;
    document.getElementById('scheduleModal').classList.add('open');
    // Set min date to today
    var today = new Date().toISOString().split('T')[0];
    document.getElementById('modalInterviewDate').min = today;
    document.getElementById('modalInterviewDate').value = '';
}

function closeScheduleModal() {
    document.getElementById('scheduleModal').classList.remove('open');
}

window.onload = function() {
    var activeTab = '${activeTab}' || 'tab-overview';
    var tabEl = document.getElementById(activeTab);
    if (tabEl) {
        tabEl.classList.add('active');
        // Activate the corresponding button
        var tabMap = {
            'tab-overview': 0,
            'tab-jobs': 1,
            'tab-students': 2,
            'tab-applications': 3
        };
        var idx = tabMap[activeTab];
        var btns = document.querySelectorAll('.tab-btn');
        if (btns[idx]) btns[idx].classList.add('active');
    } else {
        document.getElementById('tab-overview').classList.add('active');
        document.querySelectorAll('.tab-btn')[0].classList.add('active');
    }
};
</script>
</head>
<body>

<!-- Schedule Interview Modal -->
<div class="modal-overlay" id="scheduleModal">
    <div class="modal">
        <h3>📅 Schedule Interview</h3>
        <p>Set interview date for: <strong id="modalStudentName"></strong></p>
        <form action="${pageContext.request.contextPath}/admin/scheduleInterview" method="post">
            <input type="hidden" name="appId" id="modalAppId"/>
            <div class="form-group">
                <label>Interview Date and Time</label>
                <input type="datetime-local" name="interviewDate" id="modalInterviewDate" required />
            </div>
            <div class="modal-actions">
                <button type="button" class="btn-cancel" onclick="closeScheduleModal()">Cancel</button>
                <button type="submit" class="btn-confirm">📅 Confirm Schedule</button>
            </div>
        </form>
    </div>
</div>

<!-- Navbar -->
<div class="navbar">
    <div class="brand">🛡️ Admin Panel - Career Bridge</div>
    <div class="nav-right">
        <span class="admin-name">👤 <%= admin.getName() %></span>
        <a href="logout" class="logout-btn">Logout</a>
    </div>
</div>

<!-- Tab Navigation -->
<div class="tab-nav">
    <button class="tab-btn" onclick="showTab('tab-overview')">📊 Overview</button>
    <button class="tab-btn" onclick="showTab('tab-jobs')">💼 Manage Jobs</button>
    <button class="tab-btn" onclick="showTab('tab-students')">🎓 Students</button>
    <button class="tab-btn" onclick="showTab('tab-applications')">📋 Applications</button>
</div>

<div class="container">

    <c:if test="${not empty jobSuccess}">
        <div class="alert alert-success">${jobSuccess}</div>
    </c:if>

    <!-- Overview Tab -->
    <div id="tab-overview" class="tab-content">
        <div class="stats-row">
            <div class="stat-card">
                <div class="stat-icon">🎓</div>
                <div class="stat-info">
                    <div class="num">${totalStudents}</div>
                    <div class="label">Total Students</div>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">💼</div>
                <div class="stat-info">
                    <div class="num">${totalJobs}</div>
                    <div class="label">Job Openings</div>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">📋</div>
                <div class="stat-info">
                    <div class="num">${totalApplications}</div>
                    <div class="label">Applications</div>
                </div>
            </div>
        </div>

        <div class="card">
            <div class="card-header">📋 Recent Applications</div>
            <div class="card-body">
                <table>
                    <thead>
                        <tr>
                            <th>#</th><th>Student</th><th>Email</th>
                            <th>Branch</th><th>CGPA</th><th>Status</th><th>Interview Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="app" items="${applications}" varStatus="i" end="4">
                            <tr>
                                <td>${i.index + 1}</td>
                                <td>${app.studentName}</td>
                                <td>${app.email}</td>
                                <td>${app.branch}</td>
                                <td>${app.cgpa}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${app.status == 'INTERVIEW_SCHEDULED'}"><span class="badge badge-interview">📅 Interview Scheduled</span></c:when>
                                        <c:when test="${app.status == 'ACCEPTED'}"><span class="badge badge-accepted">✅ Accepted</span></c:when>
                                        <c:when test="${app.status == 'REJECTED'}"><span class="badge badge-rejected">❌ Rejected</span></c:when>
                                        <c:otherwise><span class="badge badge-pending">⏳ Pending</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:if test="${not empty app.interviewDate}">
                                        <span class="interview-date-cell">📅 ${app.interviewDate}</span>
                                    </c:if>
                                    <c:if test="${empty app.interviewDate}">—</c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Jobs Tab -->
    <div id="tab-jobs" class="tab-content">
        <div class="card">
            <div class="card-header">➕ Post New Job</div>
            <div class="card-body">
                <form action="${pageContext.request.contextPath}/admin/addJob" method="post">
                    <div class="form-row">
                        <div class="fg">
                            <label>Job Title</label>
                            <input type="text" name="title" placeholder="e.g. Software Developer" required />
                        </div>
                        <div class="fg">
                            <label>Company Name</label>
                            <input type="text" name="company" placeholder="e.g. TCS" required />
                        </div>
                        <div class="fg">
                            <label>Branch</label>
                            <select name="branch" required>
                                <option value="">Select</option>
                                <option value="CSE">CSE</option>
                                <option value="IT">IT</option>
                                <option value="ENTC">ENTC</option>
                                <option value="MECH">MECH</option>
                                <option value="CIVIL">CIVIL</option>
                                <option value="ALL">All Branches</option>
                            </select>
                        </div>
                        <div class="fg">
                            <label>Min CGPA</label>
                            <input type="number" name="minCgpa" step="0.1" min="0" max="10" placeholder="e.g. 7.0" required />
                        </div>
                        <div class="fg">
                            <label>Location</label>
                            <input type="text" name="location" placeholder="e.g. Pune" required />
                        </div>
                        <div class="fg">
                            <label>Last Date</label>
                            <input type="date" name="lastDate" required />
                        </div>
                        <div class="fg">
                            <label>Salary (LPA)</label>
                            <input type="text" name="salary" placeholder="e.g. 6 LPA or 5-8 LPA" />
                        </div>
                        <div class="fg">
                            <label>Description</label>
                            <textarea name="description" placeholder="Brief job description..."></textarea>
                        </div>
                        <div class="fg" style="justify-content:flex-end;">
                            <button type="submit" class="btn-primary" style="height:38px; margin-top:18px;">Post Job</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <div class="card">
            <div class="card-header">📋 All Job Openings (${totalJobs})</div>
            <div class="card-body">
                <!-- Job Search Filter -->
                <form action="${pageContext.request.contextPath}/admin/dashboard" method="get">
                    <input type="hidden" name="activeTab" value="tab-jobs" class="activeTabInput"/>
                    <div class="search-bar">
                        <input type="text" name="jobSearch" placeholder="🔍 Search by job title or company name..."
                               value="${jobSearch}"/>
                        <button type="submit">Search</button>
                        <c:if test="${not empty jobSearch}">
                            <a href="dashboard?activeTab=tab-jobs">Clear</a>
                        </c:if>
                    </div>
                </form>
                <c:if test="${not empty jobSearch}">
                    <p style="font-size:13px;color:#888;margin-bottom:12px;">
                        Showing results for: <strong>"${jobSearch}"</strong> — ${fn:length(jobs)} job(s) found
                    </p>
                </c:if>
                <table>
                    <thead>
                        <tr>
                            <th>#</th><th>Title</th><th>Company</th><th>Branch</th>
                            <th>Min CGPA</th><th>Location</th><th>Last Date</th><th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:if test="${empty jobs}">
                            <tr><td colspan="8" class="no-results">No jobs found.</td></tr>
                        </c:if>
                        <c:forEach var="job" items="${jobs}" varStatus="i">
                            <tr>
                                <td>${i.index + 1}</td>
                                <td>${job.title}</td>
                                <td>${job.company}</td>
                                <td>${job.branch}</td>
                                <td>${job.minCgpa}</td>
                                <td>${job.location}</td>
                                <td>${job.lastDate}</td>
                                <td><a href="deleteJob?id=${job.id}" class="btn-danger" onclick="return confirm('Delete this job?')">Delete</a></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Students Tab -->
    <div id="tab-students" class="tab-content">
        <div class="card">
            <div class="card-header">🎓 All Registered Students (${totalStudents})</div>
            <div class="card-body">
                <!-- Student Search Filter -->
                <form action="${pageContext.request.contextPath}/admin/dashboard" method="get">
                    <input type="hidden" name="activeTab" value="tab-students" class="activeTabInput"/>
                    <div class="search-bar">
                        <input type="text" name="studentSearch" placeholder="🔍 Search by student name or email..."
                               value="${studentSearch}"/>
                        <button type="submit">Search</button>
                        <c:if test="${not empty studentSearch}">
                            <a href="dashboard?activeTab=tab-students">Clear</a>
                        </c:if>
                    </div>
                </form>
                <c:if test="${not empty studentSearch}">
                    <p style="font-size:13px;color:#888;margin-bottom:12px;">
                        Showing results for: <strong>"${studentSearch}"</strong> — ${fn:length(students)} student(s) found
                    </p>
                </c:if>
                <table>
                    <thead>
                        <tr>
                            <th>#</th><th>Name</th><th>Email</th><th>Username</th>
                            <th>Phone</th><th>Branch</th><th>CGPA</th><th>College</th><th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:if test="${empty students}">
                            <tr><td colspan="9" class="no-results">No students found.</td></tr>
                        </c:if>
                        <c:forEach var="student" items="${students}" varStatus="i">
                            <tr>
                                <td>${i.index + 1}</td>
                                <td>${student.name}</td>
                                <td>${student.email}</td>
                                <td>${student.username}</td>
                                <td>${student.phone}</td>
                                <td>${student.branch}</td>
                                <td>${student.cgpa}</td>
                                <td>${student.collage}</td>
                                <td><a href="deleteStudent?id=${student.id}" class="btn-danger" onclick="return confirm('Remove this student?')">Remove</a></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Applications Tab -->
    <div id="tab-applications" class="tab-content">
        <div class="card">
            <div class="card-header">📋 All Applications (${totalApplications})</div>
            <div class="card-body">
                <table>
                    <thead>
                        <tr>
                            <th>#</th><th>Student</th><th>Email</th><th>Branch</th>
                            <th>CGPA</th><th>Backlogs</th><th>Status</th>
                            <th>Interview Date</th><th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:if test="${empty applications}">
                            <tr><td colspan="9" class="no-results">No applications yet.</td></tr>
                        </c:if>
                        <c:forEach var="app" items="${applications}" varStatus="i">
                            <tr>
                                <td>${i.index + 1}</td>
                                <td><strong>${app.studentName}</strong></td>
                                <td>${app.email}</td>
                                <td>${app.branch}</td>
                                <td>${app.cgpa}</td>
                                <td>${app.backlogs}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${app.status == 'INTERVIEW_SCHEDULED'}"><span class="badge badge-interview">📅 Interview Scheduled</span></c:when>
                                        <c:when test="${app.status == 'ACCEPTED'}"><span class="badge badge-accepted">✅ Accepted</span></c:when>
                                        <c:when test="${app.status == 'REJECTED'}"><span class="badge badge-rejected">❌ Rejected</span></c:when>
                                        <c:otherwise><span class="badge badge-pending">⏳ Pending</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:if test="${not empty app.interviewDate}">
                                        <span class="interview-date-cell">📅 ${app.interviewDate}</span>
                                    </c:if>
                                    <c:if test="${empty app.interviewDate}">—</c:if>
                                </td>
                                <td style="white-space:nowrap;">
                                    <div style="display:flex;gap:5px;flex-wrap:wrap;">
                                        <c:if test="${app.status == 'PENDING'}">
                                            <a href="updateAppStatus?appId=${app.id}&status=ACCEPTED" class="btn-sm btn-accept">✅ Accept</a>
                                            <a href="updateAppStatus?appId=${app.id}&status=REJECTED" class="btn-sm btn-reject">❌ Reject</a>
                                        </c:if>
                                        <c:if test="${app.status == 'ACCEPTED' || app.status == 'INTERVIEW_SCHEDULED'}">
                                            <button class="btn-sm btn-schedule"
                                                onclick="openScheduleModal(${app.id}, '${app.studentName}')">
                                                📅 Schedule
                                            </button>
                                            <a href="updateAppStatus?appId=${app.id}&status=REJECTED" class="btn-sm btn-reject">❌ Reject</a>
                                        </c:if>
                                        <c:if test="${app.status == 'REJECTED'}">
                                            <a href="updateAppStatus?appId=${app.id}&status=ACCEPTED" class="btn-sm btn-accept">↩ Re-Accept</a>
                                        </c:if>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

</div>
</body>
</html>
