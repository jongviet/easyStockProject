package com.easystock.service.stock;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.easystock.domain.AccountVO;
import com.easystock.domain.EarningVO;
import com.easystock.domain.PageVO;
import com.easystock.domain.StockVO;
import com.easystock.domain.WatchVO;
import com.easystock.persistence.stock.StockDAORule;

@Service
public class StockService implements StockServiceRule {

	@Inject
	private StockDAORule sdao;
	
	@Transactional
	@Override
	public int register(StockVO svo) {
		sdao.insert(svo);
		
		return sdao.createRawData(svo.getSymbol());
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
	public int update(AccountVO avo) {
		return sdao.updatePrice(avo);
	}

	@Override
	public int insert(WatchVO wvo) {
		return sdao.insert(wvo);
	}

	@Override
	public int delete(WatchVO wvo) {
		return sdao.remove(wvo);
	}

	@Override
	public List<StockVO> getStockList() {
		return sdao.getStockList();
	}

	@Override
	public int hasSymbol(String symbol) {
		return sdao.hasSymbol(symbol);
	}
}
