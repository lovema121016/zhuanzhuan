$(document).ready(function(){
	
	/******商品数量增减操作*******/
	/*
	 * 注：使用<input type="hidden" name="goodnum" value="max">
	 * 	设置数量最大值，最大值为max
	 */
	
	if($("#num").val() == 1){							//如果数量 = 1（最小值）
		$("#decrease").attr("disabled","disable");		//给"-"按钮设置disabled属性禁用按钮
	}
	if($("#num").val() == $("input[name='goodnum']").val()){	//如果数量 = 剩余商品数量（最大值）
		$("#increase").attr("disabled","disable");		//给"+"按钮设置disabled属性禁用按钮
	}
	
	$("#increase").click(function(){			//"+"点击事件
		var value = $("#num").val();			//获取当前商品数量 
		if(value < parseInt($("input[name='goodnum']").val())){
			$("#num").val(parseInt(value) + 1);		//数值+1
			$("input[name='num']").val(parseInt(value) + 1);		//隐藏域num+1
			//以下三项随之修改
			$("#sum").html($("#num").val() * $("#price").html());
			$("#realpay").html("￥" + ($("#num").val() * $("#price").html() + parseFloat($("#freight").html())));
			$("#sumprice").html($("#realpay").html());
			$("#decrease").removeAttr("disabled");	//移除"-"按钮的disabled属性，取消按钮禁用
		}
		if($("#num").val() == $("input[name='goodnum']").val()){
			$("#increase").attr("disabled","disable");		//给"+"按钮设置disabled属性禁用按钮
		}
		return false;
	});
	
	$("#decrease").click(function(){			//"-"点击事件
		var value = $("#num").val();			//获取当前商品数量
		if(parseInt(value) > 1){							//当(当前数量 > 1)时，执行
			$("#num").val(parseInt(value) - 1); //数值-1
			$("input[name='num']").val(parseInt(value) - 1);		//隐藏域num-1
			$("#sum").html($("#num").val() * $("#price").html());
			$("#realpay").html("￥" + ($("#num").val() * $("#price").html() + parseFloat($("#freight").html())));
			$("#sumprice").html($("#realpay").html());
			$("#increase").removeAttr("disabled");	//移除"+"按钮的disabled属性，取消按钮禁用
		}
		if($("#num").val() == 1){						//如果数量 > 1
			$("#decrease").attr("disabled","disable");		//给"-"按钮设置disabled属性禁用按钮
		}
		return false;
	});
	/******商品数量增减操作结束******/
	
	
	/****浏览器自动保存学号，当学号有数据时，自动检查学号***/
	var user=document.getElementById("user");
	if(user.value != "")
		check_user();
});

var isPassRight = false;
var isUserRight = false;
var isVerifyRight = false;
function check_user(){
	var user=document.getElementById("user");
	var tip=document.getElementById("tip");
	var patt=/^\d{8}$/;
	if (user.value=="") {
		tip.innerHTML="用户名不能为空！";
		document.getElementById("login_button").disabled=true;
		isUserRight = false;
	} else if(!patt.test(user.value)){
		tip.innerHTML="学号由8位数字组成";
		document.getElementById("login_button").disabled=true;
		isUserRight = false;
	} else if(user.value.length != 8){
		tip.innerHTML="用户名为8位";
		document.getElementById("login_button").disabled=true;
		isUserRight = false;
	}
	else{
		tip.innerHTML="用户名格式正确√";
		if(isPassRight&&isVerifyRight)
			document.getElementById("login_button").disabled=false;
		isUserRight = true;
	}
}
//检查密码
function check_pass(){
	var pass=document.getElementById("password").value;
	var tip=document.getElementById("tip2");
	if(pass.length > 5 && pass.length < 17)
	{
		if(isUserRight&isVerifyRight)
			document.getElementById("login_button").disabled=false;
		tip.innerHTML="密码格式正确√";
		isPassRight = true;
	}
	else{
		document.getElementById("login_button").disabled=true;
		tip.innerHTML = "密码为6-16位数字、字母或“_”";
		isPassRight = false;
	}
}
/****检查验证码****/
function check_verify(){
	var tip=document.getElementById("tip3");
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
	xmlhttp.onreadystatechange=function()
	{
		if (xmlhttp.readyState==4 && xmlhttp.status==200)
		{
			var s = xmlhttp.responseText.toString();
			if(s == "OK"){
				tip.innerHTML = "验证码正确√";
				isVerifyRight = true;
				if(isUserRight&&isPassRight)
					document.getElementById("login_button").disabled=false;
			}
			else{
				tip.innerHTML = "验证码错误×";
				isVerifyRight = false;
				document.getElementById("login_button").disabled=true;
			}
			//document.getElementById("myDiv").innerHTML=xmlhttp.responseText;
		}
	}
	xmlhttp.open("POST","Login?verify=" + $("#identify").val() + "&username=&password=",true);
	xmlhttp.send();
}


//显示注册层
function showRegist(){
	var cov = document.getElementById("cover");
	var reg = document.getElementById("regist");
	cov.style.display = "block";
	reg.style.display = "block";
	
	/****加载切换按钮***/
	var user = document.getElementById("userRegist");
	var owner = document.getElementById("ownerRegist");
	user.style.color="red";
	user.onclick = (function(){
		user.style.color="red";
		owner.style.color="#BBBBBB"
	});
	owner.onclick = (function(){
		user.style.color="#BBBBBB";
		owner.style.color="red";
	});
}
//关闭注册层
function closeRegist(){
	var cov = document.getElementById("cover");
	var reg = document.getElementById("regist");
	cov.style.display = "none";
	reg.style.display = "none";
}

//加载验证码
function reloadImage(){ 
	document.getElementById("randImage").src = "image.jsp?"+Math.random(); 
} 

/***用户信息的显示***/
function personimg() 
{
	//var x = $("#xx").html();
	//x.css("font-family","楷体");
	//var tab1 = document.getElementById("tab1");
	//var tab2 = document.getElementById("tab2");
	//tab1.style.display = "none";
	//tab2.style.display = "none";
	$("iframe").attr("src","User");
}
function test(){
	layer.msg("hello");
}

//关闭修改页面
function closeChangeWindow() {
	var cov = document.getElementById("cover");
	var chan = document.getElementById("changepass");
	cov.style.display = "none";
	chan.style.display = "none";
}
//显示更改密码页面
function change() 
{
	var cov = document.getElementById("cover");
	var chan = document.getElementById("changepass");
	cov.style.display = "block";
	chan.style.display = "block";
}
//取消订单
function cancelOrder(orderid)
{
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
	xmlhttp.onreadystatechange=function()
	{
		if (xmlhttp.readyState==4 && xmlhttp.status==200)
		{
			var s = xmlhttp.responseText.toString();
			if(s == "OK"){
				layer.msg("取消订单成功！",{anim: 0,time:1500},function(){
					location.reload();
				});
			}
			else{
				layer.msg("取消失败！");
			}
		}
	}
	xmlhttp.open("POST","CancelOrder?orderid=" + orderid,true);
	xmlhttp.send();
}
/****添加到购物车****/
function addshoppingcart(goodid)
{
	//alert("df");
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
	xmlhttp.onreadystatechange=function()
	{
		if (xmlhttp.readyState==4 && xmlhttp.status==200)
		{
			var s = xmlhttp.responseText.toString();
			if(s == "OK"){
				
				layer.msg("添加成功！",{anim: 0,time:1500},function(){
				});
			}
			else if(s == "NO_LOGIN"){
				layer.msg("请先登录");
			}
			else{
				layer.msg("添加失败！");
			}
		}
	}
	xmlhttp.open("POST","AddShoppingCart?goodid=" + goodid,true);
	xmlhttp.send();
}

/****删除购物车****/
function deleteshoppingcart(shopid)
{
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
	xmlhttp.onreadystatechange=function()
	{
		if (xmlhttp.readyState==4 && xmlhttp.status==200)
		{
			var s = xmlhttp.responseText.toString();
		}
	}
	console.log("shopid:" + shopid);
	xmlhttp.open("GET","DeleteShoppingCart?shopid=" + shopid,true);
	xmlhttp.send();
}

//立即付款1，（在订单页面点“立即付款”后
function pay(orderid,sellerid,alipay)
{
	layer.confirm('请付款给该账户<br/>支付宝：' + alipay + '<br /><div style="text-align:center"><img style="width:200px" src="../img/alipayQRcode/' + sellerid + '.jpg" onerror="javascript:this.src=\'../img/alipayQRcode/default.jpg\'"/></div>', {
		 area:['400px','500px'] 
		,btn: ['已支付','取消'] //按钮
		}, function(){
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
			xmlhttp.onreadystatechange=function()
			{
				if (xmlhttp.readyState==4 && xmlhttp.status==200)
				{
					var s = xmlhttp.responseText.toString();
					if(s == "OK"){
						layer.msg("提交成功",{anim: 0,time:1500},function(){
							location.reload();
						});
					}
					else{
						layer.msg("提交失败！");
					}
				}
			}
			xmlhttp.open("POST","ChangeOrder?orderid=" + orderid + "&status=2",true);
			xmlhttp.send();
		}, function(){
		  //layer.msg('也可以这样', {
		  //  time: 20000, //20s后自动关闭
		  //  btn: ['明白了', '知道了']
		  //});
		});
}
//立即付款2，（提交订单之后）
function pay2(orderid)
{
	layer.confirm('请付款给该账户<br/>支付宝：' + $('#alipay').html() + '<br /><div style="text-align:center"><img style="width:200px" src="img/alipayQRcode/' + $('#userid').html() + '.jpg" onerror="javascript:this.src=\'./img/alipayQRcode/default.jpg\'"/></div>', {
		 area:['400px','500px'] 
		,btn: ['已支付','取消'] //按钮
		}, function(){
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
			xmlhttp.onreadystatechange=function()
			{
				if (xmlhttp.readyState==4 && xmlhttp.status==200)
				{
					var s = xmlhttp.responseText.toString();
					if(s == "OK"){
						layer.msg("提交成功",{anim: 0,time:1500},function(){
							window.location.href="center/buyer_orders.jsp";
						});
					}
					else{
						layer.msg("提交失败！");
					}
				}
			}
			xmlhttp.open("POST","ChangeOrder?orderid=" + orderid + "&status=2",true);
			xmlhttp.send();
		}, function(){
			window.close();
		  //layer.msg('也可以这样', {
		  //  time: 20000, //20s后自动关闭
		  //  btn: ['明白了', '知道了']
		  //});
		});
}

function receive(orderid)
{
	layer.confirm('是否确认收货', {
		  btn: ['确认','取消'] //按钮
		}, function(){
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
			xmlhttp.onreadystatechange=function()
			{
				if (xmlhttp.readyState==4 && xmlhttp.status==200)
				{
					var s = xmlhttp.responseText.toString();
					if(s == "OK"){
						layer.msg("收货成功",{anim: 0,time:1500},function(){
							location.reload();
						});
					}
					else{
						layer.msg("数据提交失败！");
					}
				}
			}
			xmlhttp.open("GET","ChangeOrder?orderid=" + orderid + "&status=5",true);
			xmlhttp.send();
		}, function(){
		  //layer.msg('也可以这样', {
		  //  time: 20000, //20s后自动关闭
		  //  btn: ['明白了', '知道了']
		  //});
		});
}

function receive_money(orderid)
{
	layer.confirm('是否确认收款', {
		  btn: ['确认','取消'] //按钮
		}, function(){
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
			xmlhttp.onreadystatechange=function()
			{
				if (xmlhttp.readyState==4 && xmlhttp.status==200)
				{
					var s = xmlhttp.responseText.toString();
					if(s == "OK"){
						layer.msg("收款成功，请尽快发货",{anim: 0,time:1500},function(){
							location.reload();
						});
					}
					else{
						layer.msg("数据提交失败！");
					}
				}
			}
			xmlhttp.open("POST","ChangeOrder?orderid=" + orderid + "&status=3",true);
			xmlhttp.send();
		}, function(){
		});
}
function deliver(orderid)
{
	layer.confirm('是否使用天使快递员？', {
		  btn: ['是','否，自己去送','取消'] //按钮
		}, function(){
			var xmlhttp;
			var xmlhttp1;
			if (window.XMLHttpRequest)
			{
				//  IE7+, Firefox, Chrome, Opera, Safari 浏览器执行代码
				xmlhttp=new XMLHttpRequest();
				xmlhttp1=new XMLHttpRequest();
			}
			else
			{
				// IE6, IE5 浏览器执行代码
				xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
				xmlhttp1=new ActiveXObject("Microsoft.XMLHTTP");
			}
			xmlhttp.onreadystatechange=function()
			{
				if (xmlhttp.readyState==4 && xmlhttp.status==200)
				{
					var s = xmlhttp.responseText.toString();
					if(s == "OK"){
						xmlhttp1.open("POST","ChangeOrder?orderid=" + orderid + "&status=4",true);
						xmlhttp1.send();
						layer.msg("提交成功！请耐心等待快递员提件",{anim: 0,time:1500},function(){
							location.reload();
						});
					}
					else{
						layer.msg(s);
					}
				}
			}
			xmlhttp.open("POST","SubmitStream?orderid=" + orderid,true);
			xmlhttp.send();
		}, function(){
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
			xmlhttp.onreadystatechange=function()
			{
				if (xmlhttp.readyState==4 && xmlhttp.status==200)
				{
					var s = xmlhttp.responseText.toString();
					if(s == "OK"){
						layer.msg("发货成功！",{anim: 0,time:1500},function(){
							location.reload();
						});
					}
					else{
						layer.msg("数据提交失败！");
					}
				}
			}
			xmlhttp.open("POST","ChangeOrder?orderid=" + orderid + "&status=4",true);
			xmlhttp.send();
		},function(){
			
		});
}

/***********2017/12/23更新**********/

/***申请成为天使快递员***/

var rgsdlv;			//该弹出层
function regist_deliver()
{
	rgsdlv = layer.open({
		type:2,
		content:['regist_deliver.jsp','no'],
		area:['600px','400px']
	});
}
/***申请成为天使快递员***/
function regist_deliver_do()
{
	var xmlhttp;
	var verify = $("#verify").val();
	//alert(verify);
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
	xmlhttp.onreadystatechange=function()
	{
		if (xmlhttp.readyState==4 && xmlhttp.status==200)
		{
			var s = xmlhttp.responseText.toString();
			layer.msg(s,{anim: 0,time:1500},function(){
				if(s.indexOf("成") > -1){
					var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
					parent.layer.close(index); //再执行关闭
					parent.location.reload(); //刷新父页面
				}
			});

		}
	}
	xmlhttp.open("POST","RegistCourier?verify=" + verify,true);
	xmlhttp.send();
}
/****发送短信验证码****/
function send_valid_code(mobile)
{
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
	xmlhttp.onreadystatechange=function()
	{
		if (xmlhttp.readyState==4 && xmlhttp.status==200)
		{
			var s = xmlhttp.responseText.toString();
			layer.msg(s,{anim: 0,time:1500},function(){
				
			});

		}
	}
	xmlhttp.open("POST","ValidCode?mobilephone=" + mobile,true);
	xmlhttp.send();
}

/***检查是否为天使快递员***/
var x;
function check_courier() {
	if(document.getElementById("cour").value=='null'){
		layer.confirm('您还不是天使快递员，是否立即申请为天使快递员？',{btn:['我要申请','不了，谢谢']},
			function(){
				x = layer.open({
					type:2,
					content:['center/regist_deliver.jsp','no'],
					area:['600px','400px']
				});
			},function(){
				
			});
	}else{
		window.location.href='courier/courier.jsp';
	}
}