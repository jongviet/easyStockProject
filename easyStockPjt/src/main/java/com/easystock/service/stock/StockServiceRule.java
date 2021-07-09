package com.easystock.service.stock;

import com.easystock.domain.EarningVO;
import com.easystock.domain.StockVO;
import java.util.List;

public interface StockServiceRule {
  public int register(StockVO svo); //스톡 등록용, 현재 삭제
  public int register(EarningVO evo); //어닝 등록용
  
  public List<StockVO> getList(); //스톡 리스트
  public StockVO detail(String symbol); //스톡 디테일
  
  public List<EarningVO> getEarningList(String symbol); //어닝리스트
}