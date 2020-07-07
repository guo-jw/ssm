package com.ssm.controller;

import com.ssm.model.User;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class LoginFilter implements Filter {

    @Override
    public void destroy() {
        // TODO  Auto-generated method stub

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        // TODO 对全栈url进行过滤
        //将request和response对象强转为http类型
        HttpServletRequest req=(HttpServletRequest)request;
        HttpServletResponse resp = (HttpServletResponse)response;

        //获取访问的地址
        String url = req.getRequestURI();
        //System.err.println(url);
        //获取session中的对象判断是否登录
        //拦截所有的 .do 请求但不包含tologin.do
        //jsp文件已经放到web-inf下 不用过滤 只过滤 .do请求即可
        if(!url.contains("/user/login.do")&&!url.contains("/user/checkLogin.do")) {
            //获取session
            HttpSession session = req.getSession();
            User user=(User) session.getAttribute("user");
            //System.out.println(user+"~~~~~~~~~~~~~~~");
            if(user==null){
                resp.sendRedirect("/user/login.do");
                return;
            }

        }

        //继续执行过滤连的剩余部分
        chain.doFilter(req, resp);

    }

    @Override
    public void init(FilterConfig arg0) throws ServletException {
        // TODO Auto-generated method stub

    }






}
