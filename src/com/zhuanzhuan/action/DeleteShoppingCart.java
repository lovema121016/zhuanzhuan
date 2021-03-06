package com.zhuanzhuan.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.zhuanzhuan.dao.ShoppingCartDaoImpl;
import com.zhuanzhuan.util.DaoFactory;

/**
 * Servlet implementation class DeleteShoppingCart
 */
@WebServlet("/DeleteShoppingCart")
public class DeleteShoppingCart extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteShoppingCart() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int shopid = 0;							//¹ºÎï³µid
		response.setContentType("text/html");
		System.out.println("sdafsdf");
		try {
			shopid = Integer.parseInt(request.getParameter("shopid"));
		} catch (Exception e) {
			System.out.println(e.getMessage() + "(DeleteShoppingCart.java)");
			PrintWriter writer = response.getWriter();
			writer.print("ERROR");
			return;
		}
		System.out.println("shopid" + shopid);
		ShoppingCartDaoImpl shoppingCartDao = DaoFactory.getShoppingCartDao();
		shoppingCartDao.delete(shopid);
		PrintWriter writer = response.getWriter();
		writer.print("OK");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
