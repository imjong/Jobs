package com.project.jobs.controller;

import java.io.File;
import java.net.URLEncoder;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.core.io.FileSystemResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.extern.log4j.Log4j;


@Controller("fileController")
@Log4j
public class FileController {

	/** 첨부파일 다운받을때*/
	@RequestMapping(value="/fileDown", produces=MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> download(HttpServletRequest req,@RequestHeader("User-Agent")String userAgent,
			@RequestParam("fname") String fname){
		ServletContext app=req.getServletContext();
		String upDir=app.getRealPath("/upload");
		String path=upDir+File.separator+fname;
		FileSystemResource resource=new FileSystemResource(path);
		String downFname = null;
		if(!resource.exists()) {
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		boolean checkIE=(userAgent.indexOf("MSIE"))>-1 ||userAgent.indexOf("Trident")>-1;

		try {
			//IE인경우
			if(checkIE) {
				downFname=URLEncoder.encode(fname,"UTF8").replaceAll("\\+", " ");
				int i=downFname.lastIndexOf("_");
				downFname=downFname.substring(i+1);
			}else {
				//그외 인경우
				downFname=new String(fname.getBytes("UTF-8"),"ISO-8859-1");
				int i=downFname.lastIndexOf("_");
				downFname=downFname.substring(i+1);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-Disposition", "attachment; filename="+downFname);
		ResponseEntity entity = new ResponseEntity(resource,headers,HttpStatus.OK);
		return entity;
	}

}
