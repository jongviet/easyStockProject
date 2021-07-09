package com.easystock.domain;

public class AccountVO {

	private int h_num;
	private String email;
	private String symbol;
	private double avg_h_price;
	private int h_qty;
	
	public AccountVO() {}

	public int getH_num() {
		return h_num;
	}

	public void setH_num(int h_num) {
		this.h_num = h_num;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getSymbol() {
		return symbol;
	}

	public void setSymbol(String symbol) {
		this.symbol = symbol;
	}

	public double getAvg_h_price() {
		return avg_h_price;
	}

	public void setAvg_h_price(double avg_h_price) {
		this.avg_h_price = avg_h_price;
	}

	public int getH_qty() {
		return h_qty;
	}

	public void setH_qty(int h_qty) {
		this.h_qty = h_qty;
	}
}
