package com.easystock.persistence.stock;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.easystock.domain.AccountVO;
import com.easystock.domain.EarningVO;
import com.easystock.domain.PageVO;
import com.easystock.domain.StockVO;
import com.easystock.domain.WatchVO;

@Repository
public class StockDAO implements StockDAORule {
	private final String NS = "StockMapper.";

	@Inject
	private SqlSession sql;

	@Override
	public int insert(StockVO svo) {
		return sql.insert(NS + "s_insert", svo);
	}

	@Override
	public int insert(EarningVO evo) {
		return sql.insert(NS + "e_insert", evo);
	}

	@Override
	public List<StockVO> selectList(PageVO pgvo) {
		pgvo.setCal_idx((pgvo.getPageIndex() - 1) * 5);
		return sql.selectList(NS + "s_list", pgvo);
	}

	@Override
	public StockVO selectOne(String symbol) {
		return sql.selectOne(NS + "s_detail", symbol);
	}

	@Override
	public List<EarningVO> getEarningList(String symbol) {
		return sql.selectList(NS + "e_list", symbol);
	}

	@Override
	public int selectOne(PageVO pgvo) {
		return sql.selectOne(NS + "tc", pgvo);
	}

	@Override
	public int updatePrice(StockVO svo) {
		return sql.update(NS + "s_price_update", svo);
	}

	@Override
	public int updatePrice(AccountVO avo) {
		return sql.update(NS + "a_price_update", avo);
	}

	@Override
	public int insert(WatchVO wvo) {
		return sql.insert(NS+"add_watch", wvo);
	}

	@Override
	public int remove(WatchVO wvo) {
		return sql.delete(NS+"remove_watch", wvo);
	}

	@Override
	public List<StockVO> getStockList() {
		return sql.selectList(NS+"s_list_admin");
	}

	@Override
	public int createRawData(String symbol) {
		return sql.insert(NS+"a_rawdata", symbol);
	}

	@Override
	public int hasSymbol(String symbol) {
		return sql.selectOne(NS+"hasSymbol", symbol);
	}

}
