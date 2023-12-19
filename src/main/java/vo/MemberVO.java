package vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MemberVO {
	
	private int idx;
	
	private String name; //이름
	private String id; //아이디
	private String pwd; //비밀번호
	private String email; //이메일
	private String addr; //주소
}
