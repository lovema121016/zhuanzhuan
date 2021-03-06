<%@page import="com.zhuanzhuan.dao.UserDaoImpl"%>
<%@page import="com.zhuanzhuan.model.Courier"%>
<%@page import="com.zhuanzhuan.util.DaoFactory"%>
<%@page import="com.zhuanzhuan.dao.CourierDaoImpl"%>
<%@page import="com.zhuanzhuan.model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="user" class="com.zhuanzhuan.model.User" scope="session"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>个人中心</title>
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
<link href="../css/style.css" rel="stylesheet" type="text/css">
<link href="../layui/css/layui.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../js/jquery-3.2.1.js"></script>
<script type="text/javascript" src="../js/demo.js"></script>
<script type="text/javascript" src="../layer/layer.js"></script>
<script>
	//选择图片，马上预览
	function xmTanUploadImg(obj) {
		var file = obj.files[0];
	    console.log(obj);console.log(file);
	    console.log("file.size = " + file.size);  //file.size 单位为byte
	    var reader = new FileReader();
	    //读取文件过程方法
	    reader.onloadstart = function (e) {
	        console.log("开始读取....");
	    }
	    reader.onprogress = function (e) {
	        console.log("正在读取中....");
	    }
	    reader.onabort = function (e) {
	        console.log("中断读取....");
	    }
	    reader.onerror = function (e) {
	        console.log("读取异常....");
	    }
	    reader.onload = function (e) {
	        console.log("成功读取....");
	        var img = document.getElementById("xmTanImg");
	        img.src = e.target.result;
	        var x = document.getElementById("xdaTanFileImg").value;
	        var y = x.substring(x.lastIndexOf('\\')+1);
	        document.getElementById("name").value = y;
	       	var confirm = document.getElementById("confirm");
	       	confirm.style.display="block";
	        //或者 img.src = this.result;  //e.target == this
	    }
	   reader.readAsDataURL(file);
	}
	function changealipay(){
		layer.open({
			type:2,
			content:['changealipayInput.jsp'],
			area:['400px','500px']
		});
	}
	function changeQq(){
		layer.open({
			type:2,
			content:['changeqqInput.jsp'],
			area:['200','300']
		});
	}
</script>
</head>
<body style="margin:0px;">
	<jsp:include page="../header.jsp"></jsp:include>
		<div id="functionmenu" style="float: left">
			<ul>
				<a href="buyer_orders.jsp"><li>我购买的商品</li></a>
				<a href="seller_orders.jsp"><li>出售订单</li></a>
				<a href="released_goods.jsp"><li>我发布的商品</li></a>
				<a href="ShoppingCarts"><li>购物车</li></a>
				<a href="javascript:;"><li><b>个人资料</b></li></a>
				<a href="buy_history.jsp"><li>购买历史</li></a>
				<a href="sell_history.jsp"><li>出售历史</li></a>
			</ul>	
		</div>
	<!-- 个人资料框 -->
	<div class="userinfo" id="userinfo">
		<h3 style="padding-top: 20px;">我的资料</h3>
		<hr />
		<!-- 上传图片表单，全部隐藏，使用后面的链接点击事件调用input的onclick方法实现表单提交 -->
		<form action="changeheader.jsp" method="post" enctype="multipart/form-data">
			<input type="hidden" id="name" name="name1" value="" />
			<input name="header" type="file" id="xdaTanFileImg" onchange="xmTanUploadImg(this)" accept="image/*" style="display:none;"/>
			<input id="confirm1" style="display:none" type="submit" value="确定上传">
			<p style="background-color: #f8f8f8;">
			<%
				if(user.getHead()==null || user.getHead().equals("")){
			%>
				<img id="xmTanImg" alt="" style="width:50px;" src="../img/header/head.JPG">
			<%
				}else{
			%>
				<img id="xmTanImg" src="../img/header/<%=user.getHead() %>" style="width: 50px;height:50px;border-radius: 25px;"/>
			<%
				}
			%>
				<%=user.getNickname() %>
				<a href="javascript:;" style="float: right;color:#e37318" onclick="$('#xdaTanFileImg').click()">更改头像</a><br/>
				<a href="javascript:;" id="confirm" style="display:none;float: right;" onclick="$('#confirm1').click()">确认上传</a>
			</p>
		</form>
		<!-- 上传图片表单结束 -->
		<p style="background-color: #f7f2f7;">真实姓名：<%=user.getRealname() %></p>
		<p style="background-color: #f8f8f8;">学号：<%=user.getUsername() %></p>
		<p style="background-color: #f7f2f7;">性别：<%=user.getSex() ? "女" : "男"%></p>
		<p style="background-color: #f8f8f8;">手机号码：<%=user.getMobilephone() %></p>
		<p style="background-color: #f7f2f7;">QQ：<%if(user.getQq() != null){%><%=user.getQq() %><a style="color:blue;float:right;" onclick="changeQq()">更改QQ</a><%}else{ %><%="您没有绑定QQ"%><a style="font-size:10px;color:blue;text-decoration:underline" onclick="changeQq()">立即绑定</a><%} %></p>
		<p style="background-color: #f8f8f8;">地址：<%=user.getDormitory() %>栋<%=user.getRoom() %><a href="javascript:;" style="float: right;" onclick="change()">修改个人资料</a></p>
		<p style="background-color: #f7f2f7;">密码：●●●●●●●●●●<a href="javascript:;" style="float: right;" onclick="change()">修改密码</a></p>
	</div>
	<!-- 个人资料框结束 -->
	<!-- 支付宝信息框 -->
	<div class="userinfo" id="alipayinfo" style="margin-top: 6px;float: left;width: 35%;font-size: 16px;">
		<h3 style="padding-top: 20px;">我的支付宝</h3>
		<hr/>
		<%if(user.getAlipay() == null || user.getAlipay().equals("")){ %>
			<p style="background-color: #f8f8f8;">支付宝账号：您还没有添加支付宝信息，买家无法向您付款，请<a href="javascript:;" style="color:blue;text-decoration:underline" onclick="changealipay()">点击这里</a>添加</p>
		<%}else{ %>
			<p style="background-color: #f8f8f8;">支付宝账号：<%=user.getAlipay() %><a onclick="changealipay()" style="color:blue;text-decoration:underline">支付宝已换？点击更改</a></p>
		<%} %>
		<p style="background-color: #f7f2f7;text-align: center;height:378px;">二维码：<br/><img alt="您还没有上传二维码" id="xmTanImg1" src="../img/alipayQRcode/<%=user.getId() %>.jpg" width="200" height="303.517" style="line-height:16" /></p>
	</div><!-- 支付宝信息框结束 -->
	<%		//判断是否是天使快递员，以决定是否显示“加入天使快递链接”
	CourierDaoImpl courierDao = DaoFactory.getCourierDao();
	Courier courier = courierDao.load(user.getId());
	if(courier == null){
	%>
		<div style="clear:left;text-align:center;margin-top: 530px;"><a href="javascript:;" onclick="regist_deliver()">加入“天使快递”</a>&nbsp;&nbsp;&nbsp;详见<a href="../help.jsp">《天使快递员计划》</a></div>
	<%} %>
	<div id="cover"></div>
	<!-- 修改密码框 -->
    <div id="changepass">
    <a id="changepassword" href="changepasswordInput.jsp" target="changep">修改密码</a>&nbsp;&nbsp;&nbsp;<a id="changeinfo" href="changeinfoInput.jsp" target="changep">修改详细信息</a><span><a onClick="closeChangeWindow()" style="float: right;" href="javascript:;">X</a></span>
       <hr color="red" />
       <iframe id="change" name="changep"  src="changepasswordInput.jsp">
       </iframe>
    </div>
    <br><br>
    <jsp:include page="../foot.jsp"></jsp:include>
</body>
</html>