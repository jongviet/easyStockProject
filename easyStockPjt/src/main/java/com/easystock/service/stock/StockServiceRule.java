package com.easystock.service.stock;

import com.easystock.domain.AccountVO;
import com.easystock.domain.EarningVO;
import com.easystock.domain.PageVO;
import com.easystock.domain.StockVO;
import com.easystock.domain.WatchVO;

import java.util.List;

public interface StockServiceRule {
  public int register(StockVO svo);
  public int register(EarningVO evo);
  
  public List<StockVO> getList(PageVO pgvo);
  public StockVO detail(String symbol);
  
  public List<EarningVO> getEarningList(String symbol);
  
  public int getTotalCnt(PageVO pgvo);
  
  public int update(StockVO svo);
  public int update(AccountVO avo);
  
  public int insert(WatchVO wvo);
  public int delete(WatchVO wvo);
  
  public List<StockVO> getStockList();
  public int hasSymbol(String symbol);
}