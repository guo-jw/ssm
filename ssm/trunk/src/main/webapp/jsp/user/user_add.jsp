<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="pagePath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>添加用户</title>
    <link type="text/css" rel="stylesheet" href="${pagePath}/css/css.css" />
    <link type="text/css" rel="stylesheet" href="${pagePath}/css/ligerui-dialog.css" />
    <link type="text/css" rel="stylesheet" href="${pagePath}/css/user/ligerui-icons.css" />
    <link type="text/css" rel="stylesheet" href="${pagePath}/css/pager.css" />
    <script type="text/javascript" src="${pagePath}/js/jquery-1.11.0.js"></script>
    <script type="text/javascript" src="${pagePath}/js/jquery-migrate-1.2.1.js"></script>
    <script type="text/javascript" src="${pagePath}/js/user/base.js"></script>
    <script type="text/javascript" src="${pagePath}/js/user/ligerDrag.js"></script>
    <script type="text/javascript" src="${pagePath}/js/user/ligerDialog.js"></script>
    <script type="text/javascript" src="${pagePath}/js/user/ligerResizable.js"></script>
    <script type="text/javascript">
        $(function() {
            //验证用户名是否重复
            $("#username").blur(function(){
                var username = $("#username").val();
                //发请求
                $.ajax({
                    type: "get",
                    url: "/user/findByUsername.do",
                    data: {"username": username},
                    dataType: 'json',
                    async:true,
                    success: function (data) {
                        if (data==false) {
                            //用户名已经被注册
                            $.ligerDialog.error("用户名已存在！");
                            $("#username").val("");
                            return false;
                        }
                    },
                    error:function(data, XMLHttpRequest, textStatus,
                                   errorThrown) {
                        alert("responseText="+XMLHttpRequest.responseText)
                    }
                });
            });

            /** 员工表单提交 */
            $("#userForm").submit(function() {
                var username = $("#username");
                var password = $("#password");
                var name = $("#name");
                var role = $("#role");
                var msg = "";
                if ($.trim(username.val()) == "") {
                    msg = "用户名不能为空！";
                    username.focus();
                } else if ($.trim(password.val()) == "") {
                    msg = "密码不能为空！";
                    password.focus();
                } else if ($.trim(name.val()) == "") {
                    msg = "姓名不能为空！";
                    name.focus();
                } else if ($.trim(role.val()) == "") {
                    msg = "请选择状态！";
                    role.focus();
                }
                if (msg != "") {
                    $.ligerDialog.error(msg);
                    return false;
                } else {
                    return true;
                }
                $("#userForm").submit();
            });
        });
    </script>
</head>
<body>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td height="10"></td>
    </tr>
    <tr>
        <td width="15" height="32"><img src="${pagePath}/images/main_locleft.gif" width="15" height="32"></td>
        <td class="main_locbg font2"><img src="${pagePath}/images/pointer.gif">&nbsp;当前位置：用户管理&nbsp;&gt;&nbsp;添加用户</td>
        <td width="15" height="32"><img src="${pagePath}/images/main_locright.gif" width="15" height="32"></td>
    </tr>
</table>
<table width="100%" height="90%" border="0" cellpadding="5" cellspacing="0" class="main_tabbor">
    <tr valign="top">
        <td>
            <form action="${pagePath}/user/add.do" id="userForm" method="post">
                <!-- 隐藏表单，flag表示添加标记 -->
                <input type="hidden" name="flag" value="2">
                <table width="100%" border="0" cellpadding="0" cellspacing="10" class="main_tab">
                    <tr>
                        <td class="font3 fftd">
                            <table>
                                <tr>
                                    <td class="font3 fftd">用户名：<input name="username" id="username" value="" size="23.8" /></td>
                                </tr>
                                <tr>
                                    <td class="font3 fftd">密&nbsp;&nbsp;码：<input name="password" id="password" value="" size="23.8" /></td>
                                </tr>
                                <tr>
                                    <td class="font3 fftd">姓&nbsp;&nbsp;名：<input type="text" name="name" id="name" value="" size="23.8" /></td>
                                </tr>
                                <tr>
                                    <td class="font3 fftd">权&nbsp;&nbsp;限：<select id="role" name="role"  style="width: 173px;">
                                        <option value="" >--请选择--</option>
                                        <option value="2">专业用户</option>
                                        <option value="3">普通用户</option>
                                    </select></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="main_tdbor"></td>
                    </tr>
                    <tr>
                        <td align="left" class="fftd"><input type="submit" value="添加">&nbsp;&nbsp;<input type="reset" value="取消 "></td>
                    </tr>
                </table>
            </form>
        </td>
    </tr>
</table>
<div style="height: 10px;"></div>
</body>
</html>