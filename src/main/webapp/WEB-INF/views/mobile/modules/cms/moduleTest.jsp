<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
</style>
 <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no">
 <script type="text/javascript" src="${ctxStatic}/jquery/jquery-1.8.3.min.js"></script> 
 <script type="text/javascript" sr="${ctxStatic}/bootstrap4/js/bootstrap.min.js"></script>  
   <link rel="stylesheet" href="${ctxStatic}/bootstrap4/css/bootstrap.min.css">


    <meta charset="utf-8">
<script type="text/javascript">

	function aaaa(a){
	
		$(a).parent().parent().parent().parent().prev().show();
	/* 	alert("下一题11"); */
		$(a).parent().parent().parent().parent().hide();
		/* alert("下一题22"); */
	}
	function bbbb(b){
	/* alert("上一题"); */
		$(b).parent().parent().parent().parent().next().show();
		$(b).parent().parent().parent().parent().hide();
		
	}
	
	$(document).ready(function(){
		$(".flip").click(function(){
		    $(this).next().slideToggle("fast");
		  });
		});
	</script>


<style type="text/css"> 
p{display:inline;}
div.panel,p.flip
{
margin:0px;
padding:10px;
text-align:center;
line-height:50px;
color:white;
background:#5FB760;
/* border:solid 1px #c3c3c3; */
border-radius:4px;
}
div.panel
{
height:120px;
display:none;
background:#CDCDB4;
}
</style>
</head>
  <body>
<header  style="background:#121212; color:#FFF ;height:50px">
 <h6 style="text-align:center ;line-height:50px">模块练习</span></h6>  
 
 </header>

 
	
   
        <form:form id="inputForm" modelAttribute="moduleAnswer" action="${ctx}/cms/moduleAnswer/saveModuleAnswer" method="post" class="form-horizontal">
	<input name="moduleId" type="hidden" value="${moduleId}"/>
<c:forEach items="${subList}" var="tpl" varStatus="status">
	<table class="table" id="${status.index+1}"  <c:if test='${!status.first}'>style="display:none;"</c:if>>
  <tbody >
     <tr>
     <td>
		${status.index+1}.${tpl.title}
		</td></tr>
	 <tr>
     <td>
  <input name="moduleSubjectList[${status.index}].userAnswer" type="${tpl.type eq '1'?'radio':'checkbox'}" value="A"/> 
  A.<c:if test="${tpl.judge.equals('1')}"><span id="a">${tpl.a}</span></c:if>
  <c:if test="${tpl.judge.equals('2')}"><img src="${tpl.a}" class="img-responsive"/></c:if>
     </td></tr>
     <tr>
     <td>
 <input name="moduleSubjectList[${status.index}].userAnswer" type="${tpl.type eq '1'?'radio':'checkbox'}" value="B"/> 
  B.<c:if test="${tpl.judge.equals('1')}"><span id="b">${tpl.b}</span></c:if>
  <c:if test="${tpl.judge.equals('2')}"><img src="${tpl.b}" class="img-responsive"/></c:if>		
  </td></tr>
		<tr>
     <td>
 <input name="moduleSubjectList[${status.index}].userAnswer" type="${tpl.type eq '1'?'radio':'checkbox'}" value="C"/> 
  C.<c:if test="${tpl.judge.equals('1')}"><span id="c">${tpl.c}</span></c:if>
  <c:if test="${tpl.judge.equals('2')}"><img src="${tpl.c}" class="img-responsive"/></c:if>		
  </td></tr>
		<tr>
     <td>
 <input name="moduleSubjectList[${status.index}].userAnswer" type="${tpl.type eq '1'?'radio':'checkbox'}" value="D"/> 
  D.<c:if test="${tpl.judge.equals('1')}"><span id="d">${tpl.d}</span></c:if>
  <c:if test="${tpl.judge.equals('2')}"><img src="${tpl.d}" class="img-responsive"/></c:if>		</td></tr>
		
		<input name="moduleSubjectList[${status.index}].id" value="${tpl.id}" type="hidden"/>
		<tr>
     <td>
		<c:if test="${!status.first}"><input type="button" value="上一题" class="btn btn-info btn-lg" style="font-size: 13px ;" onclick="aaaa(this)"/></c:if>&nbsp;&nbsp;
		<c:if test="${!status.last}"><input type="button" value="下一题" class="btn btn-info btn-lg" style="font-size: 13px;" onclick="bbbb(this)"/></c:if>
		<c:if test="${status.last}"><input type="submit" value="提交" class="btn btn-info btn-lg" style="font-size: 13px;" /></c:if>
		</td>
		</tr>
		<tr>
     <td>
     
 <p class="flip">查看解析</p>
 <div class="panel">
<p>${tpl.remarks}</p>

</div>
 
		</td>
		</tr>
		</tbody>	
	 </table>
</c:forEach>

</form:form>


</body>

</html>
