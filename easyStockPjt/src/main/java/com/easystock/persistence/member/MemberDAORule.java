package com.easystock.persistence.member;

import java.util.List;

import com.easystock.domain.AccountVO;
import com.easystock.domain.MemberVO;
import com.easystock.domain.PageVO;
import com.easystock.domain.ReportVO;
import com.easystock.domain.StockVO;
import com.easystock.domain.WatchVO;

public interface MemberDAORule {

	public int insert(MemberVO mvo);
	public int selectEmail(String email);
	public MemberVO selectOne(MemberVO mvo);
	
	public int selectTester(String email);
	public int insert(String tester);
	
	public String selectDeposit(String email);
	public List<AccountVO> chk_h_list(String email);
	
	public void updatePrice(List<StockVO> s_list);
	public List<WatchVO> chk_w_list(String email);
	public List<StockVO> chk_s_list(List<WatchVO> wlist);
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
	public int deductDeposit(double price, String email);
	public AccountVO getCurrentAccount(String email, String symbol);
	public int updateAccount(AccountVO new_avo);
	public int addDeposit(double price, String email);
	public int updateAccount_sell(AccountVO avo);
	public int deleteAccount_sell(AccountVO avo);
	
	public int delTester_member();
	public int delTester_account();
	public int delTester_liked();
	public int delTester_comment();
	public int delTester_report();
	public int delTester_watch();
	public String getEncPwd(MemberVO mvo);
}
