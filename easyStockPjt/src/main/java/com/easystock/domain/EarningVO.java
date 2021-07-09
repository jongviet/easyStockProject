package com.easystock.domain;

public class EarningVO {
	
	private int earningNum;
	private String symbol;
	private String reportedDate;
	private double reportedEPS;
	private double estimatedEPS;

	public EarningVO() {}

	public EarningVO(String symbol, String reportedDate, double reportedEPS, double estimatedEPS) {
		this.symbol = symbol;
		this.reportedDate = reportedDate;
		this.reportedEPS = reportedEPS;
		this.estimatedEPS = estimatedEPS;
	}

	public int getEarningNum() {
		return earningNum;
	}

	public void setEarningNum(int earningNum) {
		this.earningNum = earningNum;
	}

	public String getSymbol() {
		return symbol;
	}

	public void setSymbol(String symbol) {
		this.symbol = symbol;
	}

	public String getReportedDate() {
		return reportedDate;
	}

	public void setReportedDate(String reportedDate) {
		this.reportedDate = reportedDate;
	}

	public double getReportedEPS() {
		return reportedEPS;
	}

	public void setReportedEPS(double reportedEPS) {
		this.reportedEPS = reportedEPS;
	}

	public double getEstimatedEPS() {
		return estimatedEPS;
	}

	public void setEstimatedEPS(double estimatedEPS) {
		this.estimatedEPS = estimatedEPS;
	}
}
