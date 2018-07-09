package com.thinkgem.jeesite.modules.cms.dao;

import java.util.List;
import java.util.Map;

import com.thinkgem.jeesite.common.persistence.TreeDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.cms.entity.SubjectRoot;

@MyBatisDao
public interface SubjectRootDao extends TreeDao<SubjectRoot> {
	
	public List<SubjectRoot> findByParentId(SubjectRoot entity);
	
	public List<SubjectRoot> findModule(SubjectRoot SubjectRoot);

	public List<SubjectRoot> findByModule(String id);
	
	public List<SubjectRoot> findByParentId(String parentId, String isMenu);

	public List<Map<String, Object>> findStats(String sql);
	
}
