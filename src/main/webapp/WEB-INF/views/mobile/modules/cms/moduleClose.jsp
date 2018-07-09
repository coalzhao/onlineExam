<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
 <link rel="stylesheet" href="${ctxStatic}/jqueryMobile/css/jquery.mobile-1.3.2.min.css"> 
 <script src="${ctxStatic}/jquery/jquery-1.8.3.min.js"></script> 
 <script src="${ctxStatic}/jqueryMobile/js/jquery.mobile-1.3.2.min.js"></script> 
</head>
<script type="text/javascript"> 

</script>
<body>
<div data-role="page" id="pageone" data-theme="c">
  <div data-role="header">
    <h1>练习完毕</h1>
  </div>

  <div data-role="content">
  <h2>您已练习完毕</h2>
  <a href="${ctx}" data-role="button" data-icon="arrow-r" data-iconpos="right" data-ajax="false">返回主页</a>
<a href="${ctx}/cms/moduleAnswer/transforList" data-role="button" data-icon="arrow-r" data-iconpos="right" data-ajax="false">查看解析</a>
  </div>
  <div data-role="footer">
  <h1>考试系统</h1>
  </div>
</div> 
</body>
</html>