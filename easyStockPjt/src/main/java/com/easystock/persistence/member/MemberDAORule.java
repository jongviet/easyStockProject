package com.easystock.persistence.member;

import java.util.List;

import com.easystock.domain.AccountVO;
import com.easystock.domain.MemberVO;
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
	//테스터 계정 정기 삭제
	public int delTester();
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
}
