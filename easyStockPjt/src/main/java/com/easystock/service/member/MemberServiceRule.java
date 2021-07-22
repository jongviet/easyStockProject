package com.easystock.service.member;

import java.util.List;

import com.easystock.domain.AccountVO;
import com.easystock.domain.MemberVO;
import com.easystock.domain.PageVO;
import com.easystock.domain.ReportVO;
import com.easystock.domain.StockVO;
import com.easystock.domain.WatchVO;

public interface MemberServiceRule {
	public int join(MemberVO mvo);
	public int chkEmail(String email);
	public MemberVO login(MemberVO mvo);
	public int chkTester(String email);
	
	public String chkDeposit(String email); 
	public List<AccountVO> chk_h_list(String email);
	public void updatePrice(List<StockVO> s_list);
	public List<StockVO> chk_w_list(String email);
	public int hasWatchList(String email);
	public int hasHoldList(String email);
	
	public List<WatchVO> getWatchList(String email);
	public int inYourWatchList(String email, String symbol);
	
	public List<ReportVO> getReportList();
	public int deleteReport_all(int cNum);
	public int deleteReport_one(int reportNum);
	public int getReportCnt(PageVO pgvo);
	
	public AccountVO getSpecificSymbol(String keyword, String email);
	public StockVO getSpecificSymbol_new(String keyword);
	
	public int newBuy(AccountVO avo);
	public int additionalBuy(AccountVO new_avo);
	public int sell(AccountVO avo);
	
}
