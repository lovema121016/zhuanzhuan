<%@page import="com.zhuanzhuan.model.Good"%>
<%@page import="com.zhuanzhuan.util.DaoFactory"%>
<%@page import="com.zhuanzhuan.dao.GoodDaoImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>删除发布过的商品</title>
</head>
<body>

<%
	//接收该商品id
	int id=Integer.parseInt(request.getParameter("id"));
	//根据id查找到商品信息，将数量修改为-1
	GoodDaoImpl gooddao=DaoFactory.getGoodDao();
	Good good=gooddao.load(id);
	good.setNum(-1);
 	try{
		
 		gooddao.update(good);
		//重定向
		response.sendRedirect("released_show.jsp");
 		
 	}catch(Exception e){
	%>
		<h2 style="color:red ; font-size:50px">发生错误 : <%=e.getMessage() %></h2>
	<%
	}
	%>
	


</body>
</html>