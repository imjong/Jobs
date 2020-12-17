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
import com.project.jobs.domain.JobhunterVO;
import com.project.jobs.domain.RecruitVO;
import com.project.jobs.service.JobhunterService;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class JobhunterController {
	
	@Autowired
	private JobhunterService jobhunterservice;
	
	@Inject
	private CommonUtil util;
	
	/** 인재등록*/
	@GetMapping("/jobhunterregister")
	public String jobhunterwrite(Model m) {
		System.out.println("jobhunterwrite요청 들어옴");
		return "jobhunter/jobhunterwrite";
	}
	
	/** 인재등록에 폼작성 완료후 등록할때*/
	@PostMapping("/jobhunterwrite")
	public String jobhunterwrite(Model m, @ModelAttribute("jobhunter") JobhunterVO jobhunter,
			@RequestParam("jobhunterfile") MultipartFile mfile, HttpServletRequest req) {
		System.out.println("jobhunterwrite요청 들어옴");
		String filename=mfile.getOriginalFilename();
		UUID uid=UUID.randomUUID();
		String ustr=uid.toString();
		
		String upfile=ustr+"_"+filename;
		
		long filesize=mfile.getSize();
		
		ServletContext application=req.getServletContext();
		
		String upDir=application.getRealPath("/upload");
			
		try {
			if(!mfile.isEmpty()) {
				mfile.transferTo(new File(upDir, upfile)); 
				
				jobhunter.setFilename(upfile);
				jobhunter.setFilesize(filesize);
				
				log.info("파일 업로드 성공");
			}
		} catch (Exception e) {
			log.error("파일 업로드 실패: "+e.getMessage());
		}
		
		int n=jobhunterservice.insertJobhunter(jobhunter);
		String str=(n>0)? "작성을 완료했습니다.":"작성을 실패했습니다.";
		String loc=(n>0)? "jobhunterlist":"javascript:history.back()";
		m.addAttribute("message",str);
		m.addAttribute("loc",loc);
		return "message";
		
	}
	
	/** 인재 정보*/
	@GetMapping("/jobhunterlist")
	public String jobhunterlist(Model m, @RequestParam(value="cpage", defaultValue="1") int cpage , @RequestParam(value="searchtype", defaultValue="") String searchtype 
			, @RequestParam(value="searchkeyword", defaultValue="") String searchkeyword) {
		System.out.println("jobhunterlist요청 들어옴");
		
		Map<String, String> map = new HashMap<>();

		map.put("searchtype", searchtype);
		map.put("searchkeyword", searchkeyword);
		
		int totalCount=jobhunterservice.getTotalCount(map);
		
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
		
		List<JobhunterVO> arr = this.jobhunterservice.listJobhunter(map);//왼쪽 리스트
		List<JobhunterVO> arr2 = this.jobhunterservice.selectJobhunterTop5();//조회수 top5
		List<JobhunterVO> arr3 = this.jobhunterservice.selectCount();//카테고리
		m.addAttribute("jobhunterArr",arr);
		m.addAttribute("jobhunterArr2",arr2);
		m.addAttribute("jobhunterArr3",arr3);
		m.addAttribute("totalCount", totalCount);
		m.addAttribute("pageCount", pageCount);
		m.addAttribute("cpage", cpage);
		m.addAttribute("pagingBlock", pagingBlock);
		m.addAttribute("prevBlock", prevBlock);
		m.addAttribute("nextBlock", nextBlock);
		m.addAttribute("firstCount", firstCount);
		m.addAttribute("lastCount", lastCount);
		return "jobhunter/jobhunterlist";
	}
	
	/** 인재정보 게시글보기*/
	@GetMapping("/jobhunterview")
	public String jobhunterview(Model m,@RequestParam(defaultValue="0") int num) {
		
		System.out.println("jobhunterview요청 들어옴");
		if(num==0) {
			return util.addMsgBack(m, "잘못 들어온 경로입니다.");
		}

		boolean bool=this.jobhunterservice.updateReadnum(num);
		JobhunterVO jobhunter = this.jobhunterservice.selectByNum(num);
		
		/*viewFname에서 uuid없애기*/
		if (jobhunter.getFilename()!=null) {
			String filename = null;
			int i=jobhunter.getFilename().lastIndexOf("_");
			String Fname=jobhunter.getFilename();
			filename=Fname.substring(i+1);
			jobhunter.setViewFname(filename);
		}
		
		m.addAttribute("jobhunterinfoArr",jobhunter);
		
		return "jobhunter/jobhunterview";
	}
	
	/** 인재정보 글 삭제*/
	@PostMapping("/jobhunterdelete")
	public String jobhunterdelete(Model m, @RequestParam(defaultValue="0") int num) {
		
		System.out.println("jobhunterdelete요청 들어옴");
		
		if(num==0) {
			return util.addMsgBack(m, "잘못 들어온 경로입니다.");
		}
		
		int n = this.jobhunterservice.deleteJobhunter(num);
		String str=(n>0)? "삭제를 완료했습니다.":"삭제를 실패했습니다.";
		String loc=(n>0)? "jobhunterlist":"javascript:history.back()";
		m.addAttribute("message",str);
		m.addAttribute("loc",loc);
		
		return "message";
	}
	
	/** 채용정보 글 수정폼 띄우기*/
	@PostMapping("/jobhunterupdate")
	public String jobhunterupdate(Model m, @RequestParam(defaultValue="0") int num) {
		
		System.out.println("jobhunterupdate요청 들어옴");
		if(num==0) {
			return util.addMsgBack(m, "잘못 들어온 경로입니다.");
		}
		


		JobhunterVO jobhunter = this.jobhunterservice.selectByNum(num);
		
		/*viewFname에서 uuid없애기*/
		if (jobhunter.getFilename()!=null) {
			String filename = null;
			int i=jobhunter.getFilename().lastIndexOf("_");
			String Fname=jobhunter.getFilename();
			filename=Fname.substring(i+1);
			jobhunter.setViewFname(filename);
		}
		
		m.addAttribute("jobhunterinfoArr",jobhunter);
		
		return "jobhunter/jobhunterupdate";
	}
	
	/** 채용정보 글 수정 완료*/
	@PostMapping("/jobhunterupdatecomplete")
	public String jobhunterupdatecomplete(Model m, @ModelAttribute("jobhunter") JobhunterVO jobhunter, 
			@RequestParam(value="jobhunterfile") MultipartFile mfile, HttpServletRequest req) {

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
	
					jobhunter.setFilename(upfile);
					jobhunter.setFilesize(filesize);
	
					log.info("파일 업로드 성공");
				}
			} catch (Exception e) {
				log.error("파일 업로드 실패: "+e.getMessage());
			}
			n=jobhunterservice.updateJobhunterF(jobhunter);
		} else { //글 수정시 파일 첨부 안했을때
			n=jobhunterservice.updateJobhunter(jobhunter);
		}
		String str=(n>0)? "작성을 완료했습니다.":"작성을 실패했습니다.";
		String loc=(n>0)? "jobhunterlist":"javascript:history.back()";
		m.addAttribute("message",str);
		m.addAttribute("loc",loc);
		return "message";
	}
	
	/** 카테고리 관련*/
	@GetMapping("/jobhuntercategory")
	public String jobhuntercategory(Model m, @RequestParam("type") String type, @RequestParam("career") String career) {
		
		System.out.println("jobhuntercategory요청 들어옴");
		
		List<JobhunterVO> arr=null;
		String colname="";
		
		if(career=="") {//type만 받아올경우
			colname="type";
			arr = this.jobhunterservice.selectCategory(colname, type);//왼쪽 리스트
		}
		if(type=="") {//career만 받아올경우
			colname="career";
			arr = this.jobhunterservice.selectCategory(colname, career);//왼쪽 리스트
		}
		List<JobhunterVO> arr2 = this.jobhunterservice.selectJobhunterTop5();//조회수 top5
		List<JobhunterVO> arr3 = this.jobhunterservice.selectCount();//카테고리
		m.addAttribute("jobhunterArr",arr);
		m.addAttribute("jobhunterArr2",arr2);
		m.addAttribute("jobhunterArr3",arr3);
		return "jobhunter/jobhunterlist";
	}
	
	/** 본인이 작성한 글*/
	@GetMapping("/jobhunterlistme")
	public String jobhunterlistme(Model m, @RequestParam(value="userid", defaultValue="") String userid) {
		
		System.out.println("jobhunterlistme요청 들어옴");
		
		List<JobhunterVO> arr = this.jobhunterservice.listJobhunterMe(userid);

		m.addAttribute("jobhunterArr",arr);
		return "jobhunter/jobhunterlistme";
	}
	
}
