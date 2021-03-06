package com.zhuanzhuan.dao;

import java.util.List;
import com.zhuanzhuan.model.GoodStream;

public interface IGoodStreamDao {
	public void add(GoodStream goodStream);
	public void update(GoodStream goodStream);
	public GoodStream loadByOrderid(int orderid);
	public List<GoodStream> loadByStatus(int status);
	public List<GoodStream> load(int courierid,int status);
	public GoodStream load(int id);
}
