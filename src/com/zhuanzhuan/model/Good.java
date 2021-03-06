package com.zhuanzhuan.model;

public class Good {
	private int id;
	private String goodname;
	private int goodownerid;
	private double price;
	private String description;
	private String images;
	private int num;
	private double freight;
	private String catagory;
	
	public Good() {}
	
	public Good(String goodname, int goodownerid, double price, String description, String images, int num,
			double freight, String catagory) {
		this.goodname = goodname;
		this.goodownerid = goodownerid;
		this.price = price;
		this.description = description;
		this.images = images;
		this.num = num;
		this.freight = freight;
		this.catagory = catagory;
	}
	
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getGoodname() {
		return goodname;
	}
	public void setGoodname(String goodname) {
		this.goodname = goodname;
	}
	public int getGoodownerid() {
		return goodownerid;
	}
	public void setGoodownerid(int goodownerid) {
		this.goodownerid = goodownerid;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public String[] getImages() {
		return this.images.split(";");
	}
	public String getImagesStr() {
		return images;
	}
	public void setImages(String images) {
		this.images = images;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public double getFreight() {
		return freight;
	}
	public void setFreight(double freight) {
		this.freight = freight;
	}
	public String getCatagory() {
		return catagory;
	}
	public void setCatagory(String catagory) {
		this.catagory = catagory;
	}
	@Override
	public String toString() {
		int id = this.id;
		String goodName = this.getGoodname();
		int goodownerid = this.getGoodownerid();
		double price = this.getPrice();
		String images = this.getImagesStr();
		int num = this.getNum();
		double freight = this.getFreight();
		String goodStr = "id:" + id + 
				"goodName:" + goodName +
				"goodownerid:" + goodownerid +
				"price:" + price +
				"imagesStr:" + images + 
				"num:" + num + 
				"freight:" + freight;
		System.out.println(goodStr);
		return goodStr;
	}
	
}
