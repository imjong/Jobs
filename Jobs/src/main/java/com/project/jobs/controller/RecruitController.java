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

	/** ä������*/
	@GetMapping("/recruitlist")
	public String recruitlist(Model m, @RequestParam(value="cpage", defaultValue="1") int cpage , @RequestParam(value="searchtype", defaultValue="") String searchtype 
			, @RequestParam(value="searchkeyword", defaultValue="") String searchkeyword) {
		System.out.println("recruitlist��û ����");
		
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
		
		List<RecruitVO> arr = this.recruitservice.listRecruit(map);//���� ����Ʈ
		List<RecruitVO> arr2 = this.recruitservice.selectRecruitTop5();//��ȸ�� top5
		List<RecruitVO> arr3 = this.recruitservice.selectCount();//ī�װ�
		
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
	
	/** ä������ �۾��� Ŭ���Ҷ�*/
	@GetMapping("/recruitwrite")
	public String recruitwrite(Model m) {
		System.out.println("recruitwrite��û ����");
		return "recruit/recruitwrite";
	}
	
	/** ä������ �� �ۼ��� ����Ҷ�*/
	@PostMapping("/recruitwrite")
	public String recruitwrite(Model m, @ModelAttribute("recruit") RecruitVO recruit, 
			@RequestParam("recruitfile") MultipartFile mfile, HttpServletRequest req) {
		System.out.println("recruitwrite��û ����");
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

				log.info("���� ���ε� ����");
			}
		} catch (Exception e) {
			log.error("���� ���ε� ����: "+e.getMessage());
		}
		
		int n=recruitservice.insertRecruit(recruit);
		String str=(n>0)? "�ۼ��� �Ϸ��߽��ϴ�.":"�ۼ��� �����߽��ϴ�.";
		String loc=(n>0)? "recruitlist":"javascript:history.back()";
		m.addAttribute("message",str);
		m.addAttribute("loc",loc);
		return "message";
		
	}
	
	/** ä������ �Խñۺ���*/
	@GetMapping("/recruitview")
	public String recruitview(Model m,@RequestParam(defaultValue="0") int num) {
		
		System.out.println("recruitview��û ����");
		if(num==0) {
			return util.addMsgBack(m, "�߸� ���� ����Դϴ�.");
		}

		boolean bool=this.recruitservice.updateReadnum(num);
		RecruitVO recruit = this.recruitservice.selectByNum(num);
		
		/*viewFname���� uuid���ֱ�*/
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
	
	/** ä������ �� ����*/
	@PostMapping("/recruitdelete")
	public String recruitdelete(Model m, @RequestParam(defaultValue="0") int num) {
		
		System.out.println("recruitdelete��û ����");
		
		if(num==0) {
			return util.addMsgBack(m, "�߸� ���� ����Դϴ�.");
		}
		
		int n = this.recruitservice.deleteRecruit(num);
		String str=(n>0)? "������ �Ϸ��߽��ϴ�.":"������ �����߽��ϴ�.";
		String loc=(n>0)? "recruitlist":"javascript:history.back()";
		m.addAttribute("message",str);
		m.addAttribute("loc",loc);
		
		return "message";
	}
	
	/** ä������ �� ������ ����*/
	@PostMapping("/recruitupdate")
	public String recruitupdate(Model m, @RequestParam(defaultValue="0") int num) {
	
		System.out.println("recruitupdate��û ����");
		if(num==0) {
			return util.addMsgBack(m, "�߸� ���� ����Դϴ�.");
		}

		RecruitVO recruit = this.recruitservice.selectByNum(num);
		
		/*viewFname���� uuid���ֱ�*/
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
	
	/** ä������ �� ���� �Ϸ�*/
	@PostMapping("/recruitupdatecomplete")
	public String recruitupdatecomplete(Model m, @ModelAttribute("recruit") RecruitVO recruit, 
			@RequestParam(value="recruitfile") MultipartFile mfile, HttpServletRequest req) {

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
	
					recruit.setFilename(upfile);
					recruit.setFilesize(filesize);
	
					log.info("���� ���ε� ����");
				}
			} catch (Exception e) {
				log.error("���� ���ε� ����: "+e.getMessage());
			}
			n=recruitservice.updateRecruitF(recruit);
		} else { //�� ������ ���� ÷�� ��������
			n=recruitservice.updateRecruit(recruit);
		}
		String str=(n>0)? "�ۼ��� �Ϸ��߽��ϴ�.":"�ۼ��� �����߽��ϴ�.";
		String loc=(n>0)? "recruitlist":"javascript:history.back()";
		m.addAttribute("message",str);
		m.addAttribute("loc",loc);
		return "message";
	}
	
	/** ī�װ� ����*/
	@GetMapping("/recruitcategory")
	public String recruitcategory(Model m, @RequestParam("type") String type, @RequestParam("career") String career) {
		
		System.out.println("recruitcategory��û ����");
		
		List<RecruitVO> arr=null;
		String colname="";
		
		if(career=="") {//type�� �޾ƿð��
			colname="type";
			arr = this.recruitservice.selectCategory(colname, type);//���� ����Ʈ
		}
		if(type=="") {//career�� �޾ƿð��
			colname="career";
			arr = this.recruitservice.selectCategory(colname, career);//���� ����Ʈ
		}
		List<RecruitVO> arr2 = this.recruitservice.selectRecruitTop5();//��ȸ�� top5
		List<RecruitVO> arr3 = this.recruitservice.selectCount();//ī�װ�
		m.addAttribute("recruitArr",arr);
		m.addAttribute("recruitArr2",arr2);
		m.addAttribute("recruitArr3",arr3);
		return "recruit/recruitlist";
	}
}
