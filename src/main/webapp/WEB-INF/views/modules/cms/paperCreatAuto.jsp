<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>试卷管理</title>
<meta name="decorator" content="default" />
<%@include file="/WEB-INF/views/include/treeview.jsp"%>
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
<script type="text/javascript">
	var key, lastValue = "", nodeList = [];
	var num=0;
	$(document).ready(function() {
        if($("#link").val()){
            $('#linkBody').show();
            $('#url').attr("checked", true);
        }
		$("#title").focus();
		$("#inputForm").validate({
			submitHandler: function(form){
				var n1=parseInt($("#ds").text());
				var n2=parseInt($("#dds").text());
				var n=parseInt($("#ps").val());
				if((n1+n2)<n){
					top.$.jBox.tip('低于总分','warning');
				}else if((n1+n2)>n){
					top.$.jBox.tip('超出总分','warning');
				}else{
					top.$.jBox.tip('组卷成功','success');
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
	$(document).ready(function(){
		var setting = {
				check: {
					enable: true
				},
				data: {
					simpleData: {
						enable: true
					}
				},
				callback: {
					onCheck: zTreeOnCheck
				}
			};
		
		// 用户-菜单
		var zNodes=[
				<c:forEach items="${subjectRootList}" var="srl">{id:"${srl.id}", pId:"${not empty srl.parent.id?srl.parent.id:0}", name:"${not empty srl.parent.id?srl.name:'权限列表'}"},
	            </c:forEach>];
		// 初始化树结构
		var tree = $.fn.zTree.init($("#tree"), setting, zNodes);
		// 不选择父节点
		tree.setting.check.chkboxType = { "Y" : "ps", "N" : "s" };
		// 默认选择节点
/* 		var ids = "${role.menuIds}".split(",");
		for(var i=0; i<ids.length; i++) {
			var node = tree.getNodeByParam("id", ids[i]);
			try{tree.checkNode(node, true, false);}catch(e){}
		} */
		// 默认展开全部节点
		tree.expandAll(true);
	});

		function zTreeOnCheck(event, treeId, treeNode) {
			if(treeNode.isParent) {
				$.each(treeNode.children, function(index, value) {
					if(treeNode.checked) {
						$.ajax({
							type:"GET",
							url:"${ctx}/cms/paper/getNumber",
							data:"id="+value.id,
							success:function(data){
								appendHidden(value.name,value.id,data);
							}
						});
					} else {
						removeHidden(value.id);
					}
				});
			} else {
				if(treeNode.checked) {
					$.ajax({
						type:"GET",
						url:"${ctx}/cms/paper/getNumber",
						data:"id="+treeNode.id,
						success:function(data){
							appendHidden(treeNode.name,treeNode.id,data);
						}
					});
				} else {
					removeHidden(treeNode.id);
				}
			}
		};
		function appendHidden(name,id,data) {
			var hiddenString = "<input type='text' name='subRootList["+num+"].id' value='" + id + "'/>";
			var str = "<tr id='"+id+"'><td>"+name+"</td><td><input name='subRootList["+num+"].easyRadio' type='number' min='0' max="+data[0]+" maxlength='4'class='input-xlarge required' style='width: 50px' value='0' onchange='radioTotal(this)' />&nbsp&nbsp总数:"+data[0]+"</td><td><input name='subRootList["+num+"].hardRadio' type='number' min='0' max="+data[1]+" maxlength='4'class='input-xlarge required' style='width: 50px' value='0' onchange='radioTotal(this)'/>&nbsp&nbsp总数:"+data[1]+"</td><td><input name='subRootList["+num+"].easyMultiple' type='number' min='0' max="+data[2]+" maxlength='4'class='input-xlarge required' style='width: 50px' value='0' onchange='multipleTotal(this)'/>&nbsp&nbsp总数:"+data[2]+"</td><td><input name='subRootList["+num+"].hardMultiple' type='number' min='0' max="+data[3]+" maxlength='4'class='input-xlarge required' style='width: 50px' value='0' onchange='multipleTotal(this)'/>&nbsp&nbsp总数:"+data[3]+"</td></tr>"
			$("#hiddenBox").append(hiddenString);
			$("#box").append(str);
			num++;
		}
		function total(){
			var n1=parseInt($("#ds").text());
			var n2=parseInt($("#dds").text());
			$("#ps").val(n1+n2);
		}
		
		function radioTotal(t){
			var num=0;
			$("#box tr").each(function(){
				$(this).find("td:eq(1) input").each(function(){
					num+=parseInt($(this).val());
				});
				$(this).find("td:eq(2) input").each(function(){
					num+=parseInt($(this).val());
				});
			});
			if(!(isNaN(num))){
			$("#d").text(num);
			$("#radioNumber").val(num);
			$("#ds").text(num*$("#d-s").val());
			total();
			}
		}
		
		function multipleTotal(t){
			var num=0;
			$("#box tr").each(function(){
				$(this).find("td:eq(3) input").each(function(){
					num+=parseInt($(this).val());
				});
				$(this).find("td:eq(4) input").each(function(){
					num+=parseInt($(this).val());
				});
			});
			if(!(isNaN(num))){
			$("#dd").text(num);
			$("#multipleNumber").val(num);
			$("#dds").text(num*$("#dd-s").val());
			total();
			}
		}
		function removeHidden(id) {
			$("#hiddenBox>input").each(function(index, element) {
				if($(this).val() == id) {
					$(this).remove();
				}
			});
			$("#box>tr").each(function(index, element) {
				if($(this).attr("id") == id) {
					$(this).remove();
				}
			});
			num--;
		}
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a
			href="<c:url value='${fns:getAdminPath()}/cms/paper/form'></c:url>">自动组卷</a></li>
		<%-- <li><a href="${ctx}/cms/paper/edit?id=${paper.id}">试卷预览</a></li> --%>
	</ul>
	<br />
	<form:form id="inputForm" modelAttribute="paper"
		action="${ctx}/cms/paper/creat" method="post" class="form-horizontal">
		<form:hidden path="id" />
		
		<input type="hidden" value="0" name="simulate"/>
		<input id="radioNumber" type="hidden" value="0" name="radioNumber"/>
		<input id="multipleNumber" type="hidden" value="0" name="multipleNumber"/>
		<div id="div1" class="control-group">
			<label class="control-label">试卷名称:</label>
			<div class="controls">
				<form:input id="input1" path="paperName"  onblur="aaa();" htmlEscape="false" maxlength="200"
					class="input-xxlarge measure-input required" />
			</div>
		</div>
		<div class="control-group">
			<div style="float: left; width: 500px">
				<label class="control-label">考试时间:</label>
				<div class="controls">
					<input id="beginTime" name="beginTime" type="text"
						readonly="readonly" maxlength="20" class="input-medium Wdate required"
						value="<fmt:formatDate value="${paper.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});" />
				</div>
			</div>
			<div style="float: left;">
				<label class="control-label">时长(分钟):</label>
				<div class="controls">
					<input name="paperDuration" type="number" min='0' maxlength="4"
						class="input-xlarge required" style="width: 50px" value="0"/>
				</div>
			</div>
		</div>
		<div class="control-group">
			<div style="float: left;">
				<label class="control-label">试卷总分:</label>
				<div class="controls">
				<input id="ps" type="text" name="paperScore" value="0" style="width: 45px" readonly unselectable="on" onfocus="this.blur()"/>
					<%-- <form:select id="ps" path="paperScore">
						<form:option value="100" label="100" />
						<form:option value="120" label="120" />
					</form:select> --%>
				</div>
			</div>
			<div style="float: left;width: 330px">
				<label class="control-label">单选每题分值:</label>
				<div class="controls">
					<input id="d-s" name="radioScore" type="number" maxlength="4" onchange="radioTotal(this)"
						class="input-xlarge required" min="0" style="width: 50px" value="0"/>
				</div>
			</div>
			<div style="float: left; margin-left: -70px">
				<label class="control-label">多选每题分值:</label>
				<div class="controls">
					<input id="dd-s" name="multipleScore" type="number" maxlength="4" onchange="multipleTotal(this)"
						class="input-xlarge required" min="0" style="width: 50px" value="0"/>
				</div>
			</div>
		</div>
<!-- 		<div class="control-group">
			<label class="control-label">生成试卷数量:</label>
			<div class="controls">
				<select name="paperNumber">
					<option value="1" >1张</option>
					<option value="2" >2张</option>
					<option value="2" >3张</option>
				</select>
			</div>
		</div> -->
		<%-- 		<div id="div1" class="control-group">
			<label class="control-label">试卷模版:</label>
			<div class="controls">
				<form:textarea path="title" htmlEscape="false" rows="4"
					maxlength="200" class="input-xxlarge required" />
			</div>
		</div> --%>
		<div class="control-group">
			<label class="control-label">请选择题根:</label>
			<div class="controls"style=" width: 200px;height:300px; border:1px solid #EEEEEE;OVERFLOW-Y: auto; OVERFLOW-X:auto;">
				<div id="tree" class="ztree"></div>
			</div>
			<div style=" margin: -100px 4px 10px 0px; width: 700px; position: relative;top: -200px;left: 420px">
					<shiro:hasPermission name="cms:paper:edit">
						<table id="contentTable"
							class="table table-striped table-bordered table-condensed">
							<thead>
								<tr>
									<th rowspan="3"
										style="vertical-align: middle; text-align: center; width: 170px">题根</th>
									<th colspan="4" style="text-align: center;">题型</th>
								</tr>
								<tr>
									<th colspan="2" style="text-align: center;">单选题&nbsp;&nbsp;已选：<span id="d">0</span>个，共：<span id="ds">0</span>分</th>
									<th colspan="2" style="text-align: center;">多选题&nbsp;&nbsp;已选：<span id="dd">0</span>个，共：<span id="dds">0</span>分</th>
								</tr>
								<tr>
									<th>易题数量:</th>
									<th>难题数量:</th>
									<th>易题数量:</th>
									<th>难题数量:</th>
								</tr>
							</thead>
							<tbody id="box"></tbody>
						</table>
					</shiro:hasPermission>
				</div>
		</div>
		<div id="hiddenBox" style="display: none;"></div>
		<div class="form-actions" style="clear: both;">
			<shiro:hasPermission name="cms:paper:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit"
					value="保 存" />&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回"
				onclick="history.go(-1)" />
		</div>
	</form:form>
</body>
</html>