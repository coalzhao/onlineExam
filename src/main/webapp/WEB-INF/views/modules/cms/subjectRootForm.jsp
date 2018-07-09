<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>模块管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#inputForm").validate({
				submitHandler: function(form){
					if ($("#moduleName").val()==""){
                        $("#moduleName").focus();
                        top.$.jBox.tip('请填写题根名称','warning');
                    }else{
                        loading('正在提交，请稍等...');
                        form.submit();
                    }
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
/* 		$.fn.editable = function(config) {
			$(this).each(function(i, t) {
				$(t).change(function() {
					var me = $(this);
					me.find('.customval').remove();
					if(-1 == me.val()) {
						var ed = $("<input type=\"text\" class=\"form-control\" />");
						me.after(ed).hide();
						ed.blur(function() {
							var v = ed.val();
							if(null === v || v.length == 0) {
								ed.remove();
								me.val(null).show();
							} else {
								me.prepend("<option value=\"" + v + "\" class=\"customval\" selected>" + v + "</option>").show();
								ed.remove();
							}
						}).focus();
					}
				})
			});
		} */
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/cms/subjectRoot/">查看列表</a></li>
		<li><a href="${ctx}/cms/subjectRoot/moduleForm">模块添加</a></li>
		<li class="active"><a href="${ctx}/cms/subjectRoot/form?id=${subjectRoot.id}&parent.id=${subjectRoot.parent.id}">题根<shiro:hasPermission name="cms:subjectRoot:edit">${not empty subjectRoot.id?'修改':'添加'}</shiro:hasPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="subjectRoot" action="${ctx}/cms/subjectRoot/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
<!-- 		<div class="control-group">
			<label class="control-label">模块:</label>
			<div class="controls">
				<select name="select1" id="select1" class="editable" style="height: 27px;width:200px">
					<option value="0">Item1</option>
					<option value="1" selected="selected">Item2</option>
					<option value="-1">Others</option>
				</select>
			</div>
		</div> -->
		<div class="control-group">
			<label class="control-label">所属模块:</label>
			<div class="controls">
				<select name="parent.id" class="editable" style="height: 30px;width:200px">
					<c:forEach items="${rootList}" var="root">
						<option value="${root.id}" <c:if test="${subjectRoot.parent.id eq root.id}">selected="selected"</c:if>>${root.name}</option>
					</c:forEach>
				</select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">题根名称:</label>
			<div class="controls">
				<form:input path="name" htmlEscape="false" maxlength="50" class="required"/>
			</div>
		</div>
 		<div class="control-group">
			<label class="control-label">备注:</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="200" class="input-xxlarge"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">关键字:</label>
			<div class="controls">
				<form:input path="keywords" htmlEscape="false" maxlength="200"/>
				<span class="help-inline">填写描述及关键字，有助于搜索引擎优化</span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">排序:</label>
			<div class="controls">
				<form:input path="sort" htmlEscape="false" maxlength="11" class="required digits"/>
				<span class="help-inline">排列次序</span>
			</div>
		</div>
<%-- 		<div class="control-group">
			<label class="control-label">在导航中显示:</label>
			<div class="controls">
				<form:radiobuttons path="inMenu" items="${fns:getDictList('show_hide')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
				<span class="help-inline">是否在导航中显示该栏目</span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">在分类页中显示列表:</label>
			<div class="controls">
				<form:radiobuttons path="inList" items="${fns:getDictList('show_hide')}" itemLabel="label" itemValue="value" htmlEscape="false" class="required"/>
				<span class="help-inline">是否在分类页中显示该栏目的文章列表</span>
			</div>
		</div> --%>
		<div class="form-actions">
			<shiro:hasPermission name="cms:subjectRoot:edit"><input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>