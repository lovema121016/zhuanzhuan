package com.zhuanzhuan.model;

public class User {
	private int id;
	private String head;
	private int username;
	private String realname;
	private String nickname;
	private String password;
	private String mobilephone;
	private int dormitory;
	private int room;
	private boolean sex;
	private String alipay;
	private String alipayQRcode;
	private String qq;
	
	public User() {}
	
	public User(String head, int username, String realname, String nickname, String password, String mobilephone,
			int dormitory, int room, boolean sex, String alipay, String alipayQRcode, String qq) {
		this.head = head;
		this.username = username;
		this.realname = realname;
		this.nickname = nickname;
		this.password = password;
		this.mobilephone = mobilephone;
		this.dormitory = dormitory;
		this.room = room;
		this.sex = sex;
		this.alipay = alipay;
		this.alipayQRcode = alipayQRcode;
		this.qq = qq;
	}

	public boolean getSex() {
		return sex;
	}
	public void setSex(boolean sex) {
		this.sex = sex;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getHead() {
		return head;
	}
	public void setHead(String head) {
		this.head = head;
	}
	public int getUsername() {
		return username;
	}
	public void setUsername(int username) {
		this.username = username;
	}
	public void setUsername(String username) {
		this.username = Integer.parseInt(username);
	}
	public String getRealname() {
		return realname;
	}
	public void setRealname(String realname) {
		this.realname = realname;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getMobilephone() {
		return mobilephone;
	}
	public void setMobilephone(String mobilephone) {
		this.mobilephone = mobilephone;
	}
	public int getDormitory() {
		return dormitory;
	}
	public void setDormitory(int dormitory) {
		this.dormitory = dormitory;
	}
	public void setDormitory(String dormitory) {
		this.dormitory = Integer.parseInt(dormitory);
	}
	public int getRoom() {
		return room;
	}
	public void setRoom(int room) {
		this.room = room;
	}
	public void setRoom(String room) {
		this.room = Integer.parseInt(room);
	}
	public String getAlipay() {
		return alipay;
	}
	public void setAlipay(String alipay) {
		this.alipay = alipay;
	}
	public String getAlipayQRcode() {
		return alipayQRcode;
	}
	public void setAlipayQRcode(String alipayQRcode) {
		this.alipayQRcode = alipayQRcode;
	}
	public String getQq() {
		return qq;
	}
	public void setQq(String qq) {
		this.qq = qq;
	}
}
