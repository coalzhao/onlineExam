package com.thinkgem.jeesite.modules.cms.entity;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 用户模块答题详情Entity
 * @author SunJiaMing
 * @version 2018-01-05
 */
public class ModuleAnswer extends DataEntity<ModuleAnswer> {
	
	private static final long serialVersionUID = 1L;
	private int maId;//唯一标记
	private String userId;// 用户id
	private String moduleId;// 模块id
	private String userSubject;// 已答试题
	private String userOptions;    //用户选择的选项
	private String correct;    //判断结果是否正确
	
	private List<Subject> moduleSubjectList;
	
	public String getUserSubject() {
		return userSubject;
	}
	public void setUserSubject(String userSubject) {
		this.userSubject = userSubject;
	}
	public String getUserOptions() {
		return userOptions;
	}
	public void setUserOptions(String userOptions) {
		this.userOptions = userOptions;
	}
	public String getCorrect() {
		return correct;
	}
	public void setCorrect(String correct) {
		this.correct = correct;
	}
	public ModuleAnswer() {
		super();
	}
	public ModuleAnswer(String moduleId) {
		super();
		this.moduleId = moduleId;
	}
	public int getMaId() {
		return maId;
	}

	public void setMaId(int maId) {
		this.maId = maId;
	}

	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getModuleId() {
		return moduleId;
	}
	public void setModuleId(String moduleId) {
		this.moduleId = moduleId;
	}
	public List<Subject> getModuleSubjectList() {
		return moduleSubjectList;
	}
	public void setModuleSubjectList(List<Subject> moduleSubjectList) {
		this.moduleSubjectList = moduleSubjectList;
	}
	
}
