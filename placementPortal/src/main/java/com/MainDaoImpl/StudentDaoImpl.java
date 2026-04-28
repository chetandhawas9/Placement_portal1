package com.MainDaoImpl;

import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.MainDao.StudentDao;
import com.model.LoginModel;
import com.model.StudentModel;

@Repository
public class StudentDaoImpl implements StudentDao {

    @Autowired
    private SessionFactory sessionFactory;

    @Override
    @Transactional
    public List<StudentModel> getUserList() {
        return sessionFactory.getCurrentSession()
                .createQuery("FROM StudentModel", StudentModel.class)
                .list();
    }

    @Override
    @Transactional
    public String updateUser(StudentModel user) {
        sessionFactory.getCurrentSession().update(user);
        return "SUCCESS";
    }

    @Override
    @Transactional
    public String deleteUser(StudentModel model) {
        StudentModel student = sessionFactory.getCurrentSession()
                .get(StudentModel.class, model.getId());
        if (student != null) {
            sessionFactory.getCurrentSession().delete(student);
            return "SUCCESS";
        }
        return "NOT_FOUND";
    }

    @Override
    @Transactional
    public List<StudentModel> doLogin(LoginModel lm) {
        String hql = "FROM StudentModel WHERE username = :username AND password = :password";
        return sessionFactory.getCurrentSession()
                .createQuery(hql, StudentModel.class)
                .setParameter("username", lm.getUsername())
                .setParameter("password", lm.getPassword())
                .list();
    }

    @Override
    @Transactional
    public String saveUser(StudentModel user) {
        sessionFactory.getCurrentSession().save(user);
        return "SUCCESS";
    }

    @Override
    @Transactional
    public boolean isEmailExists(String email) {
        String hql = "FROM StudentModel WHERE email = :email";
        List<StudentModel> list = sessionFactory.getCurrentSession()
                .createQuery(hql, StudentModel.class)
                .setParameter("email", email)
                .list();
        return !list.isEmpty();
    }

    @Override
    @Transactional
    public List<String> getUserNames() {
        return sessionFactory.getCurrentSession()
                .createQuery("SELECT name FROM StudentModel", String.class)
                .list();
    }

    @Override
    @Transactional
    public List<StudentModel> searchStudentsByName(String name) {
        String hql = "FROM StudentModel WHERE LOWER(name) LIKE :name OR LOWER(email) LIKE :name";
        return sessionFactory.getCurrentSession()
                .createQuery(hql, StudentModel.class)
                .setParameter("name", "%" + name.toLowerCase() + "%")
                .list();
    }

	@Override
	@Transactional
	public StudentModel getStudentByEmail(String email) {
		 String hql = "FROM StudentModel WHERE email = :email";
	        List<StudentModel> list = sessionFactory.getCurrentSession()
	                .createQuery(hql, StudentModel.class)
	                .setParameter("email", email)
	                .list();
	        return list.isEmpty() ? null : list.get(0);
	}
}
