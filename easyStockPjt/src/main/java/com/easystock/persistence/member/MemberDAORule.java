package com.easystock.persistence.member;

import com.easystock.domain.MemberVO;

public interface MemberDAORule {

	public int insert(MemberVO mvo);
	public int selectEmail(String email);
	public MemberVO selectOne(MemberVO mvo);
	
	//테스터 생성
	public int selectTester(String tester);
	public int insert(String tester);
}
