package com.easystock.service.member;

import com.easystock.domain.MemberVO;

public interface MemberServiceRule {
	public int join(MemberVO mvo);
	public int checkEmail(String email);
	public MemberVO login(MemberVO mvo);
}
