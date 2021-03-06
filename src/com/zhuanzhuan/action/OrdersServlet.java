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
 * �������б�����
 * ��Ҫ��request������
 * 	user���û����ͣ�1:���	2:����
 * 	status������Ķ���״̬
 * ��Ҫ��session���ԣ�
 * 	user����ǰ��¼�û�
 */
@WebServlet("/OrderServlet")
public class OrdersServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// ��ȡ��ǰ�û�
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");
		// ����ʵ����
		OrderDaoImpl orderDao = new OrderDaoImpl();
		int status = 0;
		int usetype = 0;
		try {
			// ��ȡ����Ķ���״̬
			status = Integer.parseInt(request.getParameter("status"));
			// �����û�����
			usetype = Integer.parseInt(request.getParameter("usertype"));
			
		} catch (Exception e) {
			e.printStackTrace();
			return;
		}
		
		// ���ض����б�
		List<Order> orders = null;
		if(usetype == 1)
			orders = orderDao.loadByBuyer(user.getId(),status);
		else if(usetype == 2)
			orders = orderDao.loadBySeller(user.getId(), status);
		Collections.reverse(orders);
		System.out.println(user.getId());
		System.out.println(status);
		// ������������
		request.setAttribute("orders", orders);
		// ����ת��
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
