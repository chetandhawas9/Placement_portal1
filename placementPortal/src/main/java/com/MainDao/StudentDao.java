package com.MainDao;

import java.util.List;

import com.model.LoginModel;
import com.model.StudentModel;

public interface StudentDao {
    public List<StudentModel> getUserList();
    public String updateUser(StudentModel user);
    public List<StudentModel> doLogin(LoginModel lm);
    public String saveUser(StudentModel user);
    public boolean isEmailExists(String email);
    public List<String> getUserNames();
    String deleteUser(StudentModel model);
    public List<StudentModel> searchStudentsByName(String name);
    public StudentModel getStudentByEmail(String email);

}
