package com.easystock.service.member;

import java.util.List;

import com.easystock.domain.AccountVO;
import com.easystock.domain.MemberVO;
import com.easystock.domain.StockVO;

public interface MemberServiceRule {
	public int join(MemberVO mvo);
	public int chkEmail(String email);
	public MemberVO login(MemberVO mvo);
	public int chkTester(String tester);
	
	public String chkDeposit(String email); //잔고 체크
	public List<AccountVO> chk_h_list(String email); //보유 종목 체크
	public void updatePrice(List<StockVO> s_list); // account 가격 업데이트
}
