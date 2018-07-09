 <%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  <meta name="viewport" content="width=device-width, initial-scale=1">
 <link rel="stylesheet" href="${ctxStatic}/jqueryMobile/css/jquery.mobile-1.3.2.min.css"> 
 <script src="${ctxStatic}/jquery/jquery-1.8.3.min.js"></script> 
 <script src="${ctxStatic}/jqueryMobile/js/jquery.mobile-1.3.2.min.js"></script> 

</head>
<body>
   <header>
      
        <h1 class="title">试卷列表</h1>
    </header>
<div data-role="page" id="pageone" data-theme="c">
  <div data-role="header">
    <h1>试卷列表</h1>
  </div>

  <div data-role="content">
  <input type="hidden" id="state" value="${sessionScope.score}">
  <c:forEach var="paper" items="${simPaperList }">
   <div data-role="collapsible">
     <h1> ${paper.paperName }</h1>
    <a href="${ctx}/cms/paper/start?id=${paper.id}&order=0" data-role="button" data-icon="arrow-r" data-iconpos="right" data-ajax="false" >开始考试
    </a>
    <a href="${ctx}/cms/score/detail?uid=${uid}&paperId=${paper.id}" data-role="button" data-icon="arrow-r" data-iconpos="right" data-ajax="false" id="anchor"  >查看解析</a>
    </div>
    </c:forEach>         
                
      </div>
      
   </div>
     <div data-role="footer">
  <h1>考试系统</h1>
  </div>
</div> 
  </body>
  
</html>
