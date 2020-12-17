package com.project.jobs.domain;

import java.io.Serializable;
import java.util.Date;

import lombok.Data;

@Data
public class RecruitVO implements Serializable{
	
	private int rn;
	private int num;
	private String type;
	private String career;
	private String subject;
	private String content;
	private Date wdate;
	private int readnum;
	private String filename;
	private String oldFilename;
	private long filesize;
	private int idx_fk;
	private String viewFname;//뷰페이지 에서 보여질 파일 이름
	
	private int totalcount;
	private int type1;
	private int type2;
	private int type3;
	private int career1;
	private int career2;
	private int career3;
	
	//user table과 join했을때 쓸 vo
	private int idx;
	private String userid;
	private String pwd;
	private String epwd;
	private String name;
	private String imagename;
	private String info;
	private int state;
	private Date indate;
}
