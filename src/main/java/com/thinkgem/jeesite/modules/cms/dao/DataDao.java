package com.thinkgem.jeesite.modules.cms.dao;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.cms.entity.DataStatistics;
import com.thinkgem.jeesite.modules.cms.entity.Paper;
import com.thinkgem.jeesite.modules.cms.entity.SubjectData;
import com.thinkgem.jeesite.modules.cms.entity.SubjectRoot;
import com.thinkgem.jeesite.modules.sys.entity.User;

@MyBatisDao
public interface DataDao extends CrudDao<Paper>{

	List<User> selectUser();

	List<DataStatistics> dataStatistics(DataStatistics dataStatistics);

	List<SubjectRoot> selectSubjectRoot();

	List<SubjectData> selectSubData();

	List<SubjectData> selectModelData(String id);

	/*List<PaperData> selectPaperData(PaperData paperData);*/

}
