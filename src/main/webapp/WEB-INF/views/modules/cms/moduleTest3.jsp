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
${list}
<form:form id="inputForm" modelAttribute="moduleAnswer" action="${ctx}/cms/moduleAnswer/saveModuleAnswer" method="post" class="form-horizontal">
<input name="moduleId" type="text" value="${moduleId}"/>
<c:forEach items="${list}" var="tpl" varStatus="status">
	<div id="li${status.index}" >
		${status.index+1}.${tpl.title}<br>
		<input name="moduleSubjectList[${status.index}].userAnswer"  value="A"/>A.${tpl.a}<br>
		<input name="moduleSubjectList[${status.index}].userAnswer"  value="B"/>B.${tpl.b}<br>
		<input name="moduleSubjectList[${status.index}].userAnswer"  value="C"/>C.${tpl.c}<br>
		<input name="moduleSubjectList[${status.index}].userAnswer"  value="D"/>D.${tpl.d}<br>
		
		<input name="moduleSubjectList[${status.index}].id" type="text" value="${tpl.id}"/>
		
		<input name="" type="text" value="${tpl.result}"/>
		<input name="" type="text" value="${tpl.userAnswer}"/>
	</div>   
</c:forEach>

</form:form>
</body>
</html>