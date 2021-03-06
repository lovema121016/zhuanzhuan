package com.zhuanzhuan.model;

import java.sql.Timestamp;

public class Order {
	public static final int CANCEL = 0;					//������ȡ��
	public static final int WAIT_TO_PAY = 1;			//�ȴ����֧��
	public static final int WATT_TO_RECEIVE_MONEY = 2;	//�ȴ�����ȷ���տ�
	public static final int WAIT_TO_SEND = 3;			//�ȴ����ҷ���
	public static final int WAIT_TO_RECEIVE = 4;		//�ȴ�����ջ�
	public static final int WAIT_TO_REVIEW = 5;			//����ջ���������ɴ�����
	public static final int FINISH = 6;					//��ɶ���
	public static final int ALL = 7;					//���ж���
	public static final boolean ONLINE = true;
	public static final boolean OFFLINE = false;
	
	private int id;
	private String serialnumber;
	private int buyerid;
	private int sellerid;
	private int goodid;
	private Timestamp time;
	private double price;
	private int num;
	private int status;
	private double freight;
	private int type;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getSerialnumber() {
		return serialnumber;
	}
	public void setSerialnumber(String serialnumber) {
		this.serialnumber = serialnumber;
	}
	public int getBuyerid() {
		return buyerid;
	}
	public void setBuyerid(int buyerid) {
		this.buyerid = buyerid;
	}
	public int getSellerid() {
		return sellerid;
	}
	public void setSellerid(int sellerid) {
		this.sellerid = sellerid;
	}
	public int getGoodid() {
		return goodid;
	}
	public void setGoodid(int goodid) {
		this.goodid = goodid;
	}
	public Timestamp getTime() {
		return time;
	}
	public void setTime(Timestamp time) {
		this.time = time;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public double getFreight() {
		return freight;
	}
	public void setFreight(double freight) {
		this.freight = freight;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
}