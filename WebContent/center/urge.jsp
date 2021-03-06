<%@page import="com.zhuanzhuan.dao.OrderDaoImpl"%>
<%@page import="com.zhuanzhuan.model.Order"%>
<%@page import="com.zhuanzhuan.model.Message"%>
<%@page import="com.zhuanzhuan.util.DaoFactory"%>
<%@page import="com.zhuanzhuan.dao.MessageDaoImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String id = request.getParameter("id");
		OrderDaoImpl orderDao = DaoFactory.getOrderDao();
		Order order = orderDao.load(Integer.parseInt(id));
		MessageDaoImpl messageDao = DaoFactory.getMessageDao();
		Message message = new Message();
		message.setTitle("订单催促提醒");
		message.setReciveuserid(order.getSellerid());
		message.setSenduserid(0);
		message.setContent("订单 订单号："+order.getSerialnumber()+"的买家已经等很长时间了，请尽快确认信息并发货。");
		messageDao.add(message);
	%>
</body>
</html>