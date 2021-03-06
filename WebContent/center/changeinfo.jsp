<%@page import="com.zhuanzhuan.util.DaoFactory"%>
<%@page import="com.zhuanzhuan.dao.UserDaoImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="user" class="com.zhuanzhuan.model.User" scope="session"></jsp:useBean>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>更改资料</title>
</head>
<body>
	<%
		String nickname = request.getParameter("nickname");
		String sex = request.getParameter("sex");
		String phone = request.getParameter("phone");
		String dormitory = request.getParameter("dormitory");
		String room = request.getParameter("room");
		user.setNickname(nickname);
		if(sex.equals("男")){
			user.setSex(false);
		}else{
			user.setSex(true);
		}
		user.setMobilephone(phone);
		user.setDormitory(dormitory);
		user.setRoom(room);
		UserDaoImpl userDao = DaoFactory.getUserDao();
		userDao.update(user);
		out.print("<script>alert('修改信息成功！');window.top.location.href='User.jsp';</script>");
	%>
</body>
</html>