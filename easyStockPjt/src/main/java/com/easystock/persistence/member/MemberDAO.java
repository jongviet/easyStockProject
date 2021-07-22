package com.easystock.persistence.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.easystock.domain.AccountVO;
import com.easystock.domain.MemberVO;
import com.easystock.domain.PageVO;
import com.easystock.domain.ReportVO;
import com.easystock.domain.StockVO;
import com.easystock.domain.WatchVO;

@Repository
public class MemberDAO implements MemberDAORule {
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
	public List<WatchVO> chk_w_list(String email) {
		return sql.selectList(NS+"w_list", email);
	}

	@Override
	public List<StockVO> chk_s_list(List<WatchVO> wlist) {
		return sql.selectList(NS+"st_list", wlist);
	}

	@Override
	public int hasWatchList(String email) {
		return sql.selectOne(NS+"hasWatchList", email);
	}

	@Override
	public int hasHoldList(String email) {
		return sql.selectOne(NS+"hasHoldList", email);
	}

	@Override
	public List<WatchVO> getWatchList(String email) {
		return sql.selectList(NS+"getWatchList", email);
	}

	@Override
	public int inYourWatchList(String email, String symbol) {
		Map<String, Object> map = new HashMap<>();
		map.put("email", email);
		map.put("symbol", symbol);
		
		return sql.selectOne(NS+"inYourWatchList", map);
	}

	@Override
	public List<ReportVO> getReportList() {
		return sql.selectList(NS+"getReportList");
	}

	@Override
	public int deleteReport(int cNum) {
		return sql.delete(NS+"deleteReport", cNum);
	}

	@Override
	public int getReportCnt(PageVO pgvo) {
		return sql.selectOne(NS+"getReportCnt", pgvo);
	}

	@Override
	public AccountVO getSpecificSymbol(String keyword, String email) {
		Map<String, Object> map = new HashMap<>();
		map.put("email", email);
		map.put("keyword", keyword);
		
		return sql.selectOne(NS+"getSpecificSymbol", map);
	}

	@Override
	public StockVO getSpecificSymbol_new(String keyword) {
		return sql.selectOne(NS+"getSpecificSymbol_new", keyword);
	}

	@Override
	public int newBuy(AccountVO avo) {
		return sql.insert(NS+"newBuy", avo);
	}

	@Override
	public int deductDeposit(double price, String email) {
		Map<String, Object> map = new HashMap<>();
		map.put("email", email);
		map.put("price", price);
		
		return sql.update(NS+"deductDeposit", map);
	}

	@Override
	public AccountVO getCurrentAccount(String email, String symbol) {
		Map<String, Object> map = new HashMap<>();
		map.put("email", email);
		map.put("symbol", symbol);
		
		return sql.selectOne(NS+"getCurrentAccount", map);
	}

	@Override
	public int updateAccount(AccountVO new_avo) {
		return sql.update(NS+"updateAccount", new_avo);
	}

	@Override
	public int addDeposit(double price, String email) {
		Map<String, Object> map = new HashMap<>();
		map.put("email", email);
		map.put("price", price);
		
		return sql.update(NS+"addDeposit", map);
	}

	@Override
	public int updateAccount_sell(AccountVO avo) {
		return sql.update(NS+"updateAccount_sell", avo);
	}

	@Override
	public int deleteAccount_sell(AccountVO avo) {
		return sql.delete(NS+"deleteAccouont_sell", avo);
	}
	
	@Override
	public int delTester_member() {
		return sql.delete(NS+"delTester_member");
	}

	@Override
	public int delTester_account() {
		return sql.delete(NS+"delTester_account");
	}

	@Override
	public int delTester_comment() {
		return sql.delete(NS+"delTester_comment");
	}

	@Override
	public int delTester_liked() {
		return sql.delete(NS+"delTester_liked");
	}

	@Override
	public int delTester_report() {
		return sql.delete(NS+"delTester_report");
	}

	@Override
	public int delTester_watch() {
		return sql.delete(NS+"delTester_watch");
	}

}
