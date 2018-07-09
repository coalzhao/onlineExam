<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<link rel="stylesheet" href="${ctxStatic}/bootstrap/bsie/css/bootstrap.min.css">  
<script type="text/javascript" src="${ctxStatic}/jquery/jquery-1.8.3.min.js"></script>
	<title>成绩管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function(){
			//alert("jquery");
			if($("#scoreId").val()==''){
				alert("该试卷未作答，暂无成绩");
				window.close();
			}
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active">成绩列表</li>
	</ul>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><tr><th>考试人员</th><th>单选成绩</th><th>多选成绩</th><th>总成绩</th><th>所答试卷</th></tr></thead>
		<tbody>
			<tr>
				<td>${score.user.name}</td>
				<td>${score.sinScore}</td>
				<td>${score.mulScore}</td>
				<td>${score.sumScore}</td>
				<td>${score.paperName}</td>
			</tr>
		</tbody>
	</table>
	<input id="scoreId" type="hidden" value="${scoreId}">
	<div class="pagination">${page}</div>
</body>
</html>














