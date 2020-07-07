<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="pagePath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>修改员工信息</title>
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

        //1.查询部门信息
       /* $("document").ready(function() {
            $.ajax({
                type: "POST",
                url: "${pagePath}/employee/selectDept",
                dataType: "text",
                contentType: "application/json; charset=utf-8",
                success: function(data){
                    var deptList =jQuery.parseJSON(data).deptList;
                    var optionString = "";
                    for (var i=0;i<deptList.length;i++) {
                        var dept = deptList[i];
                        optionString += "<option value=\"" + dept.id + "\">" + dept.deptName+ "</option>";
                        $("#department_id").html("<option value=''>==请选择==</option>" + optionString);
                    }
                },
                error: function(e) {
                    alert(e);
                }
            });
        });*/


        //提交表单
        function submit1(){
            var id = $("#applicantId").val();
            var codeNum = $("#code_num").val();
            var departmentId = $("#department_id").val();
            var company = $("#company").val();
            var name = $("#applicant").val();
            var phoneNum = $("#phone_num").val();

            var applicant = {
                id : id,
                codeNum : codeNum,
                departmentId : departmentId,
                company : company,
                name : name,
                phoneNum : phoneNum
            };
            $.ajax({
                type: "POST",
                url: "${pagePath}/employee/update",
                data: JSON.stringify(applicant),
                dataType: "text",
                contentType: "application/json; charset=utf-8",
                success: function(data){
                    if(data.toString()=="success"){
                        alert("修改成功!");
                        window.location.href = "${pagePath}/jsp/employee/employee_select.jsp";
                    }else {
                        alert("修改失败!");
                    }
                },
                error: function(e) {
                    alert("修改异常");
                }
            });
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
        <td class="main_locbg font2"><img src="${pagePath}/images/pointer.gif">&nbsp;当前位置：修改员工信息</td>
        <td width="15" height="32"><img src="${pagePath}/images/main_locright.gif" width="15" height="32"></td>
    </tr>
</table>
<table width="100%" height="90%" border="0" cellpadding="5" cellspacing="0" class="main_tabbor">
    <tr valign="top">
        <td>
            <form>
                <!-- 隐藏表单，flag表示添加标记 -->
                <input type="hidden" name="flag" value="2">
                <table width="100%" border="0" cellpadding="0" cellspacing="10" class="main_tab buttonf">
                    <tr>
                        <td class="font3 fftd">
                            <table>

                                <tr>
                                <tr>

                                    <td class="font3 fftd">
                                        <input value="${applicant.id}" style ="display:none" id="applicantId">
                                        员 工 姓 名：<input type="text" name="applicant" id="applicant" value="${applicant.name}" size="20"/>
                                        <span style="color:red; font-size: 12px">*</span>
                                    </td>
                                    <td class="font3 fftd">所 属  部 门：
                                        <select id="department_id" name="department_id" style="width:130px">
                                            <c:forEach items="${deptList}" var="dept" varStatus="i">

                                                <option <c:if test="${dept.id == applicant.departmentId}">selected</c:if> value="${dept.id}"> ${dept.deptName}</option>

                                            </c:forEach>
                                        </select><span style="color:red; font-size: 12px">*</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="font3 fftd">人 资  编 码：<input type="text" name="code_num" id="code_num" value="${applicant.codeNum}" size="20"/></td>
                                    <td class="font3 fftd">公 司  名 称：<input type="text" name="company" id="company" value="${applicant.company}" size="20"/></td>
                                </tr>
                                <tr>
                                    <td class="font3 fftd">联 系  电 话：<input type="text" name="phone_num" id="phone_num" value="${applicant.phoneNum}" size="20"/></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" class="fftd" style="text-align: center;" ><input type="button" id = "button1" onclick="submit1()" value="确定">&nbsp;&nbsp;<input type="reset" value="取消"></td>
                    </tr>
                </table>
            </form>
        </td>
    </tr>
</table>
<div style="height: 10px;"></div>
</body>
</html>