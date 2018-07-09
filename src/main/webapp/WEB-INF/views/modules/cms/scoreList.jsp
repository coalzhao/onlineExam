<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>成绩管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		function viewComment(href){
			top.$.jBox.open('iframe:'+href,'查看评论',$(top.document).width()-220,$(top.document).height()-120,{
				buttons:{"关闭":true},
				loaded:function(h){
					$(".jbox-content", top.document).css("overflow-y","hidden");
					$(".nav,.form-actions,[class=btn]", h.find("iframe").contents()).hide();
					$("body", h.find("iframe").contents()).css("margin","10px");
				}
			});
			return false;
		}
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
		<li class="active"><a href="${ctx}/cms/score/">成绩列表</a></li>
		
	</ul>
	<form:form id="searchForm" modelAttribute="score"
    action="${ctx}/cms/score" method="post"
    class="breadcrumb form-search">
    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
    <input id="pageSize" name="pageSize" type="hidden"
      value="${page.pageSize}" />
    <label>考生姓名:</label>
    <form:input path="userName" htmlEscape="false" maxlength="50"
      class="input-small" />&nbsp;
      <label>考生登录名:</label>
    <form:input path="loginName" htmlEscape="false" maxlength="50"
      class="input-small" />&nbsp;
      <label>所答试卷:</label>
    <form:input path="paperName" htmlEscape="false" maxlength="50"
      class="input-small" />&nbsp;
    <input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" />&nbsp;&nbsp;
  </form:form> 
  
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><tr><th>序号</th><th>考试人员</th><th>登录名</th><th>单选成绩</th><th>多选成绩</th><th>总成绩</th><th>所答试卷</th><th>操作</th></tr></thead>
		<tbody>
		<c:forEach items="${page.list}" var="score" varStatus="idxNews">
			<tr>
				<td><c:out value='${idxNews.index+1}'/></td>
				<td>${score.user.name}</td>
				<td>${score.loginName}</td>
				<td>${score.sinScore}</td>
				<td>${score.mulScore}</td>
				<td>${score.sumScore}</td>
				<td>${score.paperName}</td>
				<td>
					<a href="${ctx}/cms/score/detail?uid=${score.userId}&paperId=${score.paperId}">详情</a>
					<shiro:hasPermission name="cms:score:edit">
	    				<shiro:hasPermission name="cms:score:audit">
							<a href="${ctx}/cms/score/delete?id=${score.id}${score.delFlag ne 0?'&isRe=true':''}" onclick="return confirmx('确认要删除该成绩吗？', this.href)" >删除</a>
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














