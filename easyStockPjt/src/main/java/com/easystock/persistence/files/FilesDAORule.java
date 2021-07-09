package com.easystock.persistence.files;

import java.util.List;

import com.easystock.domain.FilesVO;

public interface FilesDAORule {
	public int insert(FilesVO fvo);
	public List<FilesVO> selectList(int pno);
	public int delete(int pno);
	public int delete(String uuid); //파일삭제
	public List<FilesVO> selectList(); //스케쥴용
}
