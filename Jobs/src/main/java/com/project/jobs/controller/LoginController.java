package com.project.jobs.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.project.jobs.common.CommonUtil;
import com.project.jobs.domain.NotUserException;
import com.project.jobs.domain.UserVO;
import com.project.jobs.service.UserService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class LoginController {

	@Inject
	private CommonUtil util;

	@Inject
	private UserService userservice;

	/** �α��� �� �� */
	@PostMapping("/login")
	public String loginEnd(Model m, HttpSession ses, @ModelAttribute("user") UserVO user) throws NotUserException {

		if (user.getUserid() == null || user.getPwd() == null || user.getUserid().trim().isEmpty()
				|| user.getPwd().trim().isEmpty()) {
			return util.addMsgBack(m, "���̵�� ��й�ȣ�� �Է��ϼ���");
		}
		UserVO loginUser = userservice.loginCheck(user);

		String msg = "";
		String loc = "";

		if (loginUser.getState()==4) {
			SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd");
			String outDate = transFormat.format(loginUser.getOutdate());
			msg="Ż���� ȸ���Դϴ�. \\nŻ���� ȸ�������� Ż���� ���� 30�� ���� �����˴ϴ�.\\nȸ��Ż����: "+outDate;
			loc ="logout";
			m.addAttribute("message", msg);
			m.addAttribute("loc", loc);

			return "message3";
		}

		if (loginUser != null) {
			ses.setAttribute("loginUser", loginUser);
			msg = loginUser.getName() + "�� ȯ���մϴ�.";
			loc = "home";
		}

		return util.addMsgLoc(m, msg, loc);
	}

	/** �α׾ƿ� */
	@GetMapping("/logout")
	public String logout(HttpSession ses) {
		ses.invalidate();
		return "redirect:home";
	}

	/** ����ó�� */
	@ExceptionHandler(NotUserException.class)
	public String exceptionHandle(Exception e) {
		log.error(e.getMessage());
		return "login/errorAlert";
	}

	/** ���̹� �α��� */
	@GetMapping("/naverlogin")
	public String naverlogin() {
		return "/naverlogin";
	}

	/** ���̹� �α��� �ݹ��Լ� */
	@RequestMapping(value = "/naverCallback")
	public String naverCallback(Model m, HttpServletRequest request, HttpSession ses) throws Exception {

		String clientId = "XMrFo1wJDQ3i5vG7byts";// ���ø����̼� Ŭ���̾�Ʈ ���̵�";
		String clientSecret = "789X2DHUx5";// ���ø����̼� Ŭ���̾�Ʈ ��ũ����";
		String code = request.getParameter("code");
		String state = request.getParameter("state");
		String redirectURI = URLEncoder.encode("http://0254.duckdns.org:9090/jobs/naverCallback", "UTF-8");
		String apiURL;
		apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code";
		apiURL += "&client_id=" + clientId;
		apiURL += "&client_secret=" + clientSecret;
		apiURL += "&redirect_uri=" + redirectURI;
		apiURL += "&code=" + code;
		apiURL += "&state=" + state;

		String access_token = "";
		String refresh_token = "";

		try {
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			int responseCode = con.getResponseCode();
			BufferedReader br;
			if (responseCode == 200) { // ���� ȣ��
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else { // ���� �߻�
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			String inputLine;
			StringBuffer res = new StringBuffer();
			while ((inputLine = br.readLine()) != null) {
				res.append(inputLine);
			}
			br.close();
			if (responseCode == 200) {
				JsonObject jsonObj = new JsonParser().parse(res.toString()).getAsJsonObject();
				JsonElement jsonEle1 = jsonObj.get("access_token");
				JsonElement jsonEle2 = jsonObj.get("refresh_token");
				access_token = jsonEle1.getAsString();
				refresh_token = jsonEle2.getAsString();
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

		String email = "";
		String name = "";
		String image_src = "";
		String token = access_token; // ���̹� �α��� ���� ��ū
		String header = "Bearer " + token; // Bearer ������ ���� �߰�
		
		try {
			String apiURL2 = "https://openapi.naver.com/v1/nid/me";

			URL url = new URL(apiURL2);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();

			con.setRequestMethod("GET");
			con.setRequestProperty("Authorization", header);
			int responseCode = con.getResponseCode();
			BufferedReader br;
			if (responseCode == 200) { // ���� ȣ��
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else { // ���� �߻�
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			String inputLine;
			StringBuffer response = new StringBuffer();
			while ((inputLine = br.readLine()) != null) {
				response.append(inputLine);
			}
			br.close();

			JsonObject jsonObj1 = new JsonParser().parse(response.toString()).getAsJsonObject();
			JsonObject jsonObj2 = (JsonObject) jsonObj1.get("response");

			JsonElement jsonEle1 = jsonObj2.get("email");
			JsonElement jsonEle2 = jsonObj2.get("name");
			JsonElement jsonEle3 = jsonObj2.get("profile_image");
			
			email = jsonEle1.getAsString();
			name = jsonEle2.getAsString();
			image_src = jsonEle3.getAsString();
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		UserVO loginUser = new UserVO();
		
		loginUser.setUserid(email);
		loginUser.setName(name);
		loginUser.setImagename(image_src);
		loginUser.setState(-1);
		
		ses.setAttribute("loginUser", loginUser);
		
		String msg = loginUser.getName() + "�� ȯ���մϴ�.";
		String loc = "home";
		
		m.addAttribute("message", msg);
		m.addAttribute("loc", loc);

		return "/message";
	}

}
