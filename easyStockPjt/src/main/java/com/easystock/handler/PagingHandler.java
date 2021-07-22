package com.easystock.handler;

import com.easystock.domain.PageVO;

public class PagingHandler {
	
	private int totalCount; 
	private int firstPageIndex; 
	private int lastPageIndex; 
	private boolean prev, next;
	private PageVO pgvo;
	
	public PagingHandler() {}
	public PagingHandler(int totalCount, PageVO pgvo) {
		this.totalCount = totalCount;
		this.pgvo = pgvo;
		
		this.lastPageIndex = (int)(Math.ceil(pgvo.getPageIndex()/3.0)) * 3;
		this.firstPageIndex = this.lastPageIndex - 2; 

		int realLastPageIndex = (int)Math.ceil((totalCount*1.0)/pgvo.getCountPerPage());
		
		if(this.lastPageIndex >= realLastPageIndex) {
			this.lastPageIndex = realLastPageIndex;
		}
		
		this.prev = firstPageIndex > 1; 
		this.next = this.lastPageIndex < realLastPageIndex; 
		
	}
	
	public int getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}
	public int getFirstPageIndex() {
		return firstPageIndex;
	}
	public void setFirstPageIndex(int firstPageIndex) {
		this.firstPageIndex = firstPageIndex;
	}
	public int getLastPageIndex() {
		return lastPageIndex;
	}
	public void setLastPageIndex(int lastPageIndex) {
		this.lastPageIndex = lastPageIndex;
	}
	public boolean isPrev() {
		return prev;
	}
	public void setPrev(boolean prev) {
		this.prev = prev;
	}
	public boolean isNext() {
		return next;
	}
	public void setNext(boolean next) {
		this.next = next;
	}
	public PageVO getPgvo() {
		return pgvo;
	}
	public void setPgvo(PageVO pgvo) {
		this.pgvo = pgvo;
	}
}
