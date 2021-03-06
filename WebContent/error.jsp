<%@page import="com.zhuanzhuan.exception.OrderException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%OrderException orderException = (OrderException)request.getAttribute("orderException"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>错误</title>
</head>
<body>
<%
	if(orderException != null){ 
		out.println("<script>alert('"+orderException.getMessage()+"');window.close()</script>");
	}
	String error_msg = request.getParameter("error_msg");
	if(error_msg != null){
%>
	<h1 style="color:red;margin-left:auto;margin-right:auto;"><%=error_msg %></h1>
<%} %>
</body>
</html>