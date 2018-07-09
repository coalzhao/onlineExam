<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
</style>
 <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no">
   <link rel="stylesheet" href="${ctxStatic}/bootstrap4/css/bootstrap.min.css">
<script type="text/javascript" src="${ctxStatic}/bootstrap4/js/bootstrap.min.js"></script>  
<script type="text/javascript" src="${ctxStatic}/jquery/jquery-1.8.3.min.js"></script> 
    <meta charset="utf-8">
<style type="text/css">
p{display: inline;}
</style>
 <script type="text/javascript">

$(document).ready(function(){

	alert("模拟考试时请勿刷新页面");

	

	/* if($("#flag").val()!="未作答"){

		alert("该试卷已作答，请勿重复提交");

		$("#content").html("请关闭该窗口");

		window.close();

	} */

	//if(flag.val())

	if($("#judge").val()==2){

		$("#a").html("");

		$("#b").html("");

		$("#c").html("");

		$("#d").html("");

		$("img").show();

	}else{

		$("img").hide();

	}

	function info(){

		var a = $("#userAnswer").val();//获得上一道题目用户答案的信息，

		var b = [];

		var b = a.split(",");

		$("input[name='choose']").each(function(){  

		    if($(this).val() == b[0]){  

		        $(this).prop( "checked", true );  

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

	

	$("li").css("list-style-type","upper-alpha");

	  $("li").each(function(){

		//alert("随机排序选项");

		if(parseInt(Math.random()*2)==0){

			$(this).prependTo($(this).parent());

		}	

});  

	

	if($("#subType").val() == 1){

		$("input[name='choose']").prop('type','radio');

		$(".type").html("单选题");

	}else{

		$("input[name='choose']").prop('type','checkbox');

		$(".type").html("多选题");

	}

	

	if($("#order").val() == 1){

		$("#lastOne").hide();

	}

	

	 

	

	$("#btnSubmit").click(function (){

		

		var choose = [];

		$("input[name='choose']:checked").each(function(i){

            choose[i] = $(this).val();

      });

		$("input[name='choose']").prop( "checked", false )

		

		var param = new Object();

		var id = $("input[name='id']").val();

		var order = $("input[name='order']").val();

		var choose = choose;

		var subId = $("input[name='subId']").val();
		var last = "n";  //用于判断点击的是下一题还是上一题，n表示下一题，p表示上一题

		

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

				/* info(); */

				/* if($("#userAnswer").val()=='未作答'){

					//alert("下一题随机...");

					//alert($("#userAnswer").val());

				 $("li").each(function(){

					//alert("下一题随机");

					if(parseInt(Math.random()*2)==0){

						$(this).prependTo($(this).parent());

					}	

			}); } */

				

				 if($("#order").val() != 1){

					$("#lastOne").show();

				}

				if($("#rest").val() == 0){

					$("#s").html("");

					$("#s").html("当前为最后一道题目，准备交卷");

					$("#btnSubmit").hide();

					$("#comm").show();

				}else{

					var a=$("#rest").val();

					$("#s").html("");

					$("#s").html("还剩"+a+"道题");

					$("#btnSubmit").hide();

					$("#comm").show();

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

				

				/* info(); */

				

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

</head>
  <body onload="shownum()">

     <header  style="background:#121212; color:#FFF ;height:50px">
 <h6 style="text-align:center ;line-height:50px">考试页面</span></h6>  
 
 </header>
         
      <div class="container">
     <nav><span class="type"></span><span><span class="order"></span>总共${sum}道题，还剩<span id="s">
     <span class="rest">${rest}</span>道题</span></span> </nav>
    
   

<form:form id="inputForm"  action="${ctx}/cms/paper/commit" method="post" class="form-horizontal">
<input type="hidden" id="state" value="${time}">
<input type="hidden" name="id" value="${id}">

<input type="hidden" id="order" name="order" value="${order}">

<input name="subId" type="hidden" value="${subject.id}">

<input id="judge" type="hidden" value="${subject.judge}"> 

<input id="flag" type="hidden" value="${flag}">

<input id="userAnswer" type="hidden" value="${userAnswer}">

<input id="rest"  type="hidden" value="${rest}">

<input id="subType"  type="hidden" value="${subject.type}">


<div class="table-responsive">
  <table class="table">
  
  <tbody>
     <tr>
     <td>
<strong><span class="order">${order}</span>.<span id="title">${subject.title}</span></strong> 
     </td>
     </tr>
      <tr>
     <td>  
<input name="choose"  type="radio" value="A"/><span>A.</span><img src="${subject.a}" class="img-responsive"><span id="a">${subject.a}</span>

</td>
     </tr>
    
	 <tr>
     <td>
     	
<input name="choose"  type="radio" value="B"/><span>B.</span><img src="${subject.b}" class="img-responsive"><span id="b">${subject.b}</span>	

	</td>
     </tr>
     
	 <tr>
     <td>
    
<input name="choose"  type="radio" value="C"/><span>C.</span><img src="${subject.c}" class="img-responsive"><span id="c">${subject.c}</span> 

	</td>
     </tr>
     
	 <tr>
     <td>
    
<input name="choose"  type="radio" value="D"/> <span>D.</span><img src="${subject.d}" class="img-responsive"><span id="d">${subject.d}</span>	
	
	
	</td>  
     </tr>
   
     
	 <tr>
     <td>
<input id="lastOne"  type="button" value="上一题" class="btn btn-info btn-lg" style="font-size: 13px"/>&nbsp;
	<input type="button" id="btnSubmit"  value="下一题" class="btn btn-info btn-lg" style="font-size: 13px">
	<input style="display:none; font-size: 13px"  class="btn btn-info btn-lg" type='submit' id='comm' value='提交试卷' 
	onclick='return confirm("确定提交试卷吗？");'/> 	 </td>
     </tr>

	</tbody>
	
	</table>
	</div>
   </div>
   </form:form>
</body>
<footer  style="background:#121212; color:#FFF ;height:50px">
  <h6 style="text-align:center ;line-height:50px"><span id="time"></span></h6> 
 </footer>
 <!-- <script type="text/javascript"> 

var i = 120;
function shownum(){ 

	i=i-1;

	var j = parseInt(i/60);

	var a = i%60;

	if(j==0 && a==0){

		document.getElementById('inputForm').submit();

	}

	if(j<0 || a<0){

		alert("考试已结束");

		window.close();

	}

	if(j==10 && a==0){

		aa = window.open("","_black", "width=300,height=200,top=300,left=500");

		aa.document.write("<body bgcolor='red'><title>提示交卷</title><h4>十分钟后将自动提交试卷。(5秒后自动关闭)</h4><center><input type='button' value=' 确 认 ' onclick='window.close()'></center></body>");

		setTimeout("aa.close()", 5000);

	}

	

document.getElementById("timer").innerHTML="距离考试结束还有"+j+"分钟"+a+"秒";

setTimeout('shownum()',1000); 

} 



</script>  -->

<script>
      localStorage.setItem('start', new Date().getTime());
      countDown(localStorage.getItem('start'));
 
      function countDown(startTime) {
        var time = setInterval(function() {
        var minute = '${duration}';
        
          var currentTime = new Date();
          var second = 59 - parseInt(((currentTime.getTime() - startTime) / 1000) % 60);
          var min = minute - 1 - parseInt((currentTime.getTime() - startTime) / 60000);
 
          if(min < 10) {
            min = "0" + min;
          }
          if(second < 10) {
            second = "0" + second;
          }
 
          $('#time').html("距离考试结束还有"+min+"分钟"+second+"秒");
 if(min==15 && second==0){
		document.getElementById("time").style.color="red";
	}
          if(second == 0 && min == 0) {
       alert("时间到");
            clearInterval(time);
            document.getElementById('inputForm').submit();
          }
        }, 1000)
      }
    </script>
</html>
