package com.easystock.ctrl;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.easystock.domain.CommentVO;
import com.easystock.domain.EarningVO;
import com.easystock.domain.ReportVO;
import com.easystock.service.comment.CommentServiceRule;
import com.easystock.service.stock.StockServiceRule;

@RequestMapping("/comment/*")
@RestController
public class CommentController {
	private static Logger logger = LoggerFactory.getLogger(CommentController.class);

	@Inject
	private CommentServiceRule csv;

	@Inject
	private StockServiceRule ssv;

	//댓글 등록, 삭제 및 리스트
	@PostMapping(value = "/post", consumes = "application/json", produces = "application/text; charset=UTF-8")
	public ResponseEntity<String> post(@RequestBody CommentVO cvo) {
		int isUp = csv.insert(cvo);
		return (isUp > 0) ? new ResponseEntity<String>("1", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@DeleteMapping(value="/cNum/{cNum}", produces= MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> delete(@PathVariable("cNum") int cNum) {
		return csv.delete(cNum) > 0 ? new ResponseEntity<String>("1", HttpStatus.OK) : new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value = "/symbol/{symbol}", produces= {MediaType.APPLICATION_ATOM_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<List<CommentVO>> list(@PathVariable String symbol) {
		return new ResponseEntity<List<CommentVO>>(csv.getList(symbol), HttpStatus.OK);
	}
	
	//신고하기
	@PostMapping(value = "/report", consumes = "application/json", produces = "application/text; charset=UTF-8")
	public ResponseEntity<String> report(@RequestBody ReportVO rvo) {
		
		int isUp = csv.report(rvo); 
		return (isUp > 0) ? new ResponseEntity<String>("1", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//좋아요
	@GetMapping(value = "/cNum/{cNum}/{writer}", produces = { MediaType.APPLICATION_ATOM_XML_VALUE,
			MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<String> list(@PathVariable int cNum, @PathVariable String writer) {
		int isUp = csv.t_up(cNum, writer);
		return (isUp > 0) ? new ResponseEntity<String>("1", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//earning 현황
	@GetMapping(value = "/earning/{symbol}", produces = { MediaType.APPLICATION_ATOM_XML_VALUE,
			MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<List<EarningVO>> earning(@PathVariable String symbol) {
		return new ResponseEntity<List<EarningVO>>(ssv.getEarningList(symbol), HttpStatus.OK);
	}
}
