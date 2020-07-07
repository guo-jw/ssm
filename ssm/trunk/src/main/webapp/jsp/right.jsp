<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="pagePath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>工单管理系统 ——后台管理</title>
    <link type="text/css" rel="stylesheet" href="${pagePath}/css/css.css" />
</head>
<body>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td height="10"></td>
    </tr>
    <tr>
        <td width="15" height="32"><img src="${pagePath}/images/main_locleft.gif" width="15" height="32"></td>
        <td class="main_locbg font2"><img src="${pagePath}/images/pointer.gif">&nbsp;当前位置：后台管理&nbsp;&gt;&nbsp;当前用户</td>
        <td width="15" height="32"><img src="${pagePath}/images/main_locright.gif" width="15" height="32"></td>
    </tr>
</table>
<table width="100%" height="90%" border="0" cellpadding="10" cellspacing="0" class="main_tabbor">
    <tr valign="top">
        <td>
            <table width="100%" border="0" cellpadding="0" cellspacing="10" class="main_tab">
                <tr>
                    <td class="font3 fftd">用户账号：<font color="red" size="2">${user.username}</font></td>
                </tr>
                <tr>
                    <td class="main_tdbor"></td>
                </tr>
                <tr>
                    <td class="font3 fftd">用户姓名：<font color="red" size="2">${user.name}</font></td>
                </tr>
                <tr>
                    <td class="main_tdbor"></td>
                </tr>
                <tr>
                    <td class="font3 fftd">用户权限：<font color="red" size="2"> <c:if test="${user.role == 1}">管理员</c:if> <c:if test="${user.role == 2}">普通用户</c:if></font></td>
                </tr>
                <tr>
                    <td class="main_tdbor"></td>
                </tr>
                <tr>
                    <td class="font3 fftd">创建时间：<font color="red" size="2"> <fmt:formatDate value="${user.createTime}" pattern="yyyy-MM-dd HH:mm:ss" /></font></td>
                </tr>
                <tr>
                    <td></td>
                </tr>
            </table>
        </td>
    </tr>
</table>
<div style="height: 10px;"></div>
</body>
</html>