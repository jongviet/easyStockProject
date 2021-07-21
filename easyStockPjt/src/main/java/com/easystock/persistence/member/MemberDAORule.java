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
	
	//테스터 생성
	public int selectTester(String email);
	public int insert(String tester);
	//잔고확인
	public String selectDeposit(String email);
	//보유종목확인
	public List<AccountVO> chk_h_list(String email);
	//account 가격 업데이트
	public void updatePrice(List<StockVO> s_list);
	//관심종목확인
	public List<WatchVO> chk_w_list(String email);
	//관심 종목 기준 svo
	public List<StockVO> chk_s_list(List<WatchVO> wlist);
	//관심 종목 보유 현황 점검
	public int hasWatchList(String email);
	//보유 종목 현황 점검
	public int hasHoldList(String email);
	//WatchVO List 리턴 to stock/list; 사용 안함
	public List<WatchVO> getWatchList(String email);
	//detail 관심 종목 아이콘 처리용
	public int inYourWatchList(String email, String symbol);
	
	//신고처리
	public List<ReportVO> getReportList(PageVO pgvo);
	public int deleteReport(int cNum);
	public int getReportCnt(PageVO pgvo);
	//매수 거래 리스트
	public AccountVO getSpecificSymbol(String keyword, String email);
	public StockVO getSpecificSymbol_new(String keyword);
	//신규 매수
	public int newBuy(AccountVO avo);
	//예수금 deduct 처리
	public int deductDeposit(double price, String email);
	//추가매수; 기존 계좌 정보
	public AccountVO getCurrentAccount(String email, String symbol);
	//추가매수; 계산된 정보로 업데이트
	public int updateAccount(AccountVO new_avo);
	//예수금 add 처리
	public int addDeposit(double price, String email);
	//부분 매도
	public int updateAccount_sell(AccountVO avo);
	//전량 매도
	public int deleteAccount_sell(AccountVO avo);
	
	//테스터 정기 삭제
	public int delTester_member();
	public int delTester_account();
	public int delTester_liked();
	public int delTester_comment();
	public int delTester_report();
	public int delTester_watch();
}
