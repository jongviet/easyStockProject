package com.easystock.service.comment;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.easystock.domain.CommentVO;
import com.easystock.domain.ReportVO;
import com.easystock.persistence.comment.CommentDAORule;
import com.easystock.persistence.member.MemberDAORule;

@Service
public class CommentService implements CommentServiceRule {
	private static Logger logger = LoggerFactory.getLogger(CommentService.class);

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

	//특정 댓글의 좋아요 삭제 -> 댓글 삭제    +@ 리포트 삭제도 제일 앞에 추가
	@Override
	public int delete(int cNum) {
		
		//리포트 먼저 삭제
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
