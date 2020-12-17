package com.project.jobs.dao;

import java.util.List;
import java.util.Map;

import com.project.jobs.domain.RecruitVO;

public interface RecruitDao {
	/** ä������ �߰�*/
	int insertRecruit(RecruitVO recruit);//�߰�
	
	/** ��� ���� ��������*/
	List<RecruitVO> selectRecruitAll();//��系��
	
	/** ��� ä������ ��������*/
	List<RecruitVO> selectRecruitAll(Map<String,String> map);//�Խ��� ���
	
	/**�� �Խñ� �� ��������*/
	public int getTotalCount(Map<String,String> map);
	
	/** �ش��ϴ� idx�� ���� ��������*/
	RecruitVO selectRecruit(int idx);
	
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
	List<RecruitVO> selectCategory2(Map<String,String> categorymap);
	
	/** �� �оߺ� ī��Ʈ*/
	List<RecruitVO> selectCount();
	
	/** �� ����*/
	int deleteRecruit(int num);//����
	
	/** ���� (������ ����������)*/
	int updateRecruitF(RecruitVO recruit);
	
	/** ���� (������ ������������)*/
	int updateRecruit(RecruitVO recruit);
}
