package com.thinkgem.jeesite.modules.cms.entity;

import java.util.Date;
import java.util.List;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.sys.entity.User;
/**
 * 试卷Entity
 * @author ThinkGem
 * @version 2013-05-15
 */
public class Paper extends DataEntity<Paper>{

	private static final long serialVersionUID = 1L;
	private Date beginTime; //考试开始时间
	private Date endTime; //考试结束时间
	private String paperName; //试卷名称
	private int paperScore;  //试卷总分
	private String paperStatus;//试卷状态
	private int paperDuration;//考试时长
	private int radioNumber;//单选题个数
	private int multipleNumber;//多选题个数
	private String simulate;//是否为模拟试卷
	
	private int radioScore;//单选分值
	private int multipleScore;//多选分值
	
	private User user;  
	private List<Subject> subList;
	private List<SubjectRoot> subRootList;
	
	public Paper() {
		super();
		this.paperStatus="0";
	}
	
	public String getSimulate() {
		return simulate;
	}
	public void setSimulate(String simulate) {
		this.simulate = simulate;
	}
	public int getRadioNumber() {
		return radioNumber;
	}
	public void setRadioNumber(int radioNumber) {
		this.radioNumber = radioNumber;
	}
	public int getMultipleNumber() {
		return multipleNumber;
	}
	public void setMultipleNumber(int multipleNumber) {
		this.multipleNumber = multipleNumber;
	}
	public Date getBeginTime() {
		return beginTime;
	}
	public void setBeginTime(Date beginTime) {
		this.beginTime = beginTime;
	}
	public Date getEndTime() {
		return endTime;
	}
	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	public String getPaperName() {
		return paperName;
	}
	public void setPaperName(String paperName) {
		this.paperName = paperName;
	}
	public int getPaperScore() {
		return paperScore;
	}
	public void setPaperScore(int paperScore) {
		this.paperScore = paperScore;
	}
	public String getPaperStatus() {
		return paperStatus;
	}
	public void setPaperStatus(String paperStatus) {
		this.paperStatus = paperStatus;
	}
	public int getPaperDuration() {
		return paperDuration;
	}
	public void setPaperDuration(int paperDuration) {
		this.paperDuration = paperDuration;
	}
	public int getRadioScore() {
		return radioScore;
	}
	public void setRadioScore(int radioScore) {
		this.radioScore = radioScore;
	}
	public int getMultipleScore() {
		return multipleScore;
	}
	public void setMultipleScore(int multipleScore) {
		this.multipleScore = multipleScore;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public List<Subject> getSubList() {
		return subList;
	}
	public void setSubList(List<Subject> subList) {
		this.subList = subList;
	}
	public List<SubjectRoot> getSubRootList() {
		return subRootList;
	}
	public void setSubRootList(List<SubjectRoot> subRootList) {
		this.subRootList = subRootList;
	}


}
