package com.thinkgem.jeesite.modules.cms.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.cms.entity.Paper;
import com.thinkgem.jeesite.modules.cms.entity.Subject;
import com.thinkgem.jeesite.modules.cms.service.PaperManualService;
import com.thinkgem.jeesite.modules.cms.service.PaperService;
import com.thinkgem.jeesite.modules.cms.service.SubjectService;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * 手动生成试卷
 * @author cofe
 *
 */
@Controller
@RequestMapping(value = "${adminPath}/cms/paper/manual")
public class PaperManualController extends BaseController{
	@Autowired
	private PaperManualService paperManualService;
//	@Autowired
//	private SubjectService subjectService;
	@Autowired
	private PaperService paperService;
	@ModelAttribute
	public Paper get(@RequestParam(required = false) String id) {
		if (StringUtils.isNotBlank(id)) {
			return paperService.get(id);
		} else {
			return new Paper();
		}
	}
	/**
	 * 手动组卷--跳转添加组卷页面
	 * @return 页面地址
	 */
	@RequestMapping(value ="goManual")
	public String goManual(String simulate,Model model,HttpServletRequest request) {
//			model.addAttribute("simulate", simulate);
			request.getSession().setAttribute("simulate", simulate);
			return "modules/cms/paperManual/paperManualAdd";
		}
	
	/**
	 * 手动组卷--添加试卷
	 * @param paper
	 * @return	试卷加题
	 */
	@RequiresPermissions("cms:paper:view")
	@RequestMapping(value="addPaper")
	public String AddPaperManual(Paper paper){
		User user=UserUtils.getUser();
		paperManualService.paperManualAdd(paper,user);
//		return "redirect:" + adminPath + "/cms/paper/manual/selectListPaper?simulate="+paper.getSimulate();
		return "redirect:" + adminPath + "/cms/paper/manual/goPaperManualSubAdd?paperId="+paper.getId();
	}
	
	/**
	 * 手动组卷--查询组卷
	 * @return	列表页面
	 */
	@RequestMapping("selectListPaper")
	public String getListPaper(String simulate, Paper paper, HttpServletRequest request, HttpServletResponse response, Model model){
		if(paper == null)paper=new Paper();
		paper.setSimulate(simulate);
		Page<Paper> page = paperManualService.findPage(new Page<Paper>(request, response), paper);
		model.addAttribute("page", page);
		model.addAttribute("simulate", simulate);
		return "modules/cms/paperManual/paperManualList";
	}
	
	
	/**
	 * 手动组卷--试卷所包含的试题详情查看
	 * @param id 试卷id
	 * @return 试卷详情页面
	 */
	@RequestMapping(value="detail")
	public String detail(String id,Model model){
		Paper paper = paperManualService.selectPaperManualSubject(id);
		model.addAttribute("paper", paper);
		return "modules/cms/paperManual/paperManualDetail";
	}
	/**
	 * 手动组卷--删除试卷中的试题
	 * @param subjectId 试题id
	 * @param paperId 试卷id
	 * @return	
	 */
	@RequiresPermissions("cms:paper:view")
	@RequestMapping("subjectDelete")
	@ResponseBody
	public Object subjectDelete(String subjectId,String subType,String paperId){
		User user=UserUtils.getUser();
		Paper paper = paperManualService.subjectDelete(subjectId,subType,paperId,user);
		return paper;
	}
	/**
	 * 手动组卷--跳转到试题添加页面
	 * @param paperId
	 * @param model
	 * @return
	 */
	@RequestMapping("goPaperManualSubAdd")
	public String goPaperManualSubAdd(String paperId,Model model,Subject subject,HttpServletRequest request, HttpServletResponse response){
		//获取试卷信息,将已经选的题目存入页面中
		Paper paper = paperManualService.selectPaperManualSubject(paperId);
		model.addAttribute("paper", paper);
		if(subject ==null){
			subject=new Subject();
		}
		
		//是模拟卷自能查模拟题
		if(paper.getSimulate().equals("1")){
			subject.setSimulate(paper.getSimulate());
		}
		
		Page<Subject> page = paperManualService.findPage(new Page<Subject>(request, response), subject);
        model.addAttribute("page", page);
		return "modules/cms/paperManual/paperManualSubAdd";
	}

	
	/**
	 * 手动组卷--试题添加
	 * @param subId	试题id
	 * @param subType 试题内型
	 * @param paperId 试卷id
	 * @return 
	 */
	@RequiresPermissions("cms:paper:view")
	@RequestMapping("subAdd")
	@ResponseBody
	public Object  subAdd(String subId,String subType,String paperId){
		User user=UserUtils.getUser();
		Paper paper = paperManualService.subAdd(subId,subType,paperId,user);
		return paper;
	}
	/**
	 * 手动组卷--试卷删除
	 * @param paperId 试卷id
	 * @return 试卷列表页面
	 */
	@RequiresPermissions("cms:paper:view")
	@RequestMapping("paperDelete")
	public Object paperDelete(String paperId){
		User user=UserUtils.getUser();
		Paper paper = paperManualService.selectPaperManualSubject(paperId);
		paperManualService.paperDelete(paperId,user);
		return "redirect:" + adminPath + "/cms/paper/manual/selectListPaper?simulate="+paper.getSimulate(); 
	}
	/**
	 * 修改试卷分值
	 * @param paper
	 * @return
	 */
	@RequestMapping("paperScoreUpdate")
	public Object paperScoreUpdate(Paper paper){
		paper=paperManualService.paperScoreUpdate(paper);
		return "redirect:" + adminPath + "/cms/paper/manual/detail?id="+paper.getId();
	}
	@RequestMapping("paperScoreUpdate2")
	public Object paperScoreUpdate2(Paper paper){
		paper=paperManualService.paperScoreUpdate(paper);
		return "redirect:" + adminPath + "/cms/paper/manual/goPaperManualSubAdd?paperId="+paper.getId();
	}
	/**
	 * 手动组卷--发布试卷
	 * @param paperId
	 * @return
	 */
	@RequestMapping("publish")
	public Object save(String paperId){
		Paper paper=paperManualService.publish(paperId);
		return "redirect:" + adminPath +
				"/cms/paper/manual/selectListPaper?simulate="+paper.getSimulate();
	}
}






