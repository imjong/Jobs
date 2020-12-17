package com.project.jobs.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.jobs.common.CommonUtil;
import com.project.jobs.domain.NewsletterVO;
import com.project.jobs.domain.UserVO;
import com.project.jobs.service.NewsletterService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j

public class NewsletterController {
	
	@Autowired
	private NewsletterService newsletterservice;
	
	@Inject
	private CommonUtil util;
	
	
	/** 뉴스레터에 이메일 등록했을때 */
	@PostMapping("/insertnewsletter")
	public String insertnewsletter(Model m, @ModelAttribute("email") NewsletterVO newsletter) {
		System.out.println("home요청 들어옴");
		int n = newsletterservice.insertnewsletter(newsletter);
		String str=(n>0)? "등록을 완료했습니다.":"등록을 실패했습니다.";
		String loc=(n>0)? "home":"javascript:history.back()";
		m.addAttribute("message",str);
		m.addAttribute("loc",loc);
		return "message";
	}
	
	/** 등록된 뉴스레터 보기*/
	@GetMapping("/newsletterlist")
	public String newsletterlist(Model m) {
		System.out.println("newsletterlist요청 들어옴");
		List<NewsletterVO> arr = this.newsletterservice.getNewsletter();
		m.addAttribute("newsletterArr",arr);
		return "admin/newsletterlist";
	}
	
	/** 등록된 뉴스레터 삭제*/
	@GetMapping("/newsletterdelete")
	public String newsletterdelete(Model m, @RequestParam(defaultValue="0") int idx) {
		System.out.println("newsletterdelete요청 들어옴");

		if(idx==0) {
			return util.addMsgBack(m, "잘못 들어온 경로입니다.");
		}
		
		int n = this.newsletterservice.deleteNewsletter(idx);
		String str=(n>0)? "삭제를 완료했습니다.":"삭제를 실패했습니다.";
		String loc=(n>0)? "newsletterlist":"javascript:history.back()";
		m.addAttribute("message",str);
		m.addAttribute("loc",loc);
		
		return "message";
	}

}
