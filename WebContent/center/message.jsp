<%@page import="com.zhuanzhuan.util.DaoFactory"%>
<%@page import="com.zhuanzhuan.dao.MessageDaoImpl"%>
<%@page import="com.zhuanzhuan.model.Message"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="user" class="com.zhuanzhuan.model.User" scope="session"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>

	<meta charset="utf-8">
	<title>系统信息</title>
	<script type="text/javascript" src="../js/jquery-3.2.1.js" ></script>
	<script type="text/javascript" src="../layui/layui.js" ></script>
	<link rel="stylesheet" href="../layui/css/layui.css" />
	<link rel="stylesheet" href="../css/style.css" />
<jsp:include page="../header.jsp"></jsp:include>
<div id="functionmenu" style="float: left">
	<ul>
		<a href="javascript:;"><li><b>系统消息</b></li></a>
		<a href="user_msg.jsp"><li>用户消息</li></a>
	</ul>	
</div>
	<script>
			//注意：选项卡 依赖 element 模块，否则无法进行功能性操作
			layui.use('element', function(){
			  var element = layui.element;
			  element.on('tab(msg)', function(data){
			  console.log(this); //当前Tab标题所在的原始DOM元素
			  console.log(data.index);//得到当前Tab的所在下标
			  {
				  if(data.index==0)
					  {
					  	$("#msgiframe").attr("src","Messages?status=<%=Message.ALL%>&receiveid=<%=user.getId() %>") ;
					  	
					  }
				  else
					  {
					  $("#msgiframe").attr("src","Messages?status=<%=Message.UNREAD %>&receiveid=<%=user.getId() %>") ;
					  
					  }
				  
			  }
			  console.log(data.elem); //得到当前的Tab大容器
			});
			});
			layui.use('layer',function(){
				
			});
			var x;
			function deletemsg(reciveid) {
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
				layer.confirm('是否确定清空？',{btn:['是','否']},
						function(){
							xmlhttp.open("POST","DeleteMsg?reciveid=" + reciveid,true);
							xmlhttp.send();
							layer.msg("操作成功！",{anim: 0,time:1500},function(){
								window.location.href='message.jsp';
							});
						},function(){
							
						});
				}
			</script>
</head>
	<body>
		<div id="msgbox" style="width:60%;margin-left:auto;margin-right:auto;">
			<font style="font-family: '微软雅黑';position: absolute;left:50%;top:15%;font-size:30px;color:red;">消息中心</font><a onclick="deletemsg(<%=user.getId() %>)" style="float:right;color:blue;text-decoration:underline;font-size:17px;margin-top: 122px;">清空</a><hr/>
			<div class="layui-tab" lay-filter="msg">
			  <ul class="layui-tab-title" >
			    <li class="layui-this" style="font-size:20px">全部消息</li>
			    <li style="font-size:20px">未读消息</li>
			  </ul>
			  <iframe id="msgiframe" src="Messages?status=<%=Message.ALL%>&receiveid=<%=user.getId() %>" style="width: 100%;border: none;height:600px">
			  	
			  </iframe>
			</div>
		</div>
	</body>
</html>