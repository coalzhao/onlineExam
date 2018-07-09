<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>Insert title here</title>
<link rel="stylesheet" href="${ctxStatic}/bootstrap/bsie/css/bootstrap.min.css">  
<script type="text/javascript" src="${ctxStatic}/jquery/jquery-1.8.3.min.js"></script>  
<style type="text/css">
p{display: inline;}
</style>
</head>
<body>


<c:forEach items="${subject}" var="subject" varStatus="idsubject">
<input type="hidden" name="a" id="judge" value="${subject.judge}">
<div class="panel panel-primary">
	<div class="panel-heading"><c:if test="${subject.type.equals('1')}">单选题</c:if><c:if test="${subject.type.equals('2')}">多选题</c:if><c:if test="${subject.result.equals('T')}"><span style="float:right;">正确</span></c:if><c:if test="${subject.result.equals('F')}"><span style="float:right;">错误</span></c:if></div>
	<div class="panel-body">
		<p><c:out value='${idsubject.index+1}'/>.${subject.title}
		</p>
	</div>
	<ul class="list-group">
		<li class="list-group-item">A.<c:if test="${subject.judge.equals('1')}"><span id="a">${subject.a}</span></c:if><c:if test="${subject.judge.equals('2')}"><img src="${subject.a}"/></c:if></li>
		<li class="list-group-item">B.<c:if test="${subject.judge.equals('1')}"><span id="b">${subject.b}</span></c:if><c:if test="${subject.judge.equals('2')}"><img src="${subject.b}"/></c:if></li>
		<li class="list-group-item">C.<c:if test="${subject.judge.equals('1')}"><span id="c">${subject.c}</span></c:if><c:if test="${subject.judge.equals('2')}"><img src="${subject.c}"/></c:if></li>
		<li class="list-group-item">D.<c:if test="${subject.judge.equals('1')}"><span id="d">${subject.d}</span></c:if><c:if test="${subject.judge.equals('2')}"><img src="${subject.d}"/></c:if></li>
		<li class="list-group-item">已选答案：${subject.userAnswer}</li>
		<li class="list-group-item">正确答案：${subject.correct}</li>
		<li class="list-group-item">解析：${subject.remarks}</li>
	</ul>
</div>
<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
</c:forEach>

</body>
</html>