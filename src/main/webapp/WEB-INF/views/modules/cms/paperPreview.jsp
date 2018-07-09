<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>试卷预览</title>
<meta name="decorator" content="default" />
<%@include file="/WEB-INF/views/include/treeview.jsp"%>
<style type="text/css">
.subject {
	font-size: 17px;
	width: 700px;
	padding: 10px 10px 0px 10px;
	margin: 20px 0px 20px 50px;
	border: 1px solid #aeaeae;
	border-radius: 10px;
	box-shadow: 5px 5px 15px #999999;
}

.option {
	max-width: 250px;
	margin: 0px 30px 10px 0px;
}

.option2 {
	max-width: 50px;
	margin: 0px 30px 10px 0px;
}
</style>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a
			href="<c:url value='${fns:getAdminPath()}/cms/paper/${paper.simulate eq "1"?"simuList":"list" }'></c:url>">试卷列表</a></li>
		<li class="active"><a
			href="${ctx}/cms/paper/preview?id=${paper.id}">试卷预览</a></li>
	</ul>
	<br />
	<div class="form-horizontal">
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
				一、单选题(<span id="c-d">${paper.radioNumber}</span>小题，每题<span id="d-r">${paper.radioScore}</span>分，共计<span
					id="d-score">${paper.radioNumber*paper.radioScore}</span>分)
			</div>
			<ol type="1" class="controls">
				<c:forEach items="${paper.subList}" var="subject" varStatus="status">
					<c:if test="${subject.type eq '1'}">
						<li id="d${status.index+1}" class="d subject">
							${subject.title}
							<p></p> <c:if test="${subject.judge eq '2'}">
								A.<img class="option" src="${subject.a}">
								B.<img class="option" src="${subject.b}">
								<br>
								C.<img class="option" src="${subject.c}">
								D.<img class="option" src="${subject.d}">
							</c:if> <c:if test="${subject.judge eq '1'}">
								<p style="text-indent: 2em;">A.${subject.a}</p>
								<p style="text-indent: 2em;">B.${subject.b}</p>
								<p style="text-indent: 2em;">C.${subject.c}</p>
								<p style="text-indent: 2em;">D.${subject.d}</p>
							</c:if> <c:if test="${ !empty subject.e}">
								<p style="text-indent: 2em;">E.${subject.e}</p>
							</c:if> <c:if test="${ !empty subject.f}">
								<p style="text-indent: 2em;">F.${subject.f}</p>
							</c:if> <c:if test="${ !empty subject.g}">
								<p style="text-indent: 2em;">G.${subject.g}</p>
							</c:if>
						</li>
					</c:if>
				</c:forEach>
			</ol>
			<br>
			<div class="controls " style="font-size: 20px;">
				二、多选题(<span id="c-dd">${paper.multipleNumber }</span>小题，每题<span id="dd-m">${paper.multipleScore}</span>分，共计<span
					id="dd-score">${paper.multipleScore*paper.multipleNumber}</span>分)
			</div>
			<ol type="1" class="controls">
				<c:forEach items="${paper.subList}" var="subject" varStatus="status">
					<c:if test="${subject.type eq '2'}">
						<li id="dd${status.index+1}" class="dd subject">
							${subject.title}
							<p></p> <c:if test="${subject.judge eq '2'}">
								A.<img class="option" src="${subject.a}">
								<br>
								B.<img class="option" src="${subject.b}">
								<br>
								C.<img class="option" src="${subject.c}">
								<br>
								D.<img class="option" src="${subject.d}">
							</c:if> <c:if test="${subject.judge eq '1'}">
								<p style="text-indent: 2em;">A.${subject.a}</p>
								<p style="text-indent: 2em;">B.${subject.b}</p>
								<p style="text-indent: 2em;">C.${subject.c}</p>
								<p style="text-indent: 2em;">D.${subject.d}</p>
							</c:if> <c:if test="${ !empty subject.e}">
								<p style="text-indent: 2em;">E.${subject.e}</p>
							</c:if> <c:if test="${ !empty subject.f}">
								<p style="text-indent: 2em;">F.${subject.f}</p>
							</c:if> <c:if test="${ !empty subject.g}">
								<p style="text-indent: 2em;">G.${subject.g}</p>
							</c:if>
						</li>
					</c:if>
				</c:forEach>
			</ol>
		</div>
		<div class="form-actions" style="clear: both;">
			<shiro:hasPermission name="cms:paper:edit">
			<a class="btn btn-primary" href="${ctx}/cms/paper/edit?id=${paper.id}">修改</a>
			&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回"
				onclick="history.go(-1)" />
		</div>
	</div>
</body>
</html>