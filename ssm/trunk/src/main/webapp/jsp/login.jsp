<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="pagePath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>工单系统</title>
    <script  type="text/javascript" src="${pagePath}/js/jquery.min.js"></script>
    <script  type="text/javascript" src="${pagePath}/js/jquery.easyui.min.js"></script>
    <style>
        * { margin: 0; padding: 0; }
        html { height: 100%; }
        body { height: 100%; background: #fff url(/images/backgroud.png) 50% 50% no-repeat; background-size: cover;}
        .dowebok { position: absolute; left: 50%; top: 50%; width: 430px; height: 550px; margin: -300px 0 0 -215px; border: 1px solid #fff; border-radius: 20px; overflow: hidden;}
        .logo { width: 104px; height: 104px; margin: 50px auto 80px; background: url(/images/login.png) 0 0 no-repeat; }
        .form-item { position: relative; width: 360px; margin: 0 auto; padding-bottom: 30px;}
        .form-item input { width: 288px; height: 48px; padding-left: 70px; border: 1px solid #fff; border-radius: 25px; font-size: 18px; color: #fff; background-color: transparent; outline: none;}
        .form-item button { width: 360px; height: 50px; border: 0; border-radius: 25px; font-size: 18px; color: #1f6f4a; outline: none; cursor: pointer; background-color: #fff; }
        #username { background: url(/images/emil.png) 20px 14px no-repeat; }
        #password { background: url(/images/password.png) 23px 11px no-repeat; }
        .tip { display: none; position: absolute; left: 20px; top: 52px; font-size: 14px; color: #f50; }
        .reg-bar { width: 360px; margin: 20px auto 0; font-size: 14px; overflow: hidden;}
        .reg-bar a { color: #fff; text-decoration: none; }
        .reg-bar a:hover { text-decoration: underline; }
        .reg-bar .reg { float: left; }
        .reg-bar .forget { float: right; }
        .dowebok ::-webkit-input-placeholder { font-size: 18px; line-height: 1.4; color: #fff;}
        .dowebok :-moz-placeholder { font-size: 18px; line-height: 1.4; color: #fff;}
        .dowebok ::-moz-placeholder { font-size: 18px; line-height: 1.4; color: #fff;}
        .dowebok :-ms-input-placeholder { font-size: 18px; line-height: 1.4; color: #fff;}

        @media screen and (max-width: 500px) {
            * { box-sizing: border-box; }
            .dowebok { position: static; width: auto; height: auto; margin: 0 30px; border: 0; border-radius: 0; }
            .logo { margin: 50px auto; }
            .form-item { width: auto; }
            .form-item input, .form-item button, .reg-bar { width: 100%; }
        }
    </style>
    <script type="text/javascript">
        $(document).ready(function () {
            $('input').val('');
            $('#submit').on('click', function () {
                var username = $("#username").val();
                var password = $("#password").val();
                if (username == ""|| password == "") {
                    $('.tip').show();
                    return;
                }

                /* ajax请求 */
                $.ajax({
                    url : "/user/checkLogin.do",
                    type : "post",
                    dataType:'json',
                    async:true,
                    data : {
                        "username" : username,
                        "password" : password
                    },
                    success : function(data) {
                        if (data) {
                            window.location.href = "/jsp/main.jsp";
                        }else{
                            alert( "用户名或者密码错误！");
                            return;
                        }
                    },
                    error:function(data, XMLHttpRequest, textStatus,
                                   errorThrown) {
                        alert("登陆异常");
                        alert("responseText="+XMLHttpRequest.responseText)
                        alert("date=" + JSON.parse(data));
                        alert("xmlhttprequeststatus="
                            + XMLHttpRequest.status);
                        alert("readyState="
                            + XMLHttpRequest.readyState);
                        alert("textStatus=" + textStatus);
                    }
                });
            })
        });
            

    </script>
</head>
<body>
        <div class="logo"></div>
        <div class="form-item">
            <input id="username" nama="username" type="text" autocomplete="off" placeholder="账号">
            <p class="tip">请输入合法的账号</p>
        </div>
        <div class="form-item">
            <input id="password" name="password" type="password" autocomplete="off" placeholder="登录密码">
            <p class="tip">邮箱或密码不正确</p>
        </div>
        <div class="form-item"><button id="submit">登 录</button></div>
        <div class="reg-bar">
            <a class="reg" href="javascript:">立即注册</a>
            <a class="forget" href="javascript:">忘记密码</a>
        </div>
</body>
</html>