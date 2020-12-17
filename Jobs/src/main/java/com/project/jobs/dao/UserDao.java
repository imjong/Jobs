package com.project.jobs.dao;

import java.util.List;
import java.util.Map;

import com.project.jobs.domain.NewsletterVO;
import com.project.jobs.domain.UserVO;

public interface UserDao {
	int createUser(UserVO user);// ȸ������

	public int idCheck(String userid);// ID �ߺ�üũ

	public int updateUser(UserVO user);// ȸ�� ���� ����
	
	public UserVO getUser(String userid);// ���̵�� ȸ������ ��������
	
	public UserVO getUserByIdx(int idx);// ȸ����ȣ�� ȸ������ ��������

	/** ���ȸ���� ������� �������� */
	List<UserVO> selectCompanyAll(Map<String, String> map);

	/** ȸ����ȣ�� Ư�� ������� �������� */
	public UserVO selectByNum(Integer idx);

	/** �� �Խñ� �� �������� */
	public int getTotalCount(String search);

	/** ���� ��� ���� */
	List<UserVO> getUserlist();

	/** ȸ�� ���� */
	int deleteUser(int idx);// ����

	/** ȸ������ ���� */
	public int updateState(Map<String, Integer> map);
	
	/** ȸ�� Ż�� */
	int quitUser(int idx);// Ż��
}
