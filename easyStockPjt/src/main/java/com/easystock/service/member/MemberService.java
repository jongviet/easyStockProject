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
import com.easystock.domain.WatchVO;
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

	@Override
	public List<StockVO> chk_w_list(String email) {
		List<WatchVO> wlist = mdao.chk_w_list(email); //관심종목 symbol 리스트
		return mdao.chk_s_list(wlist);//관심종목 symbol 리스트에 따른 StockVO List
	}

	@Override
	public int hasWatchList(String email) {
		return mdao.hasWatchList(email);
	}

	@Override
	public int hasHoldList(String email) {
		return mdao.hasHoldList(email);
	}

	//WatchVO List 리턴 to stock/list
	@Override
	public List<WatchVO> getWatchList(String email) {
		return mdao.getWatchList(email);
	}

	// detail 관심 종목 아이콘 처리용
	@Override
	public int inYourWatchList(String email, String symbol) {
		return mdao.inYourWatchList(email, symbol);
	}
}
