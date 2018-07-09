<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<script src="${ctxStatic}/common/echarts.min.js" type="text/javascript"></script>
<html>
<head>
<title>数据统计</title>
<meta name="decorator" content="default" />
<script type="text/javascript">
	function selectModelData(){
		var id=$("#modelId").val();
		if(id.length >0){
			$.ajax({
				url : "${ctx}/cms/data/selectModelData",
				data:"id="+id,
				success : function(data) {
					var data1 = new Array();
					var data2 = new Array();
					 for(var i=0;i<data.length;i++){
						data1[i]=data[i].subjectRoot.name;
						data2[i]=data[i].subNum; 
					} 
					 var myChart = echarts.init(document.getElementById('main'));
					 myChart.setOption({
					        title: {
					            text: '题目数据'
					        },
					        tooltip: {},
					        legend: {
					            data:['数量']
					        },
					        xAxis: {
					            data: data1
					        },
					        yAxis: {},
					        series: [{
					            name: '数量',
					            type: 'bar',
					            data: data2
					        }]
					    }); 
				}
			});
		}
	}
</script>
</head>
<body>
	<hr>
	<%-- <form:form id="searchForm" action="${ctx}/cms/data/selectModelData"
		method="post" class="form-horizontal"> --%>
		<label>模块类型：</label>
		<select name="id" id="modelId" style="width: 100px">
			<option value="">请选择</option>
			<c:forEach items="${subjectRoot}" var="subRoot">
				<option value="${subRoot.id }">${subRoot.name }</option>
			</c:forEach>
		</select>
		<input id="btnSubmit" class="btn btn-primary" type="button" onclick="selectModelData()" value="查询" />
<%-- 	</form:form> --%>
	<hr>
	<!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
	<div id="main" style="width: 800px; height: 400px;"></div>
	<script type="text/javascript">
		var myChart = echarts.init(document.getElementById('main'));
		myChart.setOption({
		    title: {
		        text: '题目数据'
		    },
		    tooltip: {},
		    legend: {
		        data:['数量']
		    },
		    xAxis: {
		        data: []
		    },
		    yAxis: {},
		    series: [{
		        name: '数量',
		        type: 'bar',
		        data: []
		    }]
		});
		$(function() {
			$.ajax({
				url : "${ctx}/cms/data/subDataSelect",
				success : function(data) {
					var data1 = new Array();
					var data2 = new Array();
					 for(var i=0;i<data.length;i++){
						data1[i]=data[i].subjectRoot.name;
						data2[i]=data[i].subNum; 
					}  
					 myChart.setOption({
					        xAxis: {
					            data: data1
					        },
					        series: [{
					            // 根据名字对应到相应的系列
					            name: '数量',
					            data: data2
					        }]
					    });
				}
			});
		});
	</script>

	<div class="pagination">${page}</div>
</body>
</html>














