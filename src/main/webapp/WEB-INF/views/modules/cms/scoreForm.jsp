<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>修改成绩</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
	</script>
</head>
<body>
	
	<form:form id="inputForm" modelAttribute="score" action="${ctx}/cms/score/save" method="post" class="form-horizontal">
		 <form:hidden path="id"/> 
		<sys:message content="${message}"/>
		<div class="control-group">
			<div class="control-group">
			<label class="control-label">考试人员:</label>
			<div class="controls">
				<form:input path="user.name" value="${sc.user.name}" htmlEscape="false" maxlength="50" class="required"/>
			</div>
		</div>
		</div>
		<div class="control-group">
			<div class="control-group">
			<label class="control-label">单选成绩:</label>
			<div class="controls">
				<form:input type="number" min="0" max="100" path="sinScore" value="${sc.sinScore}" htmlEscape="false" maxlength="50" class="required"/>
			</div>
		</div>
		</div>
		<div class="control-group">
			<div class="control-group">
			<label class="control-label">多选成绩:</label>
			<div class="controls">
				<form:input type="number" min="0" max="100" path="mulScore" value="${sc.mulScore}" htmlEscape="false" maxlength="50" class="required"/>
			</div>
		</div>
		</div>
		<div class="control-group">
			<div class="control-group">
			<label class="control-label">总成绩:</label>
			<div class="controls">
				<form:input type="number" min="0" max="150" path="sumScore" value="${sc.sumScore}" htmlEscape="false" maxlength="50" class="required"/>
			</div>
		</div>
		</div>
		<div class="form-actions">
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>