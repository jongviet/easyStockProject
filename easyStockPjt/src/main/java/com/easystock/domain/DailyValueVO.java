package com.easystock.domain;

public class DailyValueVO {

	private int dvNum;
	private String date;
	private String symbol;
	private double open;
	private double high;
	private double close;
	private int d_volume;

	public DailyValueVO() {}

	public int getDvNum() {
		return dvNum;
	}

	public void setDvNum(int dvNum) {
		this.dvNum = dvNum;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getSymbol() {
		return symbol;
	}

	public void setSymbol(String symbol) {
		this.symbol = symbol;
	}

	public double getOpen() {
		return open;
	}

	public void setOpen(double open) {
		this.open = open;
	}

	public double getHigh() {
		return high;
	}

	public void setHigh(double high) {
		this.high = high;
	}

	public double getClose() {
		return close;
	}

	public void setClose(double close) {
		this.close = close;
	}

	public int getD_volume() {
		return d_volume;
	}

	public void setD_volume(int d_volume) {
		this.d_volume = d_volume;
	}

}
