package com.project.jobs.service;

import java.util.List;

import com.project.jobs.domain.NewsletterVO;

public interface NewsletterService {
	
	/** �̸��� ����ϱ� */
	int insertnewsletter(NewsletterVO newsletter);
	
	/** �̸��� ��� ����*/
	List<NewsletterVO> getNewsletter();
	
	/** �� ����*/
	int deleteNewsletter(int idx);//����
	
}
