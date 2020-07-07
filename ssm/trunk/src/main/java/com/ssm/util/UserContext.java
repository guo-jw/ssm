package com.ssm.util;

import com.ssm.model.User;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpSession;

public class UserContext {
    private UserContext(){};

    public static final String EMP_IN_SESSION="EMP_IN_SESSION";

    public static void setCurrentUser(User emp){
        getSession().setAttribute("EMP_IN_SESSION", emp);

    }

    public static User getCurrentUser(){
        return (User) getSession().getAttribute(EMP_IN_SESSION);

    }


    public static HttpSession getSession(){
        ServletRequestAttributes attrs=(ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        return attrs.getRequest().getSession();
    }
}
