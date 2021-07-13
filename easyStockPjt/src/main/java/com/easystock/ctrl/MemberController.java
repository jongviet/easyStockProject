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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.easystock.domain.MemberVO;
import com.easystock.service.member.MemberServiceRule;

@RequestMapping("/member/*")
@Controller
public class MemberController {
	private static Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Inject
	private MemberServiceRule msv;
	
	//테스터 계정 체크, 가입 후, session 부여
	@ResponseBody
	@PostMapping("/chkTester")
	public String chkTester(@RequestParam("tester") String tester, HttpSession ses) {
		int result = msv.chkTester(tester);
		if(result > 0) {
			ses.setAttribute("ses", tester);
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
	public String login(MemberVO mvo, HttpSession ses, RedirectAttributes reAttr) {
		MemberVO member = msv.login(mvo);
		if(member != null) {
			ses.setAttribute("ses", member.getEmail());
			ses.setMaxInactiveInterval(15 * 60);
		}
		reAttr.addFlashAttribute("result", ses.getAttribute("ses") != null ? 
				"로그인 성공" : "로그인 실패");
		return "redirect:/";
	}
	
	@GetMapping("/main")
	public String main() {
		return "main";	
	}
	
	@GetMapping("/logout")
	public String logout(RedirectAttributes reAttr, HttpSession ses) {
		ses.invalidate();
		reAttr.addFlashAttribute("result", "로그아웃 되었습니다.");
		return "redirect:/";
	}
	
}
