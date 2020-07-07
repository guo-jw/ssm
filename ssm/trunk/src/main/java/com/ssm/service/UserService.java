package com.ssm.service;

import com.ssm.model.User;

import java.util.List;
import java.util.Map;

public interface UserService {

    //检验用户登录
    User login(Map map);
    //注册用户
    void userAdd(User user);
    //用户列表
    List<User> queryAllUser();
    //个人详细
    User getById(Integer id);
    //修改个人用户
    void updateUser(User user);
    //验证用户名
    User findByUsername(String username);
    User findByName(String username);
    //根据角色查询现场处理人信息
    List<User> selectByRole();
}