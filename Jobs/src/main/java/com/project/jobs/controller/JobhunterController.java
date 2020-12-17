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
	
	/** ������*/
	@GetMapping("/jobhunterregister")
	public String jobhunterwrite(Model m) {
		System.out.println("jobhunterwrite��û ����");
		return "jobhunter/jobhunterwrite";
	}
	
	/** �����Ͽ� ���ۼ� �Ϸ��� ����Ҷ�*/
	@PostMapping("/jobhunterwrite")
	public String jobhunterwrite(Model m, @ModelAttribute("jobhunter") JobhunterVO jobhunter,
			@RequestParam("jobhunterfile") MultipartFile mfile, HttpServletRequest req) {
		System.out.println("jobhunterwrite��û ����");
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
				
				log.info("���� ���ε� ����");
			}
		} catch (Exception e) {
			log.error("���� ���ε� ����: "+e.getMessage());
		}
		
		int n=jobhunterservice.insertJobhunter(jobhunter);
		String str=(n>0)? "�ۼ��� �Ϸ��߽��ϴ�.":"�ۼ��� �����߽��ϴ�.";
		String loc=(n>0)? "jobhunterlist":"javascript:history.back()";
		m.addAttribute("message",str);
		m.addAttribute("loc",loc);
		return "message";
		
	}
	
	/** ���� ����*/
	@GetMapping("/jobhunterlist")
	public String jobhunterlist(Model m, @RequestParam(value="cpage", defaultValue="1") int cpage , @RequestParam(value="searchtype", defaultValue="") String searchtype 
			, @RequestParam(value="searchkeyword", defaultValue="") String searchkeyword) {
		System.out.println("jobhunterlist��û ����");
		
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
		
		List<JobhunterVO> arr = this.jobhunterservice.listJobhunter(map);//���� ����Ʈ
		List<JobhunterVO> arr2 = this.jobhunterservice.selectJobhunterTop5();//��ȸ�� top5
		List<JobhunterVO> arr3 = this.jobhunterservice.selectCount();//ī�װ�
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
	
	/** �������� �Խñۺ���*/
	@GetMapping("/jobhunterview")
	public String jobhunterview(Model m,@RequestParam(defaultValue="0") int num) {
		
		System.out.println("jobhunterview��û ����");
		if(num==0) {
			return util.addMsgBack(m, "�߸� ���� ����Դϴ�.");
		}

		boolean bool=this.jobhunterservice.updateReadnum(num);
		JobhunterVO jobhunter = this.jobhunterservice.selectByNum(num);
		
		/*viewFname���� uuid���ֱ�*/
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
	
	/** �������� �� ����*/
	@PostMapping("/jobhunterdelete")
	public String jobhunterdelete(Model m, @RequestParam(defaultValue="0") int num) {
		
		System.out.println("jobhunterdelete��û ����");
		
		if(num==0) {
			return util.addMsgBack(m, "�߸� ���� ����Դϴ�.");
		}
		
		int n = this.jobhunterservice.deleteJobhunter(num);
		String str=(n>0)? "������ �Ϸ��߽��ϴ�.":"������ �����߽��ϴ�.";
		String loc=(n>0)? "jobhunterlist":"javascript:history.back()";
		m.addAttribute("message",str);
		m.addAttribute("loc",loc);
		
		return "message";
	}
	
	/** ä������ �� ������ ����*/
	@PostMapping("/jobhunterupdate")
	public String jobhunterupdate(Model m, @RequestParam(defaultValue="0") int num) {
		
		System.out.println("jobhunterupdate��û ����");
		if(num==0) {
			return util.addMsgBack(m, "�߸� ���� ����Դϴ�.");
		}
		


		JobhunterVO jobhunter = this.jobhunterservice.selectByNum(num);
		
		/*viewFname���� uuid���ֱ�*/
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
	
	/** ä������ �� ���� �Ϸ�*/
	@PostMapping("/jobhunterupdatecomplete")
	public String jobhunterupdatecomplete(Model m, @ModelAttribute("jobhunter") JobhunterVO jobhunter, 
			@RequestParam(value="jobhunterfile") MultipartFile mfile, HttpServletRequest req) {

		String filename=mfile.getOriginalFilename();
		int n=0;
		
		if(filename!="") { //�� ������ ���� ÷�� ������
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
	
					log.info("���� ���ε� ����");
				}
			} catch (Exception e) {
				log.error("���� ���ε� ����: "+e.getMessage());
			}
			n=jobhunterservice.updateJobhunterF(jobhunter);
		} else { //�� ������ ���� ÷�� ��������
			n=jobhunterservice.updateJobhunter(jobhunter);
		}
		String str=(n>0)? "�ۼ��� �Ϸ��߽��ϴ�.":"�ۼ��� �����߽��ϴ�.";
		String loc=(n>0)? "jobhunterlist":"javascript:history.back()";
		m.addAttribute("message",str);
		m.addAttribute("loc",loc);
		return "message";
	}
	
	/** ī�װ� ����*/
	@GetMapping("/jobhuntercategory")
	public String jobhuntercategory(Model m, @RequestParam("type") String type, @RequestParam("career") String career) {
		
		System.out.println("jobhuntercategory��û ����");
		
		List<JobhunterVO> arr=null;
		String colname="";
		
		if(career=="") {//type�� �޾ƿð��
			colname="type";
			arr = this.jobhunterservice.selectCategory(colname, type);//���� ����Ʈ
		}
		if(type=="") {//career�� �޾ƿð��
			colname="career";
			arr = this.jobhunterservice.selectCategory(colname, career);//���� ����Ʈ
		}
		List<JobhunterVO> arr2 = this.jobhunterservice.selectJobhunterTop5();//��ȸ�� top5
		List<JobhunterVO> arr3 = this.jobhunterservice.selectCount();//ī�װ�
		m.addAttribute("jobhunterArr",arr);
		m.addAttribute("jobhunterArr2",arr2);
		m.addAttribute("jobhunterArr3",arr3);
		return "jobhunter/jobhunterlist";
	}
	
	/** ������ �ۼ��� ��*/
	@GetMapping("/jobhunterlistme")
	public String jobhunterlistme(Model m, @RequestParam(value="userid", defaultValue="") String userid) {
		
		System.out.println("jobhunterlistme��û ����");
		
		List<JobhunterVO> arr = this.jobhunterservice.listJobhunterMe(userid);

		m.addAttribute("jobhunterArr",arr);
		return "jobhunter/jobhunterlistme";
	}
	
}
