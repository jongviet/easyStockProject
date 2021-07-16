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
	
	//추후 스케쥴대로 움직여줄 수 있는 자바 코드 동작 가능~~~ 메시지 전송, 검사 등등
	//에러 로그만 정기적으로 날리는 것도 추가 가능함~~
	// 초 분 시 일 월 요일 연도(optional)
 	@Scheduled(cron = "30 00 09 * * *") //ss, mm, hh, 매일, 매월, 매요일
	public void testerCleaner() throws Exception {
		logger.info(">>> testerCleaner() - Start Running");
		logger.info(">>> Start Running at : " + LocalDateTime.now());
		
		int result = mdao.delTester();
		logger.info(result > 0 ? ">>> 테스터 계정 삭제 완료" : ">>> 테스터 계정 삭제 실패");
	}
}
