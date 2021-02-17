package com.jjh.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jjh.dao.MemberDAO;
import com.jjh.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService{
	
	
	@Autowired
	MemberDAO dao;
	
	@Override
	public void register(MemberVO vo) throws Exception {
		dao.register(vo);
		
	}

	@Override
	public MemberVO login(MemberVO vo) throws Exception {
		
		return dao.login(vo);
	}
	
	//Controller에서 보내는 파라미터들을 memberUpdate(MemberVO vo)로 받고
	@Override
	public void memberUpdate(MemberVO vo) throws Exception {
		//받은 vo를 DAO로 보내줍니다.
		dao.memberUpdate(vo);
		
	}

	@Override
	public void memberDelete(MemberVO vo) throws Exception {
		dao.memberDelete(vo);
		
	}
	
	//패스워드 체크
	@Override
	public int passChk(MemberVO vo) throws Exception {
		int result = dao.passChk(vo);
		return result;
	}
	
	//아이디 중복 체크
	@Override
	public int idChk(String userId) throws Exception {
		int result = dao.idChk(userId);
		return result;
	}

}
