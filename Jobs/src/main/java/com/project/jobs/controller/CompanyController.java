package com.project.jobs.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.project.jobs.domain.UserVO;
import com.project.jobs.service.UserService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class CompanyController {
	
	@Autowired
	private UserService userService;
	
	/** 기업정보*/
	@GetMapping("/companylist")
	public String companylist(Model m, @RequestParam(value="cpage", defaultValue="1") int cpage , @RequestParam(value="search", defaultValue="") String search) {
		System.out.println("companylist요청 들어옴");
		
		/*총 게시물수 구하기*/
		int totalCount=userService.getTotalCount(search);//검색어
		
		int pageSize=5;//한페이지에 5개씩
		
		//페이지수 구하기
		int pageCount=(totalCount-1)/pageSize+1;
		
		if(cpage<=0) {
			cpage=1;
		}
		if(cpage>pageCount) {
			if(pageCount==0) {
				cpage=1;
				pageCount=1;
			}else {
			cpage=pageCount;
			}
		}
		int end=cpage*pageSize;
		int start=end-(pageSize-1);
		
		int pagingBlock=5;//5개 단위로 페이지 묶음 처리
		int prevBlock=(cpage-1)/pagingBlock*pagingBlock;
		int nextBlock=prevBlock+(pagingBlock+1);
		
		
		int firstCount=1;
		int lastCount=0;
		if(totalCount%pageSize!=0) {
			lastCount=(totalCount/pageSize)+1;
		} else {
			lastCount=totalCount/pageSize;
		}
				
		//-map
		Map<String, String> map = new HashMap<>();
		map.put("search", search);
		map.put("start", String.valueOf(start));
		map.put("end", String.valueOf(end));
		
		/*기업 정보 다 불러올때*/
		List<UserVO> arr = this.userService.getCompany(map);
		m.addAttribute("companyArr",arr);
		m.addAttribute("totalCount", totalCount);
		m.addAttribute("pageCount", pageCount);
		m.addAttribute("cpage", cpage);
		m.addAttribute("pagingBlock", pagingBlock);
		m.addAttribute("prevBlock", prevBlock);
		m.addAttribute("nextBlock", nextBlock);
		m.addAttribute("firstCount", firstCount);
		m.addAttribute("lastCount", lastCount);
		return "company/companylist";
	}
	
	/** 해당 기업정보를 클릭할때 기업정보 보기*/
	@GetMapping("/companyview")
	public String companyview(Model m,@RequestParam(defaultValue="0") int idx) {
		
		System.out.println("companyview요청 들어옴");
		if(idx==0) {
			
			return "redirect:index";
		}

		UserVO company = this.userService.selectByNum(idx);
		
		m.addAttribute("companyinfoArr",company);
		
		return "company/companyview";
	}

}
