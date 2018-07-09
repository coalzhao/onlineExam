package com.thinkgem.jeesite.modules.cms.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.cms.entity.ScoreDetail;

/**
 * 成绩详情DAO接口
 * @author ThinkGem
 * @version 2013-8-23
 */
@MyBatisDao
public interface ScoreDetailDao extends CrudDao<ScoreDetail>{

	List<ScoreDetail> findscoreDetail(String uid);

	//String isAnswered(@Param("id") String id,@Param("subId") String subId,@Param("userId") String userId);
	String isAnswered(ScoreDetail scoreDetail);

	void updateScoreDetail(ScoreDetail scoreDetail);

	List<ScoreDetail> getByUserAndPaper(@Param("userId") String userId,@Param("id") String id);

	//String getSubId(@Param("id") String id,@Param("num") int num);  //通过试卷id和桥表中的顺序来获得该题目的id
 
	int getSubNum(String id);   //通过试卷id获取该试卷中共有多少道题目

	int getSinCount(@Param("userId") String userId,@Param("id") String id,@Param("type") String type,@Param("result") char result);  //获取用户成绩详情中单选题正确的个数

	int getMulCount(@Param("userId") String userId,@Param("id") String id,@Param("type") String type,@Param("result") char result);  //获取用户成绩详情中多选题正确的个数

	int judgePaper(@Param("userId") String userId,@Param("id") String id);  //判断考试选过试卷
	//void addScore(@Param("") int id,@Param("timuid") String timuid,@Param("userAnswer") String userAnswer,@Param("answer") String answer);
	
}
