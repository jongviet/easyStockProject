package com.easystock.service.comment;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.easystock.domain.CommentVO;
import com.easystock.domain.ReportVO;
import com.easystock.persistence.comment.CommentDAORule;
import com.easystock.persistence.member.MemberDAORule;

@Service
public class CommentService implements CommentServiceRule {

	@Inject
	private CommentDAORule cdao;
	
	@Inject
	private MemberDAORule mdao;

	@Override
	public int insert(CommentVO cvo) {
		return cdao.insert(cvo);
	}

	@Override
	public List<CommentVO> getList(String symbol) {
		return cdao.selectList(symbol);
	}

	@Transactional(isolation = Isolation.READ_COMMITTED)
	@Override
	public int t_up(int cNum, String writer) {
		if (cdao.chkliked(cNum, writer) == 0) {
			cdao.onLiked(cNum, writer);
			return cdao.update(cNum, 1) > 0 ? 1 : 0;
		} else {
			cdao.offLiked(cNum, writer);
			return cdao.update(cNum, -1) > 0 ? 1 : 0;
		}
	}

	@Override
	public int delete(int cNum) {
		
		mdao.deleteReport(cNum);
		
		if(cdao.cmtDel(cNum) == 1) {
			return cdao.delete(cNum);
		} else {
			return cdao.delete(cNum);
		}
	}

	@Override
	public int report(ReportVO rvo) {
		return cdao.report(rvo);
	}

	@Override
	public CommentVO getReportedComment(int cNum) {
		return cdao.getReportedComment(cNum);
	}
}
