package dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import vo.CommentsVO;

public class CommentsDAO {

	SqlSession sqlSession;
	
	public CommentsDAO(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public int c_insert(CommentsVO c_vo) {
		int res = sqlSession.insert("c.c_insert",c_vo);
		return res;
	}
	
	//해당 게시물의 댓글 전체 조회
	public int c_rowTotal(int idx){
		Integer res = sqlSession.selectOne("c.c_count", idx);
	    if (res == null) {
	        return 0;
	    }
	    return res;			
	}
	
	//해당 게시물의 댓글 조회 후 댓글 수 별로 조회
	public List<CommentsVO> select_comments(HashMap<String, Integer> c_map){
		List<CommentsVO> c_list = sqlSession.selectList("c.c_list", c_map);
		
		return c_list;
	}
	
	//댓글 삭제를 위한 idx 한건 조회
	public CommentsVO c_selectOne(int idx) {
		CommentsVO cVO = sqlSession.selectOne("c.c_select", idx);
		
		return cVO;
	}
	
	public int c_del_update(CommentsVO cVO) {
		int res = sqlSession.update("c.c_del_update", cVO);
		
		return res;
	}
}
