package com.thinkgem.jeesite.modules.cms.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.cms.entity.Paper;
@MyBatisDao
public interface PaperDao extends CrudDao<Paper>{
	public List<Paper> getSimPaper();

	public List<Paper> getAllPaper();

	public void creatPaper(String paperId,String subId);
	
	public void notDelSubject(@Param("pid")String paperId,@Param("sid")String subId);
	
	public void delSubject(@Param("pid")String paperId,@Param("sid")String subId);
	
	public void delAllSubject(@Param("pid")String paperId);
	
	public void alterSubject(@Param("pid")String paperId,@Param("sid")String subId,@Param("id")String id);
	
	public void saveSubject(@Param("pid")String paperId,@Param("id")String id);
	//试题排序
	public void subjectSort(@Param("pid")String paperId,@Param("sid")String subId,@Param("num")int num);
	//查找试卷中有没有当前试题(没有被标记删除的)
	public int getSubject(@Param("pid")String paperId,@Param("id")String id);
	//查找试卷中有没有当前试题(已经被标记删除的)
	public int getDelSubject(@Param("pid")String paperId,@Param("id")String id);

	public List<String> getSubjectIds(String paperId);
	
	public List<Paper> findPaperName();
}
