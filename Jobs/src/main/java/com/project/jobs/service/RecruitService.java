package com.project.jobs.service;

import java.util.List;
import java.util.Map;

import com.project.jobs.domain.RecruitVO;



public interface RecruitService {
	
	int getTotalCount();
	
	/** �� �ۼ�*/
	int insertRecruit(RecruitVO recruit);
	
	/** ��� ä������ ��������*/
	List<RecruitVO> listRecruit();
	
	/** ��� ä������ ��������*/
	List<RecruitVO> listRecruit(Map<String,String> map);
	
	/**�� �Խñ� �� ��������*/
	public int getTotalCount(Map<String,String> map);
	
	/** �ش��ϴ� idx�� ���� ��������*/
	RecruitVO getRecruit(int idx);
	
	/**�Խ��ǹ�ȣ�� Ư�� ä������ ��������*/
	public RecruitVO selectByNum(Integer num);
	
	/** �Խ��� ��ȣ�� ��ȸ�� �ø���*/
	public boolean updateReadnum(Integer num);
	
	/** ��ȸ�� top5 �Խñ۸� ����*/
	List<RecruitVO> selectRecruitTop5();
	
	/** �ֱ� ��ϵ� 6���� �Խñ۸� ����*/
	List<RecruitVO> selectRecruitlatest();
	
	/** ī�װ��� �°� �Խñ� ����*/
	List<RecruitVO> selectCategory(String colname, String category);
	
	/** �� �оߺ� ī��Ʈ*/
	List<RecruitVO> selectCount();
	
	/** �� ����*/
	int deleteRecruit(int num);//����
	
	/** ���� (������ ����������)*/
	int updateRecruitF(RecruitVO recruit);
	
	/** ���� (������ ������������)*/
	int updateRecruit(RecruitVO recruit);


}
