package dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import vo.BoardVO;

public class BoardDAO {

	SqlSession sqlSession;
	
	public BoardDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//페이지별 게시물 조회
	public List<BoardVO> selectList(HashMap<String, Integer> map){
		List<BoardVO> list = sqlSession.selectList("b.board_list",map);
		
		return list;
	}
	
	//전체 게시물 수 조회
	public int getRowTotal() {
		int res = sqlSession.selectOne("b.board_count");
		
		return res;
	}
	
	//idx에 해당하는 게시물 한 건 조회(게시물 상세보기)
	public BoardVO selectOne(int idx) {
		BoardVO vo = sqlSession.selectOne("b.board_one", idx);
		
		return vo;
	}
	
	//조회수 증가
	public int update_readhit(int idx) {	
		int res = sqlSession.update("b.update_readhit", idx);
		
		return res;
	}
	
	//게시글 추가
	public int b_insert(BoardVO vo) {
		int res = sqlSession.insert("b.board_insert", vo);
		
		return res;
	}
	
	//게시글 삭제
	public int board_del(int idx) {
		int res = sqlSession.delete("b.board_del", idx);
		
		return res;
	}
}
