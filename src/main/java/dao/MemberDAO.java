package dao;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;

import vo.MemberVO;

public class MemberDAO {

	SqlSession sqlSession;
	public MemberDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//아이디 중복체크
	public int check_id(String id) {
		int res = sqlSession.selectOne("m.check_id",id);
		
		return res;
	}
	
	//회원가입
	public int m_insert(MemberVO vo) {
		int res = sqlSession.insert("m.member_insert",vo);
		
		return res;
	}
	
	//로그인 체크 및 비밀번호 변경을 위한 조회
	public MemberVO login_check(String id) {
		MemberVO vo = sqlSession.selectOne("m.login_check",id);
		
		return vo;
	}
	
	//아이디 찾기
	public MemberVO result_id(HashMap<String, String> map) {
		MemberVO vo = sqlSession.selectOne("m.result_id", map);
		
		return vo;
	}
	
	//비밀번호 찾기를 위한 인증
	public MemberVO send(HashMap<String, String> map) {
		MemberVO vo = sqlSession.selectOne("m.send", map);
		
		return vo;
	}
	
	//비밀번호 변경
	public int result_pwd(MemberVO vo) {
		int res = sqlSession.update("m.result_pwd",vo);
		
		return res;
	}
	
	//회원탈퇴(게시글도 함께 삭제된다)
	public int secession(String id) {
		int res = sqlSession.delete("m.secession",id);
		
		return res;
	}
}
