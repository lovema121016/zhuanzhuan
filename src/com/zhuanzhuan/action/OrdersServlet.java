package com.zhuanzhuan.action;

import java.io.IOException;
import java.util.Collections;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.zhuanzhuan.dao.OrderDaoImpl;
import com.zhuanzhuan.model.Order;
import com.zhuanzhuan.model.User;

/**
 * 处理订单列表请求：
 * 需要的request参数：
 * 	user：用户类型，1:买家	2:卖家
 * 	status：请求的订单状态
 * 需要的session属性：
 * 	user：当前登录用户
 */
@WebServlet("/OrderServlet")
public class OrdersServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 获取当前用户
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");
		// 订单实现类
		OrderDaoImpl orderDao = new OrderDaoImpl();
		int status = 0;
		int usetype = 0;
		try {
			// 获取请求的订单状态
			status = Integer.parseInt(request.getParameter("status"));
			// 加载用户类型
			usetype = Integer.parseInt(request.getParameter("usertype"));
			
		} catch (Exception e) {
			e.printStackTrace();
			return;
		}
		
		// 加载订单列表
		List<Order> orders = null;
		if(usetype == 1)
			orders = orderDao.loadByBuyer(user.getId(),status);
		else if(usetype == 2)
			orders = orderDao.loadBySeller(user.getId(), status);
		Collections.reverse(orders);
		System.out.println(user.getId());
		System.out.println(status);
		// 设置请求属性
		request.setAttribute("orders", orders);
		// 请求转发
		RequestDispatcher rd = request.getRequestDispatcher("orders.jsp");
		rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
