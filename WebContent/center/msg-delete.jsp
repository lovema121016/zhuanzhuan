<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@page import="com.zhuanzhuan.model.Message"%>
<%@page import="com.zhuanzhuan.dao.MessageDaoImpl"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>删除系统消息</title>
</head>
<body>
<%

//获取系统消息id
	int id=Integer.parseInt(request.getParameter("id"));
	MessageDaoImpl messageDao=new MessageDaoImpl();
	messageDao.delete(id);
	out.print("<script>alert('删除成功');window.top.location.href='message.jsp';</script>");
%>
</body>
</html>