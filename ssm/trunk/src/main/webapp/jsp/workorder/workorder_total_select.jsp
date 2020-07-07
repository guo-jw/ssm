<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="pagePath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>咨询申请单管理</title>
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
    <script language="javascript" type="text/javascript" src="${pagePath}/js/My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript">


        function reload() {

            var start_time = $("#start_time").val();
            var start2_time = $("#start2_time").val();

            $.ajax({
                type:"POST",
                data: {"startTime":start_time,"start2Time":start2_time},
                url:"${pagePath}/order/selectOrderTotalNum",
                dataType:"text",
                //contentType:"application/json; charset=utf-8",
                success: function(data) {
                    var html = '<tr class="main_trbg_tit" align="center">\n' +

                        '<th style="height: 25px">类别</th>\n' +
                        '<th style="height: 25px">总条数</th>\n' +
                        '</tr>';

                    var list = jQuery.parseJSON(data).list;
                    if (list!=null && list!='') {
                        $.each(list, function (index, order) {
                            if(order['className']=='---------'){
                                html += '<tr style="width: 100px">' +
                                    '<td align="center">' + order['className'] + '</td>' +
                                    '<td align="center">\</td>' +
                                    '</tr>';
                            }else {
                                html += '<tr style="width: 100px">' +
                                    '<td align="center">' + order['className'] + '</td>' +
                                    '<td align="center">' + order['number'] + '</td>' +
                                    '</tr>';
                            }

                        });
                    }
                    $('#datatable').html(html);
                },
                error: function(e) {
                    alert("查询工单数量异常!");
                }
            })
        }

        $("document").ready(function() {
            reload();
        });

        function selectBy() {
            reload();
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
        <td class="main_locbg font2"><img src="${pagePath}/images/pointer.gif">&nbsp;当前位置：工单数量统计查询</td>
        <td width="15" height="32"><img src="${pagePath}/images/main_locright.gif" width="15" height="32"></td>
    </tr>
</table>
<table width="100%" height="90%" border="0" cellpadding="5" cellspacing="0" class="main_tabbor" >
    <!-- 查询区  -->
    <tr valign="top">
        <td height="30">
            <table width="100%" border="0" cellpadding="0" cellspacing="10" class="main_tab">
                <tr>
                    <td class="fftd">
                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td class="font3">
                                    开始时间 ：<input type="text" name="start_time" id="start_time" style="width: 120px" readonly="readonly" onclick="WdatePicker({ realFullFmt: '%Date ', dateFmt: 'yyyy-MM-dd' })" />
                                    结束时间：<input type="text" name="start2_time" id="start2_time" style="width: 120px" readonly="readonly" onclick="WdatePicker({ realFullFmt: '%Date ', dateFmt: 'yyyy-MM-dd' })" />
                                    <input type="button" id = "select" onclick="selectBy();" value="搜&nbsp;&nbsp;索"style="font-size:11pt;width: 40pt"/>
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
            <table width="50%" border="1" cellpadding="5" cellspacing="0" style="border: #c2c6cc 1px solid; border-collapse: collapse;" id="datatable">

                <%-- <c:if test="${empty pages.list}">
                     <tr>
                         <td align="center" colspan="10">没有数据！</td>
                     </tr>
                 </c:if>--%>
            </table>
        </td>
    </tr>
    <!-- 分页标签
    <tr valign="top">
        <td align="center" class="font3">
            <table width="100%" align="center" id="pageId" style="font-size: 13px;" class="sabrosus">

            </table>
        </td>
    </tr> -->
</table>
<div style="height: 10px;"></div>

</body>
</html>

