package com.zhuanzhuan.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.zhuanzhuan.dao.ShoppingCartDaoImpl;
import com.zhuanzhuan.model.ShoppingCart;
import com.zhuanzhuan.model.User;

/**
 * Servlet implementation class ShoppingCartsServlet
 */
@WebServlet("/ShoppingCartsServlet")
public class ShoppingCartsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ShoppingCartsServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");
		if(user == null || user.getId() == 0) {
			return;
		}
		// ����ʵ����
		ShoppingCartDaoImpl shoppingCartDao = new ShoppingCartDaoImpl();
		// ���ض����б�
		List<ShoppingCart> shoppingCarts = null;
		shoppingCarts = shoppingCartDao.loadByBuyer(user.getId());
		
		// ������������
		request.setAttribute("shoppingCarts", shoppingCarts);
		// ����ת��
		RequestDispatcher rd = request.getRequestDispatcher("shoppingCart.jsp");
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
