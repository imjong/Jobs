package com.project.jobs.service;

import java.util.List;
import java.util.Map;

import com.project.jobs.domain.RecruitVO;



public interface RecruitService {
	
	int getTotalCount();
	
	/** 글 작성*/
	int insertRecruit(RecruitVO recruit);
	
	/** 모든 채용정보 가져오기*/
	List<RecruitVO> listRecruit();
	
	/** 모든 채용정보 가져오기*/
	List<RecruitVO> listRecruit(Map<String,String> map);
	
	/**총 게시글 수 가져오기*/
	public int getTotalCount(Map<String,String> map);
	
	/** 해당하는 idx의 정보 가져오기*/
	RecruitVO getRecruit(int idx);
	
	/**게시판번호로 특정 채용정보 가져오기*/
	public RecruitVO selectByNum(Integer num);
	
	/** 게시판 번호로 조회수 늘리기*/
	public boolean updateReadnum(Integer num);
	
	/** 조회수 top5 게시글만 띄우기*/
	List<RecruitVO> selectRecruitTop5();
	
	/** 최근 등록된 6개의 게시글만 띄우기*/
	List<RecruitVO> selectRecruitlatest();
	
	/** 카테고리에 맞게 게시글 띄우기*/
	List<RecruitVO> selectCategory(String colname, String category);
	
	/** 각 분야별 카운트*/
	List<RecruitVO> selectCount();
	
	/** 글 삭제*/
	int deleteRecruit(int num);//삭제
	
	/** 수정 (파일을 수정했을때)*/
	int updateRecruitF(RecruitVO recruit);
	
	/** 수정 (파일을 수정안했을때)*/
	int updateRecruit(RecruitVO recruit);


}
