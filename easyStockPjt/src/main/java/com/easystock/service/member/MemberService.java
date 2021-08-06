package com.easystock.service.member;

import java.util.List;

import javax.inject.Inject;

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
	
	@Override
	public String getEncPwd(MemberVO mvo) {
		return mdao.getEncPwd(mvo);
	}

	@Transactional
	@Override
	public int chkTester(String email) {
		if(mdao.selectTester(email) == 0) {
			return mdao.insert(email);
		} else {
			return 0;
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
		List<WatchVO> wlist = mdao.chk_w_list(email);
		return mdao.chk_s_list(wlist);
	}

	@Override
	public int hasWatchList(String email) {
		return mdao.hasWatchList(email);
	}

	@Override
	public int hasHoldList(String email) {
		return mdao.hasHoldList(email);
	}

	@Override
	public List<WatchVO> getWatchList(String email) {
		return mdao.getWatchList(email);
	}

	@Override
	public int inYourWatchList(String email, String symbol) {
		return mdao.inYourWatchList(email, symbol);
	}

	@Override
	public List<ReportVO> getReportList() {
		return mdao.getReportList();
	}

	@Override
	public int deleteReport_all(int cNum) {
		return mdao.deleteReport_all(cNum);
	}
	
	@Override
	public int deleteReport_one(int reportNum) {
		return mdao.deleteReport_one(reportNum);
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
		double price = avo.getAvg_h_price() * avo.getH_qty();
		String email = avo.getEmail();
		int result1 = mdao.deductDeposit(price, email);
		int result2 = 0;
		
		if(result1 > 0) {
			result2 = mdao.newBuy(avo);
		}
		return result2;
	}

	@Transactional
	@Override
	public int additionalBuy(AccountVO new_avo) {
		
		double price = new_avo.getAvg_h_price() * new_avo.getH_qty();
		String email = new_avo.getEmail();
		mdao.deductDeposit(price, email);

		AccountVO cur_avo = mdao.getCurrentAccount(new_avo.getEmail(), new_avo.getSymbol());
		
		double avg_h_price = (  (cur_avo.getAvg_h_price() * cur_avo.getH_qty()) + (new_avo.getAvg_h_price() * new_avo.getH_qty()) ) / 
				(cur_avo.getH_qty() + new_avo.getH_qty());
		
		new_avo.setAvg_h_price(avg_h_price);
		new_avo.setH_qty(cur_avo.getH_qty() + new_avo.getH_qty());
		
		return mdao.updateAccount(new_avo);
	}
	
	@Transactional
	@Override
	public int sell(AccountVO avo) {
		
		double price = avo.getCur_price() * avo.getH_qty();
		String email = avo.getEmail();
		mdao.addDeposit(price, email);
		
		AccountVO cur_avo = mdao.getCurrentAccount(avo.getEmail(), avo.getSymbol());
		
		if(cur_avo.getH_qty() == avo.getH_qty()) {
			return mdao.deleteAccount_sell(avo);
		} else {
			return mdao.updateAccount_sell(avo);
		}
	}



}









