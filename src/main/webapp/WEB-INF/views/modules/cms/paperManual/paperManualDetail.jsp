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
		<li class="active"><a href="#">试卷详情</a></li>
		<li><a
			href="${ctx}/cms/paper/manual/goPaperManualSubAdd?paperId=${paper.id}">试题增删</a></li>
		<li><a
			href="${ctx}/cms/paper/manual/selectListPaper?simulate=${simulate}">试卷列表</a></li>
	</ul>
	<form id="publishFrom" class="breadcrumb form-search"
		action="${ctx}/cms/paper/manual/paperScoreUpdate">
		<input type="text" style="display: none;" value="${paper.id }" name="id"> 
		<label class="control-label" >考试时间:</label>
		<input id="beginTime" name="beginTime" type="text"
				readonly="readonly" maxlength="20" class="input-medium Wdate"
				value="<fmt:formatDate value="${paper.beginTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
				onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});" />
		<label class="control-label">时长:</label>
		<input name="paperDuration" type="number" min='1' maxlength="4"
			   class="input-xlarge required" style="width: 50px" value="${paper.paperDuration }" /> <label>分钟</label>
		<hr>
		<label>单选个数：</label> <input type="text" readonly="readonly" value="${paper.radioNumber }"
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
		<form>
			<table id="contentTable"
				class="table table-striped table-bordered table-condensed">
				<thead>
					<tr>
						<th>序号</th>
						<th>题根</th>
						<th>题目</th>
						<th>答案及解析</th>
						<th>题型</th>
						<th>难易程度</th>
						<th>操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${paper.subList}" var="subject"
						varStatus="status">
						<tr>
							<td align="center" width="40">${status.count}</td>
							<td align="center" width="40">${subject.subjectRoot.name }</td>
							<td width="300">${subject.title}<c:if
									test="${subject.judge == 2 }">
									<td>${subject.title}<br> A.<img
										style="max-width: 80px; margin: 0px 10px 5px 0px;"
										src="${subject.a}"> B.<img
										style="max-width: 80px; margin: 0px 10px 5px 0px;"
										src="${subject.b}"><br> C.<img
										style="max-width: 80px; margin: 0px 10px 5px 0px;"
										src="${subject.c}"> D.<img
										style="max-width: 80px; margin: 0px 10px 5px 0px;"
										src="${subject.d}">
									</td>
								</c:if> <c:if test="${subject.judge != 2 }">
									<td>${subject.title}<c:if test="${not empty subject.a}">
											<br>A.${subject.a}</c:if> <c:if test="${not empty subject.b}">
											<br>B.${subject.b}</c:if> <c:if test="${not empty subject.c}">
											<br>C.${subject.c}</c:if> <c:if test="${not empty subject.d}">
											<br>D.${subject.d}</c:if> <c:if test="${not empty subject.e}">
											<br>E.${subject.e}</c:if> <c:if test="${not empty subject.f}">
											<br>F.${subject.f}</c:if> <c:if test="${not empty subject.g}">
											<br>G.${subject.g}</c:if></td>
								</c:if>
							</td>
							<td>${subject.correct}<br />解析：${subject.remarks}
							</td>
							<td>${fns:getDictLabel(subject.type, 'sub_type', '单选题')}</td>
							<td>${fns:getDictLabel(subject.complexity, 'sub_complexity', '易')}</td>
							<td><input type="button" class="btn btn-primary"
								onclick="dltSub('${paper.id }','${subject.id}','${subject.type }',this)"
								value="删除"></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<div class="pagination">${page}</div>
</body>
</html>