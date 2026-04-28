package com.MainDao;

import java.util.List;

import com.model.JobModel;

public interface JobDao {

    public String saveJob(JobModel job);

    public List<JobModel> getAllJobs();

    public List<JobModel> getJobsByBranch(String branch);

    public List<JobModel> searchJobs(String keyword, String branch);

    public List<JobModel> searchJobsByName(String keyword);

    public JobModel getJobById(int id);

    public String deleteJob(int id);
}
