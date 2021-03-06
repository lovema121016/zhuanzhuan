<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.zhuanzhuan.model.User"%>
<%@page import="com.zhuanzhuan.dao.UserDaoImpl"%>
<%@page import="com.sun.org.apache.xerces.internal.util.Status"%>
<%@page import="com.zhuanzhuan.model.Good"%>
<%@page import="com.zhuanzhuan.util.DaoFactory"%>
<%@page import="com.zhuanzhuan.dao.GoodDaoImpl"%>
<%@page import="com.zhuanzhuan.model.Order"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="user" class="com.zhuanzhuan.model.User" scope="session"/>
<%
// 加载订单列表
List<Order> orders = (List<Order>) request.getAttribute("orders");
// 商品实现类
GoodDaoImpl goodDao = DaoFactory.getGoodDao(); 
UserDaoImpl userDao = DaoFactory.getUserDao();
// 买家订单状态
String status1[] = {"交易关闭","待付款","等待卖家确认","等待卖家发货","待收货","待评价","交易完成"};
// 卖家订单状态
String status2[] = {"交易关闭","等待买家付款","待确认","待发货","等待买家收货","等待买家评价","交易完成"};
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.2.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/layer/layer.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/demo.js"></script>
<script>
	function urge(id) {
		var xmlhttp;
		if (window.XMLHttpRequest)
		{
			//  IE7+, Firefox, Chrome, Opera, Safari 浏览器执行代码
			xmlhttp=new XMLHttpRequest();
		}
		else
		{
			// IE6, IE5 浏览器执行代码
			xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.open("POST","urge.jsp?id=" + id,true);
		xmlhttp.send();
		layer.msg("催促成功，请耐心等待！",{anim: 0,time:1500},function(){
		});
	}
	function evaluate1(id){
	    layer.open({
	        type: 2,
	        title: '评价',
	        shadeClose: true,
	        shade: false,
	        maxmin: true, //开启最大化最小化按钮
	        content: ['evaluate.jsp?id='+id, 'no'],
	        area: ['400px', '200px'],
	    });
	}
</script>
<title>我的订单</title>
</head>
<body style="margin: 0px;">
<%
for(Order order:orders)		// 遍历输出订单
{
	//获取商品信息
	Good good = goodDao.load(order.getGoodid());
	User goodowner = null;
	User buyer = null;
	if(user.getId() == order.getBuyerid())
	  	goodowner = userDao.load(order.getSellerid()); 
	else buyer = userDao.load(order.getBuyerid());
%>
	<table class="order" width="100%" cellspacing="0" cellpadding="8">
		<tr id="orderkey" height="30">
			<td colspan="2" align="left" style="font-family: tahoma ;"><%=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(order.getTime())  %></td>
			<td colspan="4" align="left" ">订单号：<%=order.getSerialnumber() %></td>
			<%if(user.getId() == order.getBuyerid()){ %>
			<td colspan="2" align="right">卖家：<%=goodowner.getNickname() %></td>
			<%}else if(user.getId() == order.getSellerid()){ %>
			<td colspan="2" align="right">买家：<%=buyer.getNickname() %></td>
			<%} %>
		</tr>
		<tr id="ordervalue" height="120px">
			<td width="8%"><img width="55" alt="<%=good.getGoodname() %>" src="${pageContext.request.contextPath}/img/goods/<%=good.getImages()[0]%>"></td>
			<td valign="center" width="22%"><a target="_blank" href="${pageContext.request.contextPath}/Good?id=<%=good.getId()%>"><%=good.getGoodname() %></a></td>
			<td width="10%" align="center"><%=order.getPrice() %></td>
			<td width="10%" align="center"><%=order.getNum() %></td>
			<td width="12%" align="center">
				<p>退款</p>
				<p>投诉</p>
			</td>
			<td width="10%" align="center"><%=order.getPrice() * order.getNum() %></td>
			<%if(user.getId() == order.getBuyerid()){ %>
				<td width="14%" align="center"><%=status1[order.getStatus()] %></td>
			<%}else{ %>
				<td width="14%" align="center"><%=status2[order.getStatus()] %></td>
			<%} %>
			<td width="14%" align="center">
			<!-- 如果当前是买家的订单  -->
			<%if(user.getId() == order.getBuyerid()){ %>
				<%if(order.getStatus() == Order.WAIT_TO_PAY) {				%>
					<!-- <a target="_blank" href="${pageContext.request.contextPath}/pay.jsp?id=<%=order.getId() %>"><button class="pay_button">立即付款</button></a><br/> -->
					<a href="javascript:;"><button onclick="pay(<%=order.getId() %>,<%=goodowner.getId() %>,'<%=goodowner.getAlipay() %>')" class="pay_button">立即付款</button></a><br/>
					<a href="javascript:;" onclick="cancelOrder(<%=order.getId() %>);">取消订单</a>
				<%}else if(order.getStatus() == Order.WATT_TO_RECEIVE_MONEY){ %>
					<a onclick="urge(<%=order.getId() %>)"><button class="pay_button">催促卖家</button></a><br/>
				<%}else if(order.getStatus() == Order.WAIT_TO_SEND){ %>
					<a href="javascript:;"><button class="pay_button">催促卖家</button></a><br/>
				<%}else if(order.getStatus() == Order.WAIT_TO_RECEIVE){ %>
					<a href="javascript:;"><button onclick="receive(<%=order.getId() %>)" class="pay_button">确认收货</button></a><br/>
				<%}else if(order.getStatus() == Order.WAIT_TO_REVIEW){ %>
					<a onclick="evaluate1(<%=order.getId() %>)"><button class="pay_button">评价</button></a><br/>
				<%}else {%>
					<a href="javascript:;"><button class="pay_button">查看</button></a><br/>
				<%}
			}else{%><!-- 买家订单结束，判断如果是卖家的订单 -->
				<%if(order.getStatus() == Order.WAIT_TO_PAY) {%>
					<a href="${pageContext.request.contextPath}/pay.jsp?id=<%=order.getId() %>"><button class="pay_button">查看</button></a><br/>
				<%}else if(order.getStatus() == Order.WATT_TO_RECEIVE_MONEY){ %>
					<a href="javascript:;"><button onclick="receive_money(<%=order.getId() %>)" class="pay_button">确认收款</button></a><br/>
				<%}else if(order.getStatus() == Order.WAIT_TO_SEND){ %>
					<a href="javascript:;"><button onclick="deliver(<%=order.getId() %>)" class="pay_button">发货</button></a><br/>
				<%}else if(order.getStatus() == Order.WAIT_TO_RECEIVE){ %>
					<a href="javascript:;"><button class="pay_button">查看</button></a><br/>
				<%}else if(order.getStatus() == Order.WAIT_TO_REVIEW){ %>
					<a href="javascript:;"><button class="pay_button">查看</button></a><br/>
				<%}else {%>
					<a href="javascript:;"><button class="pay_button">查看</button></a><br/>
				<%}
			}%>
			</td>
		</tr>
	</table>
	<tr><td>&nbsp;</td></tr>	<!-- 空行 -->
<%} %>
	</body>
</html>