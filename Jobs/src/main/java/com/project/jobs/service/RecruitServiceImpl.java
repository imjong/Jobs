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
	
	/**�Խ��ǹ�ȣ�� Ư�� ä������ ��������*/
	@Override
	public RecruitVO selectByNum(Integer num) {
		return this.recruitDao.selectByNum(num);
	}

	/** �Խ��� ��ȣ�� �޾� ��ȸ�� �ø���*/
	@Override
	public boolean updateReadnum(Integer num) {
		return this.recruitDao.updateReadnum(num);
	}
	
	/** ��ȸ�� top5 �Խñ۸� ����*/
	@Override
	public List<RecruitVO> selectRecruitTop5() {
		return recruitDao.selectRecruitTop5();
	}

	/** �Խñ� �ۼ�*/
	@Override
	public int insertRecruit(RecruitVO recruit) {
		return recruitDao.insertRecruit(recruit);
	}

	/** �ֱ� ��ϵ� 6���� �Խñ۸� ����*/
	@Override
	public List<RecruitVO> selectRecruitlatest() {
		return recruitDao.selectRecruitlatest();
	}

	/** ��� �Խ��� �� ��������*/
	@Override
	public List<RecruitVO> listRecruit() {
		return recruitDao.selectRecruitAll();
	}

	/** ��� �Խ��� �� ��������*/
	@Override
	public List<RecruitVO> listRecruit(Map<String, String> map) {
		return recruitDao.selectRecruitAll(map);
	}

	/** �� ����*/
	@Override
	public int deleteRecruit(int num) {
		return this.recruitDao.deleteRecruit(num);
	}
	
	/** ���� (������ ������������)*/
	@Override
	public int updateRecruit(RecruitVO recruit) {
		return this.recruitDao.updateRecruit(recruit);
	}

	@Override
	public RecruitVO getRecruit(int idx) {
		return null;
	}

	/** ���� (������ ����������)*/
	@Override
	public int updateRecruitF(RecruitVO recruit) {
		return this.recruitDao.updateRecruitF(recruit);
	}
	
	/** �� �оߺ� ī��Ʈ*/
	@Override
	public List<RecruitVO> selectCount() {
		return this.recruitDao.selectCount();
	}
	
	/** ī�װ��� �°� �Խñ� ����*/
	@Override
	public List<RecruitVO> selectCategory(String colname, String category) {
		Map<String,String> categorymap=new HashMap<>();
		categorymap.put("colname",colname);
		categorymap.put("category",category);
		return this.recruitDao.selectCategory2(categorymap);
	}
	
	/**�� �Խñ� �� ��������*/
	@Override
	public int getTotalCount(Map<String, String> map) {
		return this.recruitDao.getTotalCount(map);
	}
	
	

}
