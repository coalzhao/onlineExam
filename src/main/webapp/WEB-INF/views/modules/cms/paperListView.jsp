<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>真题试卷列表</title>
<meta name="decorator" content="default" />
<script type="text/javascript">
	function page(n, s) {
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		$("#searchForm").submit();
		return false;
	}
</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/cms/paper/list">试卷列表</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="paper"
		action="${ctx}/cms/paper/list" method="post"
		class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
		<input id="pageSize" name="pageSize" type="hidden"
			value="${page.pageSize}" />
		<label>试卷名称:</label>
		<form:input path="paperName" htmlEscape="false" maxlength="50"
			class="input-small" />&nbsp;
		<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" />&nbsp;&nbsp;
		<label>状态:</label>
		<form:radiobuttons onclick="$('#searchForm').submit();" path="paperStatus"
			items="${fns:getDictList('paper_status')}" itemLabel="label"
			itemValue="value" htmlEscape="false" />
	</form:form>
	<sys:message content="${message}" />
	<table id="contentTable"
		class="table table-striped table-bordered table-condensed">
		<thead><tr><th>序号</th><th>试卷名称</th><th>考试时间</th><th>时长</th><th>试卷总分</th><th>更新时间</th><th>创建者</th><th>试卷状态</th><th>操作</th></tr></thead>
		<tbody>
			<c:forEach items="${page.list}" var="paper" varStatus="status">
				<tr>
				<td>${status.index+1}</td>
				<td><a href="${ctx}/cms/paper/preview?id=${paper.id}" title="${paper.paperName}">${fns:abbr(paper.paperName,40)}</a></td>
				<td><fmt:formatDate value="${paper.beginTime}" type="both"/></td>
				<td>${paper.paperDuration}分钟</td>
				<td>${paper.paperScore}</td>
				<td><fmt:formatDate value="${paper.updateDate}" type="both"/></td>
				<td>${paper.createBy.name}</td>
				<td>${fns:getDictLabel(paper.paperStatus, 'paper_status', '审核')}</td>
				<td>
					<a href="${ctx}/cms/paper/preview?id=${paper.id}">预览</a>
					<shiro:hasPermission name="cms:paper:edit">
	    				<a href="${ctx}/cms/paper/edit?id=${paper.id}">编辑${paper.paperStatus eq '0'?'发布':'审核' }</a>
	    				<shiro:hasPermission name="cms:paper:audit">
							<a href="${ctx}/cms/paper/delete?id=${paper.id}" onclick="return confirmx('确认要删除该试卷吗？', this.href)" >删除</a>
						</shiro:hasPermission>
					</shiro:hasPermission>
				</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>