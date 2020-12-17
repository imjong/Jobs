package com.project.jobs.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.project.jobs.dao.JobhunterDao;
import com.project.jobs.domain.JobhunterVO;

import lombok.extern.log4j.Log4j;

@Service("JobhunterServiceImpl")
@Log4j
public class JobhunterServiceImpl implements JobhunterService {
	
	@Inject
	private JobhunterDao jobhunterDao;

	@Override
	public int getTotalCount() {
		return 0;
	}
	
	/**게시판번호로 특정 채용정보 가져오기*/
	@Override
	public JobhunterVO selectByNum(Integer num) {
		return this.jobhunterDao.selectByNum(num);
	}

	/** 게시판 번호를 받아 조회수 올리기*/
	@Override
	public boolean updateReadnum(Integer num) {
		return this.jobhunterDao.updateReadnum(num);
	}
	
	/** 조회수 top5 게시글만 띄우기*/
	@Override
	public List<JobhunterVO> selectJobhunterTop5() {
		return jobhunterDao.selectJobhunterTop5();
	}

	/** 게시글 작성*/
	@Override
	public int insertJobhunter(JobhunterVO jobhunter) {
		return jobhunterDao.insertJobhunter(jobhunter);
	}

	/** 최근 등록된 6개의 게시글만 띄우기*/
	@Override
	public List<JobhunterVO> selectJobhunterlatest() {
		return jobhunterDao.selectJobhunterlatest();
	}

	/** 모든 게시판 글 가져오기*/
	@Override
	public List<JobhunterVO> listJobhunter() {
		return jobhunterDao.selectJobhunterAll();
	}
	
	/** 모든 게시판 글 가져오기*/
	@Override
	public List<JobhunterVO> listJobhunter(Map<String, String> map) {
		return jobhunterDao.selectJobhunterAll(map);
	}

	/** 글 삭제*/
	@Override
	public int deleteJobhunter(int num) {
		return this.jobhunterDao.deleteJobhunter(num);
	}
	
	/** 수정 (파일을 수정안했을때)*/
	@Override
	public int updateJobhunter(JobhunterVO jobhunter) {
		return this.jobhunterDao.updateJobhunter(jobhunter);
	}

	@Override
	public JobhunterVO getJobhunter(int idx) {
		return null;
	}

	/** 수정 (파일을 수정했을때)*/
	@Override
	public int updateJobhunterF(JobhunterVO jobhunter) {
		return this.jobhunterDao.updateJobhunterF(jobhunter);
	}
	
	/** 각 분야별 카운트*/
	@Override
	public List<JobhunterVO> selectCount() {
		return this.jobhunterDao.selectCount();
	}
	
	/** 카테고리에 맞게 게시글 띄우기*/
	@Override
	public List<JobhunterVO> selectCategory(String colname, String category) {
		Map<String,String> categorymap=new HashMap<>();
		categorymap.put("colname",colname);
		categorymap.put("category",category);
		return this.jobhunterDao.selectCategory2(categorymap);
	}
	
	/**총 게시글 수 가져오기*/
	@Override
	public int getTotalCount(Map<String, String> map) {
		return this.jobhunterDao.getTotalCount(map);
	}

	@Override
	/** 본인이 작성한 글*/
	public List<JobhunterVO> listJobhunterMe(String userid) {
		return jobhunterDao.listJobhunterMe(userid);
	}
}
