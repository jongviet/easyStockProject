package com.easystock.service.stock;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.easystock.domain.AccountVO;
import com.easystock.domain.EarningVO;
import com.easystock.domain.PageVO;
import com.easystock.domain.StockVO;
import com.easystock.domain.WatchVO;
import com.easystock.persistence.member.MemberDAORule;
import com.easystock.persistence.stock.StockDAORule;

@Service
public class StockService implements StockServiceRule {
	private static Logger logger = LoggerFactory.getLogger(StockService.class);

	@Inject
	private StockDAORule sdao;
	
	@Inject
	private MemberDAORule mdao;

	@Override
	public int register(StockVO svo) {
		return sdao.insert(svo);
	}

	@Override
	public int register(EarningVO evo) {
		return sdao.insert(evo);
	}

	@Override
	public List<StockVO> getList(PageVO pgvo) {
		return sdao.selectList(pgvo);
	}

	@Override
	public StockVO detail(String symbol) {
		return sdao.selectOne(symbol);
	}

	@Override
	public List<EarningVO> getEarningList(String symbol) {
		return sdao.getEarningList(symbol);
	}

	@Override
	public int getTotalCnt(PageVO pgvo) {
		return sdao.selectOne(pgvo);
	}
	
	//stock 테이블
	@Override
	public int update(StockVO svo) {
		return sdao.updatePrice(svo);
	}

	//account 테이블
	@Override
	public int update(AccountVO avo) {
		return sdao.updatePrice(avo);
	}

	@Transactional(isolation =  Isolation.READ_COMMITTED)
	@Override
	public List<WatchVO> insertAndList(WatchVO wvo) {
		sdao.insert(wvo); //관심종목삽입
		List<WatchVO> w_list = mdao.chk_w_list(wvo.getEmail()); //symbol만 담긴 watchVO의 리스트
		
		return w_list;
	}
}
