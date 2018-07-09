/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.cms.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.cms.dao.ModuleAnswerDao;
import com.thinkgem.jeesite.modules.cms.entity.ModuleAnswer;
import com.thinkgem.jeesite.modules.cms.entity.Subject;

/**
 * 用户模块答题详情Service
 * @author SunJiaMing
 * @version 2018-01-05
 */
@Service
@Transactional(readOnly = true)
public class ModuleAnswerService extends CrudService<ModuleAnswerDao, ModuleAnswer> {
	@Transactional(readOnly = false)
	public List<String> findSubjectByModule(String userId,String moduleId){
		return dao.findSubjectByModule(userId, moduleId);
	}
	@Transactional(readOnly = false)
	public void saveAnswer(ModuleAnswer moduleAnswer,Subject subject) {
//		List<ModuleAnswer> ma=dao.getModuleAnswer(moduleAnswer.getCurrentUser().getId(), subject.getId());
//		System.out.println("++++++++++++++++开        始+++++++++++++++++++");
//		System.out.println("登陆用户的id："+moduleAnswer.getCurrentUser().getId());
//		System.out.println("登录id："+moduleAnswer.getUserId());
//		for (ModuleAnswer moduleAnswer2 : ma) {
//			System.out.println(">>>>>>>>>>"+moduleAnswer2.getUserSubject());
//		}
//		System.out.println("++++++++++++++++结        束+++++++++++++++++++");
		ModuleAnswer ma=dao.getModuleAnswer(moduleAnswer.getCurrentUser().getId(), subject.getId());
		if(ma!=null) {
			ma.setUserOptions(subject.getUserAnswer());
			ma.setUserSubject(subject.getId());
			ma.setCorrect(subject.getResult());
			dao.updateModuleAnswer(ma);
		}else {
			dao.saveAnswer(moduleAnswer, subject);
		}
	}
	@Transactional(readOnly = false)
	public void deleteModuleAnswer(String subjectId) {
		dao.deleteModuleAnswer(subjectId);
	}
	
	public int subjectNumberByModule(String userId,String moduleId) {
		return dao.subjectNumberByModule(userId, moduleId);
	}
	//查询出当前模块下没有做过的模拟题
	public List<Subject> findSubject(String userId,String moduleId){
		return dao.findSubject(userId, moduleId);
	}
	//获取模块下所有的题
	public int subjectAllNumberByModule(String moduleId) {
		return dao.subjectAllNumberByModule(moduleId);
	}
	public List<Subject> findALLFinishedSubject(String userId,String moduleId){
		return dao.findALLFinishedSubject(userId, moduleId);
	}
}
