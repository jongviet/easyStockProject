package com.easystock.service.comment;

import com.easystock.domain.CommentVO;
import com.easystock.domain.ReportVO;

import java.util.List;

public interface CommentServiceRule {
	public int insert(CommentVO cvo);
	public List<CommentVO> getList(String symbol);
	public int t_up(int cNum, String writer);
	public int delete(int cNum);
	public int report(ReportVO rvo);
}
