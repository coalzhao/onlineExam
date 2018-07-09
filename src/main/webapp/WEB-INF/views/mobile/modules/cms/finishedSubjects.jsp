<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
</style>
<style type="text/css">
li{display: inline;}
</style>
 <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no">
<link rel="stylesheet" href="${ctxStatic}/jqueryMobile/css/jquery.mobile-1.3.2.min.css"> 
 <script src="${ctxStatic}/jquery/jquery-1.8.3.min.js"></script> 
 <script src="${ctxStatic}/jqueryMobile/js/jquery.mobile-1.3.2.min.js"></script> 
    <meta charset="utf-8">
  </head>
  
  <body>
<div data-role="page">
  <div data-role="content">
<c:forEach items="${subList}" var="subject" varStatus="idsubject">
<input type="hidden" name="a" id="judge" value="${subject.judge}">
 
<ul data-role="listview">
<h1 ><c:out value='${idsubject.index+1}'/>.</h1>
<h2>
	题型:<c:if test="${subject.type.equals('1')}">单选题</c:if><c:if test="${subject.type.equals('2')}">多选题</c:if>
	<span style="float:right;">结果:<c:if test="${subject.result.equals('1')}">正确</span></c:if>
	<span style="float:right;"><c:if test="${subject.result.equals('0')}">错误</span></c:if>
	</h2>
	
	<li data-role="list-divider"><strong>${subject.title}</strong></li>
		<li>A.<c:if test="${subject.judge.equals('1')}"><span id="a">${subject.a}</span></c:if><c:if test="${subject.judge.equals('2')}"><img src="${subject.a}" class="img-responsive"/></c:if></li>
		<li>B.<c:if test="${subject.judge.equals('1')}"><span id="b">${subject.b}</span></c:if> <c:if test="${subject.judge.equals('2')}"><img src="${subject.b}" class="img-responsive"/></c:if> </li>
		<li>C.<c:if test="${subject.judge.equals('1')}"><span id="c">${subject.c}</span></c:if><c:if test="${subject.judge.equals('2')}"><img src="${subject.c}" class="img-responsive" /> </c:if></li>
		<li>D.<c:if test="${subject.judge.equals('1')}"><span id="d">${subject.d}</span></c:if><c:if test="${subject.judge.equals('2')}"> <img src="${subject.d}" class="img-responsive"/></c:if></li>
		<li>已选答案：${subject.userAnswer}</li>
		<li>正确答案：${subject.correct}</li>
		<li>解析：${subject.remarks}  </li>
		</br>
	</ul>
<!-- <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/> -->
</c:forEach> 

<a href="${ctx}" data-role="button"  data-ajax="false">返回主页</a>
</div>
</div>
  </body>
</html>
