package com.easystock.ctrl;

import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;

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

import com.easystock.domain.AccountVO;
import com.easystock.domain.EarningVO;
import com.easystock.domain.PageVO;
import com.easystock.domain.StockVO;
import com.easystock.domain.WatchVO;
import com.easystock.handler.PagingHandler;
import com.easystock.service.member.MemberServiceRule;
import com.easystock.service.stock.StockServiceRule;
import com.github.openjson.JSONArray;
import com.github.openjson.JSONObject;

@RequestMapping("/stock/*")
@Controller
public class StockController {

	@Inject
	private StockServiceRule ssv;
	
	@Inject
	private MemberServiceRule msv;

	@PostMapping(value = "/c_register", consumes = "application/json", produces = "application/text; charset=UTF-8")
	public ResponseEntity<String> register(@RequestBody StockVO svo) {
		int isUp = ssv.register(svo);
		return (isUp > 0) ? new ResponseEntity<String>("1", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
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
	
	@ResponseBody
	@GetMapping(value = {"/tradable"}, produces = { MediaType.APPLICATION_ATOM_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<List<StockVO>> tradable() {
			
		List<StockVO> svo_list = ssv.getStockList();
		
		return (svo_list != null) ? new ResponseEntity<List<StockVO>>(svo_list, HttpStatus.OK)
				: new ResponseEntity<List<StockVO>>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@ResponseBody
	@PostMapping(value = "/trade", consumes = "application/json", produces = "application/text; charset=UTF-8")
	public ResponseEntity<String> trade(@RequestBody StockVO svo) {
		int isUp = ssv.update(svo);
		return (isUp > 0) ? new ResponseEntity<String>("1", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@ResponseBody
	@PostMapping(value = "/account", consumes = "application/json", produces = "application/text; charset=UTF-8")
	public ResponseEntity<String> account(@RequestBody AccountVO avo) {
		int isUp = ssv.update(avo);
		return (isUp > 0) ? new ResponseEntity<String>("1", HttpStatus.OK)
				: new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping("/list")
	public void list(Model model, PageVO pgvo) {
		model.addAttribute("s_list", ssv.getList(pgvo));
		int totalCnt = ssv.getTotalCnt(pgvo);
		model.addAttribute("pghdl", new PagingHandler(totalCnt, pgvo));
	}

	@GetMapping("/detail")
	public void detail(Model model, @RequestParam("symbol") String symbol, @ModelAttribute("pgvo") PageVO pgvo, @RequestParam String email) {
		model.addAttribute("svo", ssv.detail(symbol));

		 if(msv.hasWatchList(email) > 0) {
			 if(msv.inYourWatchList(email, symbol) > 0) {
				 model.addAttribute("hasWatch", 1);
			 }
		 }
	}
	
	@ResponseBody
	@GetMapping(value = "/earning/{symbol}", produces = { MediaType.APPLICATION_ATOM_XML_VALUE,
			MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<List<EarningVO>> earning(@PathVariable String symbol) {
		return new ResponseEntity<List<EarningVO>>(ssv.getEarningList(symbol), HttpStatus.OK);
	}
	
	@ResponseBody
	@GetMapping(value = {"/list/{keyword}/{email}"}, produces = { MediaType.APPLICATION_ATOM_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<HashMap<String, Object>> list(@PathVariable String keyword, @PathVariable String email) {
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("deposit", msv.chkDeposit(email));
		
		AccountVO avo = msv.getSpecificSymbol(keyword, email);
		if(avo == null) {
			StockVO svo = msv.getSpecificSymbol_new(keyword);
			map.put("svo", svo);
		} else {
			map.put("avo", avo);
		}
		return (map != null) ? new ResponseEntity<HashMap<String, Object>>(map, HttpStatus.OK) : new ResponseEntity<HashMap<String, Object>>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@PostMapping(value = "/newBuy", consumes = "application/json", produces = "application/text; charset=UTF-8")
	public ResponseEntity<String> newBuy(@RequestBody AccountVO avo) {
		int isUp = msv.newBuy(avo);
		return (isUp > 0) ? new ResponseEntity<String>("1", HttpStatus.OK) : new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@PostMapping(value = "/additionalBuy", consumes = "application/json", produces = "application/text; charset=UTF-8")
	public ResponseEntity<String> additionalBuy(@RequestBody AccountVO new_avo) {
		int isUp = msv.additionalBuy(new_avo);
		return (isUp > 0) ? new ResponseEntity<String>("1", HttpStatus.OK) : new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@PostMapping(value = "/sell", consumes = "application/json", produces = "application/text; charset=UTF-8")
	public ResponseEntity<String> sell(@RequestBody AccountVO avo) {
		int isUp = msv.sell(avo);
		return (isUp > 0) ? new ResponseEntity<String>("1", HttpStatus.OK) : new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@ResponseBody
	@GetMapping(value = {"/add_watch/{symbol}/{email}"}, produces = { MediaType.APPLICATION_ATOM_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<String> add_watch(@PathVariable String symbol, @PathVariable String email) {
		
		WatchVO wvo = new WatchVO();
		wvo.setEmail(email);
		wvo.setSymbol(symbol);
		
		int isUp = ssv.insert(wvo);
		
		return (isUp > 0) ? new ResponseEntity<String>("1", HttpStatus.OK) : new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@ResponseBody
	@GetMapping(value = {"/remove_watch/{symbol}/{email}"}, produces = { MediaType.APPLICATION_ATOM_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<String> remove_watch(@PathVariable String symbol, @PathVariable String email) {
		
		WatchVO wvo = new WatchVO();
		wvo.setEmail(email);
		wvo.setSymbol(symbol);
		
		int isUp = ssv.delete(wvo);
		
		return (isUp > 0) ? new ResponseEntity<String>("1", HttpStatus.OK) : new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@ResponseBody
	@GetMapping(value = {"/hasSymbol/{symbol}"}, produces = { MediaType.APPLICATION_ATOM_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE })
	public ResponseEntity<String> hasSymbol(@PathVariable String symbol) {
		
		int isUp = ssv.hasSymbol(symbol);
		return (isUp > 0) ? new ResponseEntity<String>("1", HttpStatus.OK) : new ResponseEntity<String>("0", HttpStatus.OK);
	}
}
















