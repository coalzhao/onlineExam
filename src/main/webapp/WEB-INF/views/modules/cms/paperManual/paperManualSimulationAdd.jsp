<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>手动添加试卷</title>
<meta name="decorator" content="default" />
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/cms/paper/manual/goManualSimulation">手动组卷</a></li>
		<li><a href="${ctx}/cms/paper/manual/selectListPaperSimulation">试卷列表</a></li>
	</ul>
	<form:form id="inputForm" modelAttribute="paper"
		action="${ctx}/cms/paper/manual/addPaper" method="post"
		class="form-horizontal">
		<form:hidden path="id" />


		<div id="div1" class="control-group">
			<div style="float: left;">
				<label class="control-label">试卷名称:</label>
				<div class="controls">
					<form:input id="input1" path="paperName" htmlEscape="false"
						maxlength="200" class="input-xxlarge measure-input required" />
				</div>
			</div>
			<div style="float: left;">
				<label class="control-label">试卷内型:</label>
				<div class="controls">
					<!-- <input type=radio name="simulate"  checked="checked" value="0">考试 -->
					 <input type=radio name="simulate" value="1" checked="checked">模拟
				</div>
			</div>
		</div>

		<div class="control-group">
			<div style="float: left; width: 480px">
				<label class="control-label">考试时间:</label>
				<div class="controls">
					<input id="beginTime" name="beginTime" type="text"
						readonly="readonly" maxlength="20" class="input-medium Wdate"
						value="<fmt:formatDate value="${paper.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});" />
				</div>
			</div>
			<div style="float: left;">
				<label class="control-label">时长:</label>
				<div class="controls">
					<input name="paperDuration" type="number" min='0' maxlength="4"
						class="input-xlarge required" style="width: 50px" value="0" /> <label>分钟</label>
				</div>

			</div>
		</div>
		<div class="control-group">
			<div style="float: left;">
				<label class="control-label">试卷总分:</label>
				<div class="controls">
					<form:select path="paperScore">
						<form:option value="100" label="100" />
						<form:option value="120" label="120" />
					</form:select>
				</div>
			</div>
			<div class="" style="float: left;">
				<label class="control-label">单选每题分值:</label>
				<div class="controls">
					<input name="radioScore" type="number" maxlength="4"
						class="input-xlarge required" min="0" style="width: 50px"
						value="0" />
				</div>
			</div>
			<div style="float: left;">
				<label class="control-label">多选每题分值:</label>
				<div class="controls">
					<input name="multipleScore" type="number" maxlength="4"
						class="input-xlarge required" min="0" style="width: 50px"
						value="0" />
				</div>
			</div>
		</div>
		<div id="hiddenBox" style="display: none;"></div>
		<div class="form-actions" style="clear: both;">
			<shiro:hasPermission name="cms:paper:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit"
					value="保存" />&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn btn-primary" type="button"
				value="返 回" onclick="history.go(-1)" />
		</div>
	</form:form>
</body>
</html>