package com.thinkgem.jeesite.modules.cms.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.cms.dao.PaperDao;
import com.thinkgem.jeesite.modules.cms.dao.SubjectDao;
import com.thinkgem.jeesite.modules.cms.entity.Paper;

/**
 * 试卷Service
 * @author SunJiaMing
 * @version 2017-12-09
 */
@Service
@Transactional(readOnly = true)
public class PaperService extends CrudService<PaperDao,Paper>{
	public List<Paper> getSimPaper(){
		return dao.getSimPaper();
	}

	public List<Paper> getAllPaper(){
		return dao.getAllPaper();
	}
	
	@Transactional(readOnly = false)
	public void creatPaper(String paperId,String subId) {
		dao.creatPaper(paperId,subId);
	}
	@Transactional(readOnly = false)
	public void delSubject(String paperId,String subId) {
		dao.delSubject( paperId,subId);
	}
	@Transactional(readOnly = false)
	public void alterSubject(String paperId,String subId,String id) {
		dao.alterSubject(paperId,subId,id);
	}
	@Transactional(readOnly = false)
	public void subjectSort(String paperId,String subId,int num){
		dao.subjectSort(paperId,subId,num);
	}
	@Transactional(readOnly = false)
	public void saveSubject(String paperId,String id) {
		dao.saveSubject(paperId, id);
	}
	public int getSubject(String paperId,String id) {
		return dao.getSubject(paperId, id);
	}
	public int getDelSubject(String paperId,String id) {
		return dao.getDelSubject(paperId, id);
	}
	@Transactional(readOnly = false)
	public void delAllSubject(String paperId) {
		dao.delAllSubject(paperId);
	}
	@Transactional(readOnly = false)
	public void notDelSubject(String paperId,String subId) {
		dao.notDelSubject(paperId, subId);
	}
	
	public List<String> getSubjectIds(String paperId) {
		return dao.getSubjectIds(paperId);
	}
	
	public List<Paper> findPaperName(){
		return dao.findPaperName();
	}
}
