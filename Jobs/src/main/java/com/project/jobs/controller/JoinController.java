package com.project.jobs.controller;

import java.io.File;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.project.jobs.domain.UserVO;
import com.project.jobs.service.UserService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class JoinController {

	@Autowired
	private UserService userService;

	/** 일반회원가입 */
	@GetMapping("/join")
	public String join(Model m) {
		return "join/join";
	}

	/** 기업회원가입 */
	@GetMapping("/cojoin")
	public String cojoin(Model m) {
		return "join/companyJoin";
	}
	
	/** 아이디 중복검사 */
	@GetMapping(value = "/join/idCheck", produces = {MediaType.APPLICATION_JSON_UTF8_VALUE})
	@ResponseBody
	public Map<String, Integer> idCheck(@RequestParam("userid") String userid) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("isExistID", userService.idCheck(userid));
		
		return map;
	}

	/** 일반, 기업 모두 회원가입 폼 작성후 가입할 때 */
	@PostMapping("/join")
	public String createUser(Model m, @ModelAttribute("join") UserVO user,
			@RequestParam("imagefile") MultipartFile mfile, HttpServletRequest req) {
		
		String filename = mfile.getOriginalFilename();
		UUID uid = UUID.randomUUID();
		String ustr = uid.toString();

		String upfile = ustr + "_" + filename;

		long fsize = mfile.getSize();// 업로드 파일 크기

		ServletContext application = req.getServletContext();
		String upDir = application.getRealPath("/profileimage");

		log.info("upDir=" + upDir);

		try {
			if (!mfile.isEmpty()) {
				mfile.transferTo(new File(upDir, upfile));

				user.setImagename(upfile);

				log.info("파일 업로드 성공");
			}
		} catch (Exception e) {
			log.error("파일 업로드 실패: " + e.getMessage());
		}

		int n = userService.createUser(user);
		String str = (n > 0) ? "회원 가입 성공" : "회원 가입 실패";
		String loc = (n > 0) ? "home" : "javascript:history.back()";
		
		m.addAttribute("message", str);
		m.addAttribute("loc", loc);
		
		return "message";
	}
}
