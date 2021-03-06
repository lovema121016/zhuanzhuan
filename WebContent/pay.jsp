<%@page import="com.zhuanzhuan.model.User"%>
<%@page import="com.zhuanzhuan.util.DaoFactory"%>
<%@page import="com.zhuanzhuan.dao.UserDaoImpl"%>
<%@page import="com.zhuanzhuan.exception.OrderException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="order" class="com.zhuanzhuan.model.Order" scope="request"/>
<jsp:useBean id="user" class="com.zhuanzhuan.model.User" scope="session" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.2.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/demo.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>支付页面</title>
</head>
<body>
<%
UserDaoImpl userDao = DaoFactory.getUserDao();
User owner = userDao.load(order.getSellerid());
System.out.println("orderid是" + order.getId() + "(pay.jsp)");
%>
<div id="alipay" style="display:none;"><%=owner.getAlipay() %></div>
<div id="userid" style="display:none;"><%=owner.getId() %></div>
<script type="text/javascript">pay2(<%=order.getId() %>)</script>
</body>
</html>