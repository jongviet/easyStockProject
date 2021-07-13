package com.easystock.domain;

public class MemberVO {

	private String email;
	private String pwd;
	private double deposit_usd;

	public MemberVO() {}
	
	public MemberVO(String email, String pwd) {
		this.email = email;
		this.pwd = pwd;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public double getDeposit_usd() {
		return deposit_usd;
	}

	public void setDeposit_usd(double deposit_usd) {
		this.deposit_usd = deposit_usd;
	}

}
