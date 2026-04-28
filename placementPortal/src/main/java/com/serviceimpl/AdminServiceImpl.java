package com.serviceimpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.MainDao.AdminDao;
import com.model.AdminModel;
import com.model.LoginModel;
import com.service.AdminService;

@Service
public class AdminServiceImpl implements AdminService {

    @Autowired
    private AdminDao dao;

    @Override
    @Transactional
    public String saveAdmin(AdminModel admin) {
        return dao.saveAdmin(admin);
    }

    @Override
    @Transactional
    public List<AdminModel> doAdminLogin(LoginModel lm) {
        return dao.doAdminLogin(lm);
    }

    @Override
    @Transactional
    public boolean isAdminEmailExists(String email) {
        return dao.isAdminEmailExists(email);
    }
}
