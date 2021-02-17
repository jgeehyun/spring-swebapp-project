package com.jjh.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.jjh.service.MemberService;
import com.jjh.vo.MemberVO;

@Controller
@RequestMapping("/member/*")
public class MemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	MemberService service;
	
	//암호화 기능 사용
	@Autowired
	BCryptPasswordEncoder pwdEncoder;
	
	// 회원가입 get
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public void getRegister() throws Exception {
		logger.info("get register");
	}
	
	// 회원가입 post
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String postRegister(MemberVO vo) throws Exception {
		logger.info("post register");
		//int result = service.idChk(vo);
		try {
//			if(result == 1) {
//				return "/member/register";
//			}else if(result == 0) {
				String inputPass = vo.getUserPass();
				String pwd = pwdEncoder.encode(inputPass);
				vo.setUserPass(pwd);
				
				service.register(vo);
//			}
			// 요기에서~ 입력된 아이디가 존재한다면 -> 다시 회원가입 페이지로 돌아가기 
			// 존재하지 않는다면 -> register
		} catch (Exception e) {
			throw new RuntimeException();
		}
		return "redirect:/";
	}

	//로그인 post
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(@ModelAttribute MemberVO vo, HttpSession session, Model model) throws Exception{
		logger.info("post login");
		logger.info("post login vo >>>>> " + vo.getUserId());
		//MemberVO member = (MemberVO) session.getAttribute("member");
		MemberVO login = service.login(vo);
		if(login != null) {
			boolean pwdMatch = pwdEncoder.matches(vo.getUserPass(), login.getUserPass());
			logger.info("post login >>>>> " + login.getUserId() + " / match>>> "+ pwdMatch);
			if(login != null && pwdMatch == true) {
				session.setAttribute("member", login);			
			}else {
				model.addAttribute("msg", false);
			}
		}else {
			model.addAttribute("msg", false);
		}
		return "home";
	}
	
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) throws Exception{
		//logger.info(((MemberVO) session.getAttribute("member")).getUserId() + " >>> logout");
		session.invalidate();
		
		return "redirect:/";
	}
	
	@RequestMapping(value="/memberUpdateView", method = RequestMethod.GET)
	public String registerUpdateView() throws Exception{
		
		return "member/memberUpdateView";
	}

	//회원정보 수정 post
	@RequestMapping(value="/memberUpdate", method = RequestMethod.POST)
	public String registerUpdate(MemberVO vo, HttpSession session) throws Exception{
		
		/* MemberVO login = service.login(vo);
		
		boolean pwdMatch = pwdEncoder.matches(vo.getUserPass(), login.getUserPass());
		if(pwdMatch) {
			service.memberUpdate(vo);
			session.invalidate();
		} else {
			return "member/memberUpdateView";
		} */
		
		service.memberUpdate(vo);
		
		session.setAttribute("member", vo);;
		
		return "redirect:/";
	}
	
	// 회원 탈퇴 get
		@RequestMapping(value="/memberDeleteView", method = RequestMethod.GET)
		public String memberDeleteView() throws Exception{
			return "member/memberDeleteView";
		}
		
		// 회원 탈퇴 post
		@RequestMapping(value="/memberDelete", method = RequestMethod.POST)
		public String memberDelete(MemberVO vo, HttpSession session, RedirectAttributes rttr) throws Exception{
			
			// 세션에 있는 member를 가져와 member변수에 넣어줍니다.
			/* MemberVO member = (MemberVO) session.getAttribute("member");
			// 세션에있는 비밀번호
			String sessionPass = member.getUserPass();
			// vo로 들어오는 비밀번호
			String voPass = vo.getUserPass();
			
			if(!(sessionPass.equals(voPass))) {
				rttr.addFlashAttribute("msg", false);
				return "redirect:/member/memberDeleteView";
			} */
			service.memberDelete(vo);
			session.invalidate();
			return "redirect:/";
		}
		
		// 패스워드 체크
		@ResponseBody
		@RequestMapping(value="/passChk", method = RequestMethod.POST)
		public int passChk(MemberVO vo) throws Exception {
			int result = service.passChk(vo);
			return result;
		}
		
		// 아이디 중복 체크
		@ResponseBody
		@RequestMapping(value="/idChk", method = RequestMethod.POST)
		public int idChk(@RequestParam("userId") String userId) throws Exception {
			logger.info("userId: >>>>>>>>>>>>>> " + userId);
			int result = service.idChk(userId);
			return result;
		}
		
		
}
