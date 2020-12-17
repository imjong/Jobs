package com.project.jobs.dao;

import java.util.List;

import com.project.jobs.domain.NewsletterVO;
import com.project.jobs.domain.UserVO;

public interface NewsletterDao {
	
	/** �̸��� ����ϱ� */
	int insertnewsletter(NewsletterVO newsletter);
	
	/** �̸��� ��� ����*/
	List<NewsletterVO> getNewsletter();
	
	/** �� ����*/
	int deleteNewsletter(int idx);//����

}
