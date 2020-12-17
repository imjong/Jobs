package com.project.jobs.service;

import java.util.List;
import java.util.Map;

import com.project.jobs.domain.NotUserException;
import com.project.jobs.domain.UserVO;

public interface UserService {
	public int createUser(UserVO user);// ȸ������

	public int idCheck(String userid);// ID �ߺ�üũ

	public int updateUser(UserVO user);// ȸ�� ���� ����

	public UserVO loginCheck(UserVO user) throws NotUserException;// �α��� üũ

	public UserVO getUser(String userid) throws NotUserException;// ���̵�� ȸ������ �������� //-�ش���̵� ������ ���̵� �����ϴ� ǥ��

	public UserVO getUserByIdx(int idx);// ȸ����ȣ�� ȸ������ ��������

	List<UserVO> getCompany(Map<String, String> map);// ���ȸ���� ������� ��������

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
