package com.service;

import java.util.List;

import com.model.LoginModel;
import com.model.StudentModel;

public interface StudentService {
    public List<StudentModel> getUserList();
    public String updateUser(StudentModel user);
    public String deleteUser(int id);
    public List<StudentModel> doLogin(LoginModel lm);
    public String saveUser(StudentModel user);
    public boolean isEmailExists(String email);
    public List<String> getUserNames(LoginModel lm);
    public List<StudentModel> searchStudentsByName(String name);
    public StudentModel getStudentByEmail(String email);

}
