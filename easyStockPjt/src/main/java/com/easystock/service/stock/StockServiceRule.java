package com.easystock.service.stock;

import com.easystock.domain.AccountVO;
import com.easystock.domain.EarningVO;
import com.easystock.domain.PageVO;
import com.easystock.domain.StockVO;
import com.easystock.domain.WatchVO;

import java.util.List;

public interface StockServiceRule {
  public int register(StockVO svo); //스톡 등록용, 현재 삭제
  public int register(EarningVO evo); //어닝 등록용
  
  public List<StockVO> getList(PageVO pgvo); //스톡 리스트, 페이지네이션추가
  public StockVO detail(String symbol); //스톡 디테일
  
  public List<EarningVO> getEarningList(String symbol); //어닝리스트
  
  public int getTotalCnt(PageVO pgvo); //스톡 페이징용
  
  public int update(StockVO svo); //거래소 가격 데이터 업데이트
  public int update(AccountVO avo); //어카운트 가격 데이터 업데이트
  
  public List<WatchVO> insertAndList(WatchVO wvo); //관심종목추가 -> symbol만 담긴 watchVO List 리턴
}