package com.project.jobs.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.jobs.common.CommonUtil;
import com.project.jobs.domain.UserVO;
import com.project.jobs.service.UserService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j

public class UserController {
	
	@Autowired
	private UserService userservice;
	
	@Inject
	private CommonUtil util;
	
	/** ��ϵ� �������� ����*/
	@GetMapping("/userlist")
	public String newsletterlist(Model m) {
		System.out.println("userlist��û ����");
		List<UserVO> arr = this.userservice.getUserlist();
		m.addAttribute("UserlistArr",arr);
		return "admin/userlist";
	}
	
	@PostMapping("/userdelete")
	public String userdelete(Model m, @RequestParam(value="idx" ,defaultValue="0") int idx) {
		System.out.println("userdelete��û ����");

		if(idx==0) {
			return util.addMsgBack(m, "�߸� ���� ����Դϴ�.");
		}
		
		int n = this.userservice.deleteUser(idx);
		String str=(n>0)? "�ش� ȸ���� ������ �Ϸ��Ͽ����ϴ�.":"�ش� ȸ���� ������ �����Ͽ����ϴ�.";
		String loc=(n>0)? "userlist":"javascript:history.back()";
		m.addAttribute("message",str);
		m.addAttribute("loc",loc);
		
		return "message";
	}
	
	@PostMapping("/userstateupdate")
	public String userstateupdate(Model m, @RequestParam(value="idx" ,defaultValue="0") int idx, @RequestParam(value="state" ,defaultValue="0") int state) {
		System.out.println("userdelete��û ����");

		if(idx==0) {
			return util.addMsgBack(m, "�߸� ���� ����Դϴ�.");
		}
		
		
		Map<String, Integer> map = new HashMap<>();
		map.put("idx", idx);
		map.put("state", state);
		
		if(state==4) {
			int n = this.userservice.quitUser(idx);
			
			String str = (n > 0) ? "ȸ�����¸� �����߽��ϴ�." : "ȸ������ ������ �����߽��ϴ�.";
			String loc = (n > 0) ? "userlist" : "javascript:history.back()";
			
			m.addAttribute("message", str);
			m.addAttribute("loc", loc);
			
			return "message";
		}
		
		int n = this.userservice.updateState(map);
		String str=(n>0)? "ȸ�����¸� �����߽��ϴ�.":"ȸ������ ������ �����߽��ϴ�.";
		String loc=(n>0)? "userlist":"javascript:history.back()";
		m.addAttribute("message",str);
		m.addAttribute("loc",loc);
		
		return "message";
	}


}
