package com.easystock.service.member;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.easystock.domain.AccountVO;
import com.easystock.domain.MemberVO;
import com.easystock.domain.PageVO;
import com.easystock.domain.ReportVO;
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

	@Override
	public List<ReportVO> getReportList(PageVO pgvo) {
		return mdao.getReportList(pgvo);
	}

	@Override
	public int deleteReport(int cNum) {
		return mdao.deleteReport(cNum);
	}

	@Override
	public int getReportCnt(PageVO pgvo) {
		return mdao.getReportCnt(pgvo);
	}

	@Override
	public AccountVO getSpecificSymbol(String keyword, String email) {
		return mdao.getSpecificSymbol(keyword, email);
	}

	@Override
	public StockVO getSpecificSymbol_new(String keyword) {
		return mdao.getSpecificSymbol_new(keyword);
	}

	@Transactional
	@Override
	public int newBuy(AccountVO avo) {
		//예수금 처리
		double price = avo.getAvg_h_price() * avo.getH_qty();
		String email = avo.getEmail();
		int result1 = mdao.deductDeposit(price, email);
		int result2 = 0;
		
		//account 등록
		if(result1 > 0) {
			result2 = mdao.newBuy(avo);
		}
		return result2;
	}
}
