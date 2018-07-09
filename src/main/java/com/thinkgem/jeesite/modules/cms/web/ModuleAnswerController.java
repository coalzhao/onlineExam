package com.thinkgem.jeesite.modules.cms.web;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
import com.thinkgem.jeesite.modules.cms.entity.Article;
import com.thinkgem.jeesite.modules.cms.entity.ModuleAnswer;
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
@RequestMapping(value = "${adminPath}/cms/moduleAnswer")
public class ModuleAnswerController extends BaseController {

	@Autowired
	private ModuleAnswerService moduleAnswerService;
	@Autowired
	private SubjectService subjectService;
	
	@ModelAttribute
	public ModuleAnswer get(@RequestParam(required=false) String moduleId) {
		if (moduleId!=null&&moduleId.length()!=0){
			return new ModuleAnswer(moduleId);
		}else{
			return new ModuleAnswer();
		}
	}
	
	/**
	 * 根据模块抽题
	 * @param moduleAnswer
	 * @param model
	 * @return
	 */
	@RequiresPermissions("cms:moduleAnswer:view")
	@RequestMapping(value = "subByModule")
	public String subByModule(ModuleAnswer moduleAnswer,Model model) {
		String userId=moduleAnswer.getCurrentUser().getId();
		String moduleId=moduleAnswer.getModuleId();
		System.out.println("moduleId>>>>>>"+moduleAnswer.getModuleId());
		List<String> subjectIdList = moduleAnswerService.findSubjectByModule(moduleAnswer.getCurrentUser().getId(), moduleAnswer.getModuleId());
		List<Subject> subjectList=moduleAnswerService.findSubject(userId, moduleId);
		int subNumber=10-subjectList.size();
		//抽取前10道题
		if(subjectList.size()>=10) {
			model.addAttribute("subList", subjectList.subList(0, 10));
		}else {
				Random random = new Random();
				for (int i = 0; i <subNumber ; i++) {
					if(subjectIdList.size()>0) {
						Subject addSubject=null;
						int j = random.nextInt(subjectIdList.size());
						addSubject=subjectService.get(subjectIdList.get(j));
						if(addSubject!=null) {
							subjectList.add(addSubject);
						}
						subjectIdList.remove(j);
					}else {
						break;
					}
				}
			model.addAttribute("subList", subjectList);
		}
		model.addAttribute("moduleId",moduleAnswer.getModuleId());
		return "modules/cms/moduleTest";
	}
	
	
	/**
	 * 回答完成的题目
	 * @param moduleAnswer
	 * @param model
	 * @return
	 */
	@RequiresPermissions("cms:moduleAnswer:view")
	@RequestMapping(value = "finishedSubject")
	public String finishedSubject(ModuleAnswer moduleAnswer,Model model) {
		String userId=moduleAnswer.getCurrentUser().getId();
		String moduleId=moduleAnswer.getModuleId();
		List<Subject> subjectList=moduleAnswerService.findALLFinishedSubject(userId, moduleId);
		model.addAttribute("subList", subjectList);
		model.addAttribute("moduleId",moduleAnswer.getModuleId());
		return "modules/cms/finishedSubjects";
	}
	
	
	/**
	 * 模块测试存题
	 * @param subject
	 * @param subId
	 * @param moduleAnswer
	 * @param model
	 * @return
	 */
	@RequiresPermissions("cms:moduleAnswer:view")
	@RequestMapping(value = "saveModuleAnswer")
	public String saveModuleAnswer(ModuleAnswer moduleAnswer, Model model,HttpSession session) {
		Date date= new java.sql.Date(new java.util.Date().getTime());//获取当前系统时间并转换为数据库时间
		moduleAnswer.setCreateDate(date);//更新创建时间
		moduleAnswer.setUserId(moduleAnswer.getCurrentUser().getId());
		List<Subject> subjectList = moduleAnswer.getModuleSubjectList();
		System.out.println("user_id>>>>>>"+moduleAnswer.getUserId());
		System.out.println("module_id>>>>>>"+moduleAnswer.getModuleId());
		System.out.println("creat_date>>>>>>"+moduleAnswer.getCreateDate());
		for (Subject subject : subjectList) {
			System.out.println("疯狂输出>>>>>"+subject.getId());
			System.out.println("options_id>>>>>>"+subject.getUserAnswer());
			System.out.println("right>>>>>>"+subject.getResult());
			System.out.println("subject_id>>>>>>"+subject.getId());
			System.out.println("----------我是分割线---------");
		}
		Subject sub=null;
		List<Subject> list=new ArrayList<Subject>();
		for (Subject subject : subjectList) {
			sub=subjectService.get(subject.getId());
			if(sub!=null&&sub.getCorrect()!=null&&!("".equals(sub.getCorrect()))) {
				if(subject.getUserAnswer()!=null&&!("".equals(subject.getCorrect()))) {
					if(subject.getUserAnswer().equals(sub.getCorrect())) {//正确
						sub.setResult("1");
					}else {//错误
						sub.setResult("0");
					}
					sub.setUserAnswer(subject.getUserAnswer());
				}else {
					sub.setResult("0");
					sub.setUserAnswer("未作答");
				}
			}
			moduleAnswerService.saveAnswer(moduleAnswer, sub);
			list.add(sub);
		}
		System.out.println(">>>>>>>>存入>>>>>>>>>");
		model.addAttribute("list",list);
		session.setAttribute("moduleDetailList", list);
//		return "modules/cms/moduleTest2";
		return "modules/cms/moduleClose";
	}
	
	 @RequiresPermissions("cms:moduleAnswer:view")
	 @RequestMapping(value = "transforList")
	 public String transforList(){
		return "modules/cms/moduleDetails";	
	}
}
