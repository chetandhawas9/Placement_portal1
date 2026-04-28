package com.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.model.AdminModel;
import com.model.ApplicationModel;
import com.model.JobModel;
import com.model.LoginModel;
import com.model.StudentModel;
import com.service.AdminService;
import com.service.ApplicationService;
import com.service.JobService;
import com.service.StudentService;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private AdminService adminService;

    @Autowired
    private StudentService studentService;

    @Autowired
    private JobService jobService;

    @Autowired
    private ApplicationService applicationService;

    @RequestMapping("/login")
    public String showAdminLogin() {
        return "AdminLogin";
    }

    @RequestMapping(value = "/loginProcess", method = RequestMethod.POST)
    public String doAdminLogin(@ModelAttribute LoginModel lm, HttpSession session, Model model) {
        List<AdminModel> result = adminService.doAdminLogin(lm);
        if (result == null || result.isEmpty()) {
            model.addAttribute("error", "Invalid admin credentials!");
            return "AdminLogin";
        }
        session.setAttribute("admin", result.get(0));
        return "redirect:/admin/dashboard";
    }

    @RequestMapping("/register")
    public String showAdminRegister() {
        return "AdminReg";
    }

    @RequestMapping(value = "/registerProcess", method = RequestMethod.POST)
    public String saveAdmin(@ModelAttribute AdminModel admin, Model model) {
        if (adminService.isAdminEmailExists(admin.getEmail())) {
            model.addAttribute("error", "Email already registered!");
            return "AdminReg";
        }
        adminService.saveAdmin(admin);
        model.addAttribute("success", "Admin registered successfully! Please login.");
        return "AdminLogin";
    }

    @RequestMapping("/dashboard")
    public String adminDashboard(HttpSession session, Model model,
            @RequestParam(value = "studentSearch", required = false, defaultValue = "") String studentSearch,
            @RequestParam(value = "jobSearch", required = false, defaultValue = "") String jobSearch,
            @RequestParam(value = "activeTab", required = false, defaultValue = "tab-overview") String activeTab) {

        AdminModel admin = (AdminModel) session.getAttribute("admin");
        if (admin == null) {
            return "redirect:/admin/login";
        }

        // Students - filtered or all
        List<StudentModel> students = studentSearch.isEmpty()
                ? studentService.getUserList()
                : studentService.searchStudentsByName(studentSearch);

        // Jobs - filtered or all
        List<JobModel> jobs = jobSearch.isEmpty()
                ? jobService.getAllJobs()
                : jobService.searchJobsByName(jobSearch);

        List<ApplicationModel> applications = applicationService.getAllApplications();

        model.addAttribute("students", students);
        model.addAttribute("jobs", jobs);
        model.addAttribute("applications", applications);
        model.addAttribute("totalStudents", studentService.getUserList().size());
        model.addAttribute("totalJobs", jobService.getAllJobs().size());
        model.addAttribute("totalApplications", applications.size());
        model.addAttribute("studentSearch", studentSearch);
        model.addAttribute("jobSearch", jobSearch);
        model.addAttribute("activeTab", activeTab);

        return "AdminDashboard";
    }

    @RequestMapping(value = "/addJob", method = RequestMethod.POST)
    public String addJob(@ModelAttribute JobModel job, HttpSession session, Model model) {
        AdminModel admin = (AdminModel) session.getAttribute("admin");
        if (admin == null) return "redirect:/admin/login";
        jobService.saveJob(job);
        return "redirect:/admin/dashboard?activeTab=tab-jobs";
    }

    @RequestMapping("/deleteJob")
    public String deleteJob(@RequestParam("id") int id, HttpSession session) {
        AdminModel admin = (AdminModel) session.getAttribute("admin");
        if (admin == null) return "redirect:/admin/login";
        jobService.deleteJob(id);
        return "redirect:/admin/dashboard?activeTab=tab-jobs";
    }

    @RequestMapping("/deleteStudent")
    public String deleteStudent(@RequestParam("id") int id, HttpSession session) {
        AdminModel admin = (AdminModel) session.getAttribute("admin");
        if (admin == null) return "redirect:/admin/login";
        studentService.deleteUser(id);
        return "redirect:/admin/dashboard?activeTab=tab-students";
    }

    @RequestMapping("/updateAppStatus")
    public String updateStatus(@RequestParam("appId") int appId,
                               @RequestParam("status") String status,
                               HttpSession session) {
        AdminModel admin = (AdminModel) session.getAttribute("admin");
        if (admin == null) return "redirect:/admin/login";
        applicationService.updateApplicationStatus(appId, status);
        return "redirect:/admin/dashboard?activeTab=tab-applications";
    }

    // NEW: Schedule interview date for an accepted application
    @RequestMapping(value = "/scheduleInterview", method = RequestMethod.POST)
    public String scheduleInterview(@RequestParam("appId") int appId,
                                    @RequestParam("interviewDate") String interviewDate,
                                    HttpSession session) {
        AdminModel admin = (AdminModel) session.getAttribute("admin");
        if (admin == null) return "redirect:/admin/login";
        applicationService.scheduleInterview(appId, interviewDate);
        return "redirect:/admin/dashboard?activeTab=tab-applications";
    }

    @RequestMapping("/logout")
    public String adminLogout(HttpSession session) {
        session.removeAttribute("admin");
        return "redirect:/admin/login";
    }
}
