package com.zhuanzhuan.dao;

import java.util.List;

import com.zhuanzhuan.model.ShoppingCart;

public interface IShoppingCartDao {
	public void add(ShoppingCart shoppingCart);//���
	public void delete(ShoppingCart shoppingCart);//ɾ��
	public void delete(int id);//ɾ��
	public List<ShoppingCart> loadByBuyer(int userid);//�����û���id��list���еĹ��ﳵ����Ʒ��Ϣ
}
