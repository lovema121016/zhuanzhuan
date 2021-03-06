<%@page import="com.zhuanzhuan.exception.OrderException"%>
<%@page import="java.sql.Date"%>
<%@page import="com.zhuanzhuan.dao.UserDaoImpl"%>
<%@page import="com.zhuanzhuan.model.User"%>
<%@page import="com.zhuanzhuan.util.DaoFactory"%>
<%@page import="com.zhuanzhuan.dao.GoodDaoImpl"%>
<%@page import="com.zhuanzhuan.model.Good"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="user" class="com.zhuanzhuan.model.User" scope="session"></jsp:useBean>

<%
	int id = 0;
	int num = 0;
	String ordertype = null;
	try{
		id = Integer.parseInt(request.getParameter("goodid"));
		num = Integer.parseInt(request.getParameter("num"));
		
		ordertype = request.getParameter("select");
	}catch(NumberFormatException e){
		out.println("订单出错！！");
		e.printStackTrace();
	}
	GoodDaoImpl goodDao = DaoFactory.getGoodDao();
	UserDaoImpl userDao = DaoFactory.getUserDao();
	Good good = goodDao.load(id); 
	User goodowner = userDao.load(good.getGoodownerid());
	int type = 0;
	if("线上交易".equals(ordertype))
		type = 1;
	else type = 0;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/style.css" />
<script type="text/javascript" src="js/jquery-3.2.1.js" ></script>
<script type="text/javascript" src="js/demo.js" ></script>
<title>订单确认</title>
</head>
<body>
	<table width="75%" border="0" align="center" >
		<tr>
			<td colspan="6">确认订单信息</td>
		</tr>
		<tr>
			<td colspan="2" class="orderkey" width="50%">宝贝</td>
			<td class="orderkey" width="12%">单价</td>
			<td class="orderkey" width="12%">数量</td>
			<td class="orderkey" width="12%">小计</td>
		</tr>
		<tr>
			<td colspan="2" height="60">卖家：<%=goodowner.getNickname() %></td>
		</tr>
		<tr>
			<td width="50" valign="center"><img src="img/goods/<%=good.getImages()[0] %>" width="50" style="vertical-align: middle;" /></td>
			<td><div style="display: inline-block;height: 100%;"><a href="javascript:;"><%=good.getGoodname() %></a></div></td>
			<td align="center" id="price"><%=good.getPrice() %></td>
			<td align="center">
				<div style="width: 78px;">
					<button id="increase">+</button>
					<input disabled="disabled" id="num" value="<%=num%>">
					<button id="decrease">-</button>
				</div>
			</td>
			<td align="center" id="sum" class="price"><%=good.getPrice() * num %></td>
		</tr>
		<tr bgcolor="#B2D1FF">
			<td colspan="2">给卖家留言：<input /></td>
			<td colspan="2">运费：</td>
			<td id="freight" align="center" class="price"><%=good.getFreight()%></td>
		</tr>
		<tr bgcolor="#B2D1FF">
			<td colspan="5" align="right" id="sumprice" class="price">合计：<%=good.getPrice() * num + good.getFreight() %>&nbsp;&nbsp;&nbsp;&nbsp;</td>
		</tr>
		<tr>
			<td colspan="5" align="right">
				<div style="text-align: right;border: solid red 2px; width: 40%;padding: 10px;">
					<p>实付款：<span class="price" id="realpay" style="font-size:30px">￥<%=good.getPrice() * num + good.getFreight() %></span></p>
					寄送至：<%=user.getDormitory() %>#<%=user.getRoom() %><br />
					收货人：<%=user.getRealname() %>&nbsp;&nbsp;<%=user.getMobilephone() %>
				</div>
				<div>
					<form target="_blank" action="SubmitOrder" method="post" onsubmit="history.go(-1)">
						<input type="hidden" name="buyerid" value="<%=user.getId() %>" />
						<input type="hidden" name="sellerid" value="<%=goodowner.getId() %>" />
						<input type="hidden" name="goodid" value="<%=good.getId() %>" />
						<input type="hidden" name="num" value="<%=num %>">
						<input type="hidden" name="price" value="<%=good.getPrice()%>" />
						<input type="hidden" name="goodnum" value="<%=good.getNum()%>">
						<input type="hidden" name="freight" value="<%=good.getFreight() * type%>">
						<input type="hidden" name="type" value="<%=type %>"> 
						<button class="submit_order">提交订单</button>
					</form>
				</div>
			</td>
		</tr>
	</table>
</body>
</html>
