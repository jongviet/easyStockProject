package com.easystock.orm;

import java.io.File;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.easystock.domain.FilesVO;
import com.easystock.persistence.files.FilesDAORule;

@Component
public class FileSweeper {
	private static Logger logger = LoggerFactory.getLogger(FileSweeper.class);
	private final String BASE_PATH = "C:\\Users\\jongk\\class\\Spring\\workspace\\upload\\";
	
	@Inject
	private FilesDAORule fdao;
	
	//추후 스케쥴대로 움직여줄 수 있는 자바 코드 동작 가능~~~ 메시지 전송, 검사 등등
	//에러 로그만 정기적으로 날리는 것도 추가 가능함~~
	//초 분 시 일 월 요일 연도(optional)
 	@Scheduled(cron = "00 40 21 * * *") //매일, 매월, 매요일
	public void fileSweep() throws Exception {
		logger.info(">>> FileSweeper > fileSweep() - Start Running");
		logger.info(">>> Start Running at : " + LocalDateTime.now());
		
		List<FilesVO> dbFileList = fdao.selectList();
		
		ArrayList<String> currFiles = new ArrayList<String>();//DB에 등록된 파일의 저장경로
		for (FilesVO fvo : dbFileList) {
			String file_path = fvo.getSavedir() + "\\" + fvo.getUuid() + "_";

			String file_name = fvo.getFname();
			currFiles.add(BASE_PATH + file_path + file_name);
			if(fvo.getFtype() > 0) {
				// 썸네일 경로
				currFiles.add(BASE_PATH + file_path + "th_" +file_name);
				
			}
		}
		//점검용
		for (String filePath : currFiles) {
			logger.info(">>> Stored File Path : " + filePath);
		}
		
		//저장되어 있는 모든 파일 검색
		LocalDate now = LocalDate.now();
		String today = now.toString();
		today = today.replace("-", File.separator);
		
		File dir = Paths.get(BASE_PATH + today).toFile();
		File[] allFileObjs = dir.listFiles();
		
		for (File file : allFileObjs) {
			String storedFileName = file.toPath().toString();
			if(!currFiles.contains(storedFileName)) {
				file.delete();
			}
		}
	}	
}
