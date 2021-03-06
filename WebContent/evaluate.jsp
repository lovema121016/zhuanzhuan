<%@page import="com.zhuanzhuan.dao.EvaluateDaoImpl"%>
<%@page import="com.zhuanzhuan.model.Evaluate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>评价</title>
</head>
<%
	String username = request.getParameter("username");
	String content = request.getParameter("content");
	if(!(content == null || content.equals(""))){
		EvaluateDaoImpl evaluateDao = new EvaluateDaoImpl();
		Evaluate evaluate = new Evaluate();
		evaluate.setUsername(username);
		evaluate.setContent(content);
		evaluateDao.addEvalute(evaluate);
		out.println("评价成功，感谢您的反馈！");
	}
%>


<body>
<form action="evaluate.jsp" style="width:50%;margin-left:auto;margin-right:auto;">
	在这里写下您的体验、建议等：<br/><br />
	<textarea name="content" style="width:100%;height:100px;"></textarea>
	您的姓名：<input name="username" />
	<button style="float:right;">提交评价</button>
</form>
</body>
</html>