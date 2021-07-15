package com.easystock.persistence.member;

import java.util.List;

import com.easystock.domain.AccountVO;
import com.easystock.domain.MemberVO;
import com.easystock.domain.StockVO;

public interface MemberDAORule {

	public int insert(MemberVO mvo);
	public int selectEmail(String email);
	public MemberVO selectOne(MemberVO mvo);
	
	//테스터 생성
	public int selectTester(String tester);
	public int insert(String tester);
	//잔고확인
	public String selectDeposit(String email);
	//보유종목확인
	public List<AccountVO> chk_h_list(String email);
	//account 가격 업데이트
	public void updatePrice(List<StockVO> s_list);
}
