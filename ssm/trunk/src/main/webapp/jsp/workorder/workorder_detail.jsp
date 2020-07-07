<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="pagePath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>咨询申请单详情</title>
    <link type="text/css" rel="stylesheet" href="${pagePath}/css/css.css" />
    <link type="text/css" rel="stylesheet" href="${pagePath}/css/ligerui-dialog.css" />
    <link type="text/css" rel="stylesheet" href="${pagePath}/css/ligerui-icons.css" />
    <link type="text/css" rel="stylesheet" href="${pagePath}/css/pager.css" />
    <script type="text/javascript" src="${pagePath}/js/jquery-1.11.0.js"></script>
    <script type="text/javascript" src="${pagePath}/js/jquery-migrate-1.2.1.js"></script>
    <script type="text/javascript" src="${pagePath}/js/base.js"></script>
    <script type="text/javascript" src="${pagePath}/js/ligerDrag.js"></script>
    <script type="text/javascript" src="${pagePath}/js/ligerDialog.js"></script>
    <script type="text/javascript" src="${pagePath}/js/ligerResizable.js"></script>

    <script type="text/javascript">
        function select1() {
            window.location.href = "${pagePath}/jsp/workorder/workorder_select.jsp";
        }
    </script>
</head>
<body>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td height="10"></td>
    </tr>
    <tr>
        <td width="15" height="32"><img src="${pagePath}/images/main_locleft.gif" width="15" height="32"></td>
        <td class="main_locbg font2"><img src="${pagePath}/images/pointer.gif">&nbsp;当前位置：咨询申请单详情</td>
        <td width="15" height="32"><img src="${pagePath}/images/main_locright.gif" width="15" height="32"></td>
    </tr>
</table>
<table width="100%" height="90%" border="0" cellpadding="5" cellspacing="0" class="main_tabbor">
    <tr valign="top">
        <td>
            <form action="${pagePath}/order/add" id="workOrderForm" method="post">
                <!-- 隐藏表单，flag表示添加标记 -->
                <input type="hidden" name="flag" value="2">
                <table width="100%" border="0" cellpadding="0" cellspacing="10" class="main_tab buttonf">
                    <tr>
                        <td class="font3 fftd">
                            <table align="center">
                                <tr>
                                    <td class="font3 fftd" width="350">联 系 电 话：<input type="text" readonly="true" name="phone_num" id="phone_num" value="${order.phoneNum}" size="20" readonly="true" style="height: 20px"/></td>
                                    <td class="font3 fftd" width="350">咨&nbsp;询&nbsp;人：
                                        <%--<select id="applicant" name="applicant" style="width:130px">
                                            <c:forEach items="${applicants}" var="applicant" varStatus="i">

                                                <option <c:if test="${applicant.id == order.applicantId}">selected</c:if> value="${applicant.id}"> ${applicant.name}</option>

                                            </c:forEach>
                                        </select><span style="color:red; font-size: 12px">*</span>--%>
                                        <input type="text" name="applicant" id="applicant" value="${order.applicantName}" size="20" readonly="true" style="height: 20px"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="font3 fftd">人 资  编 码：<input type="text" name="code_num" id="code_num" value="${order.codeNum}" size="20" readonly="true" style="height: 20px"/></td>
                                    <td class="font3 fftd">所 属  部 门：<input type="text" name="department_id" id="department_id" value="${order.departmentName}" size="20" readonly="true" style="height: 20px"/></td>
                                </tr>
                                <tr>
                                    <td class="font3 fftd">公 司  名 称：<input type="text" name="company" id="company" value="${order.company}" size="20" readonly="true" style="height: 20px"/></td>
                                </tr>
                                <tr>
                                    <input value="${order.id}" style ="display:none" id="order_id">
                                    <td class="font3 fftd" colspan="2">咨 询  标 题：<input name="title" id="title" value="${order.title}" size="20" style="width: 560px;height: 30px" disabled/><span style="color:red; font-size: 12px">*</span></td>
                                </tr>
                                <tr>
                                    <td class="font3 fftd" colspan="2">咨 询  详 述：<textarea name="detail" id="detail" size="20" style="width: 560px;height: 80px" disabled>${order.detail}</textarea></td>
                                </tr>
                                <tr>
                                    <td class="font3 fftd">
                                        咨询一级分类：<select id="class_a" name="class_a" style="width:130px" disabled>
                                            <c:forEach items="${classAs}" var="classa" varStatus="i">

                                                    <option <c:if test="${classa.id == order.classA}" >selected</c:if> value="${classa.id}"> ${classa.name}</option>

                                            </c:forEach>
                                        </select><span style="color:red; font-size: 12px">*</span>
                                    </td>
                                    <td class="font3 fftd">
                                        咨询二级分类：<select id="class_b" name="class_b" style="width:130px" disabled>
                                            <c:forEach items="${classBs}" var="classb" varStatus="i">

                                                <option <c:if test="${classb.id == order.classB}">selected</c:if> value="${classb.id}"> ${classb.name}</option>

                                            </c:forEach>
                                        </select><span style="color:red; font-size: 12px">*</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="font3 fftd">咨 询  来 源：
                                        <select id="source" name="source" style="width:130px" disabled>
                                            <option value="0"
                                                    <c:if test="${order.source=='0'}">
                                                        selected
                                                    </c:if>>电话</option>
                                            <option value="1"
                                                    <c:if test="${order.source=='1'}">
                                                        selected
                                                    </c:if>>邮件</option>
                                        </select><span style="color:red; font-size: 12px">*</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="font3 fftd" colspan="2">答 复  内 容：<textarea type="text" name="content" id="content" size="20" style="width: 560px;height: 60px" disabled>${order.content}</textarea></td>
                                </tr>
                                <tr>
                                    <td class="font3 fftd">
                                        是否现场处理：
                                        <input name="isLive" type="radio" value="0" disabled
                                                <c:if test="${order.isLive=='0'}">
                                                    checked="checked"
                                                </c:if>/>否
                                        <input name="isLive" type="radio" value="1" disabled
                                                <c:if test="${order.isLive=='1'}">
                                                    checked="checked"
                                                </c:if>/>是
                                    </td>
                                    <td class="font3 fftd" >现场处理人：
                                        <select id="handle_id" name="handle_id" style="width:130px" disabled>
                                            <option selected>==请选择==</option>
                                            <c:forEach items="${applicants1}" var="applicantl" varStatus="i">

                                                <option <c:if test="${applicantl.id == order.handleId}">selected</c:if> value="${applicantl.id}"> ${applicantl.name}</option>

                                            </c:forEach>
                                        </select>
                                    </td>
                                </tr>

                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" class="fftd" style="text-align: center;" ><input type="button" onclick="select1();" value="确定"></td>
                    </tr>
                </table>
            </form>
        </td>
    </tr>
</table>
<div style="height: 10px;"></div>

</body>
</html>