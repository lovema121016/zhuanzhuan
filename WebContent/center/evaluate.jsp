<%@page import="com.zhuanzhuan.dao.MessageDaoImpl"%>
<%@page import="com.zhuanzhuan.model.Message"%>
<%@page import="com.zhuanzhuan.model.Order"%>
<%@page import="com.zhuanzhuan.util.DaoFactory"%>
<%@page import="com.zhuanzhuan.dao.OrderDaoImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>评价</title>
<link type="text/css" rel="stylesheet" href="../layui/css/layui.css">
</head>
<body  onload="test()">
<p align="center"  style="margin-top: 10px;">请对这次购物体验进行评价</p>
<table align="center" style="margin-top: 5px;">
    <tr style="font-size:40px">
        <td>★</td><td>★</td><td>★</td><td>★</td><td>★</td>
    </tr>
    <tr height="10px"></tr>
</table>
<div align="center"><button type="button" id="ok" class="layui-btn">提交</button></div>

<script>
    tds=document.getElementsByTagName("td");
    for(var i=0;i<tds.length;i++){
        tds[i].onmouseover=test;
    }
    var index;
    function  test(){

        for(var i=0;i<tds.length;i++){
            if(tds[i]==this)
            {
                index=i;
            }
        }
        //选中的设置成红色 没选中的设置成黑色
        for(var i=0;i<=index;i++) {
            tds[i].style.color = "#F6BA40";
        }
        for(var i=index+1;i<tds.length;i++){
            tds[i].style.color = "black";
        }
    }
    document.getElementById("ok").onclick=function(){
        alert("评价成功！感谢您的评价");
        top.location.href='buyer_orders.jsp';
    }
</script>
	<%
		String id = request.getParameter("id");
		System.out.print(id);
		OrderDaoImpl orderDao = DaoFactory.getOrderDao();
		Order order = orderDao.load(Integer.parseInt(id));
		order.setStatus(Order.FINISH);
		orderDao.update(order);
		Message message = new Message();
		MessageDaoImpl messageDao = DaoFactory.getMessageDao();
		message.setTitle("订单交易成功提醒");
		message.setReciveuserid(order.getBuyerid());
		message.setContent("订单号为："+order.getSerialnumber()+"的订单，交易已完成，谢谢您的使用，祝您生活愉快！");
		messageDao.add(message);
		message.setTitle("订单交易成功提醒");
		message.setReciveuserid(order.getSellerid());
		message.setContent("订单号为："+order.getSerialnumber()+"的订单，交易已完成，谢谢您的使用，祝您生活愉快！");
		messageDao.add(message);
	%>
</body>
</html>