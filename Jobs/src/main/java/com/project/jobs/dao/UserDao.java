package com.project.jobs.dao;

import java.util.List;
import java.util.Map;

import com.project.jobs.domain.NewsletterVO;
import com.project.jobs.domain.UserVO;

public interface UserDao {
	int createUser(UserVO user);// 회원가입

	public int idCheck(String userid);// ID 중복체크

	public int updateUser(UserVO user);// 회원 정보 수정
	
	public UserVO getUser(String userid);// 아이디로 회원정보 가져오기
	
	public UserVO getUserByIdx(int idx);// 회원번호로 회원정보 가져오기

	/** 기업회원의 기업정보 가져오기 */
	List<UserVO> selectCompanyAll(Map<String, String> map);

	/** 회원번호로 특정 기업정보 가져오기 */
	public UserVO selectByNum(Integer idx);

	/** 총 게시글 수 가져오기 */
	public int getTotalCount(String search);

	/** 유저 목록 보기 */
	List<UserVO> getUserlist();

	/** 회원 삭제 */
	int deleteUser(int idx);// 삭제

	/** 회원상태 수정 */
	public int updateState(Map<String, Integer> map);
	
	/** 회원 탈퇴 */
	int quitUser(int idx);// 탈퇴
}
