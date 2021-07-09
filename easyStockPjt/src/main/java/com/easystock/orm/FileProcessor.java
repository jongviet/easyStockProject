package com.easystock.orm;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.util.UUID;

import javax.inject.Inject;

import org.apache.tika.Tika;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.easystock.domain.FilesVO;
import com.easystock.persistence.files.FilesDAORule;

import net.coobird.thumbnailator.Thumbnails;

@Component
public class FileProcessor { //보조 기능이기에 ORM패키지에 넣고 서브로 씀~
	private static Logger logger = LoggerFactory.getLogger(FileProcessor.class);
	
	@Inject
	private FilesDAORule fdao;

	public int upload_file(MultipartFile[] files, int pno) {
		final String UP_DIR = "C:\\Users\\jongk\\class\\Spring\\workspace\\upload"; //파일 저장 경로
		// 날짜별 폴더 경로 : upload/2021/06/28/uuid_fname.jpg => if 이미지 : uuid_th_fname.jpg
		
		LocalDate date = LocalDate.now(); //w3schoool에 상세한 정보 있음!
		String today = date.toString(); //2021-06-28
		today = today.replace("-", File.separator);// file.sesparator : '\\' -> 2021\\06\\28
		File folder = new File(UP_DIR, today); //파일 경로 및 폴더 구조
		
		if(!folder.exists()) folder.mkdirs();  //폴더 없을 시 생성
		
		int isUp = 1;
		
		for (MultipartFile f : files) {
			FilesVO fvo = new FilesVO();
			//파일명 DB에 저장 시, '\\' 형태가 아닌 '/' 형태로 들어가야함;   '\'가 이스케이프, 원래의 기능에서 탈출;
//			today = today.replace("\\", "/");  브라우저가 \\ 관련 해석해주기에 사실상 필요없음, 주석처리
			fvo.setSavedir(today);
			
			String originalFileName = f.getOriginalFilename();
			logger.info(">>>>>>> orginalFileName : " + originalFileName);
			
			fvo.setFname(originalFileName);
			
			UUID uuid = UUID.randomUUID(); //랜덤넘버; 강력함!
			fvo.setUuid(uuid.toString());
			
			String fullFileName = uuid.toString() + "_" + originalFileName;
			File storeFile = new File(folder, fullFileName); //파일 경로 및 파일명
			
			try {
				f.transferTo(storeFile); //파일 이동 및 저장
				if(isImageFile(storeFile)) {
					fvo.setFtype(1); //이미지는 1, 그외는 0
					File thumbnail = new File(folder, uuid.toString() + "_th_" + originalFileName); //썸네일명칭
					Thumbnails.of(storeFile).size(100, 100).toFile(thumbnail); //어떤경로의 어떤 파일을 어떠한 사이즈로 만들지~
				}
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
			fvo.setPno(pno);
			isUp *= fdao.insert(fvo);  //하나라도 에러나면 0곱해져서 0 리턴
		}
		return isUp; //for문 바깥쪽에
	}

	
	private boolean isImageFile(File storeFile) {
		try {
			String mimeType = new Tika().detect(storeFile); //단순 확장자명이 아닌 실제 파일 타입 검증 'lib - tika-parssers 1.25'
			return mimeType.startsWith("image") ? true : false;
		} catch (IOException e) {
			e.printStackTrace();
		}
		return false;
	}

	public int deleteFile(String uuid) {
		return fdao.delete(uuid);
	}
}
