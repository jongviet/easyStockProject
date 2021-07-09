
package com.easystock.domain;

public class CommentVO {

	private int cNum;
	private String symbol;
	private String writer;
	private String comment;
	private int t_up;
	private String regdate;

	public CommentVO() {}

	public int getcNum() {
		return cNum;
	}

	public void setcNum(int cNum) {
		this.cNum = cNum;
	}

	public String getSymbol() {
		return symbol;
	}

	public void setSymbol(String symbol) {
		this.symbol = symbol;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public int getT_up() {
		return t_up;
	}

	public void setT_up(int t_up) {
		this.t_up = t_up;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	
}
