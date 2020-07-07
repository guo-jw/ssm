package com.ssm.dao;

import com.ssm.model.User;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;
@Repository
public interface UserDao {
    //登陆
    User login(Map map);
    //用户和密码
    void userAdd(User user);
    //查询所有用户
    List<User> queryAllUser();
    //查询个人信息
    User getById(Integer id);
    //修改个人用户
    void updateUser(User user);
    //检验用户名
    User findByUsername(String username);
    User findByName(String username);
    //根据角色查询现场处理人信息
    List<User> selectByRole();


}
