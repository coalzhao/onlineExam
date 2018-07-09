package com.thinkgem.jeesite.modules.cms.entity;

import com.thinkgem.jeesite.common.persistence.DataEntity;
/**
 * 成绩详情Entity
 * @author ThinkGem
 * @version 2013-05-15
 */
public class ScoreDetail extends DataEntity<ScoreDetail>{

	
	private static final long serialVersionUID = 1L;
	private String userId; //用户id
	private String timuId; //题目id
	private String userAnswer;//用户所选择的答案
	private String relAnswer; //正确答案
	private char result;      //是否正确 'T'为正确，'F'为错误
	private String paperId;    //试卷Id
	private String timuType;  //1为单选题，2为多选题
	
	
	public String getTimuType() {
		return timuType;
	}
	public void setTimuType(String timuType) {
		this.timuType = timuType;
	}
	public String getPaperId() {
		return paperId;
	}
	public void setPaperId(String paperId) {
		this.paperId = paperId;
	}
	public String getRelAnswer() {
		return relAnswer;
	}
	public void setRelAnswer(String relAnswer) {
		this.relAnswer = relAnswer;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getTimuId() {
		return timuId;
	}
	public void setTimuId(String timuId) {
		this.timuId = timuId;
	}
	public String getUserAnswer() {
		return userAnswer;
	}
	public void setUserAnswer(String userAnswer) {
		this.userAnswer = userAnswer;
	}
	public char getResult() {
		return result;
	}
	public void setResult(char result) {
		this.result = result;
	}
	@Override
	public String toString() {
		return "ScoreDetail [timuId=" + timuId + ", userAnswer=" + userAnswer + ", relAnswer=" + relAnswer + ", result=";
	}
	
	
}
