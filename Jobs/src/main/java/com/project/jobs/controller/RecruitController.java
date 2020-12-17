package com.project.jobs.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
import com.project.jobs.domain.RecruitVO;
import com.project.jobs.service.RecruitService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class RecruitController {
	
	@Autowired
	private RecruitService recruitservice;
	
	@Inject
	private CommonUtil util;

	/** 채용정보*/
	@GetMapping("/recruitlist")
	public String recruitlist(Model m, @RequestParam(value="cpage", defaultValue="1") int cpage , @RequestParam(value="searchtype", defaultValue="") String searchtype 
			, @RequestParam(value="searchkeyword", defaultValue="") String searchkeyword) {
		System.out.println("recruitlist요청 들어옴");
		
		Map<String, String> map = new HashMap<>();

		map.put("searchtype", searchtype);
		map.put("searchkeyword", searchkeyword);
		
		int totalCount=recruitservice.getTotalCount(map);
		
		int pageSize=4;
		
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
		
		int pagingBlock=5;
		int prevBlock=(cpage-1)/pagingBlock*pagingBlock;
		int nextBlock=prevBlock+(pagingBlock+1);
		
		
		int firstCount=1;
		int lastCount=0;
		if(totalCount%pageSize!=0) {
			lastCount=(totalCount/pageSize)+1;
		} else {
			lastCount=totalCount/pageSize;
		}
		
		map.put("start", String.valueOf(start));
		map.put("end", String.valueOf(end));
		
		List<RecruitVO> arr = this.recruitservice.listRecruit(map);//왼쪽 리스트
		List<RecruitVO> arr2 = this.recruitservice.selectRecruitTop5();//조회수 top5
		List<RecruitVO> arr3 = this.recruitservice.selectCount();//카테고리
		
		m.addAttribute("recruitArr",arr);
		m.addAttribute("recruitArr2",arr2);
		m.addAttribute("recruitArr3",arr3);
		m.addAttribute("totalCount", totalCount);
		m.addAttribute("pageCount", pageCount);
		m.addAttribute("cpage", cpage);
		m.addAttribute("pagingBlock", pagingBlock);
		m.addAttribute("prevBlock", prevBlock);
		m.addAttribute("nextBlock", nextBlock);
		m.addAttribute("firstCount", firstCount);
		m.addAttribute("lastCount", lastCount);
		return "recruit/recruitlist";
	}
	
	/** 채용정보 글쓰기 클릭할때*/
	@GetMapping("/recruitwrite")
	public String recruitwrite(Model m) {
		System.out.println("recruitwrite요청 들어옴");
		return "recruit/recruitwrite";
	}
	
	/** 채용정보 폼 작성후 등록할때*/
	@PostMapping("/recruitwrite")
	public String recruitwrite(Model m, @ModelAttribute("recruit") RecruitVO recruit, 
			@RequestParam("recruitfile") MultipartFile mfile, HttpServletRequest req) {
		System.out.println("recruitwrite요청 들어옴");
		String filename=mfile.getOriginalFilename();
		UUID uid=UUID.randomUUID();
		String ustr=uid.toString();

		String upfile=ustr+"_"+filename;
		
		long filesize=mfile.getSize();
		
		ServletContext application=req.getServletContext();
		
		String upDir=application.getRealPath("/upload");
		
		log.info("upDir="+upDir);
		
		try {
			if(!mfile.isEmpty()) {
				mfile.transferTo(new File(upDir, upfile));

				recruit.setFilename(upfile);
				recruit.setFilesize(filesize);

				log.info("파일 업로드 성공");
			}
		} catch (Exception e) {
			log.error("파일 업로드 실패: "+e.getMessage());
		}
		
		int n=recruitservice.insertRecruit(recruit);
		String str=(n>0)? "작성을 완료했습니다.":"작성을 실패했습니다.";
		String loc=(n>0)? "recruitlist":"javascript:history.back()";
		m.addAttribute("message",str);
		m.addAttribute("loc",loc);
		return "message";
		
	}
	
	/** 채용정보 게시글보기*/
	@GetMapping("/recruitview")
	public String recruitview(Model m,@RequestParam(defaultValue="0") int num) {
		
		System.out.println("recruitview요청 들어옴");
		if(num==0) {
			return util.addMsgBack(m, "잘못 들어온 경로입니다.");
		}

		boolean bool=this.recruitservice.updateReadnum(num);
		RecruitVO recruit = this.recruitservice.selectByNum(num);
		
		/*viewFname에서 uuid없애기*/
		if (recruit.getFilename()!=null) {
			String filename = null;
			int i=recruit.getFilename().lastIndexOf("_");
			String Fname=recruit.getFilename();
			filename=Fname.substring(i+1);
			recruit.setViewFname(filename);
		}
		
		m.addAttribute("recruitinfoArr",recruit);
		
		return "recruit/recruitview";
	}
	
	/** 채용정보 글 삭제*/
	@PostMapping("/recruitdelete")
	public String recruitdelete(Model m, @RequestParam(defaultValue="0") int num) {
		
		System.out.println("recruitdelete요청 들어옴");
		
		if(num==0) {
			return util.addMsgBack(m, "잘못 들어온 경로입니다.");
		}
		
		int n = this.recruitservice.deleteRecruit(num);
		String str=(n>0)? "삭제를 완료했습니다.":"삭제를 실패했습니다.";
		String loc=(n>0)? "recruitlist":"javascript:history.back()";
		m.addAttribute("message",str);
		m.addAttribute("loc",loc);
		
		return "message";
	}
	
	/** 채용정보 글 수정폼 띄우기*/
	@PostMapping("/recruitupdate")
	public String recruitupdate(Model m, @RequestParam(defaultValue="0") int num) {
	
		System.out.println("recruitupdate요청 들어옴");
		if(num==0) {
			return util.addMsgBack(m, "잘못 들어온 경로입니다.");
		}

		RecruitVO recruit = this.recruitservice.selectByNum(num);
		
		/*viewFname에서 uuid없애기*/
		if (recruit.getFilename()!=null) {
			String filename = null;
			int i=recruit.getFilename().lastIndexOf("_");
			String Fname=recruit.getFilename();
			filename=Fname.substring(i+1);
			recruit.setViewFname(filename);
		}
		
		m.addAttribute("recruitinfoArr",recruit);
		
		return "recruit/recruitupdate";
	}
	
	/** 채용정보 글 수정 완료*/
	@PostMapping("/recruitupdatecomplete")
	public String recruitupdatecomplete(Model m, @ModelAttribute("recruit") RecruitVO recruit, 
			@RequestParam(value="recruitfile") MultipartFile mfile, HttpServletRequest req) {

		String filename=mfile.getOriginalFilename();
		int n=0;
		
		if(filename!="") { //글 수정시 파일 첨부 했을때
			UUID uid=UUID.randomUUID();
			String ustr=uid.toString();
	
			String upfile=ustr+"_"+filename;
			
			long filesize=mfile.getSize();
			
			ServletContext application=req.getServletContext();
			
			String upDir=application.getRealPath("/upload");
			
			log.info("upDir="+upDir);
			
			try {
				if(!mfile.isEmpty()) {
					mfile.transferTo(new File(upDir, upfile));
	
					recruit.setFilename(upfile);
					recruit.setFilesize(filesize);
	
					log.info("파일 업로드 성공");
				}
			} catch (Exception e) {
				log.error("파일 업로드 실패: "+e.getMessage());
			}
			n=recruitservice.updateRecruitF(recruit);
		} else { //글 수정시 파일 첨부 안했을때
			n=recruitservice.updateRecruit(recruit);
		}
		String str=(n>0)? "작성을 완료했습니다.":"작성을 실패했습니다.";
		String loc=(n>0)? "recruitlist":"javascript:history.back()";
		m.addAttribute("message",str);
		m.addAttribute("loc",loc);
		return "message";
	}
	
	/** 카테고리 관련*/
	@GetMapping("/recruitcategory")
	public String recruitcategory(Model m, @RequestParam("type") String type, @RequestParam("career") String career) {
		
		System.out.println("recruitcategory요청 들어옴");
		
		List<RecruitVO> arr=null;
		String colname="";
		
		if(career=="") {//type만 받아올경우
			colname="type";
			arr = this.recruitservice.selectCategory(colname, type);//왼쪽 리스트
		}
		if(type=="") {//career만 받아올경우
			colname="career";
			arr = this.recruitservice.selectCategory(colname, career);//왼쪽 리스트
		}
		List<RecruitVO> arr2 = this.recruitservice.selectRecruitTop5();//조회수 top5
		List<RecruitVO> arr3 = this.recruitservice.selectCount();//카테고리
		m.addAttribute("recruitArr",arr);
		m.addAttribute("recruitArr2",arr2);
		m.addAttribute("recruitArr3",arr3);
		return "recruit/recruitlist";
	}
}
