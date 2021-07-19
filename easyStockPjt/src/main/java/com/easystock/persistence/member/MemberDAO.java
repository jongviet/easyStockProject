package com.easystock.persistence.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.easystock.domain.AccountVO;
import com.easystock.domain.MemberVO;
import com.easystock.domain.PageVO;
import com.easystock.domain.ReportVO;
import com.easystock.domain.StockVO;
import com.easystock.domain.WatchVO;

@Repository
public class MemberDAO implements MemberDAORule {
	private static Logger logger = LoggerFactory.getLogger(MemberDAO.class);
	private final String NS = "MemberMapper.";
	
	@Inject
	private SqlSession sql;
	
	@Override
	public int insert(MemberVO mvo) {
		return sql.insert(NS+"join", mvo);
	}

	@Override
	public int selectEmail(String email) {
		return sql.selectOne(NS+"e_chk", email);
	}

	@Override
	public MemberVO selectOne(MemberVO mvo) {
		return sql.selectOne(NS+"login", mvo);
	}

	@Override
	public int selectTester(String email) {
		return sql.selectOne(NS+"t_chk", email);
	}

	@Override
	public int insert(String email) {
		String pwd = "1234";
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("tester",(String)email);
		map.put("pwd",(String)pwd);
		return sql.insert(NS+"t_join", map);
	}

	@Override
	public String selectDeposit(String email) {
		return sql.selectOne(NS+"deposit", email);
	}

	@Override
	public List<AccountVO> chk_h_list(String email) {
		return sql.selectList(NS+"h_list", email);
	}

	@Override
	public void updatePrice(List<StockVO> s_list) {
		sql.update(NS+"update_price", s_list);
	}

	@Override
	public int delTester() {
		return sql.delete(NS+"delTester");
	}

	//메인페이지 관심 종목 처리용 WatchVO -> StockVO
	@Override
	public List<WatchVO> chk_w_list(String email) {
		return sql.selectList(NS+"w_list", email);
	}

	//메인페이지 관심 종목 처리용 WatchVO -> StockVO
	@Override
	public List<StockVO> chk_s_list(List<WatchVO> wlist) {
		return sql.selectList(NS+"s_list", wlist);
	}

	@Override
	public int hasWatchList(String email) {
		return sql.selectOne(NS+"hasWatchList", email);
	}

	@Override
	public int hasHoldList(String email) {
		return sql.selectOne(NS+"hasHoldList", email);
	}

	//WatchVO List 리턴 to stock/list; 사용안함
	@Override
	public List<WatchVO> getWatchList(String email) {
		return sql.selectList(NS+"getWatchList", email);
	}

	// detail 관심 종목 아이콘 처리용
	@Override
	public int inYourWatchList(String email, String symbol) {
		Map<String, Object> map = new HashMap<>();
		map.put("email", email);
		map.put("symbol", symbol);
		
		return sql.selectOne(NS+"inYourWatchList", map);
	}

	@Override
	public List<ReportVO> getReportList(PageVO pgvo) {
		pgvo.setCal_idx((pgvo.getPageIndex() - 1) * 5);
		return sql.selectList(NS+"getReportList", pgvo);
	}

	@Override
	public int deleteReport(int cNum) {
		return sql.delete(NS+"deleteReport", cNum);
	}

	@Override
	public int getReportCnt(PageVO pgvo) {
		return sql.selectOne(NS+"getReportCnt", pgvo);
	}

}
