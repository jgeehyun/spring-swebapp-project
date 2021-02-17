package com.jjh.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.jjh.vo.BoardVO;
import com.jjh.vo.SearchCriteria;


@Repository
public class BoardDAOImpl implements BoardDAO {
	
	@Autowired 
	private SqlSession sqlSession;
	
	// 게시글 작성
	@Override
	public void write(BoardVO boardVO) throws Exception {
		sqlSession.insert("boardMapper.insert", boardVO);
		
	}
	
	//게시글 목록 조회
	@Override
	public List<BoardVO> list(SearchCriteria scri) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("boardMapper.listPage",scri);
	}
	
	//게시물 총 갯수
	@Override
	public int listCount(SearchCriteria scri) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("boardMapper.listCount", scri);
	}
	
	//게시물 조회
	@Override
	public BoardVO read(int bno) throws Exception {
		
		return sqlSession.selectOne("boardMapper.read",bno);
	}

	//게시물 수정
	@Override
	public void update(BoardVO boardVO) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update("boardMapper.update", boardVO);
		
	}
	
	//게시물 삭제
	@Override
	public void delete(int bno) throws Exception {
		// TODO Auto-generated method stub
		
	}
	

}
