package com.thinkgem.jeesite.modules.cms.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.security.access.method.P;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.cms.entity.Paper;
import com.thinkgem.jeesite.modules.cms.entity.Subject;

/**
 *  手动组卷dao
 * @author cofe
 *
 */
@MyBatisDao
public interface PaperManualDao extends CrudDao<Paper>{

  Paper selectPaperManualSubject(@Param("id") String id);

  void subjectDelete(@Param("subjectId") String subjectId, @Param("paperId")String paperId);

  void subAdd(@Param("sub_id")String subId,@Param("paper_id")String paperId);

  Paper getPaper(String id);

  /*void paperDelete(Paper paper);*/

  void papUpdate(Paper paper);

  List<Subject> selectSubList(Subject subject);


  int slcRadioNum(String paperId);

	int slcMltNum(String paperId);

	Subject subSel(@Param("subjectId")String subId, @Param("paperId")String paperId);
	void subUpdDel(@Param("subjectId")String subId, @Param("paperId")String paperId);

	void paperScoreUpdate(Paper paper);
  
  

}