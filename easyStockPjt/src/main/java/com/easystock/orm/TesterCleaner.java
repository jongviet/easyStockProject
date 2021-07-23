package com.easystock.orm;

import java.time.LocalDateTime;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.easystock.persistence.member.MemberDAORule;

@Component
public class TesterCleaner {
	private static Logger logger = LoggerFactory.getLogger(TesterCleaner.class);
	
	@Inject
	private MemberDAORule mdao;
	
 	@Scheduled(cron = "00 49 13 * * *")
	public void testerCleaner() throws Exception {
		logger.info(">>> testerCleaner() - Start Running");
		logger.info(">>> Start Running at : " + LocalDateTime.now());
		
		int result = 1;
		result = mdao.delTester_report();
		result = mdao.delTester_liked();
		result = mdao.delTester_comment();
		result = mdao.delTester_watch();
		result = mdao.delTester_account();
		result = mdao.delTester_member();
		
		logger.info(result > 0 ? ">>> 테스터 데이터 삭제 완료" : ">>> 테스터 데이터 삭제 실패");
	} 	
}
