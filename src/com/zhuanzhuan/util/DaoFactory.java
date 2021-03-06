package com.zhuanzhuan.util;

import com.zhuanzhuan.dao.CourierDaoImpl;
import com.zhuanzhuan.dao.GoodDaoImpl;
import com.zhuanzhuan.dao.GoodStreamDaoImpl;
import com.zhuanzhuan.dao.MessageDaoImpl;
import com.zhuanzhuan.dao.OrderDaoImpl;
import com.zhuanzhuan.dao.ShoppingCartDaoImpl;
import com.zhuanzhuan.dao.UserDaoImpl;

public class DaoFactory {
	public static UserDaoImpl getUserDao() {
		return new UserDaoImpl();
	}
	public static GoodDaoImpl getGoodDao() {
		return new GoodDaoImpl();
	}
	public static OrderDaoImpl getOrderDao() {
		return new OrderDaoImpl();
	}
	public static GoodStreamDaoImpl getGoodStreamDao() {
		return new GoodStreamDaoImpl();
	}
	public static ShoppingCartDaoImpl getShoppingCartDao() {
		return new ShoppingCartDaoImpl();
	}
	public static CourierDaoImpl getCourierDao() {
		return new CourierDaoImpl();
	}
	public static MessageDaoImpl getMessageDao() {
		return new MessageDaoImpl();
	}
}
