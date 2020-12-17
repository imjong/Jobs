package com.project.jobs.domain;

import java.io.Serializable;
import java.util.Date;

import lombok.Data;

@Data
public class UserVO implements Serializable {
	private int rn;
	private int idx;
	private String userid;
	private String pwd;
	private String epwd;
	private String name;
	private String imagename;
	private String info;
	private int state;
	private Date indate;
	private Date outdate;
}
