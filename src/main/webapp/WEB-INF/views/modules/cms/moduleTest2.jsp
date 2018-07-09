<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>模块管理</title>
<meta name="decorator" content="default" />
<%@include file="/WEB-INF/views/include/treetable.jsp"%>
<script type="text/javascript">
	function aaaa(a){
		$(a).parent("div").prev().show();
		$(a).parent("div").hide();
	}
	function bbbb(b){
		$(b).parent("div").next().show();
		$(b).parent("div").hide();
	}
</script>
<style type="text/css">
p{display:inline;}
</style>
</head>

<body>
<form:form id="inputForm" modelAttribute="moduleAnswer" action="${ctx}/cms/moduleAnswer/saveModuleAnswer" method="post" class="form-horizontal">
<input name="moduleId" type="text" value="${moduleId}"/>
<c:forEach items="${subList}" var="tpl" varStatus="status">
	<div id="li${status.index}" <c:if test='${!status.first}'>style="display:none;"</c:if>>
		${status.index+1}.${tpl.title}<br>
		<input name="moduleSubjectList[${status.index}].userAnswer" type="${tpl.type eq '1'?'radio':'checkbox'}" value="A"/>A.${tpl.a}<br>
		<input name="moduleSubjectList[${status.index}].userAnswer" type="${tpl.type eq '1'?'radio':'checkbox'}" value="B"/>B.${tpl.b}<br>
		<input name="moduleSubjectList[${status.index}].userAnswer" type="${tpl.type eq '1'?'radio':'checkbox'}" value="C"/>C.${tpl.c}<br>
		<input name="moduleSubjectList[${status.index}].userAnswer" type="${tpl.type eq '1'?'radio':'checkbox'}" value="D"/>D.${tpl.d}<br>
		
		<input name="moduleSubjectList[${status.index}].id" type="text" value="${tpl.id}"/>
		
		<c:if test="${!status.first}"><input type="button" value="上一题" onclick="aaaa(this)"/></c:if>&nbsp;&nbsp;
		<c:if test="${!status.last}"><input type="button" value="下一题" onclick="bbbb(this)"/></c:if>
		<c:if test="${status.last}"><input type="submit" value="提交"/></c:if>
	</div>   
</c:forEach>

</form:form>
</body>
</html>