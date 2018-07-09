package com.thinkgem.jeesite.modules.cms.dao;

import org.apache.ibatis.annotations.Param;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.cms.entity.Score;
/**
 * 成绩DAO接口
 * @author ThinkGem
 * @version 2013-8-23
 */
@MyBatisDao
public interface ScoreDao extends CrudDao<Score>{

	Score findScoreById(String id);

	void updateScore(Score score);

	void deleteScore(Score score);

	void addScore(Score score);

	String getPaperName(String id);

	String isCommit(Score score);//判断该用户的成绩是否存在   

	void upScore(Score score);//如果该用户成绩已存在，则更新 

	Score getPersonScore(@Param("uid") String uid,@Param("pid") String pid);

	String judge(@Param("uid") String uid,@Param("id") String id);

	String getUserName(String id);

	
}
