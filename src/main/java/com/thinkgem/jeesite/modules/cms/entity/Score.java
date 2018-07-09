package com.thinkgem.jeesite.modules.cms.entity;

import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.sys.entity.User;
/**
 * 成绩Entity
 * @author ThinkGem
 * @version 2013-05-15
 */
public class Score extends DataEntity<Score>{

	
	private static final long serialVersionUID = 1L;
	
	private String paperName;//试卷名称
	private String userId;  //用户id
	private int sinScore;   //单选题的成绩
	private int mulScore;   //多选题的成绩
	private int time;       //答题所用时长
	private int sumScore;   //总成绩
	private User user;      //当前用户
	private String paperId; //该成绩所属的试卷编号
	private ScoreDetail scoreDetail;
	private String  userName;//考生名字,用于模糊查询
	private String  loginName;//考生的登录名，用于查询
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPaperName() {
		return paperName;
	}
	public void setPaperName(String paperName) {
		this.paperName = paperName;
	}
	public ScoreDetail getScoreDetail() {
		return scoreDetail;
	}
	public void setScoreDetail(ScoreDetail scoreDetail) {
		this.scoreDetail = scoreDetail;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public int getSinScore() {
		return sinScore;
	}
	public void setSinScore(int sinScore) {
		this.sinScore = sinScore;
	}
	public int getMulScore() {
		return mulScore;
	}
	public void setMulScore(int mulScore) {
		this.mulScore = mulScore;
	}
	public int getTime() {
		return time;
	}
	public void setTime(int time) {
		this.time = time;
	}
	public int getSumScore() {
		return sumScore;
	}
	public void setSumScore(int sumScore) {
		this.sumScore = sumScore;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public String getPaperId() {
		return paperId;
	}
	public void setPaperId(String paperId) {
		this.paperId = paperId;
	}
	public String getLoginName() {
		return loginName;
	}
	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}
	
	
}
