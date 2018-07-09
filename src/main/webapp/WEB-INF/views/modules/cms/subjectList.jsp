<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>试题管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/cms/subject/?subjectRoot.id=${subject.subjectRoot.id}">试题列表</a></li>
		<shiro:hasPermission name="cms:subject:edit"><li><a href="<c:url value='${fns:getAdminPath()}/cms/subject/form?id=${subject.id}&subjectRoot.id=${subject.subjectRoot.id}'><c:param name='subjectRoot.name' value='${subject.subjectRoot.name}'/></c:url>">文本试题添加</a></li></shiro:hasPermission>
		<shiro:hasPermission name="cms:subject:edit"><li><a href="<c:url value='${fns:getAdminPath()}/cms/subject/photoForm?id=${subject.id}&subjectRoot.id=${subject.subjectRoot.id}'><c:param name='subjectRoot.name' value='${subject.subjectRoot.name}'/></c:url>">图片试题添加</a></li></shiro:hasPermission>
	</ul>
	<form:form id="searchForm" modelAttribute="subject" action="${ctx}/cms/subject/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<label>栏目：</label><sys:treeselect id="subjectRoot" name="subjectRoot.id" value="${subject.subjectRoot.id}" labelName="subjectRoot.name" labelValue="${subject.subjectRoot.name}"
					title="题根" url="/cms/subjectRoot/treeData" module="subject" notAllowSelectRoot="false" cssClass="input-small"/>
		<label>题目：</label><form:input path="title" htmlEscape="false" maxlength="50" class="input-small"/>&nbsp;
		<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>&nbsp;&nbsp;
		<label>题型：</label><form:radiobuttons onclick="$('#searchForm').submit();" path="type" items="${fns:getDictList('sub_type')}" itemLabel="label" itemValue="value" htmlEscape="false"/>&nbsp;&nbsp;
		<label>分类：</label><form:radiobuttons onclick="$('#searchForm').submit();" path="simulate" items="${fns:getDictList('simulate')}" itemLabel="label" itemValue="value" htmlEscape="false"/>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><tr><th width="30">序号</th><th width="40">题根</th><th width="300">题目</th><th>答案及解析</th><th>题型</th><th>类别</th><th>难易</th><th>发布者</th><th>更新时间</th><th>操作</th></tr></thead>
		<tbody>
		<c:forEach items="${page.list}" var="subject" varStatus="status">
			<tr>
				<td>${status.index+1}</td>
				<td align="center" ><a href="javascript:" onclick="$('#subjectRootId').val('${subject.subjectRoot.id}');$('#subjectRootName').val('${subject.subjectRoot.name}');$('#searchForm').submit();return false;">${subject.subjectRoot.name}</a></td>
				<td>
				${subject.title}
				<c:if test="${subject.judge eq '1'}">
				A.${subject.a}
				<br>B.${subject.b}
				<br>C.${subject.c}
				<br>D.${subject.d}
				<c:if test="${not empty subject.e}"><br>E.${subject.e}</c:if>
				<c:if test="${not empty subject.f}"><br>F.${subject.f}</c:if>
				<c:if test="${not empty subject.g}"><br>G.${subject.g}</c:if>
				</c:if>
				<c:if test="${subject.judge eq '2'}">
				A.<img style="max-width: 80px;margin: 0px 10px 5px 0px;" src="${subject.a}">
				B.<img style="max-width: 80px;margin: 0px 10px 5px 0px;" src="${subject.b}"><br>
				C.<img style="max-width: 80px;margin: 0px 10px 5px 0px;" src="${subject.c}">
				D.<img style="max-width: 80px;margin: 0px 10px 5px 0px;" src="${subject.d}">
				</c:if>
				</td>
				<td>${subject.correct}<br/>解析：${subject.remarks}</td>
				<td>${fns:getDictLabel(subject.type, 'sub_type', '单选题')}</td>
				<td>${fns:getDictLabel(subject.simulate, 'simulate', '模拟题')}</td>
				<td>${fns:getDictLabel(subject.complexity, 'sub_complexity', '易')}</td>
				<td>${subject.user.name}</td>
				<td><fmt:formatDate value="${subject.updateDate}" type="both"/></td>
				<td>
					<shiro:hasPermission name="cms:subject:edit">
	    				<a href="${ctx}/cms/subject/<c:if test="${subject.judge eq '1' }">form</c:if><c:if test="${subject.judge eq '2' }">photoForm</c:if>?id=${subject.id}">修改</a>
	    				<shiro:hasPermission name="cms:suject:audit">
							<a href="${ctx}/cms/subject/delete?id=${subject.id}&subjectRootId=${subject.subjectRoot.id}" onclick="return confirmx('确认要删除该试题吗？', this.href)" >删除</a>
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