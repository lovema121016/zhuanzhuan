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
		String serialnumber = null;			//�������
		int buyerid = 0;					//���id
		int sellerid = 0;					//���id
		int goodid = 0;						//��Ʒid
		Timestamp time = null;					//��������ʱ��
		int status = 0;						//����״̬
		int num = 0;						//��������
		double price = 0;					//��Ʒ����
		double freight = 0;					//����踶���˷�
		int type = 0;						//��������
		/***���Դ�confirm_order.jsp�������л�ȡ��������***/
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
		} catch (NumberFormatException e) {		//������ֵ�����쳣
			e.printStackTrace();
			return;
		}
		
		//������������ӵ����ݿ�
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
		//ת��������pay֧��ҳ��
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
		OrderDaoImpl orderDao = DaoFactory.getOrderDao();	//����ʵ����
		GoodDaoImpl goodDao = DaoFactory.getGoodDao();		//��Ʒʵ����
		//�ж϶����Ƿ��ظ�
		List<Order> orders = orderDao.loadByBuyer(order.getBuyerid(), Order.ALL);
		for(Order o:orders) 
		{
			if(o.getGoodid() == order.getGoodid() && Order.CANCEL < order.getStatus() && order.getStatus() < Order.FINISH)
			{
				throw new OrderException("����Ʒ�����Ѵ��ڣ�������ɻ�ȡ��֮ǰ�Ķ���");
			}
		}
		Good good = goodDao.load(order.getGoodid());
		if (good.getNum() < order.getNum()) {
			throw new OrderException("��Ʒʣ����������");
		}
		good.setNum(good.getNum() - order.getNum());
		goodDao.update(good);
		orderDao.create(order);
		order.setId(orderDao.load(order.getSerialnumber()).getId());
	}
}
