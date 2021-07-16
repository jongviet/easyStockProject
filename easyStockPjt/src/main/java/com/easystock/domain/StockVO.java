package com.easystock.domain;

public class StockVO {

	private String symbol;
	private String fullName;
	private String description;
	private String sector;
	private long m_capitalization; //시가총액, 숫자 범위 매우 큼!
	private double per;
	private double eps;
	private double pxt_insiders;
	private double pxt_institutions;
	private double year_high;
	private double year_low;
	private double avg_target;
	private double cur_price; //거래용, 4개 종목만 업데이트하기

	public StockVO() {}

	public StockVO(String symbol, String fullName, String description, String sector, long m_capitalization, double per,
			double eps, double pxt_insiders, double pxt_institutions, double year_high, double year_low,
			double avg_target) {
		this.symbol = symbol;
		this.fullName = fullName;
		this.description = description;
		this.sector = sector;
		this.m_capitalization = m_capitalization;
		this.per = per;
		this.eps = eps;
		this.pxt_insiders = pxt_insiders;
		this.pxt_institutions = pxt_institutions;
		this.year_high = year_high;
		this.year_low = year_low;
		this.avg_target = avg_target;
	}

	
	public double getCur_price() {
		return cur_price;
	}

	public void setCur_price(double cur_price) {
		this.cur_price = cur_price;
	}

	public String getSymbol() {
		return symbol;
	}

	public void setSymbol(String symbol) {
		this.symbol = symbol;
	}

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getSector() {
		return sector;
	}

	public void setSector(String sector) {
		this.sector = sector;
	}

	public long getM_capitalization() {
		return m_capitalization;
	}

	public void setM_capitalization(long m_capitalization) {
		this.m_capitalization = m_capitalization;
	}

	public double getPer() {
		return per;
	}

	public void setPer(double per) {
		this.per = per;
	}

	public double getEps() {
		return eps;
	}

	public void setEps(double eps) {
		this.eps = eps;
	}

	public double getPxt_insiders() {
		return pxt_insiders;
	}

	public void setPxt_insiders(double pxt_insiders) {
		this.pxt_insiders = pxt_insiders;
	}

	public double getPxt_institutions() {
		return pxt_institutions;
	}

	public void setPxt_institutions(double pxt_institutions) {
		this.pxt_institutions = pxt_institutions;
	}

	public double getYear_high() {
		return year_high;
	}

	public void setYear_high(double year_high) {
		this.year_high = year_high;
	}

	public double getYear_low() {
		return year_low;
	}

	public void setYear_low(double year_low) {
		this.year_low = year_low;
	}

	public double getAvg_target() {
		return avg_target;
	}

	public void setAvg_target(double avg_target) {
		this.avg_target = avg_target;
	}

	@Override
	public String toString() {
		return "StockVO [symbol=" + symbol + ", fullName=" + fullName + ", description=" + description + ", sector="
				+ sector + ", m_capitalization=" + m_capitalization + ", per=" + per + ", eps=" + eps
				+ ", pxt_insiders=" + pxt_insiders + ", pxt_institutions=" + pxt_institutions + ", year_high="
				+ year_high + ", year_low=" + year_low + ", avg_target=" + avg_target + ", cur_price=" + cur_price
				+ "]";
	}
	
}
