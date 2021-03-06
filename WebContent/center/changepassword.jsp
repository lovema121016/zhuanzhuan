<%@page import="com.zhuanzhuan.util.DaoFactory"%>
<%@page import="com.zhuanzhuan.dao.UserDaoImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="user" class="com.zhuanzhuan.model.User" scope="session"></jsp:useBean>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>更改密码</title>
</head>
<body>
	<%
		String newpass = request.getParameter("newpassword");
		user.setPassword(newpass);
		UserDaoImpl userDao = DaoFactory.getUserDao();
		userDao.update(user);
		out.print("<script>alert('修改密码成功！');window.top.location.href='User.jsp';</script>");
	%>
</body>
</html>