package com.zhuanzhuan.action;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.zhuanzhuan.dao.GoodDaoImpl;
import com.zhuanzhuan.dao.OrderDaoImpl;
import com.zhuanzhuan.exception.OrderException;
import com.zhuanzhuan.model.Good;
import com.zhuanzhuan.model.Order;
import com.zhuanzhuan.util.DaoFactory;

/**
 * Servlet implementation class SubmitOrderServlet
 */
@WebServlet("/SubmitOrderServlet")
public class SubmitOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SubmitOrderServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String serialnumber = null;			//订单编号
		int buyerid = 0;					//买家id
		int sellerid = 0;					//买家id
		int goodid = 0;						//商品id
		Timestamp time = null;					//订单创建时间
		int status = 0;						//订单状态
		int num = 0;						//交易数量
		double price = 0;					//商品单价
		double freight = 0;					//买家需付的运费
		int type = 0;						//订单类型
		/***尝试从confirm_order.jsp隐藏域中获取订单属性***/
		try {
			serialnumber = String.valueOf(System.currentTimeMillis());
			buyerid = Integer.parseInt(request.getParameter("buyerid"));
			sellerid = Integer.parseInt(request.getParameter("sellerid"));
			goodid = Integer.parseInt(request.getParameter("goodid"));
			time = new Timestamp(System.currentTimeMillis());
			status = Order.WAIT_TO_PAY;
			num = Integer.parseInt(request.getParameter("num"));
			price = Double.parseDouble(request.getParameter("price"));
			freight = Double.parseDouble(request.getParameter("freight"));
			type=Integer.parseInt(request.getParameter("type"));
			
			System.out.println(time);
		} catch (NumberFormatException e) {		//捕获数值解析异常
			e.printStackTrace();
			return;
		}
		
		//创建订单，添加到数据库
		Order order = new Order();
		order.setBuyerid(buyerid);
		order.setFreight(freight);
		order.setGoodid(goodid);
		order.setNum(num);
		order.setPrice(price);
		order.setSellerid(sellerid);
		order.setSerialnumber(serialnumber);
		order.setStatus(status);
		order.setTime(time);
		order.setType(type);
		
		try {
			submitOrder(order);
		} catch (OrderException e) {
			request.setAttribute("orderException", e);
			RequestDispatcher rd = request.getRequestDispatcher("error.jsp");
			rd.forward(request, response);
		}
		request.setAttribute("order", order);
		//转发请求至pay支付页面
		RequestDispatcher rd = request.getRequestDispatcher("pay.jsp");
		rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

	private void submitOrder(Order order) throws OrderException{
		OrderDaoImpl orderDao = DaoFactory.getOrderDao();	//订单实现类
		GoodDaoImpl goodDao = DaoFactory.getGoodDao();		//商品实现类
		//判断订单是否重复
		List<Order> orders = orderDao.loadByBuyer(order.getBuyerid(), Order.ALL);
		for(Order o:orders) 
		{
			if(o.getGoodid() == order.getGoodid() && Order.CANCEL < order.getStatus() && order.getStatus() < Order.FINISH)
			{
				throw new OrderException("该商品订单已存在，请先完成或取消之前的订单");
			}
		}
		Good good = goodDao.load(order.getGoodid());
		if (good.getNum() < order.getNum()) {
			throw new OrderException("商品剩余数量不足");
		}
		good.setNum(good.getNum() - order.getNum());
		goodDao.update(good);
		orderDao.create(order);
		order.setId(orderDao.load(order.getSerialnumber()).getId());
	}
}
