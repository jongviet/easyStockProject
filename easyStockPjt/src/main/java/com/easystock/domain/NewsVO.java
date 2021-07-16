package com.easystock.domain;

public class NewsVO {
	
	private int newsNum;
	private String symbol;
	private String title;
	private String content;

	public int getNewsNum() {
		return newsNum;
	}

	public void setNewsNum(int newsNum) {
		this.newsNum = newsNum;
	}

	public String getSymbol() {
		return symbol;
	}

	public void setSymbol(String symbol) {
		this.symbol = symbol;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
}
