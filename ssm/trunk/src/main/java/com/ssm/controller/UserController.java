package com.ssm.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.ssm.model.User;
import com.ssm.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    @Resource
    private UserService userService;
    //正常访问login页面
    @RequestMapping("/login.do")
    public ModelAndView login(ModelAndView view){
        view.setViewName("/login");
        return view;
    }

    //登陆验证页面
    @ResponseBody
    @RequestMapping("/checkLogin.do")
    public boolean checkLogin(String username,String password,HttpSession session) {
        Map map = new HashMap();
        map.put("username",username);
        map.put("password",password);
        User user = userService.login(map);
        boolean flag = false;
        if(user!=null) {
            session.setAttribute("user", user);
            System.out.println(session);
            flag = true;
        }
        return flag;
    }
     //用户列表
    @RequestMapping("/list.do")
    public ModelAndView list(@RequestParam(defaultValue = "1") Integer page, String key, Integer status) {
        ModelAndView view = new ModelAndView();
        PageHelper.startPage(page, 5);
        List<User> users = userService.queryAllUser();
        PageInfo<User> pageInfo = new PageInfo<User>(users);
        view.addObject("pages", pageInfo);
        view.addObject("key", key);
        view.addObject("status", status);
        view.setViewName("user/user_all");
        return view;
    }
    //验证用户名是否存在
    @ResponseBody
    @RequestMapping("/findByUsername.do")
    public boolean findByUsername(String username) {
        boolean flag = true;
        System.out.println("~~~~~~~~~~~~~~"+username);
        //验证用户名是否存在
        User u = userService.findByUsername(username.toString());
        System.out.println("~~~~~~~~~~~~~~"+u);
        if (u != null) {
            flag=false;
        }
        return flag;
    }
    //注册用户
    @RequestMapping("/add.do")
    public ModelAndView add(String flag,String username,String role, String password, String name) {
        ModelAndView view = new ModelAndView();
        if (flag.equals("1")) {
            // 设置跳转到添加页面
            view.setViewName("user/user_add");
        } else if (flag.toString().equals("2")) {
            //执行添加操作
            User user = new User();
            user.setUsername(username);
            user.setPassword(password);
            user.setName(name);
            user.setRole(Integer.parseInt(role));
            user.setCreateTime(new Date());
            userService.userAdd(user);
            // 设置客户端跳转到查询请求
            view.setViewName("redirect:list.do");
        }
        // 返回
        return view;
    }
     //修改用户
    @RequestMapping(value = "/modify.do")
    public ModelAndView modify(String flag,Integer id,String username,String role, String password, String name) {
        ModelAndView view = new ModelAndView();
        if (flag.equals("1")) {
            // 根据id查询用户
            User user = userService.getById(id);
            // 设置Model数据
            view.addObject("user", user);
            // 返回修改员工页面
            view.setViewName("user/user_modify");
        } else if (flag.equals("2")) {
            // 执行修改操作
            User user = userService.getById(id);
            user.setUsername(username);
            user.setPassword(password);
            user.setName(name);
            user.setRole(Integer.parseInt(role));

            userService.updateUser(user);
            // 设置客户端跳转到查询请求
            view.setViewName("redirect:list.do");
        }
        // 返回
        return view;
    }



















    //退出注销页面
    @RequestMapping("/logout.do")
    public ModelAndView logout(ModelAndView view, HttpSession session) {
        session.removeAttribute("user");
        view.addObject("message", "您已成功退出登录");
        view.setViewName("/login");
        return view;
    }
    @RequestMapping(value = "/index.do")
    public ModelAndView index(ModelAndView view) {
        view.setViewName("/main");
        return view;
    }
    @RequestMapping(value = "/top.do")
    public ModelAndView top(ModelAndView view) {
        view.setViewName("/top");
        return view;
    }
    @RequestMapping(value = "/left.do")
    public ModelAndView left(ModelAndView view) {
        view.setViewName("/left");
        return view;
    }
    @RequestMapping(value = "/right.do")
    public ModelAndView right(ModelAndView view) {
        view.setViewName("/right");
        return view;
    }











}
