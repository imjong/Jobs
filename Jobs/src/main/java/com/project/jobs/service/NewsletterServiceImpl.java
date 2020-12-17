package com.project.jobs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.project.jobs.dao.NewsletterDao;
import com.project.jobs.domain.NewsletterVO;

import lombok.extern.log4j.Log4j;

@Service("NewsletterServiceImpl")
@Log4j

public class NewsletterServiceImpl implements NewsletterService {
	
	@Inject
	private NewsletterDao newsletterDao;

	/** �̸��� ����ϱ� */
	@Override
	public int insertnewsletter(NewsletterVO newsletter) {
		return this.newsletterDao.insertnewsletter(newsletter);
	}

	/** �̸��� ��� ����*/
	@Override
	public List<NewsletterVO> getNewsletter() {
		return this.newsletterDao.getNewsletter();
	}
	
	/** �� ����*/
	@Override
	public int deleteNewsletter(int idx) {
		return this.newsletterDao.deleteNewsletter(idx);
	}

}
