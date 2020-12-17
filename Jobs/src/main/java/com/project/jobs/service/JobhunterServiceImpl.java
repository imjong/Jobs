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
	
	/**�Խ��ǹ�ȣ�� Ư�� ä������ ��������*/
	@Override
	public JobhunterVO selectByNum(Integer num) {
		return this.jobhunterDao.selectByNum(num);
	}

	/** �Խ��� ��ȣ�� �޾� ��ȸ�� �ø���*/
	@Override
	public boolean updateReadnum(Integer num) {
		return this.jobhunterDao.updateReadnum(num);
	}
	
	/** ��ȸ�� top5 �Խñ۸� ����*/
	@Override
	public List<JobhunterVO> selectJobhunterTop5() {
		return jobhunterDao.selectJobhunterTop5();
	}

	/** �Խñ� �ۼ�*/
	@Override
	public int insertJobhunter(JobhunterVO jobhunter) {
		return jobhunterDao.insertJobhunter(jobhunter);
	}

	/** �ֱ� ��ϵ� 6���� �Խñ۸� ����*/
	@Override
	public List<JobhunterVO> selectJobhunterlatest() {
		return jobhunterDao.selectJobhunterlatest();
	}

	/** ��� �Խ��� �� ��������*/
	@Override
	public List<JobhunterVO> listJobhunter() {
		return jobhunterDao.selectJobhunterAll();
	}
	
	/** ��� �Խ��� �� ��������*/
	@Override
	public List<JobhunterVO> listJobhunter(Map<String, String> map) {
		return jobhunterDao.selectJobhunterAll(map);
	}

	/** �� ����*/
	@Override
	public int deleteJobhunter(int num) {
		return this.jobhunterDao.deleteJobhunter(num);
	}
	
	/** ���� (������ ������������)*/
	@Override
	public int updateJobhunter(JobhunterVO jobhunter) {
		return this.jobhunterDao.updateJobhunter(jobhunter);
	}

	@Override
	public JobhunterVO getJobhunter(int idx) {
		return null;
	}

	/** ���� (������ ����������)*/
	@Override
	public int updateJobhunterF(JobhunterVO jobhunter) {
		return this.jobhunterDao.updateJobhunterF(jobhunter);
	}
	
	/** �� �оߺ� ī��Ʈ*/
	@Override
	public List<JobhunterVO> selectCount() {
		return this.jobhunterDao.selectCount();
	}
	
	/** ī�װ��� �°� �Խñ� ����*/
	@Override
	public List<JobhunterVO> selectCategory(String colname, String category) {
		Map<String,String> categorymap=new HashMap<>();
		categorymap.put("colname",colname);
		categorymap.put("category",category);
		return this.jobhunterDao.selectCategory2(categorymap);
	}
	
	/**�� �Խñ� �� ��������*/
	@Override
	public int getTotalCount(Map<String, String> map) {
		return this.jobhunterDao.getTotalCount(map);
	}

	@Override
	/** ������ �ۼ��� ��*/
	public List<JobhunterVO> listJobhunterMe(String userid) {
		return jobhunterDao.listJobhunterMe(userid);
	}
}
