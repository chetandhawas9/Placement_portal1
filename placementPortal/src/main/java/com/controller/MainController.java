package com.controller;

import java.io.File;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.model.*;
import com.service.*;

@Controller
public class MainController {

    @Autowired
    private StudentService studentService;

    @Autowired
    private JobService jobService;

    @Autowired
    private ApplicationService applicationService;

    // HOME
    @RequestMapping("/")
    public String home() {
        return "redirect:/login";
    }

    // LOGIN PAGE
    @RequestMapping("/login")
    public String showLogin() {
        return "login";
    }
    @Autowired
    private JavaMailSender mailSender;

    // LOGIN PROCESS
    @RequestMapping(value = "/loginProcess", method = RequestMethod.POST)
    public String doLogin(@ModelAttribute LoginModel lm, HttpSession session, Model model) {
        List<StudentModel> result = studentService.doLogin(lm);
        if (result == null || result.isEmpty()) {
            model.addAttribute("error", "Invalid username or password!");
            return "login";
        }
        session.setAttribute("user", result.get(0));
        return "redirect:/studentDashboard";
    }

    // REGISTER PAGE
    @RequestMapping("/register")
    public String showRegister() {
        return "register";
    }

    // REGISTER PROCESS
    @RequestMapping(value = "/registerProcess", method = RequestMethod.POST)
    public String saveUser(@ModelAttribute StudentModel user, Model model) {
        if (studentService.isEmailExists(user.getEmail())) {
            model.addAttribute("error", "Email already exists!");
            return "register";
        }
        studentService.saveUser(user);
        model.addAttribute("success", "Registration successful! Please login.");
        return "login";
    }

    // STUDENT DASHBOARD
    @RequestMapping("/studentDashboard")
    public String studentDashboard(HttpSession session, Model model,
            @RequestParam(value = "keyword", required = false, defaultValue = "") String keyword) {

        StudentModel user = (StudentModel) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        List<?> jobs = keyword.isEmpty()
                ? jobService.getJobsByBranch(user.getBranch())
                : jobService.searchJobs(keyword, user.getBranch());

        List<ApplicationModel> apps =
                applicationService.getApplicationsByStudentId(user.getId());

        model.addAttribute("user", user);
        model.addAttribute("jobs", jobs);
        model.addAttribute("myApplications", apps);
        model.addAttribute("totalJobs", jobs.size());
        model.addAttribute("appliedCount", apps.size());
        model.addAttribute("keyword", keyword);

        return "StudDashboard";
    }

    // APPLY JOB PAGE
    @RequestMapping("/jobApplication")
    public String applyPage(HttpSession session) {
        if (session.getAttribute("user") == null) {
            return "redirect:/login";
        }
        return "applyJob";
    }

    // APPLY JOB PROCESS
    @RequestMapping(value = "/applyJobProcess", method = RequestMethod.POST)
    public String applyJob(
            @RequestParam("jobId") int jobId,
            @RequestParam("backlogs") String backlogs,
            @RequestParam("cgpa") double cgpa,
            @RequestParam(value = "coverLetter", required = false) String coverLetter,
            @RequestParam("resume") MultipartFile resume,
            HttpSession session,
            RedirectAttributes redirectAttrs) {

        StudentModel user = (StudentModel) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        if (applicationService.hasAlreadyApplied(user.getId(), jobId)) {
            redirectAttrs.addFlashAttribute("error", "You have already applied for this job!");
            return "redirect:/studentDashboard";
        }

        String fileName = "";
        try {
            if (!resume.isEmpty()) {
                String path = System.getProperty("catalina.home") + "/uploads/";
                File dir = new File(path);
                if (!dir.exists()) dir.mkdirs();
                fileName = user.getId() + "_" + resume.getOriginalFilename();
                resume.transferTo(new File(path + fileName));
            }
        } catch (Exception e) {
            redirectAttrs.addFlashAttribute("error", "File upload failed. Please try again.");
            return "redirect:/studentDashboard";
        }

        ApplicationModel app = new ApplicationModel();
        app.setStudentId(user.getId());
        app.setJobId(jobId);
        app.setStudentName(user.getName());
        app.setEmail(user.getEmail());
        app.setPhone(user.getPhone());
        app.setBranch(user.getBranch());
        app.setCgpa(cgpa);
        app.setBacklogs(backlogs);
        app.setCoverLetter(coverLetter);
        app.setResumePath(fileName);
        app.setStatus("PENDING");

        applicationService.saveApplication(app);

        redirectAttrs.addFlashAttribute("msg", "Applied successfully! We'll update you on your status.");
        return "redirect:/studentDashboard";
    }

    // LOGOUT
    @RequestMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
    
    @RequestMapping("/forgotPassword")
    public String showForgotForm() {
        return "forgotpassword"; 
    }
    


    // FORGOT PASSWORD PAGE
    @RequestMapping(value = "/forgotPassword", method = RequestMethod.GET)
    public String showForgotPassword() {
        return "forgotPassword";
    }

    // FORGOT PASSWORD PROCESS
    @RequestMapping(value = "/forgotPasswordProcess", method = RequestMethod.POST)
    public String processForgotPassword(@RequestParam("email") String email, Model model) {
        StudentModel student = studentService.getStudentByEmail(email);
        if (student == null) {
            model.addAttribute("error", "No account found with this email address.");
            return "forgotPassword";
        }
        try {
            SimpleMailMessage message = new SimpleMailMessage();
            message.setTo(student.getEmail());
            message.setSubject("Placement Portal - Your Password");
            message.setText(
                "Hello " + student.getName() + ",\n\n" +
                "You requested your password for Placement Portal.\n\n" +
                "Your login credentials are:\n" +
                "  Username : " + student.getUsername() + "\n" +
                "  Password : " + student.getPassword() + "\n\n" +
                "Please login at: http://localhost:8080/placementPortal/login\n\n" +
                "Regards,\nPlacement Portal Team"
            );
            mailSender.send(message);
            model.addAttribute("success", "Your password has been sent to your registered email: " + email);
        } catch (Exception e) {
            model.addAttribute("error", "Failed to send email. Please try again later.");
        }
        return "forgotPassword";
    }

}
