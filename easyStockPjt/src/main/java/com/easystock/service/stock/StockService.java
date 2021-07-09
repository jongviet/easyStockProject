package com.easystock.service.stock;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.easystock.domain.EarningVO;
import com.easystock.domain.StockVO;
import com.easystock.persistence.stock.StockDAORule;

@Service
public class StockService implements StockServiceRule {
	private static Logger logger = LoggerFactory.getLogger(StockService.class);

	@Inject
	private StockDAORule sdao;

	@Override
	public int register(StockVO svo) {
		return sdao.insert(svo);
	}

	@Override
	public int register(EarningVO evo) {
		return sdao.insert(evo);
	}

	@Override
	public List<StockVO> getList() {
		return sdao.selectList();
	}

	@Override
	public StockVO detail(String symbol) {
		return sdao.selectOne(symbol);
	}

	@Override
	public List<EarningVO> getEarningList(String symbol) {
		return sdao.getEarningList(symbol);
	}
}
