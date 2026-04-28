package com.MainDao;

import java.util.List;

import com.model.ApplicationModel;

public interface ApplicationDao {

    public String saveApplication(ApplicationModel app);

    public List<ApplicationModel> getAllApplications();

    public List<ApplicationModel> getApplicationsByStudentId(int studentId);

    public List<ApplicationModel> getApplicationsByJobId(int jobId);

    public String updateApplicationStatus(int appId, String status);

    public boolean hasAlreadyApplied(int studentId, int jobId);

    public void scheduleInterview(int appId, String interviewDate);
}
