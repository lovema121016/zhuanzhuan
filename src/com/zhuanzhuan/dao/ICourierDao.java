package com.zhuanzhuan.dao;

import java.util.List;

import com.zhuanzhuan.model.Courier;

public interface ICourierDao {
	public void add(Courier courier);
	public void update(Courier courier);
	public void delete(int courierid);
	public Courier load(int courierid);
	public List<Courier> loadNormalCourier();
}
