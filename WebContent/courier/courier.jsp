<%@page import="com.zhuanzhuan.model.Courier"%>
<%@page import="com.zhuanzhuan.dao.CourierDaoImpl"%>
<%@page import="com.zhuanzhuan.util.DaoFactory"%>
<%@page import="com.zhuanzhuan.model.GoodStream"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="user" class="com.zhuanzhuan.model.User" scope="session"/>

<%
CourierDaoImpl courierDao = DaoFactory.getCourierDao();
Courier courier = courierDao.load(user.getId());
if(user.getId() == 0){%>
	<jsp:forward page="../error.jsp">
		<jsp:param value="您没有权限访问该页面。" name="error_msg"/>
	</jsp:forward>
<%}else if(courier == null){ %>
	<%-- <jsp:forward page="">
		<!-- 跳转申请天使快递员页面 -->
	</jsp:forward> --%>
<%} %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="../css/style.css" />
<script type="text/javascript" src="../js/jquery-3.2.1.js" ></script>
<link rel="stylesheet" href="../layui/css/layui.css" />
<script type="text/javascript" src="../layui/layui.js" ></script>
<script type="text/javascript" src="../js/demo.js" ></script>
<style type = "text/css">
	a:link{
		color:blue;
		text-decoration:none;
	}
	a:hover{
		color:red;
		text-decoration:none;
		position:relative;
		top:1px;
		left:1px;
	}
</style>
<title>我的主页</title>
</head>
<body onload="orderClass(0)">
<jsp:include page="../header.jsp"></jsp:include>

<div id="functionmenu" style="float: left">
	<ul>
		<a target="stream" href="GoodStreams?status=<%=GoodStream.WAIT_TO_SEND%>"><li>待接单</li></a>
		<a target="stream" href="GoodStreams?courierid=<%=user.getId()%>&status=<%=GoodStream.WAIT_TO_RECEIVE%>"><li>当前任务</li></a>
		<a target="stream" href="GoodStreams?courierid=<%=user.getId()%>&status=<%=GoodStream.FINISH %>"><li>送货历史</li></a>
		<a target="stream" href="salary.jsp"><li>我的工资</li></a>
	</ul>
</div>
<br />
<div id="usertype" style="display:none">1</div>
<!-- 订单列表主体开始 -->
<iframe name="stream" width="70%" frameborder="no" src="GoodStreams?status=<%=GoodStream.WAIT_TO_SEND%>" style="min-height:500px;">
	
</iframe>
<!-- 订单列表结束 -->
</table>
</body>
</html>