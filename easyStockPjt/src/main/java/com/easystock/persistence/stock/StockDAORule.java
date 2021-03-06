package com.easystock.persistence.stock;

import com.easystock.domain.AccountVO;
import com.easystock.domain.EarningVO;
import com.easystock.domain.PageVO;
import com.easystock.domain.StockVO;
import com.easystock.domain.WatchVO;

import java.util.List;

public interface StockDAORule {

	public int insert(StockVO svo);
	public int insert(EarningVO evo);
	public int createRawData(String symbol);

	public List<StockVO> selectList(PageVO pgvo);
	public StockVO selectOne(String symbol);

	public List<EarningVO> getEarningList(String symbol);
	
	public int selectOne(PageVO pgvo);
	
	public int updatePrice(StockVO svo);
	public int updatePrice(AccountVO avo);
	public int insert(WatchVO wvo);
	public int remove(WatchVO wvo);
	
	public List<StockVO> getStockList();
	public int hasSymbol(String symbol);
}
