package com.easystock.ctrl;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.easystock.domain.MemberVO;
import com.easystock.service.member.MemberServiceRule;

@RequestMapping("/member/*")
@Controller
public class MemberController {
	private static Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Inject
	private MemberServiceRule msv;

	// 회원가입
	@PostMapping("/join")
	public String register(MemberVO mvo, RedirectAttributes reAttr) {
		int isUp = msv.join(mvo);
		reAttr.addFlashAttribute("result", isUp > 0 ? "가입성공" : "가입실패");
		return "/";
	}
}
