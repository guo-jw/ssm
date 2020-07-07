<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="pagePath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>修改用户</title>
    <link type="text/css" rel="stylesheet" href="${pagePath}/css/css.css" />
    <link type="text/css" rel="stylesheet" href="${pagePath}/css/user/ligerui-dialog.css" />
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
            /** 员工表单提交 */
            $("#userForm").submit(function() {
                var name = $("#name");
                var password = $("#password");
                var role = $("#role");
                var msg = "";
                if ($.trim(name.val()) == "") {
                    msg = "姓名不能为空！";
                    name.focus();
                } else if ($.trim(password.val()) == "") {
                    msg = "密码不能为空！";
                    password.focus();
                } else if ($.trim(role.val()) == "") {
                    msg = "请选择用户权限！";
                    role.focus();
                }
                if (msg != "") {
                    $.ligerDialog.error(msg);
                    return false;
                } else {
                    $("#userForm").submit();
                }
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
        <td class="main_locbg font2"><img src="${pagePath}/images/pointer.gif">&nbsp;当前位置：用户管理&nbsp;&gt;&nbsp;修改用户</td>
        <td width="15" height="32"><img src="${pagePath}/images/main_locright.gif" width="15" height="32"></td>
    </tr>
</table>
<table width="100%" height="90%" border="0" cellpadding="5" cellspacing="0" class="main_tabbor">
    <tr valign="top">
        <td>
            <form action="${pagePath}/user/modify.do" id="userForm" method="post">
                <!-- 隐藏表单，flag表示添加标记 -->
                <input type="hidden" name="flag" value="2"> <input type="hidden" name="id" value="${user.id}">
                <table width="100%" border="0" cellpadding="0" cellspacing="10" class="main_tab">
                    <tr>
                        <td class="font3 fftd">
                            <table>
                                <tr>
                                    <td class="font3 fftd">用户名：<input type="text" value="${user.username}" disabled="disabled" /></td>
                                </tr>
                                <tr>
                                    <td class="font3 fftd">密&nbsp;码：&nbsp;<input name="password" type="password" id="password" size="20" value="${user.password}" /></td>
                                </tr>
                                <tr>
                                    <td class="font3 fftd">姓&nbsp;名：&nbsp;<input name="name" id="name" size="20" value="${user.name}" /></td>
                                </tr>
                                <tr>
                                    <td class="font3 fftd">权&nbsp;限：&nbsp;<select id="role" name="role" style="width: 153px;">
                                        <c:if test="${user.role == 1}">
                                            <option value="1" selected="selected">管理员</option>
                                            <option value="2">专业用户</option>
                                            <option value="3">普通用户</option>
                                        </c:if>
                                        <c:if test="${user.role == 2}">
                                            <option value="2" selected="selected">专业用户</option>
                                            <option value="3" selected="selected">普通用户</option>
                                        </c:if>
                                        <c:if test="${user.role == 3}">
                                            <option value="3" selected="selected">普通用户</option>
                                            <option value="2" selected="selected">专业用户</option>
                                        </c:if>
                                    </select></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td class="main_tdbor"></td>
                    </tr>
                    <tr>
                        <td align="left" class="fftd"><input type="submit" value="修改 ">&nbsp;&nbsp;<input type="button" onclick="location.href='${pagePath}/user/list.do'" value="取消 "></td>
                    </tr>
                </table>
            </form>
        </td>
    </tr>
</table>
<div style="height: 10px;"></div>
</body>
</html>