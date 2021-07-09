package com.easystock.ctrl;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.easystock.persistence.stock.StockDAORule;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = "file:src/main/webapp/WEB-INF/spring/root-context.xml")
public class DummyTest {
		
	@Inject
	private StockDAORule sdao;
	
//	@Test
//	public void stockTest() throws Exception {
//		
//	}
	
}
