<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="pagePath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>添加咨询申请单</title>
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
        var apps = null;
        //隐藏弹框查询页面
        function show(){
            document.getElementById("win").style.display="";
        }
        function closeLogin(){
            document.getElementById("win").style.display="none";
        }
        function selectClose(){

            var s = $("input[name='applicant_id1']:checked").val();
            $.each(apps, function (index, applicant) {
                if(s==applicant.id) {
                    $("#applicant").val(applicant.name);
                    $("#department_id").val(applicant.departmentName);
                    $("#code_num").val(applicant.codeNum);
                    $("#company").val(applicant.company);
                    $("#phone_num").val(applicant.phoneNum);
                    $("#applicantId").val(applicant.id);
                }
            })
            //alert(s)
            document.getElementById("win").style.display="none";
        }
        //是否现场处理的change事件
        $(function () {
            $(":radio").on("change",function () {
                var islive = $('input:radio[name="isLive"]:checked').val();
                if(islive=="1"){
                    $("#handle_id").attr("disabled",false);
                        $.ajax({
                            type: "POST",
                            url: "${pagePath}/order/selectApplicantL",
                            dataType: "text",
                            success: function(data){
                                var applicantLs =jQuery.parseJSON(data).applicantLs;
                                var optionString = "";
                                for (var i=0;i<applicantLs.length;i++) {
                                    var applicantL = applicantLs[i];
                                    optionString += "<option value=\"" + applicantL.id + "\">" + applicantL.name + "</option>";
                                    $("#handle_id").html("<option value=''>==请选择==</option>" + optionString);
                                }
                            },
                            error: function(e) {
                                alert(e);
                            }
                        });
                }else {
                    $("#handle_id").html("<option value=''>==请选择==</option>");
                    $("#handle_id").attr("disabled",true);
                }
            })
        })


        //申请人联系方式改变事件  https://www.cnblogs.com/aboutYouH/p/9944346.html  https://www.iteye.com/blog/luanxiyuan-1847138
        //layer实现弹窗功能并通过同一个页面将返回值辅导当前页面   怎么将一个页面做成弹窗形式
        function selectByPhone(){
                var phone_num = $("#phone_id").val();
                $.ajax({
                    type: "POST",
                    data: {"phoneNum":phone_num},
                    url: "${pagePath}/order/selectApplicantByP",
                    dataType: "text",
                   //contentType: "application/json; charset=utf-8",
                   success: function(data){

                        var html =  '<tr>\n' +
                                        '<th width="60" align="center" height="30">选择</th>\n' +
                                       '<th>员工姓名</th>\n' +
                                       '<th>人资编码</th>\n' +
                                       '<th>联系方式</th>\n' +
                                       '<th>所属处室</th>\n' +
                                       '<th>公司名称</th>\n' +
                                   '</tr>';
                       var applicants =jQuery.parseJSON(data).applicants;
                       if (applicants!=null && applicants!='') {
                               apps = applicants;
                           $.each(applicants, function (index, applicant) {
                               //alert(applicant['id'])
                               html += '<tr>' +
                                           '<td align="center">' + '<input  type="radio" value="'+applicant['id']+'" name="applicant_id1">' + '</td>' +
                                           '<td>' + applicant['name'] + '</td>' +
                                           '<td>' + applicant['codeNum'] + '</td>' +
                                           '<td>' + applicant['phoneNum'] + '</td>' +
                                           '<td>' + applicant['departmentName'] + '</td>' +
                                           '<td>' + applicant['company'] + '</td>' +
                                       '</tr>';
                           })
                       }else {
                           html += '<tr>'+
                                        '<td align="center" colspan="6">暂无数据！</td>'+
                                   '</tr>';
                       }
                       $('#datatable').html(html);

                   },
                   error: function(e) {
                       alert("查询异常");
                   }
               });
           }


        //申请人改变事件 TODO 需要重新根据id去查询
       /*$(function(){
            $("#applicant").on("change",function(){
               $.ajax({
                   type: "POST",
                   url: "{pagePath}/order/selectClassA",
                   //data: {""},
                   //dataType: "json",
                   dataType: "text",
                   contentType: "application/json; charset=utf-8",
                   success: function(data){
                       var applicants =jQuery.parseJSON(data).applicants;
                       for (var i=0;i<applicants.length;i++) {
                           var applicant = applicants[i];
                           if(applicant.id==$("#applicant").val()){
                               $("#department_id").val(applicant.departmentName);
                               $("#code_num").val(applicant.codeNum);
                               $("#company").val(applicant.company);
                               $("#phone_num").val(applicant.phoneNum);
                           }
                       }
                   },
                   error: function(e) {
                       alert(e);
                   }
               });
           });
       })*/

        //1.查询咨询一级分类
        $("document").ready(function() {
            $.ajax({
                type: "POST",
                url: "${pagePath}/order/selectClassA",
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

        //提交表单
        function submit1(){
            var title = $("#title").val();
            var class_a = $("#class_a").val();
            var class_b = $("#class_b").val();


            var applicant_id = $("#applicantId").val();
            var code_num = $("#code_num").val();
            var department_name = $("#department_id").val();
            var phone_num = $("#phone_num").val();
            var company = $("#company").val();
            var applicant = $("#applicant").val();


            var source = $("#source").val();
            var content = $("#content").val();
            var detail = $("#detail").val();
            var handle_id = $("#handle_id").val();
            var is_live = $('input:radio[name="isLive"]:checked').val();
           if(title==null || title ==""){
               alert("标题不能为空!")
               return
           }
            if(class_a==null || class_a ==""){
                alert("请选择一级分类!")
                return
            }
            if(class_b==null || class_b ==""){
                alert("请选择二级分类!")
                return
            }
            if(applicant_id==null || applicant_id ==""){
                alert("申请人不能为空!")
                return
            }
            /*if(is_live==1){
                if(handle_id==null || handle_id ==""){
                    alert("处理人不能为空!")
                    return
                }
            }*/


            var orderConsultUser = {
                title : title,
                classA : class_a,
                classB : class_b,
                applicantId : applicant_id,
                codeNum : code_num,
                departmentName : department_name,
                phoneNum : phone_num,
                company : company,
                applicant : applicant,
                source : source,
                content : content,
                detail : detail,
                isLive : is_live,
                handleId : handle_id
            };

            $.ajax({
                type: "POST",
                url: "${pagePath}/order/add",
                data: JSON.stringify(orderConsultUser),
                dataType: "text",
                contentType: "application/json; charset=utf-8",
                success: function(data){
                    if(data.toString()=="success"){
                        alert("添加成功!");
                        window.location.href = "${pagePath}/jsp/workorder/workorder_add.jsp";
                    }else {
                        alert("添加失败!");
                    }
                },
                error: function(e) {
                    alert("添加异常");
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
        <td class="main_locbg font2"><img src="${pagePath}/images/pointer.gif">&nbsp;当前位置：添加咨询申请单</td>
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
                                    <td class="font3 fftd" width="350">联 系 电 话：<input type="text" onclick="show()" id="phone_num" style="height: 20px">
                                        <%--<input type="text" id="phone_num" name="phone_num" list="browser" onkeyup="searcha();" onblur="searchOnBlur()" value="" size="20"/>--%>

                                        <%--<datalist id="browser">

                                        </datalist>--%>
                                    </td>
                                    <td class="font3 fftd" width="350">咨&nbsp;询&nbsp;人：
                                        <input id="applicantId" style="display: none">
                                        <input type="text" name="applicant" id="applicant" value="" size="20" readonly="true" style="height: 20px"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="font3 fftd">人 资  编 码：<input type="text" name="code_num" id="code_num" value="" size="20" readonly="true" style="height: 20px"/></td>
                                    <td class="font3 fftd">所 属  部 门：<input type="text" name="department_id" id="department_id" value="" size="20" readonly="true" style="height: 20px"/></td>
                                </tr>
                                <tr>
                                    <td class="font3 fftd">公 司  名 称：<input type="text" name="company" id="company" value="" size="20" readonly="true" style="height: 20px"/></td>
                                </tr>
                                <tr>
                                    <td class="font3 fftd"  colspan="2">咨 询  标 题：<input name="title" id="title" value="" style="width: 560px;height: 30px"/><span style="color:red; font-size: 12px">*</span></td>
                                </tr>
                                <tr>
                                    <td class="font3 fftd" colspan="2">咨 询  详 述：<textarea name="detail" id="detail" style="width: 560px;height: 80px"></textarea></td>
                                </tr>
                                <tr>
                                    <td class="font3 fftd">
                                        咨询一级分类：<select id="class_a" name="class_a" style="width:130px">

                                        </select><span style="color:red; font-size: 12px">*</span>
                                    </td>
                                    <td class="font3 fftd">
                                        咨询二级分类：<select id="class_b" name="class_b" style="width:130px">
                                            <%--<option value="0">==请选择==</option>
                                            <c:forEach items="${classBList}" varStatus="regionList">
                                                <c:set var="class_b" value="${classList1.current}"/>
                                                <option <c:if test="${act.id==classB.id }">selected</c:if>
                                                        value="${classB.id}">${classB.name}</option>
                                            </c:forEach>--%>
                                        </select><span style="color:red; font-size: 12px">*</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="font3 fftd">咨 询  来 源：
                                        <select id="source" name="source" style="width:130px">
                                            <option value="0" selected>电话</option>
                                            <option value="1">邮件</option>
                                        </select><span style="color:red; font-size: 12px">*</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="font3 fftd" colspan="2">答 复  内 容：<textarea type="text" name="content" id="content" size="20" style="width: 560px;height: 60px"></textarea></td>
                                </tr>
                                <tr>
                                    <td class="font3 fftd">
                                        是否现场处理：
                                        <input name="isLive" type="radio" value="0" checked="checked">否
                                        <input name="isLive" type="radio" value="1">是
                                    </td>
                                    <td class="font3 fftd">
                                        <select id="handle_id" name="handle_id" style="width:130px; display:none" >
                                        </select>
                                    </td>
                                </tr>
                                <tr>

                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td align="left" class="fftd" style="text-align: center;" ><input type="button" id = "button1" onclick="submit1()" value="保存">&nbsp;&nbsp;<input type="reset" value="取消"></td>
                    </tr>
                </table>
            </form>
        </td>
    </tr>

</table>
<div style="height: 10px;"></div>
<div id="win" style="display:none; POSITION:absolute; left:50%; top:50%; width:600px; height:400px; margin-left:-300px; margin-top:-200px; border:1px solid #888; background-color:#edf; text-align:center">
    <%--<div class="font3 fftd" style="left: 2px;">
        联系方式:<input id="phone_id">
        人资编码:<input readonly id="code_id">
        </div>--%>
        <%--<div class="font3 fftd" style="left: 2px;">
            所属部门:<input readonly id="depart_id">
            公司名称:<input readonly id="company_id">
        </div>--%>
        <div class="font3 fftd" align="left"> 联系方式:<input id="phone_id">&nbsp;&nbsp;<input type="button" onclick="selectByPhone()" value="查询"></div>
        <div class="font3 fftd">
            <table width="100%" border="1" cellpadding="5" cellspacing="0" style="border: #c2c6cc 1px solid; border-collapse: collapse;" id="datatable">

                    <tr>
                        <th width="60" align="center" height="30">选择</th>
                        <th>员工姓名</th>
                        <th>人资编码</th>
                        <th>联系方式</th>
                        <th>所属处室</th>
                        <th>公司名称</th>
                    </tr>
            </table>
            <div class="font3 fftd" align="center"><input type="button" onclick="selectClose();" value="确定">&nbsp;<input type="button" onclick="closeLogin();" value="取消"></div>
        </div>

</div>

</body>
</html>