package com.easystock.persistence.stock;

import com.easystock.domain.EarningVO;
import com.easystock.domain.PageVO;
import com.easystock.domain.StockVO;
import java.util.List;

public interface StockDAORule {
	public int insert(StockVO svo);
	public int insert(EarningVO evo);

	public List<StockVO> selectList(PageVO pgvo);
	public StockVO selectOne(String symbol);

	public List<EarningVO> getEarningList(String symbol);
	
	public int selectOne(PageVO pgvo);
	
	public int updatePrice(StockVO svo);//거래 가격업뎃
	public List<StockVO> getPriceList(); //스톡 가격 추출 -> account 가격 업데이트용

}
