package com.zhuanzhuan.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.zhuanzhuan.util.ValidCodeUtil;

/**
 * 发送短信验证码请求
 * 需要的request参数：
 * 	validcode：要发送给用户的验证码
 * 	mobliephone：接收验证码的手机号
 */
@WebServlet("/ValidCodeServlet")
public class ValidCodeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 获取参数
		String validCode = request.getParameter("validcode");
		if(validCode == null)
			validCode = String.valueOf((int)(Math.random() * 1000000));
		String mobilePhone = request.getParameter("mobilephone");
		
		System.out.println("生成验证码：" + mobilePhone);
		// 将验证码添加到Session
		HttpSession session = request.getSession();
		session.setAttribute("rand", validCode);
		// 取得发送结果
		String restult = ValidCodeUtil.sendSMS(validCode, mobilePhone);
		// 调试输出
		System.out.println("result:" + restult);
		response.setContentType("text/html");
		PrintWriter writer = response.getWriter();
		writer.print(restult);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
}
