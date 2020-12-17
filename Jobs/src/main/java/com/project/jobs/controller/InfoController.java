package com.project.jobs.controller;

import java.io.File;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.project.jobs.common.CommonUtil;
import com.project.jobs.domain.UserVO;
import com.project.jobs.service.UserService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class InfoController {

	@Autowired
	private UserService userService;
	
	@Inject
	private CommonUtil util;

	@GetMapping("/info")
	public String info() {
		return "/info";
	}

	@PostMapping("/info")
	public String updateUser(Model m, @ModelAttribute("info") UserVO user,
			@RequestParam("imagefile") MultipartFile mfile, HttpServletRequest req) {

		// ����
		String filename = mfile.getOriginalFilename();
		UUID uid = UUID.randomUUID();
		String ustr = uid.toString();

		String upfile = ustr + "_" + filename;

		ServletContext application = req.getServletContext();
		String upDir = application.getRealPath("/profileimage");

		
		if(!mfile.isEmpty()) {
			File file = new File(upDir + "/" + user.getImagename());
			if (file.exists()) {
				file.delete();
			}
			try {
				mfile.transferTo(new File(upDir, upfile));
				user.setImagename(upfile);
			} catch (Exception e) {
				log.error("���� ���ε� ����: " + e.getMessage());
			}
		}

		int n = userService.updateUser(user);
		String str = (n > 0) ? "ȸ�������� �����߽��ϴ�. �ٽ� �α����ϼ���." : "ȸ������ ������ �����߽��ϴ�.";
		String loc = (n > 0) ? "logout" : "javascript:history.back()";
		
//		ses.setAttribute("", "");

		m.addAttribute("message", str);
		m.addAttribute("loc", loc);

		return "message";
	}
	
	/** ȸ�� Ż�� ����*/
	@PostMapping("/userquit")
	public String userquit(Model m, @RequestParam(value="idx", defaultValue="0") int idx) {
		
		if(idx==0) {
			return util.addMsgBack(m, "�߸� ���� ����Դϴ�.");
		}
		
		int n = this.userService.quitUser(idx);
		
		String str = (n > 0) ? "ȸ��Ż�� �Ϸ��߽��ϴ�." : "ȸ��Ż�� �����߽��ϴ�.";
		String loc = (n > 0) ? "logout" : "javascript:history.back()";
		
		m.addAttribute("message", str);
		m.addAttribute("loc", loc);
		
		return "message";
	}
	
}
