package com.easystock.persistence.comment;

import com.easystock.domain.CommentVO;
import com.easystock.domain.ReportVO;

import java.util.List;

public interface CommentDAORule {
	public int insert(CommentVO cvo);
	public List<CommentVO> selectList(String symbol);
	public int delete(int cNum);

	//좋아요처리
	public int update(int cNum, int num);
	public int chkliked(int cNum, String writer);
	public int onLiked(int cNum, String writer);
	public int offLiked(int cNum, String writer);
	
	//신고처리
	public int report(ReportVO rvo);

}
