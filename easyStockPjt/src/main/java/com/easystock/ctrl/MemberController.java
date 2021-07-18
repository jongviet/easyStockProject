package com.easystock.ctrl;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.easystock.domain.MemberVO;
import com.easystock.service.member.MemberServiceRule;
import com.easystock.service.stock.StockServiceRule;

@RequestMapping("/member/*")
@Controller
public class MemberController {
	private static Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Inject
	private MemberServiceRule msv;
	
	@Inject
	private StockServiceRule ssv;
	
	//테스터 계정 체크, 가입 후, session 부여
	@ResponseBody
	@PostMapping("/chkTester")
	public String chkTester(@RequestParam("email") String email, HttpSession ses, Model model) {
		int result = msv.chkTester(email);
		if(result > 0) {
			ses.setAttribute("ses", email);
			String[] array = email.split("@");
			String ses_id = array[0];
			ses.setAttribute("ses_id", ses_id);
			String ses_tester = array[0].substring(0, 6);
			ses.setAttribute("ses_tester", ses_tester);
			ses.setMaxInactiveInterval(15 * 60);
			return "1";
		}
		return "0";
	}
	
	//중복 이메일 체크
	@ResponseBody
	@PostMapping("/chkEmail")
	public String chkEmail(@RequestParam("email") String email) {
		int result = msv.chkEmail(email);
		return result > 0 ? "1" : "0";
	}

	//회원가입
	@PostMapping("/join")
	public String join(MemberVO mvo, Model model) {
		int result = msv.join(mvo);
		if(result > 0) {
			model.addAttribute("msg", "회원가입 완료");
			model.addAttribute("url", "/");
		}
		return "temp";
	}
	
	//로그인
	@PostMapping("/login")
	public String login(MemberVO mvo, HttpSession ses, Model model) {
		MemberVO member = msv.login(mvo);
		
		if(member != null) {
			
			//1.세션 처리
			ses.setAttribute("ses", member.getEmail());
			String[] array = member.getEmail().split("@");
			String ses_id = array[0];
			ses.setAttribute("ses_id", ses_id);
			ses.setMaxInactiveInterval(15 * 60);
			
			//2.예수금, 보유종목, 관심종목 현황
			model.addAttribute("deposit", msv.chkDeposit(mvo.getEmail()));
			model.addAttribute("h_list", msv.chk_h_list(mvo.getEmail()));
			
			if(msv.hasWatchList(mvo.getEmail()) > 0) {
				model.addAttribute("w_list", msv.chk_w_list(mvo.getEmail()));
			}

			return "main";
			
		} else {
			model.addAttribute("msg", "아이디나 비밀번호가 올바르지 않습니다.");
			model.addAttribute("url", "/");
			return "temp";
		}
	}

	@GetMapping("/main")
	public String main(Model model, @RequestParam(value = "email", required=false) String email) {
		
		if(email != null) {
			model.addAttribute("deposit", msv.chkDeposit(email));
			model.addAttribute("h_list", msv.chk_h_list(email));				

			if(msv.hasWatchList(email) > 0) {
				model.addAttribute("w_list", msv.chk_w_list(email)); //wvo가 아닌 svo가 리턴됨! 주의!
			}
		}
		return "main";	
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession ses) {
		ses.invalidate();
		return "redirect:/";
	}
	
	//잔고 체크
	@ResponseBody
	@PostMapping("/chkDeposit")
	public String chkDeposit(@RequestParam("email") String email) {
		return msv.chkDeposit(email);
	}
	
	
	
}
