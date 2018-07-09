<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
 <link rel="stylesheet" href="${ctxStatic}/jqueryMobile/css/jquery.mobile-1.3.2.min.css"> 
 <script src="${ctxStatic}/jquery/jquery-1.8.3.min.js"></script> 
 <script src="${ctxStatic}/jqueryMobile/js/jquery.mobile-1.3.2.min.js"></script> 
<%-- <script type="text/javascript" src="${ctxStatic}/jquery/jquery-1.8.3.min.js"></script>  --%>
<%-- <script type="text/javascript" src="${ctxStatic}/jquery/jquery-1.10.2.min.js"></script>  --%>
 
</head>
<body>

<div data-role="page">
  <div data-role="header">
  <h1>用户登录</h1>
  </div>

  <div data-role="main" class="ui-content">
    <form method="post" action="${ctx}/login" id="inputForm" data-ajax="false">
      <div class="ui-field-contain">
        <label for="username">账号：</label>
        <input type="text" name="username" id="username" placeholder="请输入账号" class="required">  
        </br>     
        <label for="密码">密码:</label>
        <input type="password" name="password" id="password" placeholder="请输入密码" class="required">
<span style="color:#F00">${message }</span>
      </div>
      <input type="submit" data-inline="true" value="提交" id="btnSubmit" >
    </form>
  </div>
</div>
 <script type="text/javascript">

 $("form:input.required").each(function () {
            //通过jquery api：$("HTML字符串") 创建jquery对象
            var $required = $("<strong class='high'></strong>");
            //添加到this对象的父级对象下
            $(this).parent().append($required);
        });

        //为表单元素添加失去焦点事件
        $("form :input").blur(function(){
            var $parent = $(this).parent();
            $parent.find(".msg").remove(); //删除以前的提醒元素（find()：查找匹配元素集中元素的所有匹配元素）
            //验证姓名
            if($(this).is("#username")){
                var nameVal = $.trim(this.value); //原生js去空格方式：this.replace(/(^\s*)|(\s*$)/g, "")
                if(nameVal == "" || nameVal.length ==null){
                    var errorMsg = "账号不能为空";
                    
                    $parent.append("<span class='msg onError'>" + errorMsg + "</span>");
                }
                else{
                    var okMsg=" 输入正确";
                    $parent.find(".high").remove();
                    $parent.append("<span class='msg onSuccess'>" + okMsg + "</span>");
                }
            }
             //验证邮箱
            if($(this).is("#password")){
                var password = $.trim(this.value);
                if(password== "" || password==null){
                    var errorMsg = "密码不能为空";
                    $parent.append("<span class='msg onError'>" + errorMsg + "</span>");
                }
                else{
                    var okMsg=" 输入正确";
                    $parent.find(".high").remove();
                    $parent.append("<span class='msg onSuccess'>" + okMsg + "</span>");
                }
            } 
        }).keyup(function(){
            //triggerHandler 防止事件执行完后，浏览器自动为标签获得焦点
            $(this).triggerHandler("blur"); 
        }).focus(function(){
            $(this).triggerHandler("blur");
        });
        
        //点击重置按钮时，通过trigger()来触发文本框的失去焦点事件
        $("#btnSubmit").click(function(){
            //trigger 事件执行完后，浏览器会为submit按钮获得焦点
            $("form .required:input").trigger("blur"); 
            var numError = $("form .onError").length;
            if(numError){
                return false;
            }
           
        });
</script>

</body>
</html>