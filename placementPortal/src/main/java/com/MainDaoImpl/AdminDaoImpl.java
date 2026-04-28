package com.MainDaoImpl;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.MainDao.AdminDao;
import com.model.AdminModel;
import com.model.LoginModel;

@Repository
public class AdminDaoImpl implements AdminDao {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    @Transactional
    public String saveAdmin(AdminModel admin) {
        sessionFactory.getCurrentSession().save(admin);
        return "SUCCESS";
    }

    @Override
    @Transactional
    public List<AdminModel> doAdminLogin(LoginModel lm) {
        String hql = "FROM AdminModel WHERE username = :username AND password = :password";
        return sessionFactory.getCurrentSession()
                .createQuery(hql, AdminModel.class)
                .setParameter("username", lm.getUsername())
                .setParameter("password", lm.getPassword())
                .list();
    }

    @Override
    @Transactional
    public boolean isAdminEmailExists(String email) {
        String hql = "FROM AdminModel WHERE email = :email";
        List<AdminModel> list = sessionFactory.getCurrentSession()
                .createQuery(hql, AdminModel.class)
                .setParameter("email", email)
                .list();
        return !list.isEmpty();
    }
}
