package com.thinkgem.jeesite.modules.cms.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.cms.entity.Score;
import com.thinkgem.jeesite.modules.cms.entity.ScoreDetail;
import com.thinkgem.jeesite.modules.cms.entity.Subject;
import com.thinkgem.jeesite.modules.cms.service.ScoreDetailService;
import com.thinkgem.jeesite.modules.cms.service.ScoreService;
import com.thinkgem.jeesite.modules.cms.service.SubjectService;

/**
 * 成绩Controller
 * @author thinkgem
 * @version 2017-11-22
 */
@Controller
@RequestMapping(value = "${adminPath}/cms/score")
public class ScoreController extends BaseController{

	@Autowired
	private ScoreService scoreService;
	
	@Autowired
	private ScoreDetailService scoreDetailService;
	
	@Autowired
	private SubjectService subjectService;
	
	@ModelAttribute
	public Score get(@RequestParam(required=false) String id) {
		if (StringUtils.isNotBlank(id)){
			return scoreService.get(id);
		}else{
			return new Score();
		}
	}
	
	
	//该方法用于展示成绩列表
	@RequiresPermissions("cms:score:view")
	@RequestMapping(value = {"list", ""})
	public String list(Score score, HttpServletRequest request, HttpServletResponse response, Model model) {
        Page<Score> page = scoreService.findPage(new Page<Score>(request, response), score); 
        model.addAttribute("page", page);
        //System.out.println("成绩单=======");
        //System.out.println(page.getList().size());
		return "modules/cms/scoreList";
	}
	//该方法用于查询个人成绩
		@RequiresPermissions("cms:score:view")
		@RequestMapping(value = "person")
		public String listPerson(String uid,String pid, Model model) {
			//System.out.println("接收到的uid  "+uid+"  接收到的pid"+pid);
			Score score = scoreService.getPersonScore(uid,pid);
			if(score!=null) {
				String scoreId = score.getId();
				 model.addAttribute("scoreId", scoreId);
			}
	        model.addAttribute("score", score);
			return "modules/cms/scorePerson";
		}
	
	//原来的查看成绩详情的方法，已被替代
	@RequiresPermissions("cms:score:view")
	@RequestMapping(value = "detail2")
	public String detail2(Score score,Model model,String uid) {
		uid=score.getUserId();
		//System.out.println("uid======="+uid);
		List<ScoreDetail> scoredetail = scoreDetailService.findscoreDetail(uid); 
		model.addAttribute("scoredetail", scoredetail);
		return "modules/cms/scoreDetail";
	}
	
	
	//该方法用于通过id查找一条记录，用于修改
	@RequiresPermissions("cms:score:view")
	@RequestMapping(value = "edit")
	public String edit(Score score,Model model,String id) {
		id=score.getId();
		//System.out.println("uid======="+id);
		Score sc = scoreService.findScoreById(id);
		//System.out.println(sc.getSinScore()+"======="+sc.getMulScore()+"======="+sc.getSumScore());
		model.addAttribute("score", sc);
		return "modules/cms/scoreForm";
	}
	
	
	//该方法用于更新一条记录，暂时用不到
	@RequiresPermissions("cms:score:view")
	@RequestMapping(value = "save")
	public String save(Score score,Model model) {
		//System.out.println("uid======="+id);
		scoreService.updateScore(score);
		return "redirect:" + adminPath + "/cms/score";
	}
	
	
	//该方法用于软删除一条记录
	@RequiresPermissions("cms:score:view")
	@RequestMapping(value = "delete")
	public String deleteScore(Score score,Model model) {
		//System.out.println("uid======="+id);
		scoreService.deleteScore(score);
		return "redirect:" + adminPath + "/cms/score";
	}
	
	//该方法用于联级查询，显示成绩详情，根据用户id查询所做题目信息，以及答题信息
	
	@RequiresPermissions("cms:score:view")
	@RequestMapping(value = "detail")
	public String detail(String uid, String paperId ,Model model) {
		//uid=score.getUserId();
		//System.out.println("uid======="+uid);
		List<Subject> subject = subjectService.findSubject(uid,paperId); 
		//List<ScoreDetail> scoredetail = scoreDetailService.findscoreDetail(uid);
		//System.out.println("题目数量===="+subject.size());
		//System.out.println("题目详情===="+subject.toString());
		//System.out.println("成绩数量===="+scoredetail.size());
		//System.out.println("成绩详情===="+scoredetail.toString());
		model.addAttribute("subject", subject);
		if (subject.size()!=0) {
			model.addAttribute("message", "data");
		}else {
			model.addAttribute("message", "noneData");
		}
		//model.addAttribute("scoredetail", scoredetail);
		return "modules/cms/scoreDetail2";
		
	}
	
	
	
	
}











