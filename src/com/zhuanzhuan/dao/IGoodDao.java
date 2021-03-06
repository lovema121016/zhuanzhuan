package com.zhuanzhuan.dao;

import java.util.List;

import com.zhuanzhuan.model.Good;

public interface IGoodDao {
	public void add(Good good);
	public void delete(Good good);
	public void delete(int id);
	public void update(Good good);
	public List<Good> load(String goodname);
	public List<Good> loadByCatagory(String goodname,String catagory);
	public List<Good> loadWithCondition(String goodname,String catagory,double minPrice,double maxPrice);
	public Good load(int id);
}
