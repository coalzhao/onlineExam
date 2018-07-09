<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<script type="text/javascript" src="${ctxStatic}/jquery/jquery-1.8.3.min.js"></script> 
	<title>试卷列表</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
	$(document).ready(function(){
		//alert("jQuery执行");
		if($("#msg").val() == "error"){  //试卷已作答，不能重复提交
			alert("无试卷信息，请等待试卷发布");
			$("#content").html("暂无试卷发布，请稍后刷新页面");
			//window.close();
		}
	});
	</script>
</head>
<body>
	<div id="content">
	<input type="hidden" id="msg" value="${msg}">
	<ul class="nav nav-tabs">
		<li class="active">试卷列表</li>
	</ul>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><tr><th>试卷名称</th><th>开始时间</th><th>结束时间</th><th>卷面分值</th><th>操作</th></tr></thead>
		<tbody>
		
			<tr>
				<td>${paper.paperName}</td>
				<td><fmt:formatDate value="${paper.beginTime}" type="both"/></td>
				<td><fmt:formatDate value="${paper.endTime}" type="both"/></td>
				<td>${paper.paperScore}</td>
				<td>
					<a target="_blank" href="${ctx}/cms/paper/start?id=${paper.id}&order=0">开始答题</a>&nbsp;&nbsp;
	    				<a href="${ctx}/cms/score/person?uid=${uid}&pid=${paper.id}">查看成绩</a>
				</td>
			</tr>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
	</div>
</body>
</html>














