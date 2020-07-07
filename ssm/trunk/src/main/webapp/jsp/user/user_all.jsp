<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="pagePath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>用户管理</title>
    <link type="text/css" rel="stylesheet" href="${pagePath}/css/user/css.css" />
    <link type="text/css" rel="stylesheet" href="${pagePath}/css/user/ligerui-dialog.css" />
    <link type="text/css" rel="stylesheet" href="${pagePath}/css/user/ligerui-icons.css" />
    <link type="text/css" rel="stylesheet" href="${pagePath}/css/user/pager.css" />
    <script type="text/javascript" src="${pagePath}/js/jquery-1.11.0.js"></script>
    <script type="text/javascript" src="${pagePath}/js/jquery-migrate-1.2.1.js"></script>
    <script type="text/javascript" src="${pagePath}/js/base.js"></script>
    <script type="text/javascript" src="${pagePath}/js/user/ligerDrag.js"></script>
    <script type="text/javascript" src="${pagePath}/js/user/pligerDialog.js"></script>
    <script type="text/javascript" src="${pagePath}/js/user/ligerResizable.js"></script>
    <script type="text/javascript">
        $(function() {
            /** 获取上一次选中的部门数据 */
            var boxs = $("input[type='checkbox'][id^='box_']");
            /** 给数据行绑定鼠标覆盖以及鼠标移开事件  */
            $("tr[id^='data_']").hover(function() {
                $(this).css("backgroundColor", "#eeccff");
            }, function() {
                $(this).css("backgroundColor", "#ffffff");
            })
            /** 删除员工绑定点击事件 */
            $("#delete").click(function() {
                /** 获取到用户选中的复选框  */
                var checkedBoxs = boxs.filter(":checked");
                if (checkedBoxs.length < 1) {
                    $.ligerDialog.error("请选择一个需要删除的用户！");
                } else {
                    /** 得到用户选中的所有的需要删除的ids */
                    var ids = checkedBoxs.map(function() {
                        return this.value;
                    })
                    $.ligerDialog.confirm("确认要删除吗?", "删除用户", function(r) {
                        if (r) {
                            // alert("删除："+ids.get());
                            // 发送请求
                            window.location = "${pagePath}/user/delete.do?ids=" + ids.get();
                        }
                    });
                }
            })
        })
    </script>
    <style type="text/css">

        tbody {

            counter-reset:sectioncounter;

        }

        .SortId:before {

            content:counter(sectioncounter);

            counter-increment:sectioncounter;

        }

    </style>
</head>
<body>
<!-- 导航 -->
<table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td height="10"></td>
    </tr>
    <tr>
        <td width="15" height="32"><img src="${pagePath}/images/main_locleft.gif" width="15" height="32"></td>
        <td class="main_locbg font2"><img src="${pagePath}/images/pointer.gif">&nbsp;当前位置：用户管理&nbsp;&gt;&nbsp;用户查询</td>
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
                        <form name="empform" method="post" id="empform" action="${pagePath}/user/list.do">
                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td class="font3">用户名：<input type="text" name="key" value="${key}"> 用户权限：<select name="status" style="width: 173px;">
                                        <c:if test="${empty status}">
                                            <option value=""></option>
                                            <option value="1">管理用户</option>
                                            <option value="2">专业用户</option>
                                            <option value="3">普通用户</option>
                                        </c:if>
                                        <c:if test="${!empty status && status == 1}">
                                            <option value=""></option>
                                            <option value="2">专业用户</option>
                                            <option value="1" selected="selected">管理用户</option>
                                            <option value="3">普通用户</option>
                                        </c:if>
                                        <c:if test="${!empty status && status == 2}">
                                            <option value=""></option>
                                            <option value="1">管理用户</option>
                                            <option value="2">专业用户</option>
                                            <option value="3" selected="selected">普通用户</option>
                                        </c:if>
                                    </select> <input type="submit" value="搜索" /> <input type="button" onclick="location.href='${pagePath}/user/list.do'" value="清空" /> <input id="delete" type="button" value="删除" />
                                    </td>
                                </tr>
                            </table>
                        </form>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <!-- 数据展示区 -->
    <tr valign="top">
        <td height="20">
            <table width="100%" border="1" cellpadding="5" cellspacing="0" style="border: #c2c6cc 1px solid; border-collapse: collapse;">
                <tr class="main_trbg_tit" align="center">
                    <td></td>
                    <td>序号</td>
                    <td>用户名</td>
                    <td>密码</td>
                    <td>姓名</td>
                    <td>权限</td>
                    <td>创建时间</td>
                    <td align="center">操作</td>
                </tr>
                <c:forEach items="${pages.list}" var="user" varStatus="x">
                    <tr id="data_${x.index}" align="center" class="main_trbg" onMouseOver="move(this);" onMouseOut="out(this);">
                        <td><input type="checkbox" id="box_${x.index}" value="${user.id}"></td>
                        <td class="SortId"></td>
                        <td>${user.username}</td>
                        <td>******************</td>
                        <td>${user.name}</td>
                        <td><c:if test="${user.role == 1}">管理用户</c:if> <c:if test="${user.role == 2}">专业用户</c:if><c:if test="${user.role == 3}">普通用户</c:if></td>
                        <td><fmt:formatDate value="${user.createTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                        <td align="center" width="40px;"><a href="${pagePath}/user/modify.do?flag=1&id=${user.id}"> <img title="修改" src="${pagePath}/images/user/update.gif" /></a></td>
                    </tr>
                </c:forEach>
                <c:if test="${empty pages.list}">
                    <tr>
                        <td align="center" colspan="7">没有数据！</td>
                    </tr>
                </c:if>
            </table>
        </td>
    </tr>
    <!-- 分页标签 -->
    <tr valign="top">
        <td align="center" class="font3"><c:if test="${!empty pages.list}">
            <table width="100%" align="center" style="font-size: 13px;" class="sabrosus">
                <tr>
                    <td style="color: #0061de; margin-right: 3px; padding-top: 2px; text-decoration: none"><c:if test="${pages.hasPreviousPage}">
                        <a href="${pagePath}/user/list.do?page=${pages.pageNum - 1}&key=${key}&status=${status}"> 上一页</a>
                    </c:if> <c:if test="${!pages.hasPreviousPage}">
                        <a href="javascript:void(0);"> 上一页</a>
                    </c:if> <c:forEach items="${pages.navigatepageNums}" var="pageNum">
                        <c:if test="${pageNum == pages.pageNum}">
                            <span class="current">${pageNum}</span>
                        </c:if>
                        <c:if test="${pageNum != pages.pageNum}">
                            <a href="${pagePath}/user/list.do?page=${pageNum}&key=${key}&status=${status}">${pageNum}</a>
                        </c:if>
                    </c:forEach> <c:if test="${pages.hasNextPage}">
                        <a href="${pagePath}/user/list.do?page=${pages.pageNum + 1}&key=${key}&status=${status}"> 下一页</a>
                    </c:if> <c:if test="${!pages.hasNextPage}">
                        <a href="javascript:void(0);"> 下一页</a>
                    </c:if>&nbsp;跳转到&nbsp;<input style="text-align: center; border-right: #aaaadd 1px solid; padding-right: 5px; border-top: #aaaadd 1px solid; padding-left: 5px; padding-bottom: 2px; margin: 2px; border-left: #aaaadd 1px solid; color: #000099; padding-top: 2px; border-bottom: #aaaadd 1px solid; text-decoration: none" type="text" size="2"
                                                 id="pager_jump_page_size" />&nbsp;<input type="button"
                                                                                          style="text-align: center; border-right: #dedfde 1px solid; padding-right: 6px; background-position: 50% bottom; border-top: #dedfde 1px solid; padding-left: 6px; padding-bottom: 2px; border-left: #dedfde 1px solid; color: #0061de; margin-right: 3px; padding-top: 2px; border-bottom: #dedfde 1px solid; text-decoration: none" value="确定"
                                                                                          id="pager_jump_btn" /></td>
                </tr>
                <tr align="center" style="font-size: 13px;">
                    <td style="color: #0061de; margin-right: 3px; padding-top: 2px; text-decoration: none">总共<font color="red">${pages.total}</font>条记录，当前第 ${pages.pageNum} 页。
                    </td>
                </tr>
            </table>
        </c:if></td>
    </tr>
</table>
<div style="height: 10px;"></div>
<script type="text/javascript">
    document.getElementById("pager_jump_btn").onclick = function(){
        var page_size = document.getElementById("pager_jump_page_size").value;
        if (!/^[1-9]\d*$/.test(page_size)||page_size<1||page_size>${pages.pages}){
            alert("请输入[ 1 - ${pages.pages} ]之间的页码！");
        }else{
            var submit_url = "${pagePath}/user/list.do?page=" + page_size + "&key=${key}&status=${status}";
            window.location = submit_url;
        }
    }
</script>
</body>
</html>