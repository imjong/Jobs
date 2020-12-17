package com.project.jobs.service;

import java.util.List;

import com.project.jobs.domain.NewsletterVO;

public interface NewsletterService {
	
	/** 이메일 등록하기 */
	int insertnewsletter(NewsletterVO newsletter);
	
	/** 이메일 목록 보기*/
	List<NewsletterVO> getNewsletter();
	
	/** 글 삭제*/
	int deleteNewsletter(int idx);//삭제
	
}
