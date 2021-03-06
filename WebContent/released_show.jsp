<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <jsp:useBean id="user" class="com.zhuanzhuan.model.User" scope="session"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.zhuanzhuan.model.User"%>
<%@page import="com.zhuanzhuan.dao.UserDaoImpl"%>
<%@page import="com.sun.org.apache.xerces.internal.util.Status"%>
<%@page import="com.zhuanzhuan.model.Good"%>
<%@page import="com.zhuanzhuan.util.DaoFactory"%>
<%@page import="com.zhuanzhuan.dao.GoodDaoImpl"%>
<%@page import="com.zhuanzhuan.model.Order"%>
<%@page import="java.util.List"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>显示发布商品</title>
<style type = "text/css">
	a{
		color:#b61616;
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
</head>
<body>
	<%
	//商品实现类
	GoodDaoImpl goodDao = DaoFactory.getGoodDao(); 
	UserDaoImpl userDao = DaoFactory.getUserDao();
	// 搜索所有商品，跟当前user比对，留下user发布过的商品
	List<Good> goods = goodDao.load("");
	List<Good> newgoods=new ArrayList<Good>();
	for(int i=0;i<goods.size();i++)
	{
		if(user.getId()==goods.get(i).getGoodownerid()&&(goods.get(i).getNum()>=0))
		{		
			newgoods.add(goods.get(i));
		}
	}

for(int i=newgoods.size()-1;i>=0;i--)		// 遍历输出商品信息
{
	
%>
	<table  width="100%" cellspacing="0" cellpadding="8">
		<tr id="ordervalue" height="90px">
			<td width="8%"><img width="55" alt="<%=newgoods.get(i).getGoodname() %>" src="${pageContext.request.contextPath}/img/goods/<%=newgoods.get(i).getImages()[0]%>"></td>
			<td valign="center" width="22%"><a target="_blank" href="${pageContext.request.contextPath}/Good?id=<%=newgoods.get(i).getId()%>"><%=newgoods.get(i).getGoodname() %></a></td>
			<td width="21%" align="center"><%=newgoods.get(i).getPrice() %></td>
			<td width="21%" align="center"><%=newgoods.get(i).getNum() %></td>
			<td width="34%" align="center">
				<p><a href="update_released-input.jsp?id=<%=newgoods.get(i).getId()%>">编辑</a></p>
				<p><a href="delete_released.jsp?id=<%=newgoods.get(i).getId()%>">删除</a></p>
			</td>		
		</tr>
		<tr><td colspan="5"><hr style="color: beige;"/></td></tr>	<!-- 空行 -->
	</table>
	
<%
}
%>
</body>
</html>