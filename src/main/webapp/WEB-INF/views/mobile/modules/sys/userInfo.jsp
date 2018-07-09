<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="${ctxStatic}/jquery/jquery-1.10.2.min.js"></script>
  <link rel="stylesheet" href="${ctxStatic}/bootstrap4/css/bootstrap.min.css">
<script type="text/javascript" src="${ctxStatic}/bootstrap4/js/bootstrap.min.js"></script>  
 <script type="text/javascript">
            var msg = '${message}';
            if (msg=="保存用户信息成功"){
            alert("保存用户信息成功")
            window.location.href='${ctx}/login';
            }
           /*  if(msg=="unsuccess"){
            alert("修改失败,旧密码错误")
            } */
        </script>
</head>
<body>
<header  style="background:#121212; color:#FFF ;height:50px">
 <h6 style="text-align:center ;line-height:50px">个人信息</h6>
 </header>
<div class="container"> 
  <table class="table">
  <form:form id="inputForm" modelAttribute="user" action="${ctx}/sys/user/info" method="post"  class="form-horizontal">
		  
		<%-- <sys:message content="${message}"/>   --%>
<tbody>
<%-- <tr><td> <div class="text-info">
           
   	<span>头像:</span>
   	<form:hidden path="email" htmlEscape="false" maxlength="255" class="input-xlarge"/>
		<sys:ckfinder input="" type="files" uploadPath="/mytask" selectMultiple="false"/>   
        </div></td></tr> --%>
        <div class="text-info">
<tr> 
<td><div class="input-group"> <span class="input-group-addon">姓名</span>
    <form:input path="name" htmlEscape="false" maxlength="50" class="required" readonly="true" id="name"/></div>
</td>
</tr>
<tr>
<td><div class="input-group"> <span class="input-group-addon">邮箱</span>
    <form:input path="email" htmlEscape="false" maxlength="50" class="email" id="email"/>
    </div>
</td>
</tr>
<td><div class="input-group">
            <span class="input-group-addon">电话</span>
           <form:input path="phone" htmlEscape="false" maxlength="50" id="phone"/>
        </div>
</td></tr>
<td> <div class="input-group">
            <span class="input-group-addon">手机</span>
           <form:input path="mobile" htmlEscape="false" maxlength="50" id="mobile"/>
        </div></td></tr>
   <tr>     <td> <div class="input-group">
            <span class="input-group-addon">备注</span>
            	<form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="input-xlarge" id="remarks"/>
        </div></td>
</tr>
<tr><td> <div class="text-info">
            <span class="text-left">用户类型:</span>
           <label class="lbl">${fns:getDictLabel(user.userType, 'sys_user_type', '无')}</label>
        </div></td></tr>
<tr><td> <div class="text-info">
            <span class="text-left">用户角色:</span>
   	<span>${user.roleNames}</span>
        </div></td></tr>
        <tr><td> <div class="text-info">
            <span class="text-left">归属公司:</span>
   	<span>${user.company.name}</span>
        </div></td></tr>
        <tr><td> <div class="text-info">
            <span class="text-left">归属部门:</span>
   	<span>${user.office.name}</span>
        </div></td></tr>
<tr><td> <div class="text-info">
            <span class="text-left">上次登录</span>
   	<span>IP: ${user.oldLoginIp}&nbsp;&nbsp;&nbsp;<br/>登录时间：<fmt:formatDate value="${user.oldLoginDate}" type="both" dateStyle="full"/></span>
        </div></td></tr>

<tr><td> 
<input id="btnSubmit" class="btn btn-info btn-lg" type="button" value="保 存" />
</form:form> 
<a href="${ctx}"><button class="btn btn-info btn-lg"" type="button" value="返回主页">返回主页</button></a>
</td></tr>

</tbody>
</table> 
 
 
  </div>
 <footer  style="background:#121212; color:#FFF ;height:50px">
 <h6 style="text-align:center ;line-height:50px">考试系统</h6>
 </footer>
</div>
</div>
  
 </body>
<script type="text/javascript">
 
  
$("#btnSubmit").click(function(){
 var email=$("#email").val();
 var phone = $("#phone").val();
 var mobile = $("#mobile").val();
 var remarks = $("#remarks").val();
 
function validate1(){ 
 
      if(email==""||email==null){
 alert("请填写邮箱");
 return false;
 }else{
 return true
 }
        }
function validate2(){ 
  if(phone==""||phone==null ||phone.length!= 7){
 alert("电话号码必须为7位");
 return false;
 }else{
 return true
 }
 }
 function validate3(){ 
  if(mobile==""||mobile==null ||mobile.length!=11){
 alert("手机号码必须为11位");
 return false;
 }else{
 return true
 }
 }
  function validate4(){ 
  if(remarks==""||remarks==null){
alert("请填写备注");
 return false
 }else{
 return true
 }} 
 if(validate1()&&validate2()&&validate3()&&validate4()){
 $("#inputForm").submit();
 }
});

</script>

</html>