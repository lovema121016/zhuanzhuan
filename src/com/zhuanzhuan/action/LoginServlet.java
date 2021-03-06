package com.zhuanzhuan.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.zhuanzhuan.dao.UserDaoImpl;
import com.zhuanzhuan.model.User;
import com.zhuanzhuan.util.DaoFactory;

/**
 * 处理登录请求：
 * 需要的request参数:
 * 	username：学号
 * 	password：密码
 * 需要的session属性:
 * 	user：当前用户
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		/****从表单加载user***/
		UserDaoImpl userDao = DaoFactory.getUserDao();
		
		String imgcode = request.getParameter("verify").trim();
		String username = request.getParameter("username").trim();
		String password = request.getParameter("password").trim();
		if(username.equals("") && password.equals(""))
		{
			/***检查验证码 ***/
			HttpSession session = request.getSession();
			String truecode = (String) session.getAttribute("rand");
			response.setContentType("text/html");
			PrintWriter writer = response.getWriter();
			if(imgcode.equals(truecode))
				writer.print("OK");
			else
				writer.print("ERROR\ntruecode:" + truecode + "\nimgcode:" + imgcode);
			return;
		}
		
		User user = userDao.load(username,password);
		
		if(user != null)			// 如果user 不为 null
		{
			/***添加一个名为user的Cookie***/
			Cookie cookie = new Cookie("user", String.valueOf(user.getId()));
			cookie.setMaxAge(60*60*24); 
			response.addCookie(cookie);
			
			/***session添加属性user***/
			HttpSession session = request.getSession();
			session.setAttribute("user", user);
			response.sendRedirect("./index.jsp");
			
		}else {
			/***user为null，输出错误信息 ***/
			response.setContentType("text/html");
			String docType =
				      "<!doctype html public \"-//w3c//dtd html 4.0 " +
				      "transitional//en\">\n";
			PrintWriter writer = response.getWriter();
			writer.println(docType);
			writer.println("<script>alert('用户不存在或密码错误!')</script>");
			HttpSession session = request.getSession();
			session.setAttribute("number", username);
			writer.println("<script>window.location.href='login.jsp'</script>");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
