package com.thinkgem.jeesite.modules.cms.entity;

import java.util.Date;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.sys.entity.User;

/**
 * 数据添加
 * @author cofe
 *
 */
public class DataStatistics extends DataEntity<DataStatistics>{

	private static final long serialVersionUID = 1L;
	private Date beginTime;
	private Date endTime;
	private int paperNum;
	private int papSimNum;
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
	public int getPaperNum() {
		return paperNum;
	}
	public void setPaperNum(int paperNum) {
		this.paperNum = paperNum;
	}
	public int getPapSimNum() {
		return papSimNum;
	}
	public void setPapSimNum(int papSimNum) {
		this.papSimNum = papSimNum;
	}
	
	
}
