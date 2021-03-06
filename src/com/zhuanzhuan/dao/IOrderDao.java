package com.zhuanzhuan.dao;

import java.util.List;

import com.zhuanzhuan.model.Order;

public interface IOrderDao {
	public void create(Order order);
	public void update(Order order);
	public void delete(Order order);
	public Order load(int id);
	public Order load(String serialnumber);
	public List<Order> loadByBuyer(int buyerid,int status);
	public List<Order> loadBySeller(int sellerid,int status);
}
