package com.easystock.persistence.stock;

import com.easystock.domain.EarningVO;
import com.easystock.domain.StockVO;
import java.util.List;

public interface StockDAORule {
	public int insert(StockVO svo);
	public int insert(EarningVO evo);

	public List<StockVO> selectList();
	public StockVO selectOne(String symbol);

	public List<EarningVO> getEarningList(String symbol);
}
