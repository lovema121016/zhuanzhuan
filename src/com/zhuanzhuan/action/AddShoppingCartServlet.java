package com.zhuanzhuan.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.zhuanzhuan.dao.ShoppingCartDaoImpl;
import com.zhuanzhuan.model.ShoppingCart;
import com.zhuanzhuan.model.User;
import com.zhuanzhuan.util.DaoFactory;

/**
 * Servlet implementation class AddShoppingCartServlet
 */
@WebServlet("/AddShoppingCartServlet")
public class AddShoppingCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddShoppingCartServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		ShoppingCartDaoImpl shoppingCartDao = DaoFactory.getShoppingCartDao();
		int id = 0;
		try {
			id = Integer.parseInt(request.getParameter("goodid"));
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}
		HttpSession session = request.getSession();
		User user = (User)session.getAttribute("user");
		if (user == null || user.getId() == 0) {
			response.setContentType("text/html");
			PrintWriter writer = response.getWriter();
			writer.print("NO_LOGIN");
			return;
		}else {
			ShoppingCart shoppingCart = new ShoppingCart();
			shoppingCart.setGoodid(id);
			shoppingCart.setUserid(user.getId());
			shoppingCartDao.add(shoppingCart);
			response.setContentType("text/html");
			PrintWriter writer = response.getWriter();
			writer.print("OK");
			System.out.println("Get«Î«Û");
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
