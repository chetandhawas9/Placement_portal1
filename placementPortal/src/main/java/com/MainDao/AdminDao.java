package com.MainDao;

import java.util.List;

import com.model.AdminModel;
import com.model.LoginModel;

public interface AdminDao {

    public String saveAdmin(AdminModel admin);

    public List<AdminModel> doAdminLogin(LoginModel lm);

    public boolean isAdminEmailExists(String email);
}
