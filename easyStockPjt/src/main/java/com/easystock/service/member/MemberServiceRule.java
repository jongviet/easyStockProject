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
	
	public String chkDeposit(String email); //잔고 체크
	public List<AccountVO> chk_h_list(String email); //보유 종목 체크
	public void updatePrice(List<StockVO> s_list); // account 가격 업데이트
	public List<StockVO> chk_w_list(String email); //관심종목
	public int hasWatchList(String email); //관심종목 보유 현황 체크
	public int hasHoldList(String email); // 보유 종목 체크
	
	public List<WatchVO> getWatchList(String email); //WatchVO List 리턴 to stock/list; 사용 안함
	public int inYourWatchList(String email, String symbol); // detail 관심 종목 아이콘 처리용
	
	public List<ReportVO> getReportList(PageVO pgvo);
	public int deleteReport(int cNum); //신고 내역 제거
	public int getReportCnt(PageVO pgvo); //리포트 카운트
	
	public AccountVO getSpecificSymbol(String keyword, String email); //매수용 리스트
	public StockVO getSpecificSymbol_new(String keyword); //신규 매수용 리스트
	
	public int newBuy(AccountVO avo); //신규 구매
	public int additionalBuy(AccountVO new_avo); //추가 구매
	public int sell(AccountVO avo); //매도
}
