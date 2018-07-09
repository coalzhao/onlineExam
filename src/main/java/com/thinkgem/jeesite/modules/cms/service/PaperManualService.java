package com.thinkgem.jeesite.modules.cms.service;

import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.CacheUtils;
import com.thinkgem.jeesite.modules.cms.dao.PaperManualDao;
import com.thinkgem.jeesite.modules.cms.entity.Paper;
import com.thinkgem.jeesite.modules.cms.entity.Subject;
import com.thinkgem.jeesite.modules.cms.utils.CmsUtils;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.LogUtils;

/**
 * 手动组卷service
 * 
 * @author cofe
 *
 */
@Service
public class PaperManualService extends CrudService<PaperManualDao, Paper> {

	@Autowired
	private PaperManualDao paperManualDao;

	/**
	 * 手动组题-添加试卷
	 * 
	 * @param paper
	 */
	@Transactional(readOnly = false)
	public void paperManualAdd(Paper paper, User user) {

		paper.setId(UUID.randomUUID().toString());
		paper.setCreateBy(user);
		paper.setUpdateBy(user);
		paper.setPaperStatus("0");
		Date date = paper.getBeginTime();
		long time = paper.getPaperDuration() * 60 * 1000 + date.getTime();
		paper.setEndTime(new Date(time));
		paper.setCreateDate(new Date());
		paper.setUpdateDate(new Date());
		paperManualDao.insert(paper);
	}

	/**
	 * 手动组卷--试卷所包含的试题详情查看
	 * @param id
	 * @return 试卷包含的试题
	 */
	public Paper selectPaperManualSubject(String id) {
		Paper paper = paperManualDao.selectPaperManualSubject(id);
		// 如果试卷没有题目，查询paper根据id
		if (paper == null) {
			paper = paperManualDao.getPaper(id);
		}
		int radioNumber = paperManualDao.slcRadioNum(id);
		int multipleNumber = paperManualDao.slcMltNum(id);
		paper.setMultipleNumber(multipleNumber);
		paper.setRadioNumber(radioNumber);
		return paper;
	}
	/**
	 * 发布
	 * @param paperId
	 * @return
	 */
	@Transactional(readOnly = false)
	public Paper publish(String paperId) {
		Paper paper = paperManualDao.getPaper(paperId);
		paper.setPaperStatus("1");
		paperManualDao.papUpdate(paper);
		// 调用排序方法
		CmsUtils.subjectSort(paper.getId());
		return paper;
	}
	/**
	 * 删除试题
	 * @param subjectId
	 * @param paperId
	 */
	@Transactional(readOnly = false)
	public Paper subjectDelete(String subjectId, String subType, String paperId, User user) {
		
		paperManualDao.subjectDelete(subjectId, paperId);
		// 查询试卷信息
		Paper paper = paperManualDao.getPaper(paperId);
		int radioNumber = paperManualDao.slcRadioNum(paperId);
		int multipleNumber = paperManualDao.slcMltNum(paperId);
		paper.setMultipleNumber(multipleNumber);
		paper.setRadioNumber(radioNumber);
		paper.setPaperScore(
				paper.getMultipleNumber() * paper.getMultipleScore() + paper.getRadioNumber() * paper.getRadioScore());
		paper.setPaperStatus("0");
		paperManualDao.papUpdate(paper);
		return paper;
	}

	/**
	 * 加题
	 * @param subAdd
	 * @param subType
	 * @param paperId
	 */
	@Transactional(readOnly = false)
	public Paper subAdd(String subId, String subType, String paperId, User user) {
		//查看当前试题是否已经添加
		Subject subject= paperManualDao.subSel(subId,paperId);
		//以前没有添加过
		if(subject == null){
			paperManualDao.subAdd(subId, paperId);
		}else{//以前添加过此题，修改此列的删除标记为‘0’
			paperManualDao.subUpdDel(subId,paperId);
		}
		// 查询试卷信息
		Paper paper = paperManualDao.getPaper(paperId);
		int radioNumber = paperManualDao.slcRadioNum(paperId);
		int multipleNumber = paperManualDao.slcMltNum(paperId);
		paper.setMultipleNumber(multipleNumber);
		paper.setRadioNumber(radioNumber);
		paper.setPaperScore(
				paper.getMultipleNumber() * paper.getMultipleScore() + paper.getRadioNumber() * paper.getRadioScore());
		paper.setPaperStatus("0");
		paperManualDao.papUpdate(paper);
		return paper;
	}

	/**
	 * 删除
	 * 
	 * @param paperId
	 */
	@Transactional(readOnly = false)
	public void paperDelete(String paperId, User user) {
		Paper paper = new Paper();
		paper.setId(paperId);
		paper.setUpdateDate(new Date());
		paper.setUpdateBy(user);
		paper.setDelFlag("1");
		paperManualDao.papUpdate(paper);
	}

	/**
	 * 查询试题信息
	 * 
	 * @param page
	 * @param subject
	 * @return
	 */
	public Page<Subject> findPage(Page<Subject> page, Subject subject) {

		subject.setPage(page);
		page.setList(paperManualDao.selectSubList(subject));
		return page;
	}
	@Transactional(readOnly = false)
	public Paper paperScoreUpdate(Paper paper) {
		//修改总分
		paper.setPaperScore(
				paper.getMultipleNumber() * paper.getMultipleScore() + paper.getRadioNumber() * paper.getRadioScore());
		paper.setPaperStatus("0");
		paperManualDao.papUpdate(paper);
		return paper;
	}

}
