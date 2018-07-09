<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <meta name="viewport" content="width=device-width, initial-scale=1">
 <link rel="stylesheet" href="${ctxStatic}/jqueryMobile/css/jquery.mobile-1.3.2.min.css"> 
 <script src="${ctxStatic}/jquery/jquery-1.8.3.min.js"></script> 
 <script src="${ctxStatic}/jqueryMobile/js/jquery.mobile-1.3.2.min.js"></script> 

</head>
<body>

<div data-role="page" id="pageone" data-theme="c">
  <div data-role="header">
    <h1>首页选项</h1>
  </div>

  <div data-role="content">
    <a href="${ctx}/sys/user/info" data-role="button" data-icon="arrow-r" data-iconpos="right" data-ajax="false">个人信息</a>
    <a href="${ctx}/sys/user/modifyPwd" data-role="button" data-icon="arrow-r" data-iconpos="right" data-ajax="false">修改密码</a>
    <a href="${ctx}/cms/subjectRoot/subModulesList" data-role="button" data-icon="arrow-r" data-iconpos="right" data-ajax="false">模块测试</a>
    <a href="${ctx}/cms/paper/simuListMobile" data-role="button" data-icon="arrow-r" data-iconpos="right" data-ajax="false">模拟考试</a>
    <a href="${ctx}/logout" data-role="button" data-icon="arrow-r" data-iconpos="right" data-ajax="false" onclick='return confirm("确定退出？");'>退出登录</a>
  </div>
  <div data-role="footer">
  <h1>考试系统</h1>
  </div>
</div> 
  </body>
</html>
