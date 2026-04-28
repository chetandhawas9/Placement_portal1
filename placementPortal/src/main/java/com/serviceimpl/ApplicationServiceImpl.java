package com.serviceimpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.MainDao.ApplicationDao;
import com.model.ApplicationModel;
import com.service.ApplicationService;

@Service
public class ApplicationServiceImpl implements ApplicationService {

    @Override
	public void scheduleInterview(int appId, String interviewDate) {
    	 dao.scheduleInterview(appId, interviewDate);

		
	}

	@Autowired
    private ApplicationDao dao;

    @Override
    @Transactional
    public String saveApplication(ApplicationModel app) {
        return dao.saveApplication(app);
    }

    @Override
    @Transactional
    public List<ApplicationModel> getAllApplications() {
        return dao.getAllApplications();
    }

    @Override
    @Transactional
    public List<ApplicationModel> getApplicationsByStudentId(int studentId) {
        return dao.getApplicationsByStudentId(studentId);
    }

    @Override
    @Transactional
    public List<ApplicationModel> getApplicationsByJobId(int jobId) {
        return dao.getApplicationsByJobId(jobId);
    }

    @Override
    @Transactional
    public String updateApplicationStatus(int appId, String status) {
        return dao.updateApplicationStatus(appId, status);
    }

    @Override
    @Transactional
    public boolean hasAlreadyApplied(int studentId, int jobId) {
        return dao.hasAlreadyApplied(studentId, jobId);
    }
}
