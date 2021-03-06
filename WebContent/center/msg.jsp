<%@page import="com.zhuanzhuan.dao.UserDaoImpl"%>
<%@page import="com.zhuanzhuan.model.Message"%>
<%@page import="java.util.List"%>
<%@page import="com.zhuanzhuan.util.DaoFactory"%>
<%@page import="com.zhuanzhuan.dao.MessageDaoImpl"%>
<%@page import="com.zhuanzhuan.model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="user" class="com.zhuanzhuan.model.User" scope="session"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>我的消息</title>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
	<%
		UserDaoImpl userDao = DaoFactory.getUserDao();
		List<Message> messages = (List<Message>)request.getAttribute("messages");
		System.out.print(messages.size());
	%>
	<table border = "1">
	<%
		for(Message message : messages){
			User senduser = userDao.load(message.getSenduserid());
	%>
			<tr>
				<td rowspan="2">
					<img style="width:130px;height:130px" alt="" src="../img/header/<%=senduser.getHead() %>"><br><br>
					<div align="center"><b><%=senduser.getNickname() %></b></div>
				</td>
				<td>
					<textarea disabled="disabled" style="font-family:'楷体';font-size:20px" rows="7" cols="110"><%=message.getContent() %></textarea>
				</td>
			</tr>
			<tr>
				<td><div align="right" style="background-color:#EBEBE4">发送时间:<%=message.getTimeStr("yyyy-MM-dd HH:mm:ss") %></div></td>
			</tr>
	<%
		}
	%>
	</table>
</body>
</html>