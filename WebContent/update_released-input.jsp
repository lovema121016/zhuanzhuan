<%@page import="com.zhuanzhuan.model.Good"%>
<%@page import="com.zhuanzhuan.util.DaoFactory"%>
<%@page import="com.zhuanzhuan.dao.GoodDaoImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="user" class="com.zhuanzhuan.model.User" scope="session"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>信息发布页面</title>
     <link rel="stylesheet" href="layui/css/layui.css" />
	 <script type="text/javascript" src="layui/layui.js"></script>
     <script type="text/javascript" src="js/jquery-3.2.1.js"></script>
     <script>
     $(document).ready(function(){
     	checkname();
     	checkprice();
     	checknum();
     	checkfreight();
     	checkdes();
      });
     var lastIndex;
   	//表单模块
     layui.use('form', function(){
       var form = layui.form;
       
       //监听提交
       form.on('submit(formDemo)', function(data){
         layer.msg(JSON.stringify(data.field));
         return false;
       });
     });
   	//上传文件模块
   	layui.use('upload', function(){
  var upload = layui.upload;
   
  //执行实例
  var uploadInst = upload.render({
    elem: '#img_btn' //绑定元素
    ,url: 'upload.jsp' //上传接口
    ,done: function(res){
      console.log(res.data.src);
      $("#name").val($("#name").val() + res.data.src + ";");
      $("#sub").click();
    }
    ,error: function(){
      //请求异常回调
    }
    ,auto:false
    ,bindAction:'#btn'
    ,multiple:true
    ,choose: function(obj){
        //将每次选择的文件追加到文件队列
        var files = obj.pushFile();
        //预读本地文件，如果是多文件，则会遍历。(不支持ie8/9)
        obj.preview(function(index, file, result){
          console.log(index); //得到文件索引
          lastIndex = index.toString().charAt(index.length - 1);
          console.log(file); //得到文件对象
          console.log(result); //得到文件base64编码，比如图片
          var imgframe = document.getElementById("imgframe");
          var imag = document.createElement("img");
          imag.src = result;
          imag.width = "100";
          imag.height = "100"
          imag.style.margin = "5px";
          imgframe.appendChild(imag);
          //这里还可以做一些 append 文件列表 DOM 的操作
          
          //obj.upload(index, file); //对上传失败的单个文件重新上传，一般在某个事件中使用
          //delete files[index]; //删除列表中对应的文件，一般在某个事件中使用
        });
      }
  });
});
     var y="";
     function F_Open_dialog() 
     { 
          document.getElementById("xdaTanFileImg").click(); 
     } 
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
	        y += x.substring(x.lastIndexOf('\\')+1)+";";
	        document.getElementById("name").value = y;
	        $("#imgbtn").removeAttr("disabled");
	        //或者 img.src = this.result;  //e.target == this
	    }
	   reader.readAsDataURL(file);
	}
	function resetimg(){
		var img = document.getElementById("xmTanImg");
        img.src = '../img/49573c62ab5cd23.jpg';
        $("#imgbtn").attr("disabled","disabled");
	}
	var isNameRight = false;
	var isPriceRight = false;
	var isNumRight = false;
	var isFreightRight = false;
	var isDesRight = false;

	function checkname() 
	{
		if($("#goodname").val()==null||$("#goodname").val()=="")
		{
			$(".tip").eq(0).html("×");
			$(".tip").eq(0).css({"color":"red"});
			$(".tip").eq(0).attr("title",'请输入名称');
			isNameRight = false;
		}
		else 
		{
			$(".tip").eq(0).html("√");
			$(".tip").eq(0).css({"color":"green"});
			$(".tip").eq(0).attr("title",'');
			isNameRight = true;
		}
		checkAll();
	}
	function checkprice(){
		var price = $("#price").val();
		if($("#price").val()==null||$("#price").val()=="")
		{
			$(".tip").eq(1).html("×");
			$(".tip").eq(1).css({"color":"red"});
			$(".tip").eq(1).attr("title",'请输入价格');
			isPriceRight = false;
		}
		else if(isNaN(price))
		{
			$(".tip").eq(1).html("×");
			$(".tip").eq(1).css({"color":"red"});
			$(".tip").eq(1).attr("title",'输入格式不对');
			isPriceRight = false;
		}
		else {
			$(".tip").eq(1).html("√");
			$(".tip").eq(1).css({"color":"green"});
			$(".tip").eq(1).attr("title",'');
			isPriceRight = true;
		}
		checkAll();
	}

	function checknum(){
		var num = $("#num").val();
		if($("#num").val()==null||$("#num").val()==""){
			$(".tip").eq(2).html("×");
			$(".tip").eq(2).css({"color":"red"});
			$(".tip").eq(2).attr("title",'请输入数量');
			isNumRight = false;
		}
		else if(isNaN(num))
		{
			$(".tip").eq(2).html("×");
			$(".tip").eq(2).css({"color":"red"});
			$(".tip").eq(2).attr("title",'输入格式不对');
			isNumRight = false;
		}
		else
		{
			$(".tip").eq(2).html("√");
			$(".tip").eq(2).css({"color":"green"});
			$(".tip").eq(2).attr("title",'');
			isNumRight = true;
		}
		checkAll();
	}

	function checkfreight(){
		var freight = $("#freight").val();
		if($("#freight").val()==null||$("#freight").val()=="")
		{
			$(".tip").eq(3).html("×");
			$(".tip").eq(3).css({"color":"red"});
			$(".tip").eq(3).attr("title",'请输入运费');
			isFreightRight = false;
		}
//		else if(str.length > 10 || str.length < 6 || !patt.test(str))
//		{
//			$(".tip").eq(3).html("×");
//			$(".tip").eq(3).css({"color":"red"});
//			$(".tip").eq(3).attr("title",'显示名称由6-10个英文字符、数字或"_"组成');
//			isUserRight = false;
//		}
		else if(isNaN(freight))
		{
			$(".tip").eq(3).html("×");
			$(".tip").eq(3).css({"color":"red"});
			$(".tip").eq(3).attr("title",'输入格式不对');
			isFreightRight = false;
		}
		else{
			$(".tip").eq(3).html("√");
			$(".tip").eq(3).css({"color":"green"});
			isFreightRight = true;
		}
		checkAll();
	}
	function checkdes(){
		var des = $("#des").val();
		if($("#des").val()==null||$("#des").val()=="")
		{
			$(".tip").eq(4).html("×");
			$(".tip").eq(4).css({"color":"red"});
			$(".tip").eq(4).attr("title",'请输入描述');
			isDesRight = false;
		}
		else if(des.length>255)
		{
			$(".tip").eq(4).html("×");
			$(".tip").eq(4).css({"color":"red"});
			$(".tip").eq(4).attr("title",'描述不可大于255个字');
			isDesRight = false;
		}
		else{
			$(".tip").eq(4).html("√");
			$(".tip").eq(4).css({"color":"green"});
			isDesRight = true;
		}
		checkAll();
	}
	function checkAll(){
		var flag = isNameRight+isPriceRight+isNumRight+isFreightRight+isDesRight;
		if(flag == 5){
			$("#sub").removeAttr("disabled");
		}else{
			$("#sub").attr("disabled","disabled");
		}
	}
function amazing(){
	alert();
}
</script>
    </head>
    <body>
   		 <%
	    //接收该商品id
	    int id=Integer.parseInt(request.getParameter("id"));
	    //根据id查找到商品信息，方便在下面展示
	  	GoodDaoImpl gooddao=DaoFactory.getGoodDao();
	    Good good=gooddao.load(id);
	    %>
    	<form id="goodform" class="layui-form" action="update_released.jsp" method="get" style="width:40%;margin:auto;margin-top:20px;">
			<input type="hidden" name="id" value="<%=id %>">
			<div class="layui-form-item">
				<label class="layui-form-label">商品名称</label>
				<div class="layui-inline" style="width:67%;">
					<input id="goodname" type="text" oninput="checkname()" name="goodname" class="layui-input" value="<%=good.getGoodname() %>"/>
				</div>
				<label class="tip"></label>
			</div>
    		<div class="layui-form-item">
				<label class="layui-form-label">商品价格</label>
				<div class="layui-inline">
					<input id="price" type="text" name="price" oninput="checkprice()" class="layui-input" value="<%=good.getPrice() %>"/>
				</div>
				<label class="tip"></label>
			</div>
			<div class="layui-form-item" style="width:75%;">
				<label class="layui-form-label">商品数量</label>
				<div class="layui-inline" style="width:39%;">
					<input id="num" type="text" name="num" oninput="checknum()" class="layui-input" style="width: 100%;" value="<%=good.getNum() %>"/>
				</div>
				<label class="tip"></label>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">商品类别</label>
				<div class="layui-inline" style="width:67%;">
					<select name="catagory" style="height:30px;width:150px;">	
						<option>办公用品</option>
						<option>游戏设备</option>
						<option>数码产品</option>
						<option>图书音像</option>
						<option>运动户外</option>
						<option>玩具乐器</option>
						<option>五金工具</option>
						<option>居家日用</option>	
						<option>园艺植物</option>	
						<option>服饰/配件</option>	
						<option>电子零件</option>	
						<option>工艺礼品</option>
						<option>其它闲置</option>					
					</select>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">设置邮费</label>
				<div class="layui-inline" style="width:67%;">
					<input id="freight" type="text" name="freight" oninput="checkfreight()" class="layui-input" value="<%=good.getFreight() %>"/>
				</div>
				<label class="tip"></label>
			</div>
			<div class="layui-form-item">
				<label class="layui-form-label">商品描述</label>
				<div class="layui-inline" style="width:67%;">
					<textarea rows="20" cols="67" id="des" name="description" oninput="checkdes()" class="layui-input" style="height:200px;"><%=good.getDescription() %></textarea>
				</div>
				<label class="tip"></label>
			</div>
			<div class="layui-form-item">
    			<label class="layui-form-label">商品图片</label>
    			<!-- <img id="xmTanImg" style="width:200px;height:200px" src="../img/49573c62ab5cd23.jpg" onclick="F_Open_dialog()" /> -->
    			<input style="display:none" name="header" type="file" id="xdaTanFileImg" onchange="xmTanUploadImg(this)" accept="image/*"/>
    			<input type="hidden" size="60" id="name" name="nam" value="" />
    			<a class="layui-btn" id="img_btn">
  					<i class="layui-icon">&#xe67c;</i>添加图片
				</a>
    		</div>
    		<div id="imgframe"></div>
			<div class="layui-form-item" style="text-align:center;">
				<div class="layui-inline">
					<a id="btn" disabled="disabled" class="layui-btn">保存</a>
					<button id="sub" onclick="lastIndex--;if(lastIndex >= 0)return false" style="display:none">提交</button>
				</div>
			</div>
    	</form>
 	</body>
</html>