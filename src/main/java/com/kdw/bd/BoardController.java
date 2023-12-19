package com.kdw.bd;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import dao.BoardDAO;
import dao.CommentsDAO;
import dao.MemberDAO;
import util.Common;
import util.Paging;
import vo.BoardVO;
import vo.CommentsVO;
import vo.MemberVO;
import vo.PhotoVO;

@Controller
public class BoardController {
	
	BoardDAO board_dao;
	MemberDAO member_dao;
	CommentsDAO comments_dao;
	@Autowired
	HttpServletRequest request;
	@Autowired
	HttpSession session;	
	
	public BoardController(BoardDAO board_dao,MemberDAO member_dao,CommentsDAO comments_dao) {
		this.board_dao = board_dao;
		this.member_dao = member_dao;
		this.comments_dao = comments_dao;
	}
	
	//게시판으로 이동
	@RequestMapping(value= {"/","board.do"})
	public String board(Model model, String page) {
		int nowPage = 1;
		
		if(page != null && !page.isEmpty()) {
			nowPage = Integer.parseInt(page);
		}
		
		//한 페이지에 표시될 게시물의 시작과 끝번호를 계산
		int start = (nowPage -1) * Common.Board.BLOCKLIST +1;
		int end = start + Common.Board.BLOCKLIST -1;
		
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		map.put("start", start);
		map.put("end", end);
		
		//페이지번호에 따른 전체 게시물 조회
		List<BoardVO> list = board_dao.selectList(map);
		
		//전체 게시물 수 조회
		int rowTotal = board_dao.getRowTotal();
		
		//페이지 메뉴 생성하기
		String pageMenu = Paging.getPaging("board.do", nowPage, rowTotal, Common.Board.BLOCKLIST, Common.Board.BLOCKPAGE);
		
		request.getSession().removeAttribute("show");
		
		model.addAttribute("list", list);
		model.addAttribute("pageMenu", pageMenu);
		
		return Common.VIEW_PATH + "board.jsp?page="+nowPage;
	}
	
	//게시글 상세보기로 이동
	@RequestMapping("board_view.do")
	public String board_view(Model model, int idx, int page, String c_page) {
		//view.do?idx=0&page=
		BoardVO vo = board_dao.selectOne(idx);
		
		//한번 클릭할 때마다 조회수 1씩 증가(F5연타를 통한 조회수 증가 막아야함)
		//조회수 증가
		HttpSession session = request.getSession();
		String show = (String)session.getAttribute("show");
		
		if(show == null) {
			int res = board_dao.update_readhit(idx);
			session.setAttribute("show", "0");
		}
		
		int c_nowPage = 1;
		
		if(c_page != null && !c_page.isEmpty()) {
			c_nowPage = Integer.parseInt(c_page);
		}
		
		//한 페이지에 표시될 게시물의 시작과 끝번호를 계산
		int c_start = (c_nowPage -1) * Common.Board.BLOCKLIST +1;
		int c_end = c_start + Common.Board.BLOCKLIST -1;
		
		HashMap<String, Integer> c_map = new HashMap<String, Integer>();
		c_map.put("c_start", c_start);
		c_map.put("c_end", c_end);
		c_map.put("idx", idx);
		
		//게시글마다 댓글 조회 후 댓글 수 별로 조회
		List<CommentsVO> c_list = comments_dao.select_comments(c_map);
		
		//게시글의 댓글 수 조회
		int c_rowTotal = comments_dao.c_rowTotal(idx);
		
		//댓글이 게시글에 있는 경우
		if(c_rowTotal > 0) {
			//페이지메뉴 생성
			String c_pageMenu = Paging.getPaging("board_view.do", c_nowPage, c_rowTotal, Common.Board.BLOCKLIST, Common.Board.BLOCKPAGE);
			model.addAttribute("c_pageMenu", c_pageMenu);
		}
		else {
			System.out.println("댓글 없는 게시판");
		}
		
		
		model.addAttribute("c_list", c_list);		
		model.addAttribute("vo", vo);
			
		return Common.VIEW_PATH + "board_view.jsp?page="+page+"&c_page="+c_page;
	}
	
	//글쓰기 페이지로 이동
	@RequestMapping("insert_form.do")
	public String insert_form() {
		
		MemberVO vo = (MemberVO)session.getAttribute("member");
		
		if(vo == null) {
			return Common.VIEW_PATH + "login_form.jsp";
		}
		
		return Common.VIEW_PATH + "insert_form.jsp";
	}
	
	//글 쓰기
	@RequestMapping("b_insert.do")
	public String b_insert(String id, String content, String pwd, String subject,
	                       MultipartFile img1, MultipartFile img2, MultipartFile img3, MultipartFile img4) {

	    BoardVO bd_vo = new BoardVO();
	    PhotoVO ph_vo = new PhotoVO();
	    String ip = request.getRemoteAddr();

	    String webPath = "resources/upload";
	    String savePath = request.getServletContext().getRealPath(webPath);
	    System.out.println(savePath);
	    
	    String filename1 = "no_file";
		String filename2 = "no_file";
		String filename3 = "no_file";
		String filename4 = "no_file";
	    
	    // 디렉토리가 없다면 생성
	    File savePathFile = new File(savePath);
	    if (!savePathFile.exists()) {
	        savePathFile.mkdirs();
	    }
	    
	    // 이미지 1 처리
	    if (!img1.isEmpty()) {
	    	String originalFilename = img1.getOriginalFilename();
	        File saveFile = new File(savePath, originalFilename);

	        if (saveFile.exists()) {
	            // 파일이 이미 존재하면 새로운 이름 부여
	            long time = System.currentTimeMillis();
	            originalFilename = String.format("%d_%s", time, originalFilename);
	            saveFile = new File(savePath, originalFilename);
	        }

	        try {
	            img1.transferTo(saveFile);
	        } catch (IllegalStateException | IOException e) {
	            e.printStackTrace();
	        }

	        ph_vo.setFilename1(originalFilename);
	        bd_vo.setImg1(originalFilename);
	    }else {
	        ph_vo.setFilename1(filename1);
	        bd_vo.setImg1(filename1);
	    }

	    // 이미지 2 처리
	    if (!img2.isEmpty()) {
	    	String originalFilename = img2.getOriginalFilename();
	        File saveFile = new File(savePath, originalFilename);

	        if (saveFile.exists()) {
	            // 파일이 이미 존재하면 새로운 이름 부여
	            long time = System.currentTimeMillis();
	            originalFilename = String.format("%d_%s", time, originalFilename);
	            saveFile = new File(savePath, originalFilename);
	        }

	        try {
	            img2.transferTo(saveFile);
	        } catch (IllegalStateException | IOException e) {
	            e.printStackTrace();
	        }

	        ph_vo.setFilename2(originalFilename);
	        bd_vo.setImg2(originalFilename);
	    }
	    else {
	        ph_vo.setFilename2(filename2);
	        bd_vo.setImg2(filename2);
	    }

	    // 이미지 3 처리
	    if (!img3.isEmpty()) {
	    	String originalFilename = img3.getOriginalFilename();
	        File saveFile = new File(savePath, originalFilename);

	        if (saveFile.exists()) {
	            // 파일이 이미 존재하면 새로운 이름 부여
	            long time = System.currentTimeMillis();
	            originalFilename = String.format("%d_%s", time, originalFilename);
	            saveFile = new File(savePath, originalFilename);
	        }

	        try {
	            img3.transferTo(saveFile);
	        } catch (IllegalStateException | IOException e) {
	            e.printStackTrace();
	        }

	        ph_vo.setFilename3(originalFilename);
	        bd_vo.setImg3(originalFilename);
	    }
	    else {
	        ph_vo.setFilename3(filename3);
	        bd_vo.setImg3(filename3);
	    }

	    // 이미지 4 처리
	    if (!img4.isEmpty()) {
	    	String originalFilename = img4.getOriginalFilename();
	        File saveFile = new File(savePath, originalFilename);

	        if (saveFile.exists()) {
	            // 파일이 이미 존재하면 새로운 이름 부여
	            long time = System.currentTimeMillis();
	            originalFilename = String.format("%d_%s", time, originalFilename);
	            saveFile = new File(savePath, originalFilename);
	        }

	        try {
	            img4.transferTo(saveFile);
	        } catch (IllegalStateException | IOException e) {
	            e.printStackTrace();
	        }

	        ph_vo.setFilename4(originalFilename);
	        bd_vo.setImg4(originalFilename);
	    }
	    else {
	        ph_vo.setFilename4(filename4);
	        bd_vo.setImg4(filename4);
	    }

	    // BoardVO에 게시글 정보 설정
	    bd_vo.setIp(ip);
	    bd_vo.setId(id);
	    bd_vo.setContent(content);
	    bd_vo.setPwd(pwd);
	    bd_vo.setSubject(subject);

	    // 데이터베이스에 저장
	    int res = board_dao.b_insert(bd_vo);

	    if (res > 0) {
	        return "redirect:board.do";
	    }
	    return null;
	}

	
	//글 삭제
	@RequestMapping("board_del.do")
	@ResponseBody
	public String board_delete(int idx) {
		
		int res = board_dao.board_del(idx);
		
		if(res > 0) {
			return "[{'result':'yes'}]";
		}
		return "[{'result':'no'}]";
	}
	
	//댓글 등록
	@RequestMapping("c_reg.do")
	@ResponseBody
	public String c_reg(int b_idx, String c_id, String content) {
		CommentsVO c_vo = new CommentsVO();
		c_vo.setB_idx(b_idx);
		c_vo.setC_id(c_id);
		c_vo.setContent(content);
		
		int res = comments_dao.c_insert(c_vo);
		
		if(res > 0) {
			return "[{'result':'yes'}]";
		}
		return "[{'result':'no'}]";
	}
	
	//댓글 삭제
	@RequestMapping("c_del.do")
	@ResponseBody
	public String c_del(int idx) {
		System.out.println(idx);
		CommentsVO cVO = comments_dao.c_selectOne(idx);
		
		cVO.setContent("삭제된 글입니다.");
		
		int res = comments_dao.c_del_update(cVO);
		
		if(res > 0) {
			return "[{'result':'yes'}]";
		}
		return "[{'result':'no'}]";
	}
	
	
	
	 
}
