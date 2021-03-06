package com.zhuanzhuan.model;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class Message {
	public static final int UNREAD = 0;
	public static final int READ = 1;
	public static final int ALL = 2;
	private int id;
	private int senduserid;
	private int reciveuserid;
	private int status;
	private String content;
	private Timestamp time;
	private String title;
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getSenduserid() {
		return senduserid;
	}
	public void setSenduserid(int senduserid) {
		this.senduserid = senduserid;
	}
	public int getReciveuserid() {
		return reciveuserid;
	}
	public void setReciveuserid(int reciveuserid) {
		this.reciveuserid = reciveuserid;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Timestamp getTime() {
		return time;
	}
	public void setTime(Timestamp time) {
		this.time = time;
	}
	public String getTimeStr(String pattern) {
		SimpleDateFormat sdf = new SimpleDateFormat(pattern);
		String timeStr = sdf.format(this.time);
		return timeStr;
	}
}
