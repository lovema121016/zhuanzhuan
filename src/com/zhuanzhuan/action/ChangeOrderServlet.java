package com.zhuanzhuan.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.zhuanzhuan.dao.CourierDaoImpl;
import com.zhuanzhuan.dao.GoodDaoImpl;
import com.zhuanzhuan.dao.GoodStreamDaoImpl;
import com.zhuanzhuan.dao.MessageDaoImpl;
import com.zhuanzhuan.dao.OrderDaoImpl;
import com.zhuanzhuan.dao.UserDaoImpl;
import com.zhuanzhuan.model.Courier;
import com.zhuanzhuan.model.Good;
import com.zhuanzhuan.model.GoodStream;
import com.zhuanzhuan.model.Message;
import com.zhuanzhuan.model.Order;
import com.zhuanzhuan.model.User;
import com.zhuanzhuan.util.DaoFactory;

/**
 * Servlet implementation class ChangeOrderServlet
 */
@WebServlet("/ChangeOrderServlet")
public class ChangeOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChangeOrderServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		int id = 0;
		int status = 0;
		
		try {
			id = Integer.parseInt(request.getParameter("orderid"));
			status = Integer.parseInt(request.getParameter("status"));
		} catch (Exception e) {
			PrintWriter writer = response.getWriter();
			writer.print("ERROR");
		}
		//ʵ����
		OrderDaoImpl orderDao = DaoFactory.getOrderDao();
		GoodStreamDaoImpl goodStreamDao = DaoFactory.getGoodStreamDao();
		CourierDaoImpl courierDao = DaoFactory.getCourierDao();
		Order order = orderDao.load(id);
		System.out.println("����id��" + id);
		GoodStream goodStream = goodStreamDao.loadByOrderid(order.getId());
		//������ɣ�������
		if(status == Order.WAIT_TO_REVIEW && goodStream != null)			
		{	//���ʹ����ʹ���Ա���ջ�ʱ�����Ա����+1
			goodStream.setReceiveTime(new Timestamp(System.currentTimeMillis()));		//����ǩ��ʱ��
			goodStream.setStatus(GoodStream.FINISH);
			goodStreamDao.update(goodStream);
			System.out.println(goodStream);
			
			Courier courier = courierDao.load(goodStream.getDeliverid());
			courier.setSalary(courier.getSalary() + 1);
			courierDao.update(courier);
			System.out.println("courierid" + courier.getCourierid() + " " + "salary��" + courier.getSalary() + " status��" + courier.getStatus());
		}
		order.setStatus(status);
		orderDao.update(order);
		Message message = new Message();
		Message message2 = new Message();
		MessageDaoImpl messageDao = DaoFactory.getMessageDao();
		UserDaoImpl userDao = DaoFactory.getUserDao();
		User user = userDao.load(order.getBuyerid());
		GoodDaoImpl goodDao = DaoFactory.getGoodDao();
		Good good = goodDao.load(order.getGoodid());
		message.setSenduserid(0);
		message2.setSenduserid(0);
		switch (status) {
		case Order.WATT_TO_RECEIVE_MONEY:
			message.setTitle("������Ϣ");
			message.setReciveuserid(order.getBuyerid());
			message.setContent("���Ķ��� �����ţ�"+order.getSerialnumber()+"�����ѷ��ͣ������ĵȴ�����ȷ�ϡ�");
			messageDao.add(message);
			message2.setTitle("��������֪ͨ");
			message2.setReciveuserid(order.getSellerid());
			message2.setContent("�û���֧������" + user.getAlipay() + "��"+user.getNickname()+"������������Ʒ��"+good.getGoodname()+"���������ţ�"+order.getSerialnumber()+"���뾡��ȷ�ϡ�");
			messageDao.add(message2);
			break;
		case Order.WAIT_TO_SEND:
			message.setTitle("������Ϣ");
			message.setReciveuserid(order.getSellerid());
			message.setContent("����"+order.getSerialnumber()+"��ȷ���տ�뾡�췢����");
			messageDao.add(message);
			break;
		case Order.WAIT_TO_RECEIVE:
			message.setTitle("����֪ͨ");
			message.setReciveuserid(order.getSellerid());
			message.setContent("����"+order.getSerialnumber()+"�����ɹ��������ĵȴ����ȷ���ջ���");
			messageDao.add(message);
			message2.setTitle("����֪ͨ");
			message2.setReciveuserid(order.getBuyerid());
			message2.setContent("���Ķ��� �����ţ�"+order.getSerialnumber()+"�����ѷ������뱣���ֻ���ͨ��");
			messageDao.add(message2);
			break;
		case Order.WAIT_TO_REVIEW:
			message.setTitle("������Ϣ");
			message.setReciveuserid(order.getBuyerid());
			message.setContent("���Ķ��� �����ţ�"+order.getSerialnumber()+"�ջ��ɹ����뾡�����ۣ�");
			messageDao.add(message);
			message2.setTitle("������Ϣ");
			message2.setReciveuserid(order.getSellerid());
			message2.setContent("���� �����ţ�"+order.getSerialnumber()+"��������ջ��������ĵȴ����ۡ�");
			messageDao.add(message2);
			break;
		default:
			break;
		}
		System.out.println("����id��" + request.getParameter("orderid"));
		System.out.println("status��" + request.getParameter("status"));
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
