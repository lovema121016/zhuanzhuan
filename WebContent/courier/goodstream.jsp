<%@page import="com.zhuanzhuan.dao.OrderDaoImpl"%>
<%@page import="com.zhuanzhuan.model.Order"%>
<%@page import="com.zhuanzhuan.dao.UserDaoImpl"%>
<%@page import="com.zhuanzhuan.model.User"%>
<%@page import="java.util.List"%>
<%@page import="com.zhuanzhuan.util.DaoFactory"%>
<%@page import="com.zhuanzhuan.dao.GoodStreamDaoImpl"%>
<%@page import="com.zhuanzhuan.model.GoodStream"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="user" class="com.zhuanzhuan.model.User"/>
<%
GoodStreamDaoImpl goodStreamDao = DaoFactory.getGoodStreamDao();
UserDaoImpl userDao = DaoFactory.getUserDao();
OrderDaoImpl orderDao = DaoFactory.getOrderDao();
List<GoodStream> goodStreams = (List<GoodStream>)request.getAttribute("goodStreams");
String status[] = {"待接单","待发出","派送中","完成"};
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../css/style.css" />
</head>
<body>
<!-- 订单列表头 -->
<table id="tab2" width="100%" cellspacing="0" style="margin-top:66px;border: solid 1px #E8E8E8;">
	<tr id="orderkey" height="30">
		<td width="10%">物流编号</td>
		<td width="14%">订单编号</td>
		<td width="16%">买家</td>
		<td width="18%">卖家</td>
		<td width="16%">状态</td>
		<td width="16%">时间</td>
		<td width="10%">操作</td>
	</tr>
<!-- 订单列表头结束 -->
<%
	for(GoodStream goodStream:goodStreams){
		Order order = orderDao.load(goodStream.getOrderid());
		User buyer = userDao.load(order.getBuyerid());
		User seller = userDao.load(order.getSellerid());
		%>
		<tr height="24" style="height:76px">
			<td align="center"><%=goodStream.getId() %></td>
			<td align="center"><%=order.getSerialnumber() %></td>
			<td align="center">
				<%=buyer.getNickname() %><br/>
				<%=buyer.getMobilephone() %>
			</td>
			<td align="center">
				<%=seller.getNickname() %><br />
				<%=seller.getMobilephone() %>
			</td>
			<td align="center">
				状态：<%=status[goodStream.getStatus()] %>
			</td>
			<td align="center"><%=goodStream.getCreateTime() %></td>
			<td align="center">
				<%if(goodStream.getStatus() == GoodStream.WAIT_TO_SEND){ %>
					<a href="ChangeGoodStream?streamid=<%=goodStream.getId() %>&status=1">接单</a>
				<%}else if(goodStream.getStatus() == GoodStream.WAIT_TO_RECEIVE) {%>
					<a href="ChangeGoodStream?streamid=<%=goodStream %>&status=2">派送</a>
				<%}else if(goodStream.getStatus() == GoodStream.FINISH){%>
					<a href="javascript:;">无</a>
				<%} %>
			</td>
		</tr>
<%} %>
</table>
</body>
</html>