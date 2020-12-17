package com.project.jobs.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.project.jobs.dao.UserDao;
import com.project.jobs.domain.NotUserException;
import com.project.jobs.domain.RecruitVO;
import com.project.jobs.domain.UserVO;

import lombok.extern.log4j.Log4j;

@Service("UserServiceImpl")
@Log4j
public class UserServiceImpl implements UserService {
	
	@Inject
	private UserDao userDao;

	/** 회원가입*/
	@Override
	public int createUser(UserVO user) {
		return userDao.createUser(user);
	}

	/** 유저 목록 보기*/
	@Override
	public List<UserVO> getUserlist() {
		return this.userDao.getUserlist();
	}

	/** ID 중복 확인 */
	@Override
	public int idCheck(String userid) {
		return userDao.idCheck(userid);
	}
	
	/** 회원 정보 수정  */
	@Override
	public int updateUser(UserVO user) {
		return userDao.updateUser(user);
	}

	@Override
	public UserVO getUserByIdx(int idx) {
		return null;
	}
	
	/** 회원 여부 검사*/
	@Override
	public UserVO loginCheck(UserVO user) throws NotUserException {
		UserVO loginUser=this.getUser(user.getUserid());
		if(loginUser==null) {
			//아이디가 없는 경우
			throw new NotUserException("아이디 또는 비밀번호를 다시 확인하세요. \\n등록되지 않은 아이디이거나, \\n아이디 또는 비밀번호를 잘못 입력하셨습니다.");
		}
		if(loginUser.getPwd().equals(user.getPwd())) {
			return loginUser;
		}
		else {
			throw new NotUserException("아이디 또는 비밀번호를 다시 확인하세요. \\n등록되지 않은 아이디이거나, \\n아이디 또는 비밀번호를 잘못 입력하셨습니다.");
		}
		
	}
	
	/** 회원정보 가져오기*/
	@Override
	public UserVO getUser(String userid) throws NotUserException {
		return userDao.getUser(userid);
	}

	/** 기업정보 가져오기*/
	@Override
	public List<UserVO> getCompany(Map<String, String> map) {
		return userDao.selectCompanyAll(map);
	}
	
	/**회원번호로 특정 기업정보 가져오기*/
	@Override
	public UserVO selectByNum(Integer idx) {
		return this.userDao.selectByNum(idx);
	}

	/**총 게시글 수 가져오기*/
	public int getTotalCount(String search) {
		return this.userDao.getTotalCount(search);
	}
	
	/** 회원 삭제*/
	@Override
	public int deleteUser(int idx) {
		return this.userDao.deleteUser(idx);
	}
	
	/** 회원상태 수정*/
	@Override
	public int updateState(Map<String, Integer> map) {
		return this.userDao.updateState(map);
	}
	
	/** 회원 탈퇴*/
	@Override
	public int quitUser(int idx) {
		return this.userDao.quitUser(idx);
	}

}
