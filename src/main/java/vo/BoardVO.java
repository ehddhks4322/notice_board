package vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class BoardVO {

	private int idx; //글 번호
	private int readhit; //조회수
	private int ref; //참조글 번호
	private int step; //댓글 순서
	private int depth; //댓글 깊이
	private int del_info; //삭제여부
	
	private String id; //작성자
	private String subject; //제목
	private String content; //내용
	private String pwd; //비밀번호
	private String ip;	//ip
	private String regdate; //등록날짜
	private String img1;
	private String img2;
	private String img3;
	private String img4;
}
