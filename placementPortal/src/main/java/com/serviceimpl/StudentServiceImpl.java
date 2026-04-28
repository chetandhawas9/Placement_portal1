package com.serviceimpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.MainDao.StudentDao;
import com.model.LoginModel;
import com.model.StudentModel;
import com.service.StudentService;

@Service
public class StudentServiceImpl implements StudentService {

    @Autowired
    private StudentDao dao;

    @Override
    @Transactional
    public List<StudentModel> getUserList() {
        return dao.getUserList();
    }

    @Override
    @Transactional
    public String updateUser(StudentModel user) {
        return dao.updateUser(user);
    }

    @Override
    @Transactional
    public String deleteUser(int id) {
        List<StudentModel> all = dao.getUserList();
        for (StudentModel s : all) {
            if (s.getId() == id) {
                return dao.deleteUser(s);
            }
        }
        return "NOT_FOUND";
    }

    @Override
    @Transactional
    public List<StudentModel> doLogin(LoginModel lm) {
        return dao.doLogin(lm);
    }

    @Override
    @Transactional
    public String saveUser(StudentModel user) {
        return dao.saveUser(user);
    }

    @Override
    @Transactional
    public boolean isEmailExists(String email) {
        return dao.isEmailExists(email);
    }

    @Override
    @Transactional
    public List<String> getUserNames(LoginModel lm) {
        return dao.getUserNames();
    }

    @Override
    @Transactional
    public List<StudentModel> searchStudentsByName(String name) {
        return dao.searchStudentsByName(name);
    }

	@Override
	@Transactional
	public StudentModel getStudentByEmail(String email) {
		// TODO Auto-generated method stub
		return dao.getStudentByEmail(email);
	}
}
