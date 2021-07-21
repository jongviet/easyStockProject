package com.easystock.persistence.stock;

import com.easystock.domain.AccountVO;
import com.easystock.domain.EarningVO;
import com.easystock.domain.PageVO;
import com.easystock.domain.StockVO;
import com.easystock.domain.WatchVO;

import java.util.List;

public interface StockDAORule {
	//신규 종목 등록 처리 3개
	public int insert(StockVO svo);
	public int insert(EarningVO evo);
	public int createRawData(String symbol);

	public List<StockVO> selectList(PageVO pgvo);
	public StockVO selectOne(String symbol);

	public List<EarningVO> getEarningList(String symbol);
	
	public int selectOne(PageVO pgvo);
	
	public int updatePrice(StockVO svo);//거래 가격업뎃
	public int updatePrice(AccountVO avo);  //어카운트 가격 데이터 업데이트
	public int insert(WatchVO wvo); //관종추가
	public int remove(WatchVO wvo);
	
	public List<StockVO> getStockList(); //admin 수동 업데이트 리스트용
	


}
