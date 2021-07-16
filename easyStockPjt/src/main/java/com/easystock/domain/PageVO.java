package com.easystock.domain;

public class PageVO {
	private String range;
	private String keyword;
	private int pageIndex; //몇번째 페이지 번호인지?
	private int countPerPage; // 한페이지에 몇개의 글?
	private int cal_idx;

	public PageVO() {
		this(1, 5); //페이징 최초
	}
	
	public PageVO(int pageIndex, int countPerPage) {
		this.pageIndex = pageIndex;
		this.countPerPage = countPerPage;
	}
	
	public PageVO(int pageIndex, String range, String keyword) {
		this.pageIndex = pageIndex;
		this.range = range;
		this.keyword = keyword;
	}

	//서치했을 때 페이징
	public PageVO(String range, String keyword, int pageIndex, int countPerPage) {
		this.range = range;
		this.keyword = keyword;
		this.pageIndex = pageIndex;
		this.countPerPage = countPerPage;
	}

	public PageVO(String range, String keyword) {
		this.range = range;
		this.keyword = keyword;
	}
	
	public String getRange() {
		return range;
	}

	public void setRange(String range) {
		this.range = range;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public int getPageIndex() {
		return pageIndex;
	}

	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}

	public int getCountPerPage() {
		return countPerPage;
	}

	public void setCountPerPage(int countPerPage) {
		this.countPerPage = countPerPage;
	}

	public int getCal_idx() {
		return cal_idx;
	}

	public void setCal_idx(int cal_idx) {
		this.cal_idx = cal_idx;
	}
	
}
