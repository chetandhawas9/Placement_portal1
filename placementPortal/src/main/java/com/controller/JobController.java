package com.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.model.StudentModel;
import com.service.JobService;

@Controller
public class JobController {

    @Autowired
    private JobService jobService;

    @RequestMapping(value = "/jobs", method = RequestMethod.GET)
    public String searchJobs(
            @RequestParam(value = "keyword", required = false, defaultValue = "") String keyword,
            @RequestParam(value = "branch", required = false, defaultValue = "") String branch,
            HttpSession session,
            Model model) {

        StudentModel user = (StudentModel) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login";
        }

        String searchBranch = (branch == null || branch.isEmpty()) ? user.getBranch() : branch;

        List<?> jobs;
        if (keyword != null && !keyword.trim().isEmpty()) {
            jobs = jobService.searchJobs(keyword, searchBranch);
        } else {
            jobs = jobService.getJobsByBranch(searchBranch);
        }

        model.addAttribute("jobs", jobs);
        model.addAttribute("keyword", keyword);
        return "StudDashboard";
    }
}
