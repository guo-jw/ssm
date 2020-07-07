<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="pagePath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>工单系统</title>
    <link type="text/css" rel="stylesheet" href="${pagePath}/css/css.css" />
</head>
<frameset rows="80,*" cols="*" frameborder="no" border="0" framespacing="0">
    <frame src="${pagePath}/user/top.do" name="title" scrolling="no" noresize="noresize">
    <frameset cols="220,*" frameborder="no" border="0" framespacing="0">
        <frame src="${pagePath}/user/left.do" name="tree" scrolling="no" marginheight="0" marginwidth="0">
        <frame src="${pagePath}/user/right.do" name="main" scrolling="yes" frameborder="0" marginwidth="0" marginheight="0" noresize="noresize">
    </frameset>
</frameset>
</html>