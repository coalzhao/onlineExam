package com.thinkgem.jeesite.modules.cms.service;

import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.common.collect.Lists;
import com.google.common.collect.Sets;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.TreeService;
import com.thinkgem.jeesite.modules.cms.dao.SubjectRootDao;
import com.thinkgem.jeesite.modules.cms.entity.Category;
import com.thinkgem.jeesite.modules.cms.entity.SubjectRoot;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * 题根Service
 * @author SunJiaMing
 * @version 2017-11-28
 */
@Service
@Transactional(readOnly = true)
public class SubjectRootService extends TreeService<SubjectRootDao, SubjectRoot>{

	public static final String CACHE_SUBJECTROOT_LIST = "subjectRootList";
	
	private SubjectRoot entity = new SubjectRoot();
	
	@SuppressWarnings("unchecked")
	public List<SubjectRoot> findByUser(boolean isCurrentSite){
		
		List<SubjectRoot> list = (List<SubjectRoot>)UserUtils.getCache(CACHE_SUBJECTROOT_LIST);
		if (list == null){
			User user = UserUtils.getUser();
			SubjectRoot subjectRoot = new SubjectRoot();
			subjectRoot.getSqlMap().put("dsf", dataScopeFilter(user, "o", "u"));
			//subjectRoot.getSqlMap().put("dsf", dataScopeFilter(user, "o", "u"));
			subjectRoot.setParent(new SubjectRoot());
			list = dao.findList(subjectRoot);
			// 将没有父节点的节点，找到父节点
			Set<String> parentIdSet = Sets.newHashSet();
			for (SubjectRoot e : list){
				System.out.println("----------"+e.toString());
				if (e.getParent()!=null && StringUtils.isNotBlank(e.getParent().getId())){
					boolean isExistParent = false;
					for (SubjectRoot e2 : list){
						if (e.getParent().getId().equals(e2.getId())){
							isExistParent = true;
							break;
						}
					}
					if (!isExistParent){
						parentIdSet.add(e.getParent().getId());
					}
				}
			}
			if (parentIdSet.size() > 0){
				
				//FIXME 暂且注释，用于测试
//				dc = dao.createDetachedCriteria();
//				dc.add(Restrictions.in("id", parentIdSet));
//				dc.add(Restrictions.eq("delFlag", Category.DEL_FLAG_NORMAL));
//				dc.addOrder(Order.asc("site.id")).addOrder(Order.asc("sort"));
//				list.addAll(0, dao.find(dc));
			}
			UserUtils.putCache(CACHE_SUBJECTROOT_LIST, list);
		}
		
		if (isCurrentSite){
			List<SubjectRoot> subjectRootList = Lists.newArrayList(); 
			for (SubjectRoot e : list){
				subjectRootList.add(e);
			}
			return subjectRootList;
		}
		return list;
	}

	public List<SubjectRoot> findByParentId(String parentId){
		SubjectRoot parent = new SubjectRoot();
		parent.setId(parentId);
		entity.setParent(parent);
		return dao.findByParentId(entity);
	}
	
	public Page<SubjectRoot> find(Page<SubjectRoot> page, SubjectRoot subjectRoot) {
//		DetachedCriteria dc = dao.createDetachedCriteria();
//		if (category.getSite()!=null && StringUtils.isNotBlank(category.getSite().getId())){
//			dc.createAlias("site", "site");
//			dc.add(Restrictions.eq("site.id", category.getSite().getId()));
//		}
//		if (category.getParent()!=null && StringUtils.isNotBlank(category.getParent().getId())){
//			dc.createAlias("parent", "parent");
//			dc.add(Restrictions.eq("parent.id", category.getParent().getId()));
//		}
//		if (StringUtils.isNotBlank(category.getInMenu()) && Category.SHOW.equals(category.getInMenu())){
//			dc.add(Restrictions.eq("inMenu", category.getInMenu()));
//		}
//		dc.add(Restrictions.eq(Category.FIELD_DEL_FLAG, Category.DEL_FLAG_NORMAL));
//		dc.addOrder(Order.asc("site.id")).addOrder(Order.asc("sort"));
//		return dao.find(page, dc);
//		page.setSpringPage(dao.findByParentId(category.getParent().getId(), page.getSpringPage()));
//		return page;
		subjectRoot.setPage(page);
		subjectRoot.setInMenu(Global.SHOW);
		page.setList(dao.findModule(subjectRoot));
		return page;
	}
	
	@Transactional(readOnly = false)
	public void save(SubjectRoot subjectRoot) {
		super.save(subjectRoot);
		UserUtils.removeCache(CACHE_SUBJECTROOT_LIST);
	}
	
	@Transactional(readOnly = false)
	public void delete(SubjectRoot subjectRoot) {
		
		UserUtils.removeCache(CACHE_SUBJECTROOT_LIST);
		super.delete(subjectRoot);
	}
	
	/**
	 * 通过编号获取栏目列表
	 */
	public List<SubjectRoot> findByIds(String ids) {
		List<SubjectRoot> list = Lists.newArrayList();
		String[] idss = StringUtils.split(ids,",");
		if (idss.length>0){
//			List<Category> l = dao.findByIdIn(idss);
//			for (String id : idss){
//				for (Category e : l){
//					if (e.getId().equals(id)){
//						list.add(e);
//						break;
//					}
//				}
//			}
			for(String id : idss){
				SubjectRoot e = dao.get(id);
				if(null != e){
					//System.out.println("e.id:"+e.getId()+",e.name:"+e.getName());
					list.add(e);
				}
				//list.add(dao.get(id));
				
			}
		}
		return list;
	}
	
	
	public List<SubjectRoot> findByModule(String id){
		return dao.findByModule(id);	
	}

	



	



}
