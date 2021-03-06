package com.zhuanzhuan.model;

import java.sql.Timestamp;

public class GoodStream {
	public static final int WAIT_TO_SEND = 0;
	public static final int WAIT_TO_RECEIVE = 1;
	public static final int FINISH = 2;
	public static final int ALL = 3;
	private int id;
	private int orderid;
	private int deliverid;
	private int status;
	private Timestamp createTime;
	private Timestamp sendTime;
	private Timestamp receiveTime;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getOrderid() {
		return orderid;
	}
	public void setOrderid(int orderid) {
		this.orderid = orderid;
	}
	public int getDeliverid() {
		return deliverid;
	}
	public void setDeliverid(int deliverid) {
		this.deliverid = deliverid;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public Timestamp getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}
	public Timestamp getSendTime() {
		return sendTime;
	}
	public void setSendTime(Timestamp sendTime) {
		this.sendTime = sendTime;
	}
	public Timestamp getReceiveTime() {
		return receiveTime;
	}
	public void setReceiveTime(Timestamp receiveTime) {
		this.receiveTime = receiveTime;
	}
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return "id:" + id +
				" orderid:" + orderid + 
				" deliverid:" + deliverid + 
				" status:" + status + 
				" createtime:" + createTime.toString() + 
				" sendtime:" + sendTime + 
				" receivetime:" + receiveTime;
	}
	
	
}
