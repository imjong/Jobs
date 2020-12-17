package com.project.jobs.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.project.jobs.dao.RecruitDao;
import com.project.jobs.domain.RecruitVO;

import lombok.extern.log4j.Log4j;

@Service("RecruitServiceImpl")
@Log4j
public class RecruitServiceImpl implements RecruitService {

	@Inject
	private RecruitDao recruitDao;
	
	@Override
	public int getTotalCount() {
		return 0;
	}
	
	/**게시판번호로 특정 채용정보 가져오기*/
	@Override
	public RecruitVO selectByNum(Integer num) {
		return this.recruitDao.selectByNum(num);
	}

	/** 게시판 번호를 받아 조회수 올리기*/
	@Override
	public boolean updateReadnum(Integer num) {
		return this.recruitDao.updateReadnum(num);
	}
	
	/** 조회수 top5 게시글만 띄우기*/
	@Override
	public List<RecruitVO> selectRecruitTop5() {
		return recruitDao.selectRecruitTop5();
	}

	/** 게시글 작성*/
	@Override
	public int insertRecruit(RecruitVO recruit) {
		return recruitDao.insertRecruit(recruit);
	}

	/** 최근 등록된 6개의 게시글만 띄우기*/
	@Override
	public List<RecruitVO> selectRecruitlatest() {
		return recruitDao.selectRecruitlatest();
	}

	/** 모든 게시판 글 가져오기*/
	@Override
	public List<RecruitVO> listRecruit() {
		return recruitDao.selectRecruitAll();
	}

	/** 모든 게시판 글 가져오기*/
	@Override
	public List<RecruitVO> listRecruit(Map<String, String> map) {
		return recruitDao.selectRecruitAll(map);
	}

	/** 글 삭제*/
	@Override
	public int deleteRecruit(int num) {
		return this.recruitDao.deleteRecruit(num);
	}
	
	/** 수정 (파일을 수정안했을때)*/
	@Override
	public int updateRecruit(RecruitVO recruit) {
		return this.recruitDao.updateRecruit(recruit);
	}

	@Override
	public RecruitVO getRecruit(int idx) {
		return null;
	}

	/** 수정 (파일을 수정했을때)*/
	@Override
	public int updateRecruitF(RecruitVO recruit) {
		return this.recruitDao.updateRecruitF(recruit);
	}
	
	/** 각 분야별 카운트*/
	@Override
	public List<RecruitVO> selectCount() {
		return this.recruitDao.selectCount();
	}
	
	/** 카테고리에 맞게 게시글 띄우기*/
	@Override
	public List<RecruitVO> selectCategory(String colname, String category) {
		Map<String,String> categorymap=new HashMap<>();
		categorymap.put("colname",colname);
		categorymap.put("category",category);
		return this.recruitDao.selectCategory2(categorymap);
	}
	
	/**총 게시글 수 가져오기*/
	@Override
	public int getTotalCount(Map<String, String> map) {
		return this.recruitDao.getTotalCount(map);
	}
	
	

}
