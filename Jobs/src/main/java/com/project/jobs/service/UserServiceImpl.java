package com.project.jobs.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.project.jobs.dao.UserDao;
import com.project.jobs.domain.NotUserException;
import com.project.jobs.domain.RecruitVO;
import com.project.jobs.domain.UserVO;

import lombok.extern.log4j.Log4j;

@Service("UserServiceImpl")
@Log4j
public class UserServiceImpl implements UserService {
	
	@Inject
	private UserDao userDao;

	/** ȸ������*/
	@Override
	public int createUser(UserVO user) {
		return userDao.createUser(user);
	}

	/** ���� ��� ����*/
	@Override
	public List<UserVO> getUserlist() {
		return this.userDao.getUserlist();
	}

	/** ID �ߺ� Ȯ�� */
	@Override
	public int idCheck(String userid) {
		return userDao.idCheck(userid);
	}
	
	/** ȸ�� ���� ����  */
	@Override
	public int updateUser(UserVO user) {
		return userDao.updateUser(user);
	}

	@Override
	public UserVO getUserByIdx(int idx) {
		return null;
	}
	
	/** ȸ�� ���� �˻�*/
	@Override
	public UserVO loginCheck(UserVO user) throws NotUserException {
		UserVO loginUser=this.getUser(user.getUserid());
		if(loginUser==null) {
			//���̵� ���� ���
			throw new NotUserException("���̵� �Ǵ� ��й�ȣ�� �ٽ� Ȯ���ϼ���. \\n��ϵ��� ���� ���̵��̰ų�, \\n���̵� �Ǵ� ��й�ȣ�� �߸� �Է��ϼ̽��ϴ�.");
		}
		if(loginUser.getPwd().equals(user.getPwd())) {
			return loginUser;
		}
		else {
			throw new NotUserException("���̵� �Ǵ� ��й�ȣ�� �ٽ� Ȯ���ϼ���. \\n��ϵ��� ���� ���̵��̰ų�, \\n���̵� �Ǵ� ��й�ȣ�� �߸� �Է��ϼ̽��ϴ�.");
		}
		
	}
	
	/** ȸ������ ��������*/
	@Override
	public UserVO getUser(String userid) throws NotUserException {
		return userDao.getUser(userid);
	}

	/** ������� ��������*/
	@Override
	public List<UserVO> getCompany(Map<String, String> map) {
		return userDao.selectCompanyAll(map);
	}
	
	/**ȸ����ȣ�� Ư�� ������� ��������*/
	@Override
	public UserVO selectByNum(Integer idx) {
		return this.userDao.selectByNum(idx);
	}

	/**�� �Խñ� �� ��������*/
	public int getTotalCount(String search) {
		return this.userDao.getTotalCount(search);
	}
	
	/** ȸ�� ����*/
	@Override
	public int deleteUser(int idx) {
		return this.userDao.deleteUser(idx);
	}
	
	/** ȸ������ ����*/
	@Override
	public int updateState(Map<String, Integer> map) {
		return this.userDao.updateState(map);
	}
	
	/** ȸ�� Ż��*/
	@Override
	public int quitUser(int idx) {
		return this.userDao.quitUser(idx);
	}

}
