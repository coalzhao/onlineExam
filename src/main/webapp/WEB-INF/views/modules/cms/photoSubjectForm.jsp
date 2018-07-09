<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>试题管理</title>
<meta name="decorator" content="default" />
<script type="text/javascript">
	$(document).ready(function() {
		
	var i = 0;
	var myName = new Array("e", "f", "g");
						$("#inputForm")
								.validate(
										{
											submitHandler : function(form) {
												 if ($("#subjectRootId").val() == "") {
													$("#subjectRootName")
															.focus();
													top.$.jBox.tip('请选择归属题根',
															'warning');
												} else if (CKEDITOR.instances.content
														.getData() == "") {
													top.$.jBox.tip('请填写正文',
															'warning');
												}else if($("#nameImage1").val()==""||$("#nameImage2").val()==""||$("#nameImage3").val()==""||$("#nameImage4").val()==""){
													top.$.jBox.tip('请为选项添加图片','warning');
												}else {
													loading('正在提交，请稍等...');
													form.submit();
												}
											},
											errorContainer : "#messageBox",
											errorPlacement : function(error,
													element) {
												$("#messageBox").text(
														"输入有误，请先更正。");
												if (element.is(":checkbox")
														|| element.is(":radio")
														|| element
																.parent()
																.is(
																		".input-append")) {
													error.appendTo(element
															.parent().parent());
												} else {
													error.insertAfter(element);
												}
											}
										});
						if (i == 0) {
							$('#del').prop("disabled", true);
						}
						info();//正确选项显示
					});
	$(function() {
		$("input[name='type']").click(function() {
			if ($(this).val() == "1") {
				$("input[name='correct']").prop("type", "radio");
			} else {
				$("input[name='correct']").prop("type", "checkbox");
			}
		});

	});
	function info() {
		var a = $("#userAnswer").val();
		var b = [];
		var b = a.split(",");
		$("input[name='correct']").each(function() {
			if ($(this).val() == b[0]) {
				$(this).prop("checked", true);
			}
			if ($(this).val() == b[1]) {
				$(this).prop("checked", true);
			}
			if ($(this).val() == b[2]) {
				$(this).prop("checked", true);
			}
			if ($(this).val() == b[3]) {
				$(this).prop("checked", true);
			}
		});
	}
	function judge1() {
		$("#judge").val("1")
	}
	function judge2() {
		$("#judge").val("2")
	}
	function addDiv() {
		if (i < 3) {
			var j = i + 1;
			$("#" + i)
					.after(
							"<div id="+j+"><label class='control-label'>选项"
									+ myName[i].toUpperCase()
									+ ":</label><div class='controls'><input name='"+myName[i]+"' type='text' class='input-xlarge'/></div></div>");
			i++;
			$('#del').prop("disabled", false);
		}
		if (i == 3) {
			$('#add').prop("disabled", true);
		}
	}
	function delDiv() {
		if (i > 0) {
			$("#" + i).remove();
			i--;
		}
		if (i <= 2) {
			$('#add').prop("disabled", false);
		}
		if (i == 0) {
			$('#del').prop("disabled", true);
		}
	}
	$("#btnSub").click(function() {
		$(this).val("1")
	});
</script>
</head>
<body>

	<ul class="nav nav-tabs">
		<li><a
			href="${ctx}/cms/subject/?subjectRoot.id=">试题列表</a></li>
		
		<li ><a
			href="<c:url value='${fns:getAdminPath()}/cms/subject/form?id=${not empty subject.id?"":subject.id}&subjectRoot.id=${not empty subject.id?"":subject.subjectRoot.id}'><c:param name='subjectRoot.name' value='${subject.subjectRoot.name}'/></c:url>">文本试题<shiro:hasPermission
					name="cms:subject:edit">${not empty subject.id?'修改':'添加'}</shiro:hasPermission></a></li>
		<li class="active"><a
			href="<c:url value='${fns:getAdminPath()}/cms/subject/photoForm?id=${subject.id}&subjectRoot.id=${subject.subjectRoot.id}'><c:param name='subjectRoot.name' value='${subject.subjectRoot.name}'/></c:url>">图片试题<shiro:hasPermission
					name="cms:subject:edit">${not empty subject.id?'修改':'添加'}</shiro:hasPermission></a></li>
	</ul>
	<br />
	<input id="userAnswer" type="hidden" value="${subject.correct}" />
	<form:form id="inputForm" modelAttribute="subject"
		action="${ctx}/cms/subject/save" method="post" class="form-horizontal">
		<form:hidden path="id" />
		<sys:message content="${message}" />
		<input id="judge" name="judge" type="hidden" value="2" />
		<div class="control-group">
			<label class="control-label">归属题根:</label>
			<div class="controls">
				<sys:treeselect id="subjectRoot" name="subjectRoot.id"
					value="${subject.subjectRoot.id}" labelName="subjectRoot.name"
					labelValue="${subject.subjectRoot.name}" title="题根"
					url="/cms/subjectRoot/treeData" module="subject"
					notAllowSelectRoot="true" notAllowSelectParent="false" />
				&nbsp;
			</div>
		</div>
		<shiro:hasPermission name="cms:subject:edit">
			<div class="control-group">
				<label class="control-label">题型:</label>
				<div class="controls">
					<form:radiobuttons path="type"
						items="${fns:getDictList('sub_type')}" itemLabel="label"
						itemValue="value" htmlEscape="false" class="required" />
					<span class="help-inline"></span>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">分类:</label>
				<div class="controls">
					<form:select onchange="$('#searchForm').submit();" path="simulate"
						items="${fns:getDictList('simulate')}" itemLabel="label"
						itemValue="value" htmlEscape="false" />
					<span class="help-inline"></span>
				</div>
			</div>
		</shiro:hasPermission>
		<div class="control-group">
			<label class="control-label">题目:</label>
			<div id="div1" class="controls">
				<form:textarea id="content" htmlEscape="true" path="title" rows="4"
					maxlength="200" class="input-xxlarge" />
				<sys:ckeditor replace="content" uploadPath="/cms/subject" />
			</div>
		</div>
		<div class="control-group">
		 <label class="control-label">选项A:</label>
				<div class="controls">
					<form:hidden id="nameImage1" path="a" htmlEscape="false"
						maxlength="255" class="input-xlarge required" />
					<sys:ckfinder input="nameImage1" type="images" uploadPath="/photo"
						selectMultiple="false" maxWidth="100" maxHeight="100" />
				</div>
				<label class="control-label">选项B:</label>
				<div class="controls">
					<form:hidden id="nameImage2" path="b" htmlEscape="false"
						maxlength="255" class="input-xlarge required" />
					<sys:ckfinder input="nameImage2" type="images" uploadPath="/photo"
						selectMultiple="false" maxWidth="100" maxHeight="100" />
				</div>
				<label class="control-label">选项C:</label>
				<div class="controls">
					<form:hidden id="nameImage3" path="c" htmlEscape="false"
						maxlength="255" class="input-xlarge required" />
					<sys:ckfinder input="nameImage3" type="images" uploadPath="/photo"
						selectMultiple="false" maxWidth="100" maxHeight="100" />
				</div>
				<label class="control-label">选项D:</label>
				<div class="controls">
					<form:hidden id="nameImage4" path="d" htmlEscape="false"
						maxlength="255" class="input-xlarge required" />
					<sys:ckfinder input="nameImage4" type="images" uploadPath="/photo"
						selectMultiple="false" maxWidth="100" maxHeight="100" />
				</div> 
		</div>
		<shiro:hasPermission name="cms:subject:edit">
			<div class="control-group">
				<label class="control-label">解析:</label>
				<div class="controls">
					<form:textarea path="remarks" htmlEscape="false" rows="6"
						class="input-xxlarge" />
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">正确选项:</label>
				<div class="controls">
					<c:if test="${subject.type ne '2' }">
						<input type="radio" name="correct" value="A" required/>A&nbsp; <input
							type="radio" name="correct" value="B" />B&nbsp; <input
							type="radio" name="correct" value="C" />C&nbsp; <input
							type="radio" name="correct" value="D" />D
				</c:if>
					<c:if test="${subject.type eq '2' }">
						<input type="checkbox" name="correct" value="A" required/>A&nbsp; <input
							type="checkbox" name="correct" value="B" />B&nbsp; <input
							type="checkbox" name="correct" value="C" />C&nbsp; <input
							type="checkbox" name="correct" value="D" />D
				</c:if>
				</div>
			</div>
		</shiro:hasPermission>
		<shiro:hasPermission name="cms:subject:edit">
			<div class="control-group">
				<label class="control-label">难易程度:</label>
				<div class="controls">
					<form:radiobuttons path="complexity"
						items="${fns:getDictList('sub_complexity')}" itemLabel="label"
						itemValue="value" htmlEscape="false" class="required" />
					<span class="help-inline"></span>
				</div>
			</div>
		</shiro:hasPermission>
		<div class="form-actions">
			<shiro:hasPermission name="cms:subject:edit">
				<button id="btnSub" name="btn" class="btn btn-primary" type="submit"
					value="">保&nbsp;存</button>&nbsp;
				<c:if test="${empty subject.id}"><button class="btn btn-primary" type="submit" value="">保&nbsp;存&下一题</button>&nbsp;</c:if>
			</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回"
				onclick="history.go(-1)" />
		</div>
	</form:form>
</body>
</html>