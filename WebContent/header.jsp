<!--<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="user" class="com.zhuanzhuan.model.User" scope="session"/>-->
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
<title>转赚</title>
</head>
<body>
<header id="header">
	<a href="${pageContext.request.contextPath}/index.jsp"><img alt="主页" src="${pageContext.request.contextPath}/img/logo-title.png" style="margin-left:10px;width:22px;">回到主页</a>
	<%if(user.getId() == 0){%>
	<a class="head_account" style="margin-right: 10px;" href="${pageContext.request.contextPath}/login.jsp">[登录]</a>
	<a class="head_account" href="${pageContext.request.contextPath}/regist.jsp">[注册]丨</a>
<%}else{%>
	<a class="head_account" style="margin-right: 10px;" href="${pageContext.request.contextPath}/center/buyer_orders.jsp">[个人中心]</a>
<%-- 	<a class="head_account" href="${pageContext.request.contextPath}/center/msg.jsp">[消息]|</a> --%>
	<a class="head_account" href="${pageContext.request.contextPath}/Logout">[退出登录]|</a>
	<a class="head_account" href="javascript:;">欢迎您，<%=user.getNickname() %>&nbsp;&nbsp;&nbsp;&nbsp;</a>
<%}%>
</header>
</body>
</html>