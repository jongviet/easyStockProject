package com.easystock.domain;

public class ReportVO {
	private int reportNum;
	private int cNum;
	private String writer;
	private String content;
	private String reporter;
	
	public ReportVO() {
	}
	public String getReporter() {
		return reporter;
	}
	public void setReporter(String reporter) {
		this.reporter = reporter;
	}
	public int getReportNum() {
		return reportNum;
	}
	public void setReportNum(int reportNum) {
		this.reportNum = reportNum;
	}
	public int getcNum() {
		return cNum;
	}
	public void setcNum(int cNum) {
		this.cNum = cNum;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}
	
	@Override
	public String toString() {
		return "ReportVO [reportNum=" + reportNum + ", cNum=" + cNum + ", writer=" + writer + ", content=" + content
				+ ", reporter=" + reporter + "]";
	}

	
	
}
