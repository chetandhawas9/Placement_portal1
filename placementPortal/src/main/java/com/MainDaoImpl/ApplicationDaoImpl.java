package com.MainDaoImpl;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.MainDao.ApplicationDao;
import com.model.ApplicationModel;

@Repository
public class ApplicationDaoImpl implements ApplicationDao {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    @Transactional
    public String saveApplication(ApplicationModel app) {
        sessionFactory.getCurrentSession().save(app);
        return "SUCCESS";
    }

    @Override
    @Transactional
    public List<ApplicationModel> getAllApplications() {
        return sessionFactory.getCurrentSession()
                .createQuery("FROM ApplicationModel", ApplicationModel.class)
                .list();
    }

    @Override
    @Transactional
    public List<ApplicationModel> getApplicationsByStudentId(int studentId) {
        String hql = "FROM ApplicationModel WHERE studentId = :studentId";
        return sessionFactory.getCurrentSession()
                .createQuery(hql, ApplicationModel.class)
                .setParameter("studentId", studentId)
                .list();
    }

    @Override
    @Transactional
    public List<ApplicationModel> getApplicationsByJobId(int jobId) {
        String hql = "FROM ApplicationModel WHERE jobId = :jobId";
        return sessionFactory.getCurrentSession()
                .createQuery(hql, ApplicationModel.class)
                .setParameter("jobId", jobId)
                .list();
    }

    @Override
    @Transactional
    public String updateApplicationStatus(int appId, String status) {
        ApplicationModel app = sessionFactory.getCurrentSession()
                .get(ApplicationModel.class, appId);
        if (app != null) {
            app.setStatus(status);
            sessionFactory.getCurrentSession().update(app);
            return "SUCCESS";
        }
        return "NOT_FOUND";
    }

    @Override
    @Transactional
    public boolean hasAlreadyApplied(int studentId, int jobId) {
        String hql = "FROM ApplicationModel WHERE studentId = :studentId AND jobId = :jobId";
        List<ApplicationModel> list = sessionFactory.getCurrentSession()
                .createQuery(hql, ApplicationModel.class)
                .setParameter("studentId", studentId)
                .setParameter("jobId", jobId)
                .list();
        return !list.isEmpty();
    }

    @Override
    @Transactional
    public void scheduleInterview(int appId, String interviewDate) {
        ApplicationModel app = sessionFactory.getCurrentSession()
                .get(ApplicationModel.class, appId);
        if (app != null) {
            app.setInterviewDate(interviewDate);
            app.setStatus("INTERVIEW_SCHEDULED");
            sessionFactory.getCurrentSession().update(app);
        }
    }
}
