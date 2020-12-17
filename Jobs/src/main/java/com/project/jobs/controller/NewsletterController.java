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
	
	
	/** �������Ϳ� �̸��� ��������� */
	@PostMapping("/insertnewsletter")
	public String insertnewsletter(Model m, @ModelAttribute("email") NewsletterVO newsletter) {
		System.out.println("home��û ����");
		int n = newsletterservice.insertnewsletter(newsletter);
		String str=(n>0)? "����� �Ϸ��߽��ϴ�.":"����� �����߽��ϴ�.";
		String loc=(n>0)? "home":"javascript:history.back()";
		m.addAttribute("message",str);
		m.addAttribute("loc",loc);
		return "message";
	}
	
	/** ��ϵ� �������� ����*/
	@GetMapping("/newsletterlist")
	public String newsletterlist(Model m) {
		System.out.println("newsletterlist��û ����");
		List<NewsletterVO> arr = this.newsletterservice.getNewsletter();
		m.addAttribute("newsletterArr",arr);
		return "admin/newsletterlist";
	}
	
	/** ��ϵ� �������� ����*/
	@GetMapping("/newsletterdelete")
	public String newsletterdelete(Model m, @RequestParam(defaultValue="0") int idx) {
		System.out.println("newsletterdelete��û ����");

		if(idx==0) {
			return util.addMsgBack(m, "�߸� ���� ����Դϴ�.");
		}
		
		int n = this.newsletterservice.deleteNewsletter(idx);
		String str=(n>0)? "������ �Ϸ��߽��ϴ�.":"������ �����߽��ϴ�.";
		String loc=(n>0)? "newsletterlist":"javascript:history.back()";
		m.addAttribute("message",str);
		m.addAttribute("loc",loc);
		
		return "message";
	}

}
