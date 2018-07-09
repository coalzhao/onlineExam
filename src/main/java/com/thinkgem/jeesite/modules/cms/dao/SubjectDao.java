package com.thinkgem.jeesite.modules.cms.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.cms.entity.Subject;

/**
 * 题目Dao
 * @author SunJiaMing
 * @version 2017-11-28
 */
@MyBatisDao
public interface SubjectDao extends CrudDao<Subject> {

	List<Subject> findByIdIn(String[] ids);
	
	List<Subject> findSubject(@Param("uid") String uid,@Param("paperId") String paperId);

	List<Subject> getSubject();
	
	List<Subject> findRadioBySubjectRoot(String rid);
	
	List<Subject> findMultipleBySubjectRoot(String rid);
	
	String getAnswerById(String id);

	Subject getSubjectByOrder(@Param("id") String id,@Param("num") int num);

	List<Subject> getSubByPaperId(String id);
	
	List<Subject> findSubjectByPaper(String id);
	
	Subject getSubTypeById(String timuId);
	
	List<Subject> findSubjectByRoot(String rid);

	Subject paperGetSubject(String id);
}
