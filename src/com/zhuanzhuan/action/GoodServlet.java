package com.zhuanzhuan.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.zhuanzhuan.dao.GoodDaoImpl;
import com.zhuanzhuan.model.Good;

/**
 * 处理显示商品详情请求
 * 传入request属性：
 * 	id：商品id
 * 传入session属性：
 * 	user：当前登录用户
 */
@WebServlet("/GoodServlet")
public class GoodServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GoodServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int id = 0;		//商品ID
		PrintWriter writer = response.getWriter();
		response.setContentType("text/html");
		String docType =
			      "<!doctype html public \"-//w3c//dtd html 4.0 " +
			      "transitional//en\">\n";
		try {
			// 尝试从request获取id
			id = Integer.parseInt(request.getParameter("id"));
		} catch (Exception e) {	// 捕获数值解析异常
			writer.println(docType);
			writer.println("<html><head></head><body>数据不合法!</body></html>");
			return;
		}
		GoodDaoImpl goodDao = new GoodDaoImpl();	// 商品实现类
		Good good = goodDao.load(id);				// 加载商品
		if(good == null) {		// 如果不存在该商品，输出错误信息
			writer.println(docType);
			writer.println("<html><head></head><body>商品不存在!</body></html>");
		}else {
			request.setAttribute("good", good);		// 给request设置good属性
			// 请求转发
			RequestDispatcher rd = request.getRequestDispatcher("good_info.jsp");
			rd.forward(request, response);
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
