<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>手动添加试卷</title>
<meta name="decorator" content="default" />
<script type="text/javascript">
	
	$(function(){
		$("#inputForm").validate({
			rules:{
                beginTime:{
                	required:true
                }
			}
		})
	});

</script>
<script type="text/javascript">
 function aaa(){
			var paperName = document.getElementById("input1").value
			/* alert(paperName); */
			 $.ajax({
			 		url:"${ctx}/cms/paper/isExist",
			 		data:{"paperName":paperName},
			 		datatype:"json",
			 		type:"POST",
			 		success:function(msg){
			 			if(msg.id=='yes'){
			 				alert("该试卷名称已存在");
			 				}else{
			 					
			 				
			 				}		 				
			 			
			 			}
			 		
			 		});
		 
			 }
	
	
/*  alert("大家好"); */
 </script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/cms/paper/manual/goManual?simulate=${simulate}">手动组卷</a></li>
		<li><a href="${ctx}/cms/paper/manual/selectListPaper?simulate=${simulate}">试卷列表</a></li>
	</ul>
	<form:form id="inputForm" modelAttribute="paper"
		action="${ctx}/cms/paper/manual/addPaper" method="post"
		class="form-horizontal">
		<form:hidden path="id" />
		<div id="div1" class="control-group">
			<div style="float: left;">
				<label class="control-label">试卷名称:</label>
				<div class="controls">
					<form:input id="input1" path="paperName"  onblur="aaa()" htmlEscape="false" name="paperName"
						maxlength="200" class="input-xxlarge measure-input required" />
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
					<input name="paperDuration" type="number" min='1' maxlength="4"
						class="input-xlarge required" style="width: 50px" value="60" /> <label>分钟</label>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div class="" style="float: left;">
				<label class="control-label">单选每题分值:</label>
				<div class="controls">
					<input name="radioScore" type="number" maxlength="4"
						class="input-xlarge required" min="1" style="width: 50px"
						value="1" />
				</div>
			</div>
			<div style="float: left;">
				<label class="control-label">多选每题分值:</label>
				<div class="controls">
					<input name="multipleScore" type="number" maxlength="4"
						class="input-xlarge required" min="1" style="width: 50px"
						value="1" />
				</div>
			</div>
			
			<div style="display: none;">
				<label class="control-label">试卷类型:</label>
				<input type="text" name="simulate" value="${simulate }">
				<%-- <div class="controls">
				 <c:if test="${simulate ==0 }">
						<input type=radio name="simulate" checked="checked" value="0">考试 <input type=radio
						name="simulate" value="1" >模拟
				</c:if>
				<c:if test="${simulate ==1 }">
						<input type=radio name="simulate"  value="0">考试 <input type=radio
						name="simulate" value="1"  checked="checked" >模拟
				</c:if>
				</div> --%>
			</div>
		</div>
		<div id="hiddenBox" style="display: none;"></div>
		<div class="form-actions" style="clear: both;">
			<shiro:hasPermission name="cms:paper:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit"
					value="添加试题" />&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn btn-primary" type="button"
				value="返 回" onclick="history.go(-1)" />
		</div>
	</form:form>
</body>
</html>