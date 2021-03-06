<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="user" class="com.zhuanzhuan.model.User" scope="session"></jsp:useBean>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="../layui/css/layui.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../js/jquery-3.2.1.js"></script>
<title>更改支付宝</title>
<script>
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
	        y += x.substring(x.lastIndexOf('\\')+1)+";";
	        document.getElementById("name").value = y;
	        //或者 img.src = this.result;  //e.target == this
	    }
	   reader.readAsDataURL(file);
	   //alert($("input[type='file']").val());
	}
	$(document).ready(function(){
		check_alipay();
	});
	function check_alipay() {
		var alipay = $("#alipay").val();
		if(($("#alipay").val() == null)||(alipay=="")){
			$(".tip").eq(0).html("×");
			$(".tip").eq(0).css({"color":"red"});
			$(".tip").eq(0).attr("title",'请填写支付宝账号');
		}else{
			$(".tip").eq(0).html("√");
			$(".tip").eq(0).css({"color":"green"});
			$(".tip").eq(0).attr("title",'');
		}
	}
</script>
</head>
<body>
	<form action="changealipay.jsp" method="post" enctype="multipart/form-data">
	<div align="center">
		<table border="0" style="font-size:20px;font-family:'黑体'">
			<tr height="10"></tr>
			<tr>
				<td>支付宝账号：</td>
				<td>
				<%if(user.getAlipay() == null || "".equals(user.getAlipay())){%>
					<input id="alipay" type="text" name="alipay" value="" oninput="check_alipay()" />
				<%}else{%>
					<input id="alipay" type="text" name="alipay" value="<%=user.getAlipay() %>" oninput="check_alipay()" />
				<%} %>
				</td>
				<td class="tip">&nbsp;&nbsp;</td>
			</tr>
			<tr height="20"></tr>
			<tr align="center">
				<td colspan="2">二维码：</td>
			</tr>
			<tr align="center">
				<td colspan="2">
					<img id="xmTanImg" style="width:239px;height:297px" src="../img/alipayQRcode/<%=user.getId() %>.jpg" onclick="xdaTanFileImg.click()" />
    				<input style="display:none" name="alipayQR" type="file" id="xdaTanFileImg" onchange="xmTanUploadImg(this)" accept="image/*"/>
    				<input type="hidden" id="name" name="nam" value="" />
				</td>
			</tr>
			<tr height="20"></tr>
			<tr>
				<td colspan="2" align="center">
					<button class="layui-btn" type="submit">保存</button>
				<td>
			</tr>
		</table>
	</div>
	</form>
</body>
</html>