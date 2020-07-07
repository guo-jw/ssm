package com.ssm.service.impl;

import com.ssm.dao.UserDao;
import com.ssm.model.User;
import com.ssm.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service("userService")
public class UserServiceImpl implements UserService {


    @Autowired
    private UserDao userDao;
    @Override
    public User findByName(String username) {
        return userDao.findByName(username);
    }
    /*
     * 检验用户登录业务
     */
    public User login(Map map) {
        return userDao.login(map);
    }
    /*
     * 注册用户
     */
    public void userAdd(User user){
        userDao.userAdd(user);
    }

    @Override
    public List<User> selectByRole() {
        return userDao.selectByRole();
    }

    /*
     * 用户列表
     */
    public List<User> queryAllUser() {
        return userDao.queryAllUser();
    }
    /*
     * 查询个人用户
     */
    public User getById(Integer id){return userDao.getById(id);}
    /*
     * 修改人用户
     */
    public void updateUser(User user){userDao.updateUser(user);}
    /*
     * 验证用户名
     */
    public User findByUsername(String username){return userDao.findByUsername(username);}


}

