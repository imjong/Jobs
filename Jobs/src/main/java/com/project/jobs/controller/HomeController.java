package com.project.jobs.controller;


import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.project.jobs.domain.RecruitVO;
import com.project.jobs.service.RecruitService;

import lombok.extern.log4j.Log4j;


@Controller
@Log4j
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	@Autowired
	private RecruitService recruitservice;
	
	/**
	 * localhost:9090/jobs/
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model m) {
		System.out.println("main¿äÃ» µé¾î¿È");
		List<RecruitVO> arr = this.recruitservice.selectRecruitlatest();
		m.addAttribute("recruitArr",arr);
		return "main";
	}
	
	/**
	 * localhost:9090/jobs/home
	 */
	@GetMapping("/home")
	public String home2(Model m) {
		System.out.println("home¿äÃ» µé¾î¿È");
		List<RecruitVO> arr = this.recruitservice.selectRecruitlatest();
		m.addAttribute("recruitArr",arr);
		return "main";
	}
	
	@GetMapping("/contacts")
	public String contacts(Model m) {
		System.out.println("contacts¿äÃ» µé¾î¿È");
		return "contacts";
	}
	
	@GetMapping("/about")
	public String about(Model m) {
		System.out.println("about¿äÃ» µé¾î¿È");
		return "about";
	}
	
	@RequestMapping("/top")
	public void showTop() {
		
	}
	
	@RequestMapping("/foot")
	public void showFoot() {
		
	}
	
}
