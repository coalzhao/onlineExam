<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>数据统计</title>
<meta name="decorator" content="default" />
<script type="text/javascript">
	function page(n, s) {
		if (n)
			$("#pageNo").val(n);
		if (s)
			$("#pageSize").val(s);
		$("#searchForm").attr("action", "${ctx}/cms/data/statistics");
		$("#searchForm").submit();
		return false;
	}
	$(document).ready(function() {
		$("#btnExport").click(function() {
			top.$.jBox.confirm("确认要导出用户数据吗？", "系统提示", function(v, h, f) {
				if (v == "ok") {
					$("#searchForm").attr("action", "${ctx}/cms/data/export");
					$("#searchForm").submit();
				}
			}, {
				buttonsFocus : 1
			});
			top.$('.jbox-body .jbox-icon').css('top', '55px');
		});
	});
</script>
</head>
<body>
	<hr>
	<form:form id="searchForm" action="${ctx}/cms/data/statistics"
		method="post" class="form-horizontal">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
		<input id="pageSize" name="pageSize" type="hidden"
			value="${page.pageSize}" />
		<sys:tableSort id="orderBy" name="orderBy" value="${page.orderBy}"
			callback="page();" />
		<label>开始日期：</label>
		<input id="paperBeginTime" name="beginTime" type="text"
			readonly="readonly" maxlength="20" class="input-medium Wdate"
			value="<fmt:formatDate value="${beginTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
			onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});" />&nbsp;
		<label>截止日期：</label>
		<input id="subEndTime" name="endTime" type="text" readonly="readonly"
			maxlength="20" class="input-medium Wdate"
			value="<fmt:formatDate value="${endTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
			onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});" />
		<label>人员信息：</label>
		<select name="id" onload="selctName()" id="loginName"
			style="width: 150px">
			<option value="">请选择</option>
			<c:forEach items="${users}" var="user">
				<option value="${user.id }">${user.name }</option>
			</c:forEach>
		</select>
		<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" />
		<input id="btnExport" class="btn btn-primary" type="button" value="导出" />
	</form:form>
	<sys:message content="${message}" />
	<hr>
	<table id="contentTable"
		class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th class="sort-column id">序号</th>
				<th class="sort-column login_name">姓名</th>
				<th>真题试卷数量</th>
				<th>模拟试卷数量</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${page.list}" var="dataStatistic"
				varStatus="status">
				<tr>
					<th>${status.count }</th>
					<th>${dataStatistic.createBy.name }</th>
					<th>${dataStatistic.paperNum }</th>
					<th>${dataStatistic.papSimNum }</th>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>














