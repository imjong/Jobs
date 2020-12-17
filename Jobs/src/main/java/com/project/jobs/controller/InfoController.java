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

		// 사진
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
				log.error("파일 업로드 실패: " + e.getMessage());
			}
		}

		int n = userService.updateUser(user);
		String str = (n > 0) ? "회원정보를 수정했습니다. 다시 로그인하세요." : "회원정보 수정을 실패했습니다.";
		String loc = (n > 0) ? "logout" : "javascript:history.back()";
		
//		ses.setAttribute("", "");

		m.addAttribute("message", str);
		m.addAttribute("loc", loc);

		return "message";
	}
	
	/** 회원 탈퇴 관련*/
	@PostMapping("/userquit")
	public String userquit(Model m, @RequestParam(value="idx", defaultValue="0") int idx) {
		
		if(idx==0) {
			return util.addMsgBack(m, "잘못 들어온 경로입니다.");
		}
		
		int n = this.userService.quitUser(idx);
		
		String str = (n > 0) ? "회원탈퇴를 완료했습니다." : "회원탈퇴를 실패했습니다.";
		String loc = (n > 0) ? "logout" : "javascript:history.back()";
		
		m.addAttribute("message", str);
		m.addAttribute("loc", loc);
		
		return "message";
	}
	
}
