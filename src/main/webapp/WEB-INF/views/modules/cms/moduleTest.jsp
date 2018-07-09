<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>模块管理</title>
<meta name="decorator" content="default" />
<%@include file="/WEB-INF/views/include/treetable.jsp"%>
</head>
<body>
	<table id="treeTable"
		class="table table-striped table-bordered table-condensed">
		<tr>
			<th>模块名称</th>
		</tr>
		<c:forEach items="${modulesList}" var="tpl">
			<tr >
				<td><a href="${ctx}/cms/moduleAnswer/subByModule?moduleId=${tpl.id}">${tpl.name}</a></td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>