<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>试题管理</title>
<meta name="decorator" content="default" />
<script type="text/javascript">
	function page(n, s) {
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		$("#searchForm").submit();
		return false;
	}
	$(function(){
		$("#publishFrom").validate({
			rules:{
                beginTime:{
                	required:true
                }
			}
		})
	});
	function addSub(but) {
		//获取点击的按钮所在的行数据
		var slcTable = document.getElementById("contentTable");
		var tr = but.parentNode.parentNode;
		var index = tr.rowIndex;
		var pid = slcTable.rows[index].cells[8].innerHTML;
		var sid = slcTable.rows[index].cells[9].innerHTML;
		var title = slcTable.rows[index].cells[2].innerHTML;
		var type = slcTable.rows[index].cells[4].innerHTML;
		var complexity = slcTable.rows[index].cells[5].innerHTML;
		if (type == "单选题")
			typetext = "单选题"
		else
			typetext = "多选题";
		if (complexity == "易")
			complexitytext = "易"
		else
			complexitytext = "难";
		//前端判断该题是否已添加
		var tab = $("#addTable");
		var tableObj = document.getElementById("addTable");
		var rowLength = tableObj.rows.length;
		for (var i = 1; i < rowLength; i++) {
			var addId = tableObj.rows[i].cells[1].innerHTML;
			if (sid == addId) {
				alert("该题已经添加！");
				return;
			}
		}
		//添加试题
		$
				.ajax({
					url : "${ctx}/cms/paper/manual/subAdd",
					data : "subId=" + sid + "&subType=" + type + "&paperId="
							+ pid,
					success : function(data) {
						var trtd = $('<tr><td style="display: none;">'
								+ pid
								+ '</td><td style="display: none;">'
								+ sid
								+ '</td><td>'
								+ title
								+ '</td><td>'
								+ typetext
								+ '</td><td>'
								+ complexitytext
								+ '</td>'
								+ '<td><input type="button" class="btn btn-primary" onclick="dltSub('
								+ "'" + pid + "'," + "'" + sid + "'," + "'"
								+ type + "',"
								+ 'this)"  value="删除"/></td></tr>');
						trtd.appendTo(tab);
						$("#radioNumber").val(data.radioNumber)
						$("#multipleNumber").val(data.multipleNumber);
						$("#paperScore").val(data.paperScore)
					},
					error : function(data) {
						alert("操作失败！")
					}
				});
	}

	//删除试题方法
	function dltSub(pid, sid, type, but) {
		//删除试题
		$.ajax({
			url : "${ctx}/cms/paper/manual/subjectDelete",
			data : "subjectId=" + sid + "&subType=" + type + "&paperId=" + pid,
			success : function(data) {
				var tr = $(but).parent("td").parent("tr");
				//移除此行
				$(tr).remove();
				$("#radioNumber").val(data.radioNumber)
				$("#multipleNumber").val(data.multipleNumber);
				$("#paperScore").val(data.paperScore)
				
			},
			error : function(data) {
				alert("操作错误")
			}
		});
	}
	function publish(id){
		window.location.assign("${ctx}/cms/paper/manual/publish?paperId="+id);
	}
</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/cms/paper/manual/detail?id=${paper.id}">试卷详情</a></li>
		<li class="active"><a href="#">试题增删</a></li>
		<li><a href="${ctx}/cms/paper/manual/selectListPaper?simulate=${simulate}">试卷列表</a></li>
	</ul>
	
	<form id="publishFrom" class="breadcrumb form-search"
		action="${ctx}/cms/paper/manual/paperScoreUpdate2">
		<label style="margin-left: 0">试卷信息:</label>
		<input type="text" style="display: none;" value="${paper.id }" name="id"> 
		<label >单选个数：</label> <input type="text" readonly="readonly" value="${paper.radioNumber }"
										style="width: 60px;" id="radioNumber" name="radioNumber"> 
		<label>单选分值：</label>
		<input type="text" value="${paper.radioScore }" class="input-xlarge required"
				style="width: 60px;"type="number" min="0" id="radioScore" name="radioScore"> 
		<label>多选个数：</label> 
		<input type="text" readonly="readonly" value="${paper.multipleNumber}" 
				style="width: 60px;" id="multipleNumber" name="multipleNumber">
		<label>多选分值：</label> 
		<input type="text" value="${paper.multipleScore }" class="input-xlarge required"
				style="width: 60px;" type="number" min="0" id="multipleScore" name="multipleScore">
		<label>总分：</label> 
		<input type="text" readonly="readonly" value="${paper.paperScore }"
			style="width: 60px;" id="paperScore"> 
		<input type="submit" value="修改" class="btn btn-primary">
		<input type="button" value="发布" class="btn btn-primary" onclick="publish('${paper.id}')">
	</form>
	
	<form:form id="searchForm" modelAttribute="subject"
		action="${ctx}/cms/paper/manual/goPaperManualSubAdd" method="post"
		class="breadcrumb form-search">
		<label style="margin-left: 0">题根：</label>
		<sys:treeselect id="subjectRoot" name="subjectRoot.id"
			value="${subject.subjectRoot.id}" labelName="subjectRoot.name"
			labelValue="${subject.subjectRoot.name}" title="题根"
			url="/cms/subjectRoot/treeData" module="subject"
			notAllowSelectRoot="false" cssClass="input-small" />
		<label>题目：</label>
		<form:input path="title" htmlEscape="false" maxlength="50"
			class="input-small" />&nbsp;
		<input id="btnSubmit" class="btn btn-primary" type="submit" value="查询" />&nbsp;&nbsp;
		<label>题型：</label>
		<form:radiobuttons onclick="$('#searchForm').submit();"  path="type"
			items="${fns:getDictList('sub_type')}" itemLabel="label"
			itemValue="value" htmlEscape="false" />
		<c:if test="${simulate == 0 }">
	 	<label>类型：</label>
	 	<form:radiobuttons onclick="$('#searchForm').submit();"  path="simulate"
			items="${fns:getDictList('simulate')}" itemLabel="label"
			itemValue="value" htmlEscape="false" />
		</c:if>
		
		
		<input id="paperId" name="paperId" value="${paper.id}"
			style="visibility: hidden;">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
		<input id="pageSize" name="pageSize" type="hidden"
			value="${page.pageSize}" />
	</form:form>
	
	<div style="width: 50%; float: left">
		<table id="contentTable"
			class="table table-striped table-bordered table-condensed">
			<caption align="top">
				<font size="5px">可选题目信息</font>
			</caption>
			<thead>
				<tr>
					<th>序号</th>
					<th>题根</th>
					<th style="display: none;">题目</th>
					<th>试题</th>
					<th >题型</th>
					<th >难易</th>
					<th>类型</th>
					<th>操作</th>
					<th style="display: none;">试卷编号</th>
					<th style="display: none;">题目编号</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${page.list}" var="subject" varStatus="status">

					<tr>
						<td width="15px">${status.count }</td>
						<td align="center" width="40">${subject.subjectRoot.name}</td>
						<td width="300" style="display: none;">${subject.title}</td>
						
						<c:if test="${subject.judge == 2 }">
						<td>${subject.title}<br>
							A.<img style="max-width: 80px;margin: 0px 10px 5px 0px;" src="${subject.a}">
							B.<img style="max-width: 80px;margin: 0px 10px 5px 0px;" src="${subject.b}"><br>
							C.<img style="max-width: 80px;margin: 0px 10px 5px 0px;" src="${subject.c}">
							D.<img style="max-width: 80px;margin: 0px 10px 5px 0px;" src="${subject.d}">
						</td></c:if>
						<c:if test="${subject.judge != 2 }">
							<td>${subject.title}<c:if test="${not empty subject.a}">
									<br>A.${subject.a}</c:if> <c:if test="${not empty subject.b}">
									<br>B.${subject.b}</c:if> <c:if test="${not empty subject.c}">
									<br>C.${subject.c}</c:if> <c:if test="${not empty subject.d}">
									<br>D.${subject.d}</c:if> <c:if test="${not empty subject.e}">
									<br>E.${subject.e}</c:if> <c:if test="${not empty subject.f}">
									<br>F.${subject.f}</c:if> <c:if test="${not empty subject.g}">
									<br>G.${subject.g}</c:if></td>
						</c:if>
						<td >${fns:getDictLabel(subject.type, 'sub_type', '单选题')}</td>
						<td >${fns:getDictLabel(subject.complexity, 'sub_complexity', '易')}</td>
						<td>${fns:getDictLabel(subject.simulate, 'simulate', '考试')}</td>
						<td align="center"><input type="button" value="添加"
							class="btn btn-primary" onclick="addSub(this)"></td>
						<td style="display: none;">${paper.id }</td>
						<td style="display: none;">${subject.id}</td>
					</tr>

				</c:forEach>
			</tbody>
		</table>
		<div class="pagination">${page}</div>

	</div>
	<div style="float: right; width: 45%">
		<table id="addTable"
			class="table table-striped table-bordered table-condensed">
			<caption align="top">
				<font size="5px">已添加题目信息预览</font>
			</caption>
			<thead>
				<tr>
					<th style="display: none;" id="pid">试卷id</th>
					<th style="display: none;" id="sid">试题id</th>
					<th>题目</th>
					<th>题型</th>
					<th>难易</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${paper.subList }" var="subject"
					varStatus="status">
					<tr>
						<td style="display: none;">${paper.id}</td>
						<td style="display: none;">${subject.id }</td>
						<td>${subject.title }</td>
						<td>${fns:getDictLabel(subject.type, 'sub_type', '单选题')}</td>
						<td>${fns:getDictLabel(subject.complexity, 'sub_complexity', '易')}</td>
						<td><input type="button" class="btn btn-primary"
							onclick="dltSub('${paper.id}','${subject.id}','${subject.type }',this)"
							value="删除"></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</body>
</html>