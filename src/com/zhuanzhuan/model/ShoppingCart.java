package com.zhuanzhuan.model;

public class ShoppingCart {
    private int id;//购物车的id
    private int goodid;//商品的id
    private int userid;//买家的id
    //set和get方法
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getGoodid() {
		return goodid;
	}
	public void setGoodid(int goodid) {
		this.goodid = goodid;
	}
	public int getUserid() {
		return userid;
	}
	public void setUserid(int userid) {
		this.userid = userid;
	}
}
