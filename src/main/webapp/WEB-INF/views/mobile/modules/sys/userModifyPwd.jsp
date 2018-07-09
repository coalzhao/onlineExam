<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
 <script src="${ctxStatic}/jquery/jquery-1.10.2.min.js"></script>
   <link rel="stylesheet" href="${ctxStatic}/bootstrap4/css/bootstrap.min.css">
<script type="text/javascript" src="${ctxStatic}/bootstrap4/js/bootstrap.min.js"></script>  

</head>
<body>
<!-- <header  style="background:#545454; color:#FFF ;height:39px">

 </header> -->
 <header  style="background:#121212; color:#FFF ;height:50px">
 <h6 style="text-align:center ;line-height:50px">修改密码</h6>
 </header>

  <table class="table">
 <form:form id="inputForm" modelAttribute="user" action="${ctx}/sys/user/modifyPwd" method="post" class="form-horizontal" data-ajax="false">
		<form:hidden path="id"/>
		<%-- <sys:message content="${message}"/> --%>
 <tbody>
<tr>
<td><div class="input-group"> <span class="input-group-addon">旧密码&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
				<input id="oldPassword" name="oldPassword" type="password" value="" maxlength="50" minlength="3" class="required"/>
				<span class="help-inline"><font color="red">*</font> </span>
</td>
</tr>
<tr>
<td><div class="input-group"> <span class="input-group-addon">新密码&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
				<input id="newPassword" name="newPassword" type="password" value="" maxlength="50" minlength="3" class="required"/>
				<span class="help-inline"><font color="red">*</font> </span>
</td>
</tr>
<tr>
<td><div class="input-group"> <span class="input-group-addon">确认新密码</span>
				<input id="confirmNewPassword" name="confirmNewPassword" type="password" value="" maxlength="50" minlength="3" class="required" equalTo="#newPassword"/>
<span class="help-inline"><font color="red">*</font> </span>
</td>
</tr>
<tr>
<td>
			<input id="btnSubmit" class="btn btn-info btn-lg" type="button" value="保 存"/>
			<input id="btnReset" class="btn btn-info btn-lg" type="reset" value="取消"/>
			<a href="${ctx}"><input class="btn btn-info btn-lg"" type="button" value="返回主页"></input></a>
</tbody>
</table>
</form:form>
 <script type="text/javascript">
 
  
$("#btnSubmit").click(function(){
 var newPassword=$("#newPassword").val();
 var confirmNewPassword = $("#confirmNewPassword").val();

 
function validate1(){ 
if(newPassword!=confirmNewPassword){
 alert("两次输入密码不一致,请重新输入");
 return false;
 }else{
 return true
 }}
 
 function validate2(){ 
if(newPassword.length<5 || newPassword==null ||newPassword==""){
 alert("新密码至少为5位");
 return false;
 }else{
 return true
 }}


 
 if(validate1()&&validate2()){
 $("#inputForm").submit();

 }
});

</script>
 <script type="text/javascript">
            var msg = '${message}';
            if (msg=="修改密码成功"){
            alert("修改成功,请使用新密码重新登录")
            window.location.href='${ctx}/logout';
            }
            if(msg=="修改密码失败，旧密码错误"){
            alert("修改失败,旧密码错误")
            }
        </script>
  </body>
</html>
