<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="user" class="com.zhuanzhuan.model.User" scope="session"></jsp:useBean>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link type="text/css" rel="stylesheet" href="../layui/css/layui.css">
<title>更改QQ信息</title>
</head>
<body>
	<%
		String qq = null;
		if(user.getQq() == null){
			qq = "";
		}else{
			qq = user.getQq();
		}
	%>
	<div>
		<form style="font-size:18px" action="changeqq.jsp">
			<br><br>
			<p align="center">QQ：<input type="text" name="qq" value=<%=qq %>></p>
			<br>
			<p align="center"><button type="submit" class="layui-btn">提交</button></p>
		</form>
	</div>
</body>
</html>