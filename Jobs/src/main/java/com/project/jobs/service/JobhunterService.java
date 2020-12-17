package com.project.jobs.service;

import java.util.List;
import java.util.Map;

import com.project.jobs.domain.JobhunterVO;

public interface JobhunterService {
	
	int getTotalCount();
	
	/** �Խñ� �ۼ�*/
	int insertJobhunter(JobhunterVO jobhunter);
	
	/** ��� �������� ��������*/
	List<JobhunterVO> listJobhunter();
	
	/** ��� �������� ��������*/
	List<JobhunterVO> listJobhunter(Map<String,String> map);
	
	/**�� �Խñ� �� ��������*/
	public int getTotalCount(Map<String,String> map);

	/** �ش��ϴ� idx�� ���� ��������*/
	JobhunterVO getJobhunter(int idx);
	
	/**�Խ��ǹ�ȣ�� Ư�� ä������ ��������*/
	public JobhunterVO selectByNum(Integer num);
	
	/** �Խ��� ��ȣ�� ��ȸ�� �ø���*/
	public boolean updateReadnum(Integer num);
	
	/** ��ȸ�� top5 �Խñ۸� ����*/
	List<JobhunterVO> selectJobhunterTop5();
	
	/** �ֱ� ��ϵ� 6���� �Խñ۸� ����*/
	List<JobhunterVO> selectJobhunterlatest();
	
	/** ī�װ��� �°� �Խñ� ����*/
	List<JobhunterVO> selectCategory(String colname, String category);
	
	/** �� �оߺ� ī��Ʈ*/
	List<JobhunterVO> selectCount();
	
	/** �� ����*/
	int deleteJobhunter(int num);//����
	
	/** ���� (������ ����������)*/
	int updateJobhunterF(JobhunterVO jobhunter);
	
	/** ���� (������ ������������)*/
	int updateJobhunter(JobhunterVO jobhunter);
	
	/** ������ �ۼ��� ��*/
	List<JobhunterVO> listJobhunterMe(String userid);
}
