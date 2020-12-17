package com.project.jobs.dao;

import java.util.List;
import java.util.Map;

import com.project.jobs.domain.JobhunterVO;

public interface JobhunterDao {
	/** �������� �߰�*/
	int insertJobhunter(JobhunterVO jobhunter);//�߰�
	
	/** ��� ���� ��������*/
	List<JobhunterVO> selectJobhunterAll();//��系��
	
	/** ��� �������� ��������*/
	List<JobhunterVO> selectJobhunterAll(Map<String,String> map);//�Խ��� ���

	/** �ش��ϴ� idx�� ���� ��������*/
	JobhunterVO selectJobhunter(int idx);
	
	/**�� �Խñ� �� ��������*/
	public int getTotalCount(Map<String,String> map);
	
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
	List<JobhunterVO> selectCategory2(Map<String,String> categorymap);
	
	/** �� �оߺ� ī��Ʈ*/
	List<JobhunterVO> selectCount();
	
	/** �� ����*/
	int deleteJobhunter(int num);//����
	
	/** ���� (������ ����������)*/
	int updateJobhunterF(JobhunterVO Jobhunter);
	
	/** ���� (������ ������������)*/
	int updateJobhunter(JobhunterVO Jobhunter);
	
	/** ������ �ۼ��� ��*/
	List<JobhunterVO> listJobhunterMe(String userid);
	
	
}
