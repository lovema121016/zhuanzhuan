<%@page import="com.zhuanzhuan.model.Message"%>
<%@page import="com.zhuanzhuan.dao.MessageDaoImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>显示系统信息内容</title>
</head>
<body>
<%
	//获取系统消息id
	int id=Integer.parseInt(request.getParameter("id"));
	//根据id查询消息内容
	
	MessageDaoImpl messageDao=new MessageDaoImpl();
	Message message=messageDao.loadone(id);
	
%>
<!-- 显示消息内容 -->
	<table>
		<tr height="20px">
		</tr>
		<tr >
			<td style="position: absolute;right:50%;font-family:黑体;font-size:20px">
			<%=message.getTitle() %>
			</td>
		</tr>
		<tr height="30px" >
		</tr>
		<tr style="font-size:楷体;font-size:20px;">
			<td>
				<%=message.getContent() %>
			</td>
		</tr>
	</table>
<%
//修改类型 为已读
	message.setStatus(1);
	messageDao.update(message);
%>
</body>
</html>