/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.cms.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.cms.entity.ModuleAnswer;
import com.thinkgem.jeesite.modules.cms.entity.Subject;

/**
 * 用户模块答题详情DAO接口
 * @author SunJiaMing
 * @version 2018-01-05
 */
@MyBatisDao
public interface ModuleAnswerDao extends CrudDao<ModuleAnswer> {
	
	List<String> findSubjectByModule(@Param("uid")String userId,@Param("mid")String moduleId);
	
	void saveAnswer(@Param("ans")ModuleAnswer moduleAnswer,@Param("sub")Subject subject);
	
	void deleteModuleAnswer(String subjectId);
	
	int subjectNumberByModule(@Param("uid")String userId,@Param("mid")String moduleId);

	List<Subject> findSubject(@Param("uid")String userId,@Param("mid")String moduleId);
	
	int subjectAllNumberByModule(@Param("mid")String moduleId);

	List<Subject> findALLFinishedSubject(@Param("uid")String userId,@Param("mid")String moduleId);

	ModuleAnswer getModuleAnswer(@Param("uid")String userId,@Param("sid")String subjectId);
	
	void updateModuleAnswer(ModuleAnswer moduleAnswer);
}
