<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="pagePath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>员工管理</title>
    <link type="text/css" rel="stylesheet" href="${pagePath}/css/user/css.css" />
    <link type="text/css" rel="stylesheet" href="${pagePath}/css/user/ligerui-dialog.css" />
    <link type="text/css" rel="stylesheet" href="${pagePath}/css/user/ligerui-icons.css" />
    <link type="text/css" rel="stylesheet" href="${pagePath}/css/user/pager.css" />
    <script type="text/javascript" src="${pagePath}/js/jquery-1.11.0.js"></script>
    <script type="text/javascript" src="${pagePath}/js/jquery-migrate-1.2.1.js"></script>
    <script type="text/javascript" src="${pagePath}/js/base.js"></script>
    <script type="text/javascript" src="${pagePath}//ligerDrag.js"></script>
    <script type="text/javascript" src="${pagePath}/pligerDialog.js"></script>
    <script type="text/javascript" src="${pagePath}/js/ligerResizable.js"></script>
    <script type="text/javascript">

        //1.查询员工信息
        $("document").ready(function() {

            //1.查询部门信息
            $("document").ready(function() {
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
                            $("#deptName").html("<option value=''>==请选择==</option>" + optionString);
                        }
                    },
                    error: function(e) {
                        alert(e);
                    }
                });
            });

            reload(1);

        })


        function reload(i) {
            var name = $("#name").val();
            var deptId = $("#deptName").val();
            var pageNum = i;
            var pageSize = 20;
            $.ajax({
                type:"POST",
                data: {"name":name,"deptId":deptId,"pageNum":pageNum,"pageSize":pageSize},
                url:"${pagePath}/employee/selectApplicant",
                dataType:"text",
                //contentType:"application/json; charset=utf-8",
                success: function(data){
                    var html = '<tr class="main_trbg_tit" align="center">\n' +
                        '<th>序号</th>\n' +
                        '<th>姓名</th>\n' +
                        '<th>人资编码</th>\n' +
                        '<th>公司名称</th>\n' +
                        '<th>所属部门</th>\n' +
                        '<th>联系方式</th>\n' +
                        '<th>操作</th>\n' +
                        '</tr>';

                    if(jQuery.parseJSON(data).msg=="success"){

                        var list = jQuery.parseJSON(data).pagination.list;

                        if (list!=null && list!=''){

                            $.each(list,function(index,applicant){
                                        html += '<tr>'+
                                            '<td align="center">'+applicant['number']+'</td>'+
                                            '<td>'+applicant['name']+'</td>'+
                                            '<td>'+applicant['codeNum']+'</td>'+
                                            '<td>'+applicant['company']+'</td>'+
                                            '<td align="center">'+applicant['departmentName']+'</td>'+
                                            '<td align="center">'+applicant['phoneNum']+'</td>'+
                                            '<td align="center"><input type="button" value="修改" id = "update" onclick="update(\''+applicant['id']+'\')" style="color: blue"> ' +
                                            '<input type="button" id = "delete" onclick="deleteApp(\''+applicant['id']+'\')" value="删除" style="color: red"></td>'+
                                            '</tr>';
                            });
                        }else {
                            html += '<tr>'+
                                '<td align="center" colspan="6">暂无数据！</td>'+
                                '</tr>';
                        }
                    }else {
                        html += '<tr>'+
                             '<td align="center" colspan="6">暂无数据！</td>'+
                             '</tr>';
                }
                    var pageview = jQuery.parseJSON(data).pagination.pageView;
                    var html4 = '';

                    if (pageview!=null && pageview!='') {
                        $.each(pageview, function (index, page) {
                            html4 += page;
                        })
                    }

                    $('#datatable').html(html);
                    $('#pageId').html(html4);
                },
                error: function(e) {
                    alert("查询异常!");
                }
            })
        }
        function deleteApp(data) {
            var id = data;
            if(window.confirm("您确定要删除该条数据吗？")){
                $.ajax({
                    type:"POST",
                    data:id,
                    url:"${pagePath}/employee/delete?id="+id,
                    dataType:"text",
                    contentType:"application/json; charset=utf-8",
                    success: function(data) {
                        if (data=="success"){
                            alert("删除成功!");
                            reload(1);
                        }else if (data=="failed"){
                            alert("删除失败!");
                        }

                    },
                    error:function (data) {
                        alert("删除异常!");
                    }
                    })
            }
        }

        function selectByName() {
            reload(1);
        }
        /*function update(data) {
            var id = data;
            $.ajax({
                type:"POST",
                data:id,
                url:"/employee/selectById?id="+id,
                dataType:"text",
                contentType:"application/json; charset=utf-8",
                success: function(data) {

                },
                error:function () {
                    alert("修改异常!")
                }
            })
        }*/
        function update(data) {
            var id = data;
            window.location.href = "${pagePath}/employee/selectApplicantById?id="+id;

        }
    </script>
</head>
<body>
<!-- 导航 -->
<table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td height="10"></td>
    </tr>
    <tr>
        <td width="15" height="32"><img src="${pagePath}/images/main_locleft.gif" width="15" height="32"></td>
        <td class="main_locbg font2"><img src="${pagePath}/images/pointer.gif">&nbsp;当前位置：员工查询</td>
        <td width="15" height="32"><img src="${pagePath}/images/main_locright.gif" width="15" height="32"></td>
    </tr>
</table>
<table width="100%" height="90%" border="0" cellpadding="5" cellspacing="0" class="main_tabbor">
    <!-- 查询区  -->
    <tr valign="top">
        <td height="30">
            <table width="100%" border="0" cellpadding="0" cellspacing="10" class="main_tab">
                <tr>
                    <td class="fftd">
                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td class="font3">员工名称：
                                   <input id="name">
                                    所属部门:
                                    <select id="deptName" style="width: 120px;">

                                    </select>
                                    <input type="button" id = "select" onclick="selectByName();" value="搜索" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <!-- 数据展示区 -->
    <tr valign="top">
        <td height="20">
            <table width="100%" border="1" cellpadding="5" cellspacing="0" style="border: #c2c6cc 1px solid; border-collapse: collapse;" id="datatable">
                <tr class="main_trbg_tit" align="center">
                    <th>序号</th>
                    <th>姓名</th>
                    <th>人资编码</th>
                    <th>公司名称</th>
                    <th>联系方式</th>
                    <th>操作</th>
                </tr>
            </table>
        </td>
    </tr>
    <!-- 分页标签 -->
    <tr valign="top">
        <td align="center" class="font3">
            <table width="100%" align="center" id="pageId" style="font-size: 13px;" class="sabrosus">

            </table>
        </td>
    </tr>
</table>
<div style="height: 10px;"></div>
</body>
</html>

