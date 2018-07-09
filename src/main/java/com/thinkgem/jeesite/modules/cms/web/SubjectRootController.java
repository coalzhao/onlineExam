package com.thinkgem.jeesite.modules.cms.web;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.activiti.engine.impl.util.json.JSONArray;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.authz.annotation.RequiresUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.alibaba.druid.sql.ast.statement.SQLIfStatement.Else;
import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.cms.dao.SubjectRootDao;
import com.thinkgem.jeesite.modules.cms.entity.Subject;
import com.thinkgem.jeesite.modules.cms.entity.SubjectRoot;
import com.thinkgem.jeesite.modules.cms.service.ModuleAnswerService;
import com.thinkgem.jeesite.modules.cms.service.SubjectRootService;
import com.thinkgem.jeesite.modules.cms.service.SubjectService;

/**
 * 题根Controller
 * @author SunJiaMing
 * @version 2017-11-29
 */
@Controller
@RequestMapping(value = "${adminPath}/cms/subjectRoot")
public class SubjectRootController extends BaseController {

	@Autowired
	private SubjectRootService subjectRootService;
	@Autowired
	private SubjectService subjectService;
	@Autowired
	private ModuleAnswerService moduleAnswerService;
//	private module subjectService;
	int status = 0;
	@ModelAttribute("subjectRoot")
	public SubjectRoot get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return subjectRootService.get(id);
		}else{
			return new SubjectRoot();
		}
	}

	@RequiresPermissions("cms:subjectRoot:view")
	@RequestMapping(value = {"list", ""})
	public String list(Model model) {
		List<SubjectRoot> list = Lists.newArrayList();
		List<SubjectRoot> sourcelist = subjectRootService.findByUser(true);
		SubjectRoot.sortList(list, sourcelist, "1");
        model.addAttribute("list", list);
		return "modules/cms/subjectRootList";
	}
	
	@RequiresPermissions("cms:moduleAnswer:view")
	@RequestMapping(value = "subModulesList")
	public String subjectModulesList(Model model,SubjectRoot subjectRoot) {
		List<SubjectRoot> list = subjectRootService.findByParentId("1");
        model.addAttribute("modulesList", list);
//		return "modules/cms/moduleTest";
		return "modules/cms/moduleList";
	}

	@RequiresPermissions("cms:subjectRoot:view")
	@RequestMapping(value = "form")
	public String form(SubjectRoot subjectRoot, Model model) {
		if (subjectRoot.getParent()==null||subjectRoot.getParent().getId()==null){
			subjectRoot.setParent(new SubjectRoot("1"));
		}
		List<SubjectRoot> rootList=subjectRootService.findByParentId("1");
		SubjectRoot parent = subjectRootService.get(subjectRoot.getParent().getId());
		subjectRoot.setParent(parent);
		System.out.println(">>>>>>>>>"+subjectRoot.getParentId()+">>>>>>>>"+subjectRoot.getParent().getId());
		model.addAttribute("subjectRoot", subjectRoot);
		model.addAttribute("rootList", rootList);
		return "modules/cms/subjectRootForm";
	}
	
	@RequiresPermissions("cms:subjectRoot:view")
	@RequestMapping(value = "moduleForm")
	public String moduleForm(SubjectRoot subjectRoot, Model model) {
//		if (subjectRoot.getParent()==null||subjectRoot.getParent().getId()==null){
//			subjectRoot.setParent(new SubjectRoot("1"));
//		}
//		List<SubjectRoot> rootList=subjectRootService.findByParentId("1");
		SubjectRoot parent = subjectRootService.get("1");
		System.out.println("_________"+parent.getName());
//		subjectRoot.setParent(parent);
		model.addAttribute("subjectRoot", subjectRoot);
		model.addAttribute("subjectModule", parent);
		return "modules/cms/subjectModuleForm";
	}
	
	@RequiresPermissions("cms:subjectRoot:edit")
	@RequestMapping(value = "save")
	public String save(SubjectRoot subjectRoot, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, subjectRoot)){
			return form(subjectRoot, model);
		}
		subjectRootService.save(subjectRoot);
		addMessage(redirectAttributes, "保存'" + subjectRoot.getName() + "'成功");
		return "redirect:" + adminPath + "/cms/subjectRoot/";
	}
	
	@RequiresPermissions("cms:subjectRoot:edit")
	@RequestMapping(value = "delete")
	public String delete(SubjectRoot subjectRoot, RedirectAttributes redirectAttributes) {
		if (SubjectRoot.isRoot(subjectRoot.getId())){
			addMessage(redirectAttributes, "删除题根失败, 不允许删除顶级题根或编号为空");
		}else if ("1".equals(subjectRoot.getParentId())) {
			System.out.println("当前id为"+subjectRoot.getId());
		List<SubjectRoot> subRootList = subjectRootService.findByModule(subjectRoot.getId()); 
		 SubjectRoot[] subRootArr =  subRootList.toArray(new SubjectRoot[subRootList.size()]);
//		 System.out.println("subjectRootId"+subRootArr[0].getId()+"------"+subRootArr[1].getId());
		 System.out.println("subRootList大小"+subRootList.size());
		 subjectRootService.delete(subjectRoot);
		List<Subject> subList = new ArrayList();
		for (int i = 0; i < subRootArr.length; i++) {
			 subList =subjectService.findSubjectByRoot(subRootArr[i].getId());
			 System.out.println("题根名"+subRootArr[i].getName());
			 subjectRootService.delete(subRootArr[i]);
		}
		Subject[] subArr = new Subject[subList.size()];
		System.out.println("试题list大小为:"+subList.size());
		
			for (int i = 0; i < subList.size(); i++) {
//				System.out.println("题目名称"+subArr[i].getTitle());
				subjectService.delete(subList.get(i));
				moduleAnswerService.deleteModuleAnswer(subList.get(i).getId());
			}		
				addMessage(redirectAttributes, "删除模块成功");
		}else {
			List<Subject> subList = new ArrayList();
			subList = subjectService.findSubjectByRoot(subjectRoot.getId());
				subjectRootService.delete(subjectRoot);
			for (int i = 0; i < subList.size(); i++) {
				 subjectService.delete(subList.get(i));
				moduleAnswerService.deleteModuleAnswer(subList.get(i).getId());
			}		
				addMessage(redirectAttributes, "删除题根成功");	
		}
		return "redirect:" + adminPath + "/cms/subjectRoot/";
	}

	/**
	 * 批量修改栏目排序
	 */
	@RequiresPermissions("cms:subjectRoot:edit")
	@RequestMapping(value = "updateSort")
	public String updateSort(String[] ids, Integer[] sorts, RedirectAttributes redirectAttributes) {
    	int len = ids.length;
    	SubjectRoot[] entitys = new SubjectRoot[len];
    	for (int i = 0; i < len; i++) {
    		entitys[i] = subjectRootService.get(ids[i]);
    		entitys[i].setSort(sorts[i]);
    		subjectRootService.save(entitys[i]);
    	}
    	addMessage(redirectAttributes, "保存栏目排序成功!");
		return "redirect:" + adminPath + "/cms/subjectRoot/";
	}
	
	@RequiresUser
	@ResponseBody
	@RequestMapping(value = "treeData")
	public List<Map<String, Object>> treeData(@RequestParam(required=false) String extId, HttpServletResponse response) {
		response.setContentType("application/json; charset=UTF-8");
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<SubjectRoot> list = subjectRootService.findByUser(true);
		for (int i=0; i<list.size(); i++){
			SubjectRoot e = list.get(i);
			if (extId == null || (extId!=null && !extId.equals(e.getId()) && e.getParentIds().indexOf(","+extId+",")==-1)){
				if(!"1".equals(e.getId())) {
					Map<String, Object> map = Maps.newHashMap();
					map.put("id", e.getId());
					map.put("pId", e.getParent()!=null?e.getParent().getId():0);
					map.put("name", e.getName());
					mapList.add(map);
				}
			}
		}
		return mapList;
	}
	
/*	@RequiresUser
	@ResponseBody
	@RequestMapping(value = "treeData")
	public List<Map<String, Object>> treeData(String module, @RequestParam(required=false) String extId, HttpServletResponse response) {
		response.setContentType("application/json; charset=UTF-8");
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<SubjectRoot> list = subjectRootService.findByUser(true, module);
		for (int i=0; i<list.size(); i++){
			SubjectRoot e = list.get(i);
			if (extId == null || (extId!=null && !extId.equals(e.getId()) && e.getParentIds().indexOf(","+extId+",")==-1)){
				Map<String, Object> map = Maps.newHashMap();
				map.put("id", e.getId());
				map.put("pId", e.getParent()!=null?e.getParent().getId():0);
				map.put("name", e.getName());
				mapList.add(map);
			}
		}
		return mapList;
	}*/
}
