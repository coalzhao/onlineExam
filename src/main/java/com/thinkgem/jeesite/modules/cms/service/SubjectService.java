package com.thinkgem.jeesite.modules.cms.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.cms.dao.SubjectDao;
import com.thinkgem.jeesite.modules.cms.dao.SubjectRootDao;
import com.thinkgem.jeesite.modules.cms.entity.Paper;
import com.thinkgem.jeesite.modules.cms.entity.Subject;
import com.thinkgem.jeesite.modules.cms.entity.SubjectRoot;
/**
 * 题目Server
 * @author SunJiaMing
 * @version 2017-11-28
 */
@Service
@Transactional(readOnly = true)
public class SubjectService extends CrudService<SubjectDao, Subject> {
	
	@Autowired
	private SubjectRootDao subjectRootDao;
	
	@Transactional(readOnly = false)
	public Page<Subject> findPage(Page<Subject> page, Subject subject) {
		if (subject.getSubjectRoot()!=null && StringUtils.isNotBlank(subject.getSubjectRoot().getId()) && !SubjectRoot.isRoot(subject.getSubjectRoot().getId())){
			SubjectRoot subjectRoot = subjectRootDao.get(subject.getSubjectRoot().getId());
			if (subjectRoot==null){
				subjectRoot = new SubjectRoot();
			}
			subjectRoot.setParentIds(subjectRoot.getId());
			subject.setSubjectRoot(subjectRoot);
		}
		else{
			subject.setSubjectRoot(new SubjectRoot());
		}
		return super.findPage(page, subject);
	}
	
	public List<Subject> findSubject(String uid,String paperId) {
		return dao.findSubject(uid,paperId);
	}

	public List<Subject> getSubject() {
		return dao.getSubject();
	}
	
	public List<Subject> findSubjectByRoot(String rid) {
		return dao.findSubjectByRoot(rid);
	}
	
	public List<Subject> findRadioBySubjectRoot(String rid) {
		return dao.findRadioBySubjectRoot(rid);
	}
	
	public List<Subject> findMultipleBySubjectRoot(String rid) {
		return dao.findMultipleBySubjectRoot(rid);
	}
	public String getAnswerById(String id) {
		// TODO Auto-generated method stub
		return dao.getAnswerById(id);
	}
	public Subject paperGetSubject(String id) {
		return dao.paperGetSubject(id);
	}
	public Subject getSubjectByOrder(String id, int num) {
		// TODO Auto-generated method stub
		return dao.getSubjectByOrder(id,num);
	}

	public List<Subject> getSubByPaperId(String id) {
		// TODO Auto-generated method stub
		return dao.getSubByPaperId(id);
	}
	
	public void findSubjectByPaper(Paper paper) {
		paper.setSubList(dao.findSubjectByPaper(paper.getId()));
		System.out.println("试题集合长度======"+paper.getSubList().size());
	}

	public Subject getSubTypeById(String timuId) {
		// TODO Auto-generated method stub
		return dao.getSubTypeById(timuId); //李文鹏
	}
}
