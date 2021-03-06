var isStudentnumberRight = false;
var isPassRight = false;
var isSPassRight = false;
var isNameRight = false;
var isPhoneRight = false;
var isDormitoryRight = false;
var isRoomNumberRight = false;

function load(){
	checkAll();
	if($("#username").val()!="")
		checkId();
	if($("#password").val()!="")
		checkPass();
	if($("#spassword").val()!="")
		checkSPass();
	if($("#nickname").val() != "")
		checkNickName();
	if($("#phone").val() != "")
		checkPhone();
	if($("#dormitory").val()!="")
		checkDormitory();
	if($("#room").val()!="")
		checkRoomnumber();
};

function checkId() 
{
	var id = $("#username").val().trim();
	if($("#username").val()==null||$("#username").val()=="")
	{
		$(".tip").eq(0).html('<i class="layui-icon">&#x1007;</i>请输入学号');
		$(".tip").eq(0).css({"color":"red"});
		$(".tip").eq(0).attr("title",'请输入学号');
		isStudentnumberRight = false;
	}
	else if(id.length != 8)
	{
		$(".tip").eq(0).html('<i class="layui-icon">&#x1007;</i>格式错误，学号由8位数字组成');
		$(".tip").eq(0).css({"color":"red"});
		$(".tip").eq(0).attr("title",'请输入8位学号');
		isStudentnumberRight = false;
	}
	else if(!id.startsWith("20"))
	{
		$(".tip").eq(0).html('<i class="layui-icon">&#x1007;</i>学号错误');
		$(".tip").eq(0).css({"color":"red"});
		$(".tip").eq(0).attr("title",'学号错误');
		isStudentnumberRight = false;
	}
	else 
	{
		$(".tip").eq(0).html('<i class="layui-icon" style="color:green">&#xe616;</i>');
		$(".tip").eq(0).css({"color":"green"});
		$(".tip").eq(0).attr("title",'');
		isStudentnumberRight = true;
	}
	checkAll();
}
function checkPass(){
	var pass = $("#password").val();
	var pass2 = $("#spassword").val();
	if(pass.length <= 5 || pass.length >= 11)
	{
		$(".tip").eq(2).html('<i class="layui-icon">&#x1007;</i>密码只能是6-10位字符');
		$(".tip").eq(2).css({"color":"red"});
		$(".tip").eq(2).attr("title",'请设置6-10位字符的密码');
		isPassRight = false;
	}
	else {
		$(".tip").eq(2).html('<i class="layui-icon" style="color:green">&#xe616;</i>');
		$(".tip").eq(2).css({"color":"green"});
		$(".tip").eq(2).attr("title",'');
		isPassRight = true;
	}
	checkSPass();
	checkAll();
}

function checkSPass(){
	//alert("cs");
	if(isPassRight){
		var pass = $("#password").val();
		var pass2 = $("#spassword").val();
		//alert(pass);
		//alert(pass2);
		if(pass == pass2){
			$(".tip").eq(3).html('<i class="layui-icon" style="color:green">&#xe616;</i>');
			$(".tip").eq(3).css({"color":"green"});
			$(".tip").eq(3).attr("title",'');
			isSPassRight = true;
		}
		else
		{
			$(".tip").eq(3).html('<i class="layui-icon">&#x1007;</i>两次输入密码不一致');
			$(".tip").eq(3).css({"color":"red"});
			$(".tip").eq(3).attr("title",'两次输入密码不一致');
			isSPassRight = false;
		}
	}
	checkAll();
}

function checkNickName(){
	var str = $("#nickname").val();
	//var patt = /([a-z]|[A-Z]|[0-9]|_)?/;
	if($("#nickname").val()==null||$("#nickname").val()=="")
	{
		$(".tip").eq(4).html('<i class="layui-icon">&#x1007;</i>昵称不能为空');
		$(".tip").eq(4).css({"color":"red"});
		$(".tip").eq(4).attr("title",'显示名称不能为空');
		isNameRight = false;
	}
//	else if(str.length > 10 || str.length < 6 || !patt.test(str))
//	{
//		$(".tip").eq(3).html("×");
//		$(".tip").eq(3).css({"color":"red"});
//		$(".tip").eq(3).attr("title",'显示名称由6-10个英文字符、数字或"_"组成');
//		isUserRight = false;
//	}
	else{
		$(".tip").eq(4).html('<i class="layui-icon" style="color:green">&#xe616;</i>');
		$(".tip").eq(4).css({"color":"green"});
		isNameRight = true;
	}
	checkAll();
}
function checkPhone(){
	var str = $("#phone").val();
	var patt = /^1[3|4|5|8][0-9]\d{4,8}$/;
	if(!patt.test(str))
	{
		$(".tip").eq(5).html('<i class="layui-icon">&#x1007;</i>手机号码格式不正确');
		$(".tip").eq(5).css({"color":"red"});
		$(".tip").eq(5).attr("title",'手机号码格式不正确');
		isPhoneRight = false;
	}
	else{
		$(".tip").eq(5).html('<i class="layui-icon" style="color:green">&#xe616;</i>');
		$(".tip").eq(5).css({"color":"green"});
		isPhoneRight = true;
	}
	checkAll();
}

function checkDormitory(){
	var num = parseInt($("#dormitory").val());
	if($("#dormitory").val()==null||$("#dormitory").val()==""){
		$(".tip").eq(6).html('<i class="layui-icon">&#x1007;</i>楼号不能为空');
		$(".tip").eq(6).css({"color":"red"});
		isDormitoryRight = false;
		$(".tip").eq(6).attr("title",'楼号不能为空');
	}else if(num > 25 || num <1){
		$(".tip").eq(6).html('<i class="layui-icon">&#x1007;</i>没有该号楼');
		isDormitoryRight = false;
		$(".tip").eq(6).css({"color":"red"});
		$(".tip").eq(6).attr("title",'没有此号楼');
	}else{
		$(".tip").eq(6).html('<i class="layui-icon" style="color:green">&#xe616;</i>');
		$(".tip").eq(6).css({"color":"green"});
		isDormitoryRight = true;
		$(".tip").eq(6).attr("title",'');
	}
	checkAll();
}
function checkRoomnumber(){
	var num = parseInt($("#room").val());
	if($("#room").val()==null||$("#room").val()==""){
		$(".tip").eq(7).html('<i class="layui-icon">&#x1007;</i>宿舍号不能为空');
		isRoomNumberRight = false;
		$(".tip").eq(7).css({"color":"red"});
		$(".tip").eq(7).attr("title",'宿舍号不能为空');
	}else if(num > 700 || num <100){
		$(".tip").eq(7).html('<i class="layui-icon">&#x1007;</i>没有此号宿舍');
		isRoomNumberRight = false;
		$(".tip").eq(7).css({"color":"red"});
		$(".tip").eq(7).attr("title",'没有此号宿舍');
	}else{
		$(".tip").eq(7).html('<i class="layui-icon" style="color:green">&#xe616;</i>');
		isRoomNumberRight = true;
		$(".tip").eq(7).css({"color":"green"});
		$(".tip").eq(7).attr("title",'');
	}
	checkAll();
}

function checkAll(){
	var flag = isStudentnumberRight+isPassRight+isSPassRight+isNameRight+isPhoneRight+isDormitoryRight+isRoomNumberRight;
	console.log(flag);
	if(flag == 7){
		$("#regBtn").removeAttr("disabled");
		$("#regBtn").css({"background-color":"#cfc723"});
	}else{
		$("#regBtn").attr("disabled");
		$("#regBtn").css({"background-color":"#cf2323"});
	}
}