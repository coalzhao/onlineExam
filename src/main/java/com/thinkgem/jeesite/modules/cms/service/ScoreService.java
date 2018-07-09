package com.thinkgem.jeesite.modules.cms.service;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.cms.dao.ScoreDao;
import com.thinkgem.jeesite.modules.cms.entity.Score;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
/**
 * 成绩Service
 * @author ThinkGem
 * @version 2013-05-15
 */
@Service
@Transactional(readOnly = true)
public class ScoreService extends CrudService<ScoreDao,Score>{
	@Autowired
	private ScoreDao scoreDao;
	
	@Transactional(readOnly = false)
	public Page<Score> findPage(Page<Score> page, Score score) {
		return super.findPage(page, score);
	}
	@Transactional(readOnly = false)
	public void save(Score score) {
		score.setUpdateBy(UserUtils.getUser());//获取当前用户并设置为更新用户
		score.setUpdateDate(new Date());//获取系统时间并是设置为更新时间
		score.setCreateDate(score.getUpdateDate());
		if (StringUtils.isBlank(score.getId())){
			score.preInsert();
			dao.insert(score);
		}else{
			score.preUpdate();
			dao.update(score);
		}
	}
	@Transactional(readOnly = false)
	public Score findScoreById(String id) {
		// TODO Auto-generated method stub
		return dao.findScoreById(id);
	}
	@Transactional(readOnly = false)
	public void updateScore(Score score) {
		// TODO Auto-generated method stub
		dao.updateScore(score);
	}
	@Transactional(readOnly = false)
	public void deleteScore(Score score) {
		// TODO Auto-generated method stub
		dao.deleteScore(score);
	}
	
	
	public String getPaperName(String id) {
		// TODO Auto-generated method stub
		return dao.getPaperName(id);
	}
	public String isCommit(Score score) {  //判断该用户的成绩是否存在
		// TODO Auto-generated method stub
		return dao.isCommit(score);
	}
	@Transactional(readOnly = false)
	public void upScore(Score score) {
		// TODO Auto-generated method stub
		dao.upScore(score);
	}
	public Score getPersonScore(String uid, String pid) {
		// TODO Auto-generated method stub 
		return dao.getPersonScore(uid,pid);
	}
	public String judge(String uid, String id) { //判断是否答过改试卷
		// TODO Auto-generated method stub
		return dao.judge(uid,id);
	}
	public String getUserName(String id) {
		// TODO Auto-generated method stub
		return dao.getUserName(id);
	}
}













