package com.serviceimpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.MainDao.JobDao;
import com.model.JobModel;
import com.service.JobService;

@Service
public class JobServiceImpl implements JobService {

    @Autowired
    private JobDao dao;

    @Override
    @Transactional
    public String saveJob(JobModel job) {
        return dao.saveJob(job);
    }

    @Override
    @Transactional
    public List<JobModel> getAllJobs() {
        return dao.getAllJobs();
    }

    @Override
    @Transactional
    public List<JobModel> getJobsByBranch(String branch) {
        return dao.getJobsByBranch(branch);
    }

    @Override
    @Transactional
    public List<JobModel> searchJobs(String keyword, String branch) {
        return dao.searchJobs(keyword, branch);
    }

    @Override
    @Transactional
    public JobModel getJobById(int id) {
        return dao.getJobById(id);
    }

    @Override
    @Transactional
    public String deleteJob(int id) {
        return dao.deleteJob(id);
    }

	@Override
	public List<JobModel> searchJobsByName(String keyword) {
		// TODO Auto-generated method stub
		return dao.searchJobsByName(keyword);

	}
}
