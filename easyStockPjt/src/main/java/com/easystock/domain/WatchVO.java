package com.easystock.domain;


public class WatchVO {
	private int watchNum;
	private String email;
	private String symbol;
	
	public WatchVO() {}

	public int getWatchNum() {
		return watchNum;
	}

	public void setWatchNum(int watchNum) {
		this.watchNum = watchNum;
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
}
