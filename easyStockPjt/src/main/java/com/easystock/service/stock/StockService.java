package com.easystock.service.stock;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.easystock.domain.EarningVO;
import com.easystock.domain.PageVO;
import com.easystock.domain.StockVO;
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

	@Override
	public int update(StockVO svo) {
		return sdao.updatePrice(svo);
	}

	@Override
	public List<StockVO> getPriceList() {
		return sdao.getPriceList();
	}
}
