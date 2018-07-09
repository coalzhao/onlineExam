package com.thinkgem.jeesite.modules.cms.entity;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 题目数据统计
 * @author cofe
 *
 */
public class SubjectData extends DataEntity<SubjectData>{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private SubjectRoot subjectRoot;
	private int subNum;
	
	public int getSubNum() {
		return subNum;
	}
	public void setSubNum(int subNum) {
		this.subNum = subNum;
	}
	public SubjectRoot getSubjectRoot() {
		return subjectRoot;
	}
	public void setSubjectRoot(SubjectRoot subjectRoot) {
		this.subjectRoot = subjectRoot;
	}
	
	
}
