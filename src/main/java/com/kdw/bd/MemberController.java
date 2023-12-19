package com.kdw.bd;

import java.util.HashMap;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.MemberDAO;
import util.Common;
import vo.MemberVO;

@Controller
public class MemberController {
	
	MemberDAO member_dao;

	@Autowired
	HttpServletRequest request;
	@Autowired
	HttpSession session;
	@Autowired
	private JavaMailSender mailSender;
	
	public MemberController(MemberDAO member_dao) {
		this.member_dao = member_dao;
	}
	
	//로그인 페이지로 이동
		@RequestMapping("login_form.do")
		public String login_form() {
			
			return Common.VIEW_PATH2 + "login_form.jsp";
		}
		
		//회원가입 페이지로 이동
		@RequestMapping("member_insert.do")
		public String member_insert_form() {
			
			return Common.VIEW_PATH2 + "member_insert.jsp";
		}
		
		//아이디 중복체크
		@RequestMapping("check_id.do")
		@ResponseBody
		public String check_id(String id) {
			
			int res = member_dao.check_id(id);
			
			if(res > 0) {
				return "[{'result':'no'}]";
			}
			return "[{'result':'yes'}]";
		}
		
		//회원가입
		@RequestMapping("m_insert.do")
		public String m_insert(MemberVO vo) {
			
			int res = member_dao.m_insert(vo);
			
			if(res > 0) {
				return Common.VIEW_PATH2 + "login_form.jsp";
			}
			return null;
		}
		
		//로그인
		@RequestMapping("login.do")
		@ResponseBody
		public String login(String id, String pwd, HttpSession session) {
			
			MemberVO vo = member_dao.login_check(id);
			//아이디 존재X
			if(vo == null) {
				return "[{'result':'no_id'}]";
			}
			//비밀번호 일치X
			if(!vo.getPwd().equals(pwd)) {
				return "[{'result':'no_pwd'}]";
			}
			
			session.setAttribute("member", vo);
			
			return "[{'result':'clear'}]";
		}
		
		//로그아웃
		@RequestMapping("logout.do")
		public String logout(HttpSession session) {
			//세션에 들어있는 member라는 속성을 제거한다.
			session.removeAttribute("member");
			
			return "redirect:board.do";
		}
		
		//마이페이지
		@RequestMapping("mypage.do")
		public String mypage() {
			
			return Common.VIEW_PATH2 + "mypage.jsp";
		}
		
		//아이디 찾기 페이지로 이동
		@RequestMapping("find_id.do")
		public String find_id() {
			
			return Common.VIEW_PATH2 + "find_id.jsp";
		}
		
		//아이디 찾기
		@RequestMapping("result_id.do")
		@ResponseBody
		public String result_id(String name, String email) {
			
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("name", name);
			map.put("email", email);
			
			MemberVO vo = member_dao.result_id(map);
			
			if(vo == null) {
				return "[{'result':'no'}]";
			} else {
				return "[{\"result\":\"yes\", \"id\":\"" + vo.getId() + "\"}]";
			}
			
		}
		
		//비밀번호 찾기 페이지로 이동
		@RequestMapping("find_pwd.do")
		public String find_pwd() {
			
			return Common.VIEW_PATH2 + "find_pwd.jsp";
		}
		
		//비밀번호 찾기
		@RequestMapping("send.do")
		@ResponseBody
		public String send(String id, String email, Model model) throws Exception{
			HashMap<String, String> map = new HashMap<String, String>();
			map.put("id", id);
			map.put("email", email);
			
			MemberVO vo = member_dao.send(map);
			session.setAttribute("pw_vo", vo);
			
			Random rnd = new Random();
			int checkNum = rnd.nextInt(888888) + 111111;
			System.out.println("인증번호 : " + checkNum);
			
			String setForm = "ehddhks4322@gamil.com";
			String toMail = email;
			String title = "이메일 인증을 완료해주세요!";
			String content = "커뮤니티를 방문해주셔서 감사합니다.\n" 
						   + "인증 번호는 " + "[" + checkNum + "]" + " 입니다.\n" 
						   + "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";
			
			if(vo == null) {
				return "[{'result':'no'}]";
			}else {
				// 인증번호 발송
				try {
				MimeMessage message = mailSender.createMimeMessage();
				MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
				helper.setFrom(setForm);
				helper.setTo(toMail);
				helper.setSubject(title);
				helper.setText(content);
				mailSender.send(message);
				System.out.println("성공");
				}catch (Exception e) {
					// TODO: handle exception
					System.out.println("실패");
				}
				String authCode = Integer.toString(checkNum); // 인증번호 
				model.addAttribute("authCode", authCode); //인증번호 값을 JSP파일로 넘기기 위해 저장
				System.out.println(authCode);
				return "[{\"result\":\"yes\", \"authCode\":\"" + authCode + "\"}]";
			}
		}
		
		//비밀번호 변경 페이지로 이동
		@RequestMapping("update_pwd.do")
		public String update_pwd() {
			
			return Common.VIEW_PATH2 + "update_pwd.jsp";
		}
		
		//비밀번호 변경
		@RequestMapping("result_pwd.do")
		@ResponseBody
		public String result_pwd(String id, String pwd) {
			MemberVO vo = member_dao.login_check(id);
			
			vo.setPwd(pwd);
			
			int res = member_dao.result_pwd(vo);
			
			if(res > 0) {
				return "[{'result':'yes'}]";
			}
			return "[{'result':'no'}]";
		}
		
		//회원 탈퇴(게시글도 함께 삭제된다)
		@RequestMapping("secession.do")
		@ResponseBody
		public String secession(String id) {
			int res = member_dao.secession(id);
			
			if(res > 0) {
				return "[{'result':'yes'}]";
			}
			return "[{'result':'no'}]";
		}
		
		//회원 탈퇴 후 이동
		@RequestMapping("secession_out.do")
		public String secession_out() {
			session.removeAttribute("member");
			
			return "redirect:board.do";
		}
}
