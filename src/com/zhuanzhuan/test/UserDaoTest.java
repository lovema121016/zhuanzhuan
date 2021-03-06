package com.zhuanzhuan.test;

import com.zhuanzhuan.dao.GoodDaoImpl;
import com.zhuanzhuan.dao.UserDaoImpl;
import com.zhuanzhuan.model.Good;
import com.zhuanzhuan.model.User;
import com.zhuanzhuan.util.DaoFactory;


public class UserDaoTest {
	public static void main(String[] args) {
		//ValidCodeUtil.sendSMS("123456", "15127045632");
		/*User user = new User("ss", 1, "ff", "dsf", "ss", "4", 4, 8, false, "ss", "44", "ss");
		UserDaoImpl userDao = DaoFactory.getUserDao();
		for(int i = 0;i < 1;i++)
			userDao.add(user);*/
		Good good = new Good("goodname", 1, 12.34, "##", "..", 10, 10, "11");
		GoodDaoImpl goodDao = DaoFactory.getGoodDao();
		goodDao.add(good);
	}
}
