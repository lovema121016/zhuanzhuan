<%@page import="java.util.Collections"%>
<%@page import="com.zhuanzhuan.model.Message"%>
<%@page import="java.util.List"%>
<%@page import="com.zhuanzhuan.util.DaoFactory"%>
<%@page import="com.zhuanzhuan.dao.MessageDaoImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
MessageDaoImpl messageDao = DaoFactory.getMessageDao();
List<Message> messages = (List<Message>) request.getAttribute("messages");
Collections.reverse(messages); 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>列表显示系统消息</title>
<link href="../css/style.css" rel="stylesheet" type="text/css">
</head>
<body>
<table>
<% 
	for(Message message:messages)
	{
%>
	<tr>
		<td style="font-family:宋体;font-size:20px;">
		<%if(message.getStatus() == Message.READ){ %>
			<a class="msg_title" href="msg-show.jsp?id=<%=message.getId()%>"><%=message.getTitle()%></a>
		<%}else{ %>
			<a class="msg_title msg_unread" href="msg-show.jsp?id=<%=message.getId()%>"><%=message.getTitle()+"（未读）"%></a>
		<%} %>
		</td>
		<td style="position: absolute;right:20%;font-size:20px;">
			<%=message.getTimeStr("yyyy-MM-dd HH:mm:ss")%>
			<a class="msg_title" href="msg-delete.jsp?id=<%=message.getId()%>" style="text-decoration:none">（删除）</a>
		</td>
	</tr>
<% 	
	}
%>
 </table>	
 	
</body>
</html>