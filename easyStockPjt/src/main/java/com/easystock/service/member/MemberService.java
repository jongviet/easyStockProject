package com.easystock.service.member;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.easystock.domain.AccountVO;
import com.easystock.domain.MemberVO;
import com.easystock.domain.StockVO;
import com.easystock.persistence.member.MemberDAORule;

@Service
public class MemberService implements MemberServiceRule {
	private static Logger logger = LoggerFactory.getLogger(MemberService.class);

	@Inject
	private MemberDAORule mdao;
	
	@Override
	public int join(MemberVO mvo) {
		return mdao.insert(mvo);
	}

	@Override
	public int chkEmail(String email) {
		return mdao.selectEmail(email);
	}

	@Override
	public MemberVO login(MemberVO mvo) {
		return mdao.selectOne(mvo);
	}

	
	@Transactional
	@Override
	public int chkTester(String email) {
		if(mdao.selectTester(email) == 0) {
			return mdao.insert(email);
		} else {
			return 0; //실패
		}
	}

	@Override
	public String chkDeposit(String email) {
		return mdao.selectDeposit(email);
	}

	@Override
	public List<AccountVO> chk_h_list(String email) {
		return mdao.chk_h_list(email);
	}

	@Override
	public void updatePrice(List<StockVO> s_list) {
		mdao.updatePrice(s_list);
	}
}