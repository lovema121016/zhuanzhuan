package com.zhuanzhuan.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.zhuanzhuan.dao.GoodDaoImpl;
import com.zhuanzhuan.dao.MessageDaoImpl;
import com.zhuanzhuan.dao.OrderDaoImpl;
import com.zhuanzhuan.model.Good;
import com.zhuanzhuan.model.Message;
import com.zhuanzhuan.model.Order;
import com.zhuanzhuan.util.DaoFactory;

/**
 * Servlet implementation class CancelOrder
 */
@WebServlet("/CancelOrder")
public class CancelOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CancelOrderServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		OrderDaoImpl orderDao = DaoFactory.getOrderDao();	// ����ʵ����
		GoodDaoImpl goodDao = DaoFactory.getGoodDao();		// ��Ʒʵ����
		int id = 0;											// ����id
		try {		//��ȡ����Ķ���id
			id = Integer.parseInt(request.getParameter("orderid"));
		} catch (NumberFormatException e) {
			e.printStackTrace();
		}
		Order order = orderDao.load(id);	//���ض���
		Good good = goodDao.load(order.getGoodid());	//������Ʒ
		order.setStatus(Order.CANCEL);			//���ö���״̬Ϊ�����׹رա�
		good.setNum(good.getNum() + order.getNum());  	//�ָ���Ʒ����
		goodDao.update(good);					//������Ʒ����
		orderDao.delete(order);					//ɾ����������
		Message message = new Message();		//������Ϣ
		MessageDaoImpl messageDao = DaoFactory.getMessageDao();
		message.setTitle("����֪ͨ");
		message.setReciveuserid(order.getBuyerid());
		message.setContent("���ѳɹ�ȡ�������������ţ�"+order.getSerialnumber());
		messageDao.add(message);				//������Ϣ
		response.setContentType("text/html");	//������Ӧ����
		PrintWriter writer = response.getWriter();
		writer.print("OK");						//���OK
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
