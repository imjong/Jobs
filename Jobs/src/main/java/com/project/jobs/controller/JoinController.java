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

	/** �Ϲ�ȸ������ */
	@GetMapping("/join")
	public String join(Model m) {
		return "join/join";
	}

	/** ���ȸ������ */
	@GetMapping("/cojoin")
	public String cojoin(Model m) {
		return "join/companyJoin";
	}
	
	/** ���̵� �ߺ��˻� */
	@GetMapping(value = "/join/idCheck", produces = {MediaType.APPLICATION_JSON_UTF8_VALUE})
	@ResponseBody
	public Map<String, Integer> idCheck(@RequestParam("userid") String userid) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("isExistID", userService.idCheck(userid));
		
		return map;
	}

	/** �Ϲ�, ��� ��� ȸ������ �� �ۼ��� ������ �� */
	@PostMapping("/join")
	public String createUser(Model m, @ModelAttribute("join") UserVO user,
			@RequestParam("imagefile") MultipartFile mfile, HttpServletRequest req) {
		
		String filename = mfile.getOriginalFilename();
		UUID uid = UUID.randomUUID();
		String ustr = uid.toString();

		String upfile = ustr + "_" + filename;

		long fsize = mfile.getSize();// ���ε� ���� ũ��

		ServletContext application = req.getServletContext();
		String upDir = application.getRealPath("/profileimage");

		log.info("upDir=" + upDir);

		try {
			if (!mfile.isEmpty()) {
				mfile.transferTo(new File(upDir, upfile));

				user.setImagename(upfile);

				log.info("���� ���ε� ����");
			}
		} catch (Exception e) {
			log.error("���� ���ε� ����: " + e.getMessage());
		}

		int n = userService.createUser(user);
		String str = (n > 0) ? "ȸ�� ���� ����" : "ȸ�� ���� ����";
		String loc = (n > 0) ? "home" : "javascript:history.back()";
		
		m.addAttribute("message", str);
		m.addAttribute("loc", loc);
		
		return "message";
	}
}
