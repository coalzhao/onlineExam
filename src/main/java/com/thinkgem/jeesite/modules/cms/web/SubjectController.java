package com.thinkgem.jeesite.modules.cms.web;

import java.sql.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringEscapeUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.cms.entity.Subject;
import com.thinkgem.jeesite.modules.cms.entity.SubjectRoot;
import com.thinkgem.jeesite.modules.cms.service.ModuleAnswerService;
import com.thinkgem.jeesite.modules.cms.service.SubjectRootService;
import com.thinkgem.jeesite.modules.cms.service.SubjectService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * 试题Controller
 * @author SunJiaMing
 * @version 2017-11-28
 */
@Controller
@RequestMapping(value = "${adminPath}/cms/subject")
public class SubjectController extends BaseController {

	@Autowired
	private SubjectService subjectService;
	@Autowired
	private SubjectRootService subjectRootService;
	@Autowired
	private ModuleAnswerService moduleAnswerService;
	
	@ModelAttribute
	public Subject get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return subjectService.get(id);
		}else{
			return new Subject();
		}
	}
	
	@RequiresPermissions("cms:subject:view")
	@RequestMapping(value = {"list", ""})
	public String list(Subject subject, HttpServletRequest request, HttpServletResponse response, Model model) {
		System.out.println("-----------"+subject.getSimulate());
		Page<Subject> page = subjectService.findPage(new Page<Subject>(request, response), subject); 
        model.addAttribute("page", page);
        return "modules/cms/subjectList";
	}
	
	@RequiresPermissions("cms:subject:view")
	@RequestMapping(value = "form")
	public String form(Subject subject, Model model) {
		// 如果当前传参有子节点，则选择取消传参选择
		if (subject.getSubjectRoot()!=null && StringUtils.isNotBlank(subject.getSubjectRoot().getId())){
			List<SubjectRoot> list = subjectRootService.findByParentId(subject.getSubjectRoot().getId());
			if (list.size() > 0){
				subject.setSubjectRoot(null);
			}else{
				subject.setSubjectRoot(subjectRootService.get(subject.getSubjectRoot().getId()));
			}
		}
//      model.addAttribute("contentViewList",getTplContent());
//      model.addAttribute("article_DEFAULT_TEMPLATE",Article.DEFAULT_TEMPLATE);
		model.addAttribute("subject", subject);
//		CmsUtils.addViewConfigAttribute(model, subject.getSubjectRoot());
		
		return "modules/cms/subjectForm";
	}
	
	@RequiresPermissions("cms:subject:view")
	@RequestMapping(value = "photoForm")
	public String photoForm(Subject subject, Model model) {
		// 如果当前传参有子节点，则选择取消传参选择
		if (subject.getSubjectRoot()!=null && StringUtils.isNotBlank(subject.getSubjectRoot().getId())){
			List<SubjectRoot> list = subjectRootService.findByParentId(subject.getSubjectRoot().getId());
			if (list.size() > 0){
				subject.setSubjectRoot(null);
			}else{
				subject.setSubjectRoot(subjectRootService.get(subject.getSubjectRoot().getId()));
			}
		}
//      model.addAttribute("contentViewList",getTplContent());
//      model.addAttribute("article_DEFAULT_TEMPLATE",Article.DEFAULT_TEMPLATE);
		model.addAttribute("subject", subject);
//		CmsUtils.addViewConfigAttribute(model, subject.getSubjectRoot());

		return "modules/cms/photoSubjectForm";
	}
	
	@RequiresPermissions("cms:subject:edit")
	@RequestMapping(value = "save")
	public String save(Subject subject,Model model, RedirectAttributes redirectAttributes,String btn) {
		if (subject.getTitle()!=null){
			subject.setTitle(StringEscapeUtils.unescapeHtml4(subject.getTitle()));
		}
		if (!beanValidator(model, subject)){
			return form(subject, model);
		}
		Date date= new java.sql.Date(new java.util.Date().getTime());//获取当前系统时间并转换为数据库时间
		subject.setCreateDate(date);//更新创建时间
		subjectService.save(subject);
		System.out.println("judge>>>>>>>>>>>"+subject.getJudge());
		addMessage(redirectAttributes, "保存'" + StringUtils.abbr(subject.getTitle(),50) + "'成功");
		String subjectRootId = subject.getSubjectRoot()!=null?subject.getSubjectRoot().getId():null;
		if(btn==null&&subjectRootId!=null) {//保存，并转到下一题
			String rootName=subjectRootService.get(subjectRootId).getName();
			addMessage(redirectAttributes, "保存'" + StringUtils.abbr(subject.getTitle(),50) + "'成功");
			System.out.println("judge》》》》》》》》》》》》1");
			if("1".equals(subject.getJudge())) {//文本题目
				System.out.println("judge》》》》》》》》》》》2");
				return "redirect:" + adminPath + "/cms/subject/form?subjectRoot.name="+rootName+"&subjectRoot.id="+(subjectRootId!=null?subjectRootId:"");
			}
			//图片题目
			System.out.println("judge》》》》》》》》》》》》3");
			return "redirect:" + adminPath + "/cms/subject/photoForm?subjectRoot.name="+rootName+"&subjectRoot.id="+(subjectRootId!=null?subjectRootId:"");
		}
		//保存，不转到下一题
		addMessage(redirectAttributes, "保存'" + StringUtils.abbr(subject.getTitle(),50) + "'成功");
		return "redirect:" + adminPath + "/cms/subject/?repage&subjectRoot.id="+(subjectRootId!=null?subjectRootId:"");
	}
	
	@RequiresPermissions("cms:subject:edit")
	@RequestMapping(value = "delete")
	public String delete(Subject subject, String categor5yId, RedirectAttributes redirectAttributes) {
		// 如果没有审核权限，则不允许删除。
		if (!UserUtils.getSubject().isPermitted("cms:subject:audit")){
			addMessage(redirectAttributes, "你没有删除权限");
		}
		System.out.println("》》》》》》》》》》》》");
		subjectService.delete(subject);
		moduleAnswerService.deleteModuleAnswer(subject.getId());
		addMessage(redirectAttributes, "删除试题成功");
		return "redirect:" + adminPath + "/cms/subject/";
	}

}
