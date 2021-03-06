<%@page import="com.zhuanzhuan.model.Courier"%>
<%@page import="com.zhuanzhuan.util.DaoFactory"%>
<%@page import="com.zhuanzhuan.dao.CourierDaoImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="user" class="com.zhuanzhuan.model.User" scope="session" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
CourierDaoImpl courierDao = DaoFactory.getCourierDao();
Courier courier = courierDao.load(user.getId());
%>
	当前余额：<%=courier.getSalary() %>
	<form action="">
		提现金额：<input type="text" />
		<button>提现</button>
	</form>
</body>
</html>