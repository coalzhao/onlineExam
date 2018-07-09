package com.thinkgem.jeesite.modules.cms.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.cms.dao.ScoreDetailDao;
import com.thinkgem.jeesite.modules.cms.entity.ScoreDetail;

/**
 * 成绩详情Service
 * @author ThinkGem
 * @version 2013-05-15
 */
@Service
@Transactional(readOnly = true)
public class ScoreDetailService extends CrudService<ScoreDetailDao,ScoreDetail>{

	public List<ScoreDetail> findscoreDetail(String uid) {
		return dao.findscoreDetail(uid);
	}
	//判断用户是否已经答过该题目，防止恶意刷新，重复提交数据
	/*public String isAnswered(String id, String subId, String userId) {
		return dao.isAnswered(id,subId,userId);
	}*/
	public String isAnswered(ScoreDetail scoreDetail) {
		return dao.isAnswered(scoreDetail);
	}
	//当数据存在时，执行更新
	@Transactional(readOnly = false)
	public void updateScoreDetail(ScoreDetail scoreDetail) {
		// TODO Auto-generated method stub
		 dao.updateScoreDetail(scoreDetail);
	}
	public List<ScoreDetail> getByUserAndPaper(String userId, String id) {
		// TODO Auto-generated method stub
		return dao.getByUserAndPaper(userId, id);
	}
	/*public String getSubId(String id, int num) {  //通过试卷id和桥表中的顺序来获得该题目的id
		// TODO Auto-generated method stub
		return dao.getSubId(id,num);
	}*/
	public int getSubNum(String id) {  //通过试卷id获取该试卷中共有多少道题目
		// TODO Auto-generated method stub
		return dao.getSubNum(id);
	}
	public int getSinCount(String userId, String id, String type, char result) {
		// TODO Auto-generated method stub 
		return dao.getSinCount(userId,id,type,result);  //获取用户成绩详情中单选题正确的个数
	}
	public int getMulCount(String userId, String id, String type, char result) {
		// TODO Auto-generated method stub
		return dao.getMulCount(userId,id,type,result);  //获取用户成绩详情中多选题正确的个数
	}

	public int judgePaper(String userId, String id) { //判断考生是否已经选过试卷
		// TODO Auto-generated method stub 
		return dao.judgePaper(userId,id);
	}
	

	

	
}
