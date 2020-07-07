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
        //双击事件
        function detail(id){
            //跳转到详情页面
            //var id = data;
            window.location.href = "${pagePath}/order/selectById?id="+id+"&tag=0";
        }

        //1.查询咨询一级分类
        $("document").ready(function() {

            reload(1);

            $.ajax({
                type: "POST",
                url: "${pagePath}/order/selectClassA",

                //dataType: "json",
                dataType: "text",
                contentType: "application/json; charset=utf-8",
                success: function(data){
                    var classAList =jQuery.parseJSON(data).classAList;
                    var optionStringA = "";
                    for (var i=0;i<classAList.length;i++) {
                        var classA = classAList[i];
                        optionStringA += "<option value=\"" + classA.id + "\">" + classA.name + "</option>";
                        $("#class_a").html("<option value=''>==请选择==</option>" + optionStringA);
                    }

                    var applicants =jQuery.parseJSON(data).applicants;
                    var optionString = "";
                    for (var i=0;i<applicants.length;i++) {
                        var applicant = applicants[i];
                        optionString += "<option value=\"" + applicant.id + "\">" + applicant.name + "</option>";
                        $("#applicant").html("<option value=''>==请选择==</option>" + optionString);
                    }
                },
                error: function(e) {
                    alert(e);
                }
            });
        });

        //查询二级咨询分类
        $(function(){
            $("#class_a").on("change",function(){
                var id = $("#class_a").val();
                $.ajax({
                    type: "POST",
                    url: "${pagePath}/order/selectClassB",
                    data: {"id":id},
                    //dataType: "json",
                    dataType: "text",
                    //contentType: "application/json; charset=utf-8",
                    success: function(data){
                        var classBList =jQuery.parseJSON(data).classBList;
                        var optionString = "";
                        for (var i=0;i<classBList.length;i++) {
                            var classB = classBList[i];
                            optionString += "<option value=\"" + classB.id + "\">" + classB.name + "</option>";
                            $("#class_b").html("<option value=''>==请选择==</option>" + optionString);
                        }
                    },
                    error: function(e) {
                        alert(e);
                    }
                });
            });
        })

        /*$(document).ready(function () {
            reload();
        })*/


        function reload(i) {
            var status = $("#status").val();
            var source = $("#source").val();
            var class_a = $("#class_a").val();
            var class_b = $("#class_b").val();
            var title = $("#title").val();
            var detail = $("#detail").val();
            var phone_num = $("#phone_num").val();
            var is_live = $("#is_live").val();
            var start_time = $("#start_time").val();
            var start2_time = $("#start2_time").val();
            var user_id = $("#user_id").val();
            var pageNum = i;
            var pageSize = 20;

            $.ajax({
                type:"POST",
                data: {"status":status,"source":source,"classA":class_a,"classB":class_b,"title":title,"detail":detail,"phoneNum":phone_num,"isLive":is_live,"startTime":start_time,"userName":user_id,"start2Time":start2_time,"pageNum":pageNum,"pageSize":pageSize},
                url:"${pagePath}/order/selectOrderByUser",
                dataType:"text",
                //contentType:"application/json; charset=utf-8",
                success: function(data) {
                    var html = '<tr class="main_trbg_tit" align="center">\n' +

                        '<th width="25" align="center" height="30"><input id="selectAll" type="checkbox" onclick="checkAll()"></th>\n' +
                        '<th>序号</th>\n' +
                        '<th>受理人</th>\n' +
                        '<th>咨询标题</th>\n' +
                        '<th>咨询一级分类</th>\n' +
                        '<th>咨询二级分类</th>\n' +
                        '<th>咨询来源</th>\n' +
                        '<th>答复内容</th>\n' +
                        '<th>工单受理时间</th>\n' +
                        '<th>工单提交时间</th>\n' +
                        '<th>咨询人</th>\n' +
                        '<th>是否现场处理</th>\n' +
                        '<th>现场处理人</th>\n' +
                        '<th>处理结果</th>\n' +
                        '<th width="100">操作</th>\n' +
                        '</tr>';

                    var user = jQuery.parseJSON(data).user;
                    var pageview = jQuery.parseJSON(data).pagination.pageView;
                    //alert(pagination.pageView)
                    var list = jQuery.parseJSON(data).pagination.list;
                    if (list!=null && list!='') {
                        $.each(list, function (index, order) {
                            // alert(order.id);<input type="checkbox" name="selectFlag" id="selectFlag" value="${order.id}">
                            if (order['isLive'] == 1) {
                                if (order['source'] == 0) {
                                    html += '<tr ondblclick="detail('+order['id']+')" >' +
                                        '<td align="center">' + '<input  type="checkbox" value="'+order['id']+'" name="order_id">' + '</td>' +
                                        '<td align="center">' + order['name'] + '</td>' +
                                        '<td align="center">' + order['userId'] + '</td>' +
                                        '<td>' + order['title'] + '</td>' +
                                        '<td align="center">' + order['classA'] + '</td>' +
                                        '<td align="center">' + order['classB'] + '</td>' +
                                        '<td align="center">电话</td>' +
                                        '<td>' + order['content'] + '</td>' +
                                        '<td>' + order['startTime'] + '</td>' +
                                        '<td>' + order['endTime'] + '</td>' +
                                        '<td align="center">' + order['applicantId'] + '</td>' +
                                        '<td align="center">是</td>' +
                                        '<td align="center">' + order['handleId'] + '</td>' +
                                        '<td align="center">' + order['handleResult'] + '</td>' +
                                        '<td align="center">' /*+
                                    '<input type="button" value="修改" id = "update" onclick="update(\'' + order['id'] + '\')" style="color: blue"> ' +
                                    '<input type="button" id = "delete" onclick="delete1(\'' + order['id'] + '\')" value="删除" style="color: red">'
                                    '<input type="button" id = "" onclick="closeOne(\'' + order['id'] + '\')" value=" 处理" style="color: green">' +
                                    '</td>' +
                                    '</tr>';*/
                                } else {
                                    html += '<tr ondblclick="detail('+order['id']+')" >' +
                                        '<td align="center">' + '<input  type="checkbox" value="'+order['id']+'" name="order_id">' + '</td>' +
                                        '<td align="center">' + order['name'] + '</td>' +
                                        '<td align="center">' + order['userId'] + '</td>' +
                                        '<td>' + order['title'] + '</td>' +
                                        '<td align="center">' + order['classA'] + '</td>' +
                                        '<td align="center">' + order['classB'] + '</td>' +
                                        '<td align="center">邮件</td>' +
                                        '<td>' + order['content'] + '</td>' +
                                        '<td>' + order['startTime'] + '</td>' +
                                        '<td>' + order['endTime'] + '</td>' +
                                        '<td align="center">' + order['applicantId'] + '</td>' +
                                        '<td align="center">是</td>' +
                                        '<td align="center">' + order['handleId'] + '</td>' +
                                        '<td align="center">' + order['handleResult'] + '</td>' +
                                        '<td align="center">'
                                    /*'<input type="button" value="修改" id = "update" onclick="update(\'' + order['id'] + '\')" style="color: blue"> ' +
                                    '<input type="button" id = "delete" onclick="delete1(\'' + order['id'] + '\')" value="删除" style="color: red">'
                                    '<input type="button" id = "" onclick="closeOne(\'' + order['id'] + '\')" value=" 处理" style="color: green">' +
                                    '</td>' +
                                    '</tr>';*/
                                }

                            } else {
                                if (order['source'] == 0) {
                                    html += '<tr ondblclick="detail('+order['id']+');" >' +
                                        '<td align="center">' + '<input  type="checkbox" value="'+order['id']+'" name="order_id">' + '</td>' +
                                        '<td align="center">' + order['name'] + '</td>' +
                                        '<td align="center">' + order['userId'] + '</td>' +
                                        '<td>' + order['title'] + '</td>' +
                                        '<td align="center">' + order['classA'] + '</td>' +
                                        '<td align="center">' + order['classB'] + '</td>' +
                                        '<td align="center">电话</td>' +
                                        '<td>' + order['content'] + '</td>' +
                                        '<td>' + order['startTime'] + '</td>' +
                                        '<td>' + order['endTime'] + '</td>' +
                                        '<td align="center">' + order['applicantId'] + '</td>' +
                                        '<td align="center">否</td>' +
                                        '<td align="center">' + order['handleId'] + '</td>' +
                                        '<td align="center">' + order['handleResult'] + '</td>' +
                                        '<td align="center">'
                                    /*'<input type="button" value="修改" id = "update" onclick="update(\'' + order['id'] + '\')" style="color: blue"> ' +
                                    '<input type="button" id = "delete" onclick="delete1(\'' + order['id'] + '\')" value="删除" style="color: red">'
                                    '<input type="button" id = "" onclick="closeOne(\'' + order['id'] + '\')" value=" 处理" style="color: green">' +
                                    '</td>' +
                                    '</tr>';*/
                                } else {
                                    html += '<tr ondblclick="detail('+order['id']+');" >' +
                                        '<td align="center">' + '<input  type="checkbox" value="'+order['id']+'" name="order_id">' + '</td>' +
                                        '<td align="center">' + order['name'] + '</td>' +
                                        '<td align="center">' + order['userId'] + '</td>' +
                                        '<td>' + order['title'] + '</td>' +
                                        '<td align="center">' + order['classA'] + '</td>' +
                                        '<td align="center">' + order['classB'] + '</td>' +
                                        '<td align="center">邮件</td>' +
                                        '<td>' + order['content'] + '</td>' +
                                        '<td>' + order['startTime'] + '</td>' +
                                        '<td>' + order['endTime'] + '</td>' +
                                        '<td align="center">' + order['applicantId'] + '</td>' +
                                        '<td align="center">否</td>' +
                                        '<td align="center">' + order['handleId'] + '</td>' +
                                        '<td align="center">' + order['handleResult'] + '</td>' +
                                        '<td align="center">'
                                    /*'<input type="button" value="修改" id = "update" onclick="update(\'' + order['id'] + '\')" style="color: blue"> ' +
                                    '<input type="button" id = "delete" onclick="delete1(\'' + order['id'] + '\')" value="删除" style="color: red">'
                                    '<input type="button" id = "" onclick="closeOne(\'' + order['id'] + '\')" value=" 处理" style="color: green">' +
                                    '</td>' +
                                    '</tr>';*/
                                }
                            }
                            if(user.role==3){
                                if(order['handleResult']!="已处理"){
                                    html+='<input type="button" id = "" onclick="closeOne(\'' + order['id'] + '\')" value=" 处理" style="color: red">' +
                                        '</td>' +
                                        '</tr>'
                                }else {
                                    html+='<input type="button" id = "" onclick="closeOne(\'' + order['id'] + '\')" value=" 处理" style="color: red; background:grey" disabled>' +
                                        '</td>' +
                                        '</tr>'
                                }
                            }else {


                                if(order['handleResult']!="已处理"){

                                    /*if(user.role==2){

                                    }*/
                                    if(order['isLive'] == 1){
                                        html+='<input type="button" id = "" onclick="closeOne(\'' + order['id'] + '\')" value=" 处理" style="color: red; background:grey" disabled>' +
                                            '<input type="button" value="修改" id = "update" onclick="update(\'' + order['id'] + '\')" style="color: blue"> '
                                    }else {

                                        if(order['status'] == 0){
                                            html+='<input type="button" id = "" onclick="closeOne(\'' + order['id'] + '\')" value=" 处理" style="color: red">' +
                                                '<input type="button" value="修改" id = "update" onclick="update(\'' + order['id'] + '\')" style="color: blue"> '
                                        }else{
                                            html+='<input type="button" id = "" onclick="closeOne(\'' + order['id'] + '\')" value=" 处理" style="color: red; background:grey" disabled>' +
                                                '<input type="button" value="修改" id = "update" onclick="update(\'' + order['id'] + '\')" style="color: blue; background:grey" disabled> '
                                        }
                                    }


                                }else {
                                    html+='<input type="button" id = "" onclick="closeOne(\'' + order['id'] + '\')" value=" 处理" style="color: red; background:grey" disabled>' +
                                        '<input type="button" value="修改" id = "update" onclick="update(\'' + order['id'] + '\')" style="color: blue; background:grey" disabled> '

                                }

                                if(user.role==1){
                                    html+= '<input type="button" id = "delete" onclick="delete1(\'' + order['id'] + '\')" value="删除" style="color: red">'+
                                        '</td>' +
                                        '</tr>'
                                }else {
                                    html+=
                                        '</td>' +
                                        '</tr>'
                                }

                            }


                        });
                    }
                    else {
                        html += '<tr>'+
                            '<td align="center" colspan="12">暂无数据！</td>'+
                            '</tr>'
                    }
                    if(user.role!=1 &&  user.role!=2){
                        var html2 =  '<tr>'+
                            '<td align="center" colspan="15"><input onclick="closeAll()" type="button" value="关闭所有"></td>'+
                            '</tr>'
                    }else {
                        var html2 =  '<tr>'+
                            '</tr>'
                    }
                    var html3 = html+html2;

                    var html4 = '';

                    if (pageview!=null && pageview!='') {
                        $.each(pageview, function (index, page) {
                            html4 += page;
                        })
                    }


                    $('#pageId').html(html4);
                    $('#datatable').html(html3);
                },
                error: function(e) {
                    alert("查询异常!");
                }
            })
        }
        //单个关闭工单
        function closeOne(id){
            var arr =[];
            arr.push(id);
            //异步修改工单状态
            $.ajax({
                type:"POST",
                data:JSON.stringify(arr),
                url:"${pagePath}/order/closeAll",
                dataType:"text",
                contentType:"application/json; charset=utf-8",
                success: function(data) {
                    if (data=="success"){
                        alert("关闭工单成功!");
                        var thisPageNu=document.getElementById("this_id").innerHTML;
                        reload(thisPageNu);
                    }else if (data=="failed"){
                        alert("关闭工单失败!");
                    }else {
                        alert("关闭工单错误!");
                    }

                },
                error:function (data) {
                    alert("关闭工单异常!");
                }
            })
        }
        //全选
        function checkAll(){
            //获取用户选择的所有商品状态
            var check = document.getElementById("selectAll").checked;
            //获取所有的商品（多选框）
            var ids = document.getElementsByName("order_id");
            //将所有的多选框状态更改为用户选中的状态
            for(var i = 0; i < ids.length;i++){
                ids[i].checked = check
            }
        }
        //批量关闭
        function closeAll() {



            var arr =[];
            $.each($('input:checkbox:checked'),function(){
                if($(this).val()!="on"){
                    arr.push($(this).val());
                }
            });
            //异步修改工单状态
            $.ajax({
                type:"POST",
                data:JSON.stringify(arr),
                url:"${pagePath}/order/closeAll",
                dataType:"text",
                contentType:"application/json; charset=utf-8",
                success: function(data) {
                    if (data=="success"){
                        alert("批量关闭工单成功!");

                        var thisPageNu=document.getElementById("this_id").innerHTML;
                        reload(thisPageNu);
                    }else if (data=="failed"){
                        alert("批量关闭工单失败!");
                    }else {
                        alert("批量关闭工单错误!");
                    }

                },
                error:function (data) {
                    alert("批量关闭工单异常!");
                }
            })
        }
        function update(data) {
            var id = data;
            window.location.href = "${pagePath}/order/selectById?id="+id+"&tag=1";
        }
        function delete1(data) {
            var id = data;
            if(window.confirm("您确定要删除该条数据吗？")){
                $.ajax({
                    type:"POST",
                    data:id,
                    url:"${pagePath}/order/delete?id="+id,
                    dataType:"text",
                    contentType:"application/json; charset=utf-8",
                    success: function(data) {
                        if (data=="success"){
                            alert("删除成功!");
                            reload(1);
                        }else if (data=="failed"){
                            alert("删除失败!");
                        }else {
                            alert("删除有错误!");
                        }

                    },
                    error:function (data) {
                        alert("删除异常!");
                    }
                })
            }
        }

        function selectBy() {
            reload(1);
        }
    </script>

    <%--<script type="text/javascript">
    document.getElementById("pager_jump_btn").onclick = function(){
        var page_size = document.getElementById("pager_jump_page_size").value;
        if (!/^[1-9]\d*$/.test(page_size)||page_size<1||page_size>${pages.pages}){
            alert("请输入[ 1 - ${pages.pages} ]之间的页码！");
        }else{
            var submit_url = "${pagePath}/user/list.do?page=" + page_size + "&key=${key}&status=${status}";
            window.location = submit_url;
        }
    }
</script>--%>
</head>
<body>
<!-- 导航 -->
<table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr>
        <td height="10"></td>
    </tr>
    <tr>
        <td width="15" height="32"><img src="${pagePath}/images/main_locleft.gif" width="15" height="32"></td>
        <td class="main_locbg font2"><img src="${pagePath}/images/pointer.gif">&nbsp;当前位置：工单查询</td>
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
                                <td class="font3">处理状态：
                                    <select id="status" style="width: 120px;">
                                        <option value="">==请选择==</option>
                                        <option value="0">未处理</option>
                                        <option value="1">已处理</option>
                                    </select>
                                    <%--咨询来源:--%>
                                    <select id="source" style="width: 120px;display:none" >
                                        <option value="">==请选择==</option>
                                        <option value="0">电话</option>
                                        <option value="1">邮件</option>
                                    </select>
                                    咨询一级分类：
                                    <select id="class_a" style="width: 120px;">

                                    </select>
                                    咨询二级分类：
                                    <select id="class_b" style="width: 120px;">

                                    </select>
                                    开 始&nbsp;时 间 ：<input type="text" name="start_time" id="start_time" style="width: 120px" readonly="readonly" onclick="WdatePicker({ realFullFmt: '%Date ', dateFmt: 'yyyy-MM-dd' })" />
                                    结束时间：<input type="text" name="start2_time" id="start2_time" style="width: 120px" readonly="readonly" onclick="WdatePicker({ realFullFmt: '%Date ', dateFmt: 'yyyy-MM-dd' })" />

                                </td>
                            </tr>
                            <tr>
                                <td>
                                    标&nbsp;&nbsp;题：
                                    <input id="title" value="" style="width: 120px">
                                    咨 询 详 情 ：
                                    <input id="detail" value=""style="width: 120px">
                                    联 系 方 式：
                                    <input id="phone_num" value="" style="width: 120px" onkeyup="this.value=this.value.replace(/[^\d]/g,'') " >
                                    <%--现场处理人:
                                    <select name="status" style="width: 120px;">
                                    </select>--%>
                                    是否现场处理 ：
                                    <select name="is_live" id="is_live" style="width: 120px;">
                                        <option value="">==请选择==</option>
                                        <option value="0">否</option>
                                        <option value="1">是</option>
                                    </select>
                                    受 理 人：<input type="text" id="user_id" style="width: 120px" >
                                    <input type="button" id = "select" onclick="selectBy();" value="搜&nbsp;&nbsp;索"style="font-size:11pt;width: 40pt"/>
                                    <%--<input type="button" id="clear" value="清空" style="color:#ff0000;"/>--%>
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

                <%-- <c:if test="${empty pages.list}">
                     <tr>
                         <td align="center" colspan="10">没有数据！</td>
                     </tr>
                 </c:if>--%>
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

