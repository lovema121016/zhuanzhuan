<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="user" class="com.zhuanzhuan.model.User" scope="session"/>
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
<title>我的购买历史</title>
</head>
<body onload="orderClass(0)">
<jsp:include page="../header.jsp"></jsp:include>
<div id="functionmenu" style="float: left">
	<ul>
		<a href="buyer_orders.jsp"><li>我购买的商品</li></a>
		<a href="seller_orders.jsp"><li>出售订单</li></a>
		<a href="released_goods.jsp"><li>我发布的商品</li></a>
		<a href="ShoppingCarts"><li>购物车</li></a>
		<a href="User.jsp" onclick="personimg()"><li>个人资料</li></a>
		<a href="buy_history.jsp"><li>购买历史</li></a>
		<a href="javascript:;"><li><b>出售历史</b></li></a>
	</ul>	
</div>

<!-- 订单列表头 -->
<table id="tab2" width="70%" cellspacing="0" style="margin-top:66px;border: solid 1px #E8E8E8;">
	<tr id="orderkey" height="30">
		<td width="30%">宝贝</td>
		<td width="10%">单价</td>
		<td width="10%">数量</td>
		<td width="12%">商品操作</td>
		<td width="10%">实付款</td>
		<td width="14%">交易状态</td>
		<td width="14%">交易操作</td>
	</tr>
</table>
<!-- 订单列表头结束 -->
<br />
<div id="usertype" style="display:none">2</div>
<!-- 订单列表主体开始 -->
<iframe width="70%" frameborder="no" src="Orders?status=6&usertype=2" style="min-height:500px;">
	
</iframe>
<!-- 订单列表结束 -->
</table>
</body>
</html>