package com.easystock.ctrl;

import java.util.List;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.easystock.domain.StockVO;
import com.easystock.domain.WatchVO;
import com.easystock.persistence.member.MemberDAORule;
import com.easystock.persistence.stock.StockDAORule;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class DummyTest {
		
	@Inject
	private StockDAORule sdao;
	
	@Inject
	private MemberDAORule mdao;
	
	@Test
	public void test() throws Exception {
		String email = "jongki6161@naver.com";
		List<WatchVO> wlist = mdao.chk_w_list(email);
		List<StockVO> slist = mdao.chk_s_list(wlist);
		System.out.println(slist);
	}
}
