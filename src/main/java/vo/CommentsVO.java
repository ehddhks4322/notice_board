package vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CommentsVO {
	
	private int idx; //댓글 번호
	private int b_idx; //게시글 번호
	private int ref; //참조글 번호
	private int step; //댓글 순서
	private int depth; //댓글 깊이
	
	private String c_id; //작성자
	private String content; //내용
	private String regdate; //작성일자
}
