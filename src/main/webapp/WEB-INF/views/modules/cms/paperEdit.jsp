<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>试卷编辑</title>
<meta name="decorator" content="default" />
<%@include file="/WEB-INF/views/include/treeview.jsp"%>
<script type="text/javascript">
	var key, lastValue = "", nodeList = [];
	var num=0;
	var divId="";
	var type="";
	var i=1;
	var simu="1";
	$(document).ready(function() {
		getSubScore();
		//动态修改题目信息
		$("#r").change(function(){
			getSubScore();
		});
		$("#m").change(function(){
			getSubScore();
		});
		$("#time").change(function(){
			$("#c-time").text(this.value);
		});
		//模态框点击修改执行方法
		$("#alter").click(function () {
			$('#myModal').modal('hide');
			var id=$("input[name='radiobutton']:checked").val();
			var old=$("#oldSubId").val();
			var pid=$("#papid").val();
			var rn=$("#radioNumber").val();
			var mn=$("#multipleNumber").val();
			if(!(typeof(id) == "undefined")){
			$.ajax({
				type:"GET",
				url:"${ctx}/cms/paper/alterSubject",
				traditional:true,
				data:{"paperId":pid,"subId":old,"id":id,"rn":rn,"mn":mn},  
				success:function(data){
					if(data!=null&&data!=""){
						var head="";
						var end="</li>";
						var str="";
						if(type=="1"){//单选
							head="<li id='d"+i+"' class='d subject'>"
						}else{
							head="<li id='dd"+i+"' class='d subject'>"
						}
						if(data.complexity='1'){
							var complexity="易";
						}
						if(data.complexity='2'){
							complexity="难";
						}
						if(data.judge=="1"){//文本
						str=data.title+"<p></p><p style='text-indent: 2em;'>A."+data.a+"</p><p style='text-indent: 2em;'>B."+data.b+"</p><p style='text-indent: 2em;'>C."+data.c+"</p>"+
						"<p style='text-indent: 2em;'>D."+data.d+"</p>"
						}else if(data.judge=="2"){
						str=data.title+"<p></p>A.<img class='option' src="+data.a+">B.<img class='option' src="+data.b+"><br>C.<img class='option' src="+data.c+">D.<img class='option' src="+data.d+">"
						}
						if(data.e!=null){
							str+="<p style='text-indent: 2em;'>E."+data.e+"</p>"
							if(data.f!=null){
								str+="<p style='text-indent: 2em;'>F."+data.f+"</p>"
								if(data.g!=null){
									str+="<p style='text-indent: 2em;'>G."+data.g+"</p>"
								}
							}
						}
						str+="<p align='right'>"+complexity+"&nbsp;&nbsp;&nbsp;&nbsp;<button id="+type+" class='btn alter' data-toggle='modal' data-target='#myModal' value='"+data.id+"'onclick='buttonClick(this)'>修改</button><button id="+data.id+" class='btn delete' onclick='delSub(this)'>删除</button></p>"
						if(old!="nu"){//修改方法
							$("#"+divId).empty();
							$("#"+divId).append(str);
							top.$.jBox.tip('修改成功','success'); 
						}else{//增加方法
							str=head+str+end;
							$("#"+divId).before(str);
							getSubScore();
							top.$.jBox.tip('添加成功','success'); 
						}
					}else{
						top.$.jBox.tip('试题已存在','error');
					}
				}
			});
			}

		});
		
        if($("#link").val()){
            $('#linkBody').show();
            $('#url').attr("checked", true);
        }
		$("#title").focus();
 		$("#inputForm").validate({
			submitHandler: function(form){

				
                if ($("#multipleNumber").val()==""){
                    $("#categoryName").focus();
                    top.$.jBox.tip('请选择归属栏目','warning');
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
	$(document).ready(function(){
		var setting = {
				view: {
					dblClickExpand: false
				},
				data: {
					simpleData: {
						enable: true
					}
				},
				callback: {
					beforeClick: beforeClick,
					onClick: onClick
				}
			};
		
		// 题根
		var zNodes=[
				<c:forEach items="${subjectRootList}" var="srl">{id:"${srl.id}", pId:"${not empty srl.parent.id?srl.parent.id:0}", name:"${not empty srl.parent.id?srl.name:'权限列表'}"},
	            </c:forEach>];
		// 初始化树结构
		var tree = $.fn.zTree.init($("#treeDemo"), setting, zNodes);
		// 默认展开全部节点
		tree.expandAll(true);
	});
	//点击删除执行方法
	function delSub(t) {
    	var pid=$("#papid").val();
		var rn=$("#radioNumber").val();
		var mn=$("#multipleNumber").val();
    	$.ajax({
			type:"GET",
			url:"${ctx}/cms/paper/delSubject",
			traditional:true,
			data:{"paperId":pid,"subId":t.id,"rn":rn,"mn":mn},  
			success:function(data){
				getSubScore();					
				top.$.jBox.tip('删除成功','success');
			}
		});
    	$(t).parent().parent().remove();
    	
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
		function getSubScore() {
			var d=$(".d").length;//单选个数
			$("#c-d").text(d);
			$("#radioNumber").val(d);
			var ds=$("#r").val();//单选每题分数
			$("#d-r").text(ds);
			$("#d-score").text(ds*d);//单选总分
			
			var dd=$(".dd").length;//多选个数
			$("#c-dd").text(dd);
			$("#multipleNumber").val(dd);
			var dds=$("#m").val();//多选每题分数
			$("#dd-m").text(dds);
			$("#dd-score").text(dds*dd);//多选总分
			
			$("#ps").val(ds*d+dds*dd);//总分
			$("#c-score").text(ds*d+dds*dd);//满分
		}
		
		function buttonClick(old) {
			var oldSubId = old.value;
			type=old.id;
			$("#oldSubId").val(oldSubId);
			divId=$(old).parent().parent().attr("id");
			$("#box").empty();
		}	
		
			function beforeClick(treeId, treeNode) {
				var check = (treeNode && !treeNode.isParent);
				if (!check) alert("只能选择题根...");
				return check;
			}
			//显示试题集
			function onClick(e, treeId, treeNode) {
				var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
				nodes = zTree.getSelectedNodes(),
				v = "";
				nodes.sort(function compare(a,b){return a.id-b.id;});
				if (v.length > 0 ) v = v.substring(0, v.length-1);
				$.ajax({
					type:"GET",
					url:"${ctx}/cms/paper/findSubject",
					data:{"rid":treeNode.id,"type":type},
					success:function(data){
						/* appendHidden(treeNode.name,treeNode.id,data); */
						$("#box").empty(); 
						var str="";
						var j=1;
						for(var i=0;i<data.length;i++){
							if(simu==data[i].simulate){
							if(data[i].complexity=='1'){
								str="易";
							}
							if(data[i].complexity=='2'){
								str="难";
							}
							if(data[i].judge=="1"){//文本选项
								var str = "<tr><td align='center'>"+(j++)+"</td><td>"+data[i].title+
								"A."+data[i].a+"<br>B."+data[i].b+"<br>C."+data[i].c+"<br>D."+data[i].b+"<td>"+str+"</td><td><input type='radio' name='radiobutton' value="+data[i].id+" ></td>"
							}
							if(data[i].judge=="2"){//图片选项
								var str = "<tr><td align='center'>"+(j++)+"</td><td>"+data[i].title+
								"A.<img class='option2' src="+data[i].a+">B.<img class='option2' src="+data[i].b+"><br>C.<img class='option2' src="+data[i].c+">D.<img class='option2' src="+data[i].d+"><td>"+str+"</td><td><input type='radio' name='radiobutton' value="+data[i].id+" ></td>"
							}
							$("#box").append(str);
							}
						} 
					}
				});
			}
			function onBodyDown(event) {
				if (!(event.target.id == "menuBtn" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
					hideMenu();
				}
			}
		function getSimu(t){
			simu=t.value;
			$("#box").empty(); 
		}
		function formSubmit() {
			$("#inputForm").submit();
		}
		
	</script>
	<style type="text/css">
	.subject
	{
	font-size: 17px; 
	width: 700px; 
	padding: 10px 10px 0px 10px; 
	margin: 20px 0px 20px 50px; 
	border: 1px solid #aeaeae; 
	border-radius: 10px; 
	box-shadow: 5px 5px 15px #999999;
	}
	.option
	{
	max-width: 250px;
	margin: 0px 30px 10px 0px;
	}
	.option2
	{
	max-width: 50px;
	margin: 0px 30px 10px 0px;
	}
	</style>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/cms/paper/${paper.simulate eq '0'?'list':'simuList'}">试卷列表</a></li>
		<li class="active"><a href="${ctx}/cms/paper/edit?id=${paper.id}">试卷编辑</a></li>
	</ul>
	<br />
	<div class="form-horizontal">
		<form:form id="inputForm" modelAttribute="paper"
			action="${ctx}/cms/paper/save" method="post" class="form-horizontal">
			<form:hidden path="id" />
			<input type="hidden" value="${paper.simulate}" name="simulate" />
			<input id="radioNumber" type="hidden" value="${paper.radioNumber}" name="radioNumber" />
			<input id="multipleNumber" type="hidden" value="${paper.multipleNumber}"
				name="multipleNumber" />
			<div id="div1" class="control-group">
				<label class="control-label">试卷名称:</label>
				<div class="controls">
					<form:input id="input1" path="paperName" htmlEscape="false"
						maxlength="200" class="input-xxlarge measure-input required" />
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
					<label class="control-label">时长:(分钟)</label>
					<div class="controls">
						<input id="time" name="paperDuration" type="number" min='0'
							maxlength="4" class="input-xlarge required" style="width: 50px"
							value="${paper.paperDuration}" />
					</div>
				</div>
			</div>
			<div class="control-group">
				<div style="float: left;">
					<label class="control-label">试卷总分:</label>
					<div class="controls">
					<input id="ps" type="text" name="paperScore" value="0" style="width: 45px" readonly unselectable="on" onfocus="this.blur()"/>
<%-- 						<form:select id="score" path="paperScore">
							<form:option value="100" label="100" />
							<form:option value="120" label="120" />
						</form:select> --%>
					</div>
				</div>
				<div style="float: left;">
					<label class="control-label">单选每题分值:</label>
					<div class="controls">
						<input id="r" name="radioScore" type="number"
							class="input-xlarge required" min="0" style="width: 50px"
							value="${paper.radioScore}" />
					</div>
				</div>
				<div style="float: left;">
					<label class="control-label">多选每题分值:</label>
					<div class="controls">
						<input id="m" name="multipleScore" type="number" maxlength="4"
							class="input-xlarge required" min="0" style="width: 50px"
							value="${paper.multipleScore}" />
					</div>
				</div>
			</div>
		</form:form>
		<div class="control-group">
			<div class="controls"
				style="text-align: center; padding: 0px; font-size: 30px; width: 800px; height: 70px;">
				<br>${paper.paperName}<input id="papid" type="hidden"
					value="${paper.id}" />
				<div style="text-align: right; font-size: 15px;">
					考试时长:<span id="c-time">${paper.paperDuration}</span>分钟&nbsp;&nbsp;&nbsp;&nbsp;满分:<span
						id="c-score">${paper.paperScore}</span>分
				</div>
			</div>
			<div class="controls " style="font-size: 20px;">
				一、单选题(<span id="c-d"></span>小题，每题<span id="d-r"></span>分，共计<span
					id="d-score"></span>分)
			</div>
			<ol type="1" class="controls">
				<c:forEach items="${paper.subList}" var="subject" varStatus="status">
					<c:if test="${subject.type eq '1'}">
						<li id="d${status.index+1}" class="d subject">
							${subject.title}
							<p></p>
							<c:if test="${subject.judge eq '2'}">
								A.<img class="option" src="${subject.a}">
								B.<img class="option" src="${subject.b}"><br>
								C.<img class="option" src="${subject.c}">
								D.<img class="option" src="${subject.d}">
							</c:if>
							<c:if test="${subject.judge eq '1'}">
								<p style="text-indent: 2em;">A.${subject.a}</p>
								<p style="text-indent: 2em;">B.${subject.b}</p>
								<p style="text-indent: 2em;">C.${subject.c}</p>
								<p style="text-indent: 2em;">D.${subject.d}</p>
							</c:if>
							<c:if
								test="${ !empty subject.e}">
								<p style="text-indent: 2em;">E.${subject.e}</p>
							</c:if> <c:if test="${ !empty subject.f}">
								<p style="text-indent: 2em;">F.${subject.f}</p>
							</c:if> <c:if test="${ !empty subject.g}">
								<p style="text-indent: 2em;">G.${subject.g}</p>
							</c:if>
							<p align="right">${fns:getDictLabel(subject.complexity, 'sub_complexity', '易')}&nbsp;&nbsp;&nbsp;&nbsp;
								<button id="1" class="btn alter" data-toggle="modal"
									data-target="#myModal" value="${subject.id}"
									onclick="buttonClick(this)">修改</button>
								<button id="${subject.id}" class="btn delete" onclick="delSub(this)">删除</button>
							</p>
						</li>
					</c:if>
				</c:forEach>
				<div id="add" style="margin-left: 50px;"><div><button id="1" class="btn alter" data-toggle="modal" data-target="#myModal" value="nu" onclick="buttonClick(this)">添加</button></div></div>
			</ol>
			<br>
			<div class="controls " style="font-size: 20px;">
				二、多选题(<span id="c-dd"></span>小题，每题<span id="dd-m"></span>分，共计<span
					id="dd-score"></span>分)
			</div>
			<ol type="1" class="controls">
				<c:forEach items="${paper.subList}" var="subject" varStatus="status">
					<c:if test="${subject.type eq '2'}">
						<li id="dd${status.index+1}" class="dd subject">
							${subject.title}<p></p>
							<c:if test="${subject.judge eq '2'}">
								A.<img class="option" src="${subject.a}"><br>
								B.<img class="option" src="${subject.b}"><br>
								C.<img class="option" src="${subject.c}"><br>
								D.<img class="option" src="${subject.d}">
							</c:if>
							<c:if test="${subject.judge eq '1'}">
								<p style="text-indent: 2em;">A.${subject.a}</p>
								<p style="text-indent: 2em;">B.${subject.b}</p>
								<p style="text-indent: 2em;">C.${subject.c}</p>
								<p style="text-indent: 2em;">D.${subject.d}</p>
							</c:if>
							<c:if
								test="${ !empty subject.e}">
								<p style="text-indent: 2em;">E.${subject.e}</p>
							</c:if> <c:if test="${ !empty subject.f}">
								<p style="text-indent: 2em;">F.${subject.f}</p>
							</c:if> <c:if test="${ !empty subject.g}">
								<p style="text-indent: 2em;">G.${subject.g}</p>
							</c:if>
							<p align="right">${fns:getDictLabel(subject.complexity, 'sub_complexity', '易')}&nbsp;&nbsp;&nbsp;&nbsp;
								<button id="2" class="btn alter" data-toggle="modal"
									data-target="#myModal" value="${subject.id}"
									onclick="buttonClick(this)">修改</button>
								<button id="${subject.id}" class="btn delete" onclick="delSub(this)">删除</button>
							</p>
						</li>
					</c:if>
				</c:forEach>
				<div id="add2" style="margin-left: 50px;"><div><button id="2" class="btn alter" data-toggle="modal" data-target="#myModal" value="nu" onclick="buttonClick(this)">添加</button></div></div>
			</ol>
		</div>
		<div id="hiddenBox" style="display: none;"></div>
		<div class="form-actions" style="clear: both;">
			<shiro:hasPermission name="cms:paper:edit">
				<input id="btnSubmit" class="btn btn-primary" type="button"
					onclick="formSubmit()" value="发 布" />&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回"
				onclick="history.go(-1)" />
		</div>
	</div>
	<div>

		<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true"
			style="width: 700px; display: none;">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title" id="myModalLabel">修改试题</h4>
					</div>
					<div class="modal-body">
						<input id="oldSubId" type="hidden" value="" />
						<div style="float: left;">
							<label>请选择题根:</label>
							<div class="menuContent"
								style="width: 200px; height: 300px; border: 1px solid #EEEEEE; OVERFLOW-Y: auto; OVERFLOW-X: auto;">
								<ul id="treeDemo" class="ztree"
									style="margin-top: 0; width: 160px;"></ul>
							</div>
						</div>
						<div style="float: right;">
							<label>请选择试题:&nbsp;&nbsp;<input id="simu1" name="simu" type="radio" value="1" onclick="getSimu(this)" checked="checked"/>模拟题&nbsp;&nbsp;<input id="simu2" name="simu" type="radio" value="0" onclick="getSimu(this)"/>真题</label>
							<div style="width: 450px; height: 300px; OVERFLOW-Y: auto;">
								<div style="position: fixed; width: 435px;">
									<table id="contentTable"
										class="table table-striped table-bordered table-condensed">
										<thead>
											<tr>
												<th width="27px">序号</th>
												<th width="324px">题目</th>
												<th width="27px">难易</th>
												<th width="27px">选择</th>
											</tr>
										</thead>
									</table>
								</div>
								<table id="contentTable"
									class="table table-striped table-bordered table-condensed"
									style="width: 435px; word-break: break-all;">
									<thead>
										<tr height="27px">
											<th width="27px"></th>
											<th width="324px"></th>
											<th width="27px"></th>
											<th width="27px"></th>
										</tr>
									</thead>
									<tbody id="box" style="width: 430px;"></tbody>
								</table>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button id="alter" type="button" class="btn btn-primary"
							data-dismiss="modal">提交</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>