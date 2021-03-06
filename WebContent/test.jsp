<%@page import="com.jspsmart.upload.File"%>
<%@page import="com.jspsmart.upload.Files"%>
<%@page import="com.jspsmart.upload.SmartUpload"%>
<%@page import="com.zhuanzhuan.util.DBUtil"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>upload模块快速使用</title>
  <link rel="stylesheet" href="layui/css/layui.css" media="all">
</head>
<body>

<button type="button" class="layui-btn" id="test1">
  <i class="layui-icon">&#xe67c;</i>上传图片
</button>
 
<script src="layui/layui.js"></script>
<script>
layui.use('upload', function(){
  var upload = layui.upload;
   
  //执行实例
  var uploadInst = upload.render({
    elem: '#test1' //绑定元素
    ,url: 'testt.jsp' //上传接口
    ,done: function(res){
      //上传完毕回调
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
          console.log(file); //得到文件对象
          console.log(result); //得到文件base64编码，比如图片
          document.getElementById("img1").src=result;
          //这里还可以做一些 append 文件列表 DOM 的操作
          
          //obj.upload(index, file); //对上传失败的单个文件重新上传，一般在某个事件中使用
          //delete files[index]; //删除列表中对应的文件，一般在某个事件中使用
        });
      }
  });
});
</script>
<button id="btn">上传</button>
<img alt="" src="" id="img1" />
</body>
</html>