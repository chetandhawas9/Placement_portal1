package com.MainDaoImpl;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.MainDao.JobDao;
import com.model.JobModel;

@Repository
public class JobDaoImpl implements JobDao {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    @Transactional
    public String saveJob(JobModel job) {
        sessionFactory.getCurrentSession().save(job);
        return "SUCCESS";
    }

    @Override
    @Transactional
    public List<JobModel> getAllJobs() {
        return sessionFactory.getCurrentSession()
                .createQuery("FROM JobModel", JobModel.class)
                .list();
    }

    @Override
    @Transactional
    public List<JobModel> getJobsByBranch(String branch) {
        String hql = "FROM JobModel WHERE branch = :branch OR branch = 'ALL'";
        return sessionFactory.getCurrentSession()
                .createQuery(hql, JobModel.class)
                .setParameter("branch", branch)
                .list();
    }

    @Override
    @Transactional
    public List<JobModel> searchJobs(String keyword, String branch) {
        String hql = "FROM JobModel WHERE (title LIKE :keyword OR company LIKE :keyword) " +
                     "AND (branch = :branch OR branch = 'ALL')";
        return sessionFactory.getCurrentSession()
                .createQuery(hql, JobModel.class)
                .setParameter("keyword", "%" + keyword + "%")
                .setParameter("branch", branch)
                .list();
    }

    @Override
    @Transactional
    public JobModel getJobById(int id) {
        return sessionFactory.getCurrentSession().get(JobModel.class, id);
    }

    @Override
    @Transactional
    public String deleteJob(int id) {
        JobModel job = sessionFactory.getCurrentSession().get(JobModel.class, id);
        if (job != null) {
            sessionFactory.getCurrentSession().delete(job);
            return "SUCCESS";
        }
        return "NOT_FOUND";
    }

    @Override
    @Transactional
    public List<JobModel> searchJobsByName(String keyword) {
        String hql = "FROM JobModel WHERE LOWER(title) LIKE :keyword OR LOWER(company) LIKE :keyword";
        return sessionFactory.getCurrentSession()
                .createQuery(hql, JobModel.class)
                .setParameter("keyword", "%" + keyword.toLowerCase() + "%")
                .list();
    }

	
}
