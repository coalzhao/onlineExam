<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>答题界面</title>
<link rel="stylesheet" href="${ctxStatic}/bootstrap/bsie/css/bootstrap.min.css">  
<script type="text/javascript" src="${ctxStatic}/jquery/jquery-1.8.3.min.js"></script> 
<!-- <style type="text/css">
 .list-group li {
 list-style-type: disc;
}
</style> -->
<script type="text/javascript">
$(document).ready(function(){
	//alert($("#flag").val());
	if($("#msg").val() == "error"){  //试卷已作答，不能重复提交
		alert("无题目 信息，请联系管理员");
		$("#content").html("请关闭该窗口");
		window.close();
	}else{
		if($("#flag").val()!="ok"){  //试卷已作答，不能重复提交
		alert("该试卷已作答，请勿重复提交");
		$("#content").html("请关闭该窗口");
		window.close();
	}}
	//if(flag.val())
	if($("#judge").val()==2){//图片题，隐藏选项文本信息
		$("#a").html("");
		$("#b").html("");
		$("#c").html("");
		$("#d").html("");
		$("img").show();   //显示图片
	}else{
		$("img").hide();
	}
	info();
	function info(){     //获得用户答案的方法，用于自动勾选选项框
		var a = $("#userAnswer").val();//获得上一道题目用户答案的信息，
		var b = [];
		var b = a.split(",");  //分割字符串
		$("input[name='choose']").each(function(){  
		    if($(this).val() == b[0]){  
		        $(this).prop( "checked", true );    //根据答案，选中该选项框
		    }  
		    if($(this).val() == b[1]){  
		        $(this).prop( "checked", true );  
		    } 
		    if($(this).val() == b[2]){  
		        $(this).prop( "checked", true );  
		    } 
		    if($(this).val() == b[3]){  
		        $(this).prop( "checked", true );  
		    } 
		}); 
	}
	
	$("li").css("list-style-type","upper-alpha");    //将li的显示样式换成ABCD排序
	  $("li").each(function(){    //将四个li随机排序一次
		//alert("随机排序选项");
		if(parseInt(Math.random()*2)==0){
			$(this).prependTo($(this).parent());
		}	
});  
	
	if($("#subType").val() == 1){    //判断题型为单选题还是多选题，用于更改选项框为单选框还是复选框
		$("input[name='choose']").prop('type','radio');
		$(".type").html("单选题");
	}else{
		$("input[name='choose']").prop('type','checkbox');
		$(".type").html("多选题");
	}
	
	if($("#order").val() == 1){   //当序号为第一题时，隐藏"上一题"按钮
		$("#lastOne").hide();
	}
	
	 
	
	$("#btnSubmit").click(function (){  //点击"下一题"按钮触发的事件
		 
		var choose = [];
		$("input[name='choose']:checked").each(function(i){
            choose[i] = $(this).val();
      });                                //获取用户所选择的答案
      //alert(choose);
      if(choose == ""){
    	  alert("此题未作答");
      }
		$("input[name='choose']").prop( "checked", false )  //将选项框重置
		
		var param = new Object();   //用户向后台
		var id = $("input[name='id']").val();   //获取试卷id
		var order = $("input[name='order']").val();   //获取题目序号
		var choose = choose;     //选项
		var subId = $("input[name='subId']").val();   //获取题目id
		var last = "n";  //用于判断点击的是下一题还是上一题，n表示下一题，p表示上一题
		
		param.id = id;
		param.order = order;
		param.choose = choose;   //数据的装载
		param.subId = subId;
		param.last = last;
		$.ajax({                  //局部刷新
			url:"${ctx}/cms/paper/next",      //请求路径
			traditional:true,
			type:"get",
			data:param,              //参数
			datatype:"json",
			success:function(param){
				
				$("#subType").val(param[0].type);     //动态修改隐藏域中的值用于判断，单选题还是多选题
				$("input[name='subId']").val(param[0].id); //改变隐藏域保存题目的id
				$("#rest").val(param[2]);                 //改变剩余题目的显示
				$("#order").val(param[1]);               //改变题目序号，也就是传到后台的序号
				$("#userAnswer").val(param[3]);           //改变隐藏域中保存用户答案的值，用于选项框的自动勾选
				$("#judge").val(param[0].judge);       //动态判断该题目是否包含图片，用于设置题目图片的显示
				
				if($("#judge").val()==2){          //图片题，图片显示，路径隐藏
					$("img").show();
				}else{
					$("img").hide();
				}
				if($("#subType").val() == 1){         //   当题目为单选题时，将所有的选项框改为radio
					$("input[name='choose']").prop('type','radio');
					$(".type").html("单选题");          //修改界面展示题目类型为单选题
				}else{
					$("input[name='choose']").prop('type','checkbox');//  否则，将所有的选项框改为checkbox
					$(".type").html("多选题");            //修改界面展示题目类型为多选题
				}
				info();    //调用函数，根据隐藏域保存用户答案的值动态勾选选框。
				
				
				 if($("#order").val() != 1){       //题目序号不为1时，显示"上一题"按钮
					$("#lastOne").show();
				}
				if($("#rest").val() == 0){         //隐藏域表示剩余题量，为0时，隐藏"下一题"按钮，显示"提交按钮"
					$("#s").html("");
					$("#s").html("当前为最后一道题目，准备交卷");
					$("#btnSubmit").hide();
					$("#comm").show();
				}else{
					var a=$("#rest").val();      //否则动态修改界面的剩余题目数量。
					$("#s").html("");
					$("#s").html("还剩"+a+"道题");
					$("#btnSubmit").hide();
					$("#comm").show();    //？？
				}
				  
				if($("#rest").val() == 0){
					$("#comm").show();
				}else{
					$("#btnSubmit").show();
					$("#comm").hide();
				}   
				$(".order").html(param[1]);    //修改界面的题号
				$("#title").html(param[0].title);    //修改题干
				$("#a").html(param[0].a);        //修改选项a
				$("#b").html(param[0].b);       //修改选项b
				$("#c").html(param[0].c);       //修改选项c
				$("#d").html(param[0].d);      //修改选项d
				if($("#judge").val()==2){    //为图片类型的题目时，隐藏abcd选项的文本信息
					$("#a").html("");
					$("#b").html("");
					$("#c").html("");
					$("#d").html("");
				}
				$(".rest").html(param[2]);       //修改剩余题量的展示
			},
			error:function(){
				alert("网络出错");
			}
		});
	});
	$("#lastOne").click(function (){
		var choose = [];
		$("input[name='choose']:checked").each(function(i){
            choose[i] = $(this).val();
      });
		$("input[name='choose']").prop( "checked", false );
		
		var param = new Object();
		var id = $("input[name='id']").val();
		var order = $("input[name='order']").val();
		var choose = choose;
		var subId = $("input[name='subId']").val();
		var last = "p";
		param.id = id;
		param.order = order;
		param.choose = choose;
		param.subId = subId;
		param.last = last;
		$.ajax({
			url:"${ctx}/cms/paper/next",
			traditional:true,
			type:"get",
			data:param,
			datatype:"json",
			success:function(param){
				
				$("#subType").val(param[0].type);
				$("input[name='subId']").val(param[0].id);
				$("#rest").val(param[2]);
				$("#order").val(param[1]);
				$("#userAnswer").val(param[3]);
				$("#judge").val(param[0].judge);
				
				if($("#judge").val()==2){
					$("#a").html("");
					$("#b").html("");
					$("#c").html("");
					$("#d").html("");
					$("img").show();
				}else{
					$("img").hide();
				}
				
				if($("#subType").val() == 1){
					$("input[name='choose']").prop('type','radio');
					$(".type").html("单选题");
				}else{
					$("input[name='choose']").prop('type','checkbox');
					$(".type").html("多选题");
				}  
				
				info();
				
				if($("#rest").val() != 0){
					var a=$("#rest").val();
					$("#s").html("");
					$("#s").html("还剩"+a+"道题");
					$("#btnSubmit").hide();
					$("#comm").show();
				}
				
				 if($("#order").val() == 1){
					$("#lastOne").hide();
				}
				 if($("#rest").val() == 0){
					$("#comm").show();
				}else{
					$("#btnSubmit").show();
					$("#comm").hide();
				}
				
				$(".order").html(param[1]);
				$("#title").html(param[0].title);
				$("#a").html(param[0].a);
				$("#b").html(param[0].b);
				$("#c").html(param[0].c);
				$("#d").html(param[0].d);
				if($("#judge").val()==2){
					$("#a").html("");
					$("#b").html("");
					$("#c").html("");
					$("#d").html("");
				}
				$(".rest").html(param[2]);
			},
			error:function(){
				alert("网络出错");
			}
		});
	});
	
});
</script>
<style type="text/css">
p{display: inline;}
</style>
</head>
<body onload="shownum()">
<div id="content">
<input type="hidden" id="state" value="${time}">
<form:form id="inputForm"  action="${ctx}/cms/paper/commit" method="post" class="form-horizontal">
<input type="hidden" id="msg" value="${msg}">
<input type="hidden" name="id" value="${id}">
<input type="hidden" id="order" name="order" value="${order}">
<input name="subId" type="hidden" value="${subject.id}">
<input id="judge" type="hidden" value="${subject.judge}"> 
<input id="flag" type="hidden" value="${flag}">
<input id="userAnswer" type="hidden" value="${userAnswer}">
<input id="rest"  type="hidden" value="${rest}">
<input id="subType"  type="hidden" value="${subject.type}">
 <div class="panel panel-primary"><div class="panel-heading"><h1 align="center">${paperName}</h1><%-- <span style="text-align:center;display:block;">${paperName}</span> --%></div></div> 
<div class="panel panel-primary">
	<div class="panel-heading"><span class="type"></span><span style="float:right;"><span class="order">${order}</span>/${sum}------总共${sum}道题，<span id="s">还剩<span class="rest">${rest}</span>道题</span></span></div>
	<div class="panel-body">
		<span class="order">${order}</span>.<span id="title">${subject.title}</span>
	</div>
	<ul>
		<li style="font-size: 17px; width: 700px; padding: 10px 10px 0px 10px; margin: 20px 0px 20px 50px; border: 1px solid #aeaeae; border-radius: 10px; box-shadow: 5px 5px 15px #999999;"><input name="choose"  type="radio" value="A"/><img src="${subject.a}"><span id="a">${subject.a}</span></li>
		<li style="font-size: 17px; width: 700px; padding: 10px 10px 0px 10px; margin: 20px 0px 20px 50px; border: 1px solid #aeaeae; border-radius: 10px; box-shadow: 5px 5px 15px #999999;"><input name="choose"  type="radio" value="B"/><img src="${subject.b}"><span id="b">${subject.b}</span></li>
		<li style="font-size: 17px; width: 700px; padding: 10px 10px 0px 10px; margin: 20px 0px 20px 50px; border: 1px solid #aeaeae; border-radius: 10px; box-shadow: 5px 5px 15px #999999;"><input name="choose"  type="radio" value="C"/><img src="${subject.c}"><span id="c">${subject.c}</span></li>
		<li style="font-size: 17px; width: 700px; padding: 10px 10px 0px 10px; margin: 20px 0px 20px 50px; border: 1px solid #aeaeae; border-radius: 10px; box-shadow: 5px 5px 15px #999999;"><input name="choose"  type="radio" value="D"/><img src="${subject.d}"><span id="d">${subject.d}</span></li>
	</ul>
	<input id="lastOne" class="btn-primary" type="button" value="上一题" />&nbsp;<input type="button" id="btnSubmit" class="btn-primary" value="下一题"><input style="display:none;" type='submit' class='btn-primary'  id='comm' value='提交试卷' onclick='return confirm("确定提交试卷吗？");'/>
</div>
</form:form>
<div class="panel panel-primary"><div class="panel-heading"><span id="time" style="text-align: center;display:block;"></span></div></div>
</div>
<script type="text/javascript"> 
var i = document.getElementById("state").value;
function shownum(){ 
	i=i-1;
	var j = parseInt(i/60);
	var a = i%60;
	if(j==0 && a==0){
		document.getElementById('inputForm').submit();
	}
	if(j<0 || a<0){
		alert("考试已结束");
		$("#content").html("请关闭该窗口");
		window.close();
	}
	if(j==10 && a==0){
		document.getElementById("time").style.color="red";
	}
	
document.getElementById("time").innerHTML="距离考试结束还有"+j+"分钟"+a+"秒";
setTimeout('shownum()',1000); 
} 

</script>
</body>
</html>
















