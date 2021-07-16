package com.easystock.ctrl;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.easystock.domain.EarningVO;
import com.easystock.domain.NewsVO;
import com.easystock.domain.PageVO;
import com.easystock.domain.StockVO;
import com.easystock.domain.WatchVO;
import com.easystock.handler.PagingHandler;
import com.easystock.service.stock.StockServiceRule;
import com.github.openjson.JSONArray;
import com.github.openjson.JSONObject;

@RequestMapping("/stock/*")
@Controller
public class StockController {
	private static Logger logger = LoggerFactory.getLogger(StockController.class);

	@Inject
	private StockServiceRule ssv;

	//신규 종목 등록
	@PostMapping(value = "/c_register", consumes = "application/json", produces = "application/text; charset=UTF-8")
	public ResponseEntity<String> register(@RequestBody StockVO svo) {
		int isUp = ssv.register(svo);
		return (isUp > 0) ? new ResponseEntity<String>("1", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	//어닝 등록
	@RequestMapping(value = "/e_register", method = RequestMethod.POST)
	public String register(@RequestParam String jsonData) {
		JSONArray ja = new JSONArray(jsonData);
		for (int i = 0; i < ja.length(); i++) {
			JSONObject obj = ja.getJSONObject(i);
			String symbol = obj.get("symbol").toString();
			String date = obj.get("date").toString();
			String r_eps = obj.get("r_eps").toString();
			String e_eps = obj.get("e_eps").toString();
			double reportedEPS = Double.parseDouble(r_eps);
			double estimatedEPS = Double.parseDouble(e_eps);
			ssv.register(new EarningVO(symbol, date, reportedEPS, estimatedEPS));
		}
		return "index";
	}
	
	@GetMapping("/list")
	public void list(Model model, PageVO pgvo) {
		model.addAttribute("s_list", ssv.getList(pgvo));
		int totalCnt = ssv.getTotalCnt(pgvo);
		model.addAttribute("pghdl", new PagingHandler(totalCnt, pgvo));
	}

	@GetMapping("/detail")
	public void detail(Model model, @RequestParam("symbol") String symbol, @ModelAttribute("pgvo") PageVO pgvo) {
		model.addAttribute("svo", ssv.detail(symbol));
	}
	
	@GetMapping("/trade")
	public void trade() {
		
	}
	
	//관심종목 추가
	@ResponseBody
	@GetMapping(value = {"/add_watch/{symbol}/{email}"}, produces = { MediaType.APPLICATION_ATOM_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<List<WatchVO>> add_watch(@PathVariable String symbol, @PathVariable String email) {
		
		//관심 종목 추가만~ 일단~
		WatchVO wvo = new WatchVO();
		wvo.setEmail(email);
		wvo.setSymbol(symbol);
		
		List<WatchVO> w_list = ssv.insertAndList(wvo);
		
		return new ResponseEntity<List<WatchVO>> (w_list, HttpStatus.OK);
	}
}