<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<!-- 这个是之前的成绩详情页面，不需要了。成绩详情界面换成scoreDetail2.jsp -->
	<title>成绩详情</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		function viewComment(href){
			top.$.jBox.open('iframe:'+href,'查看评论',$(top.document).width()-220,$(top.document).height()-120,{
				buttons:{"关闭":true},
				loaded:function(h){
					$(".jbox-content", top.document).css("overflow-y","hidden");
					$(".nav,.form-actions,[class=btn]", h.find("iframe").contents()).hide();
					$("body", h.find("iframe").contents()).css("margin","10px");
				}
			});
			return false;
		}
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/cms/score/">成绩详情</a></li>
	</ul>
	
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead><tr><th>序号</th><th>考试人员</th><th>已答题目</th><th>所选答案</th><th>正确答案</th><th>是否正确</th><th>操作</th></tr></thead>
		<tbody>
		<c:forEach items="${scoredetail}" var="scoredetail" varStatus="idxNews">
			<tr>
				<td><c:out value='${idxNews.index+1}'/></td>
				<td>${scoredetail.user.name}</td>
				<td>${scoredetail.timuId}</td>
				<td>${scoredetail.userAnswer}</td>
				<td>${scoredetail.relAnswer}</td>
				<td>${scoredetail.result}</td>
				<td>
					<a href="${ctx}/cms/score/form?id=${scoredetail.timuId}">题目详情</a>
				</td>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>