package com.thinkgem.jeesite.modules.cms.web;

import static org.hamcrest.CoreMatchers.instanceOf;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mysql.fabric.xmlrpc.base.Array;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.cms.entity.Paper;
import com.thinkgem.jeesite.modules.cms.entity.Score;
import com.thinkgem.jeesite.modules.cms.entity.ScoreDetail;
import com.thinkgem.jeesite.modules.cms.entity.Subject;
import com.thinkgem.jeesite.modules.cms.entity.SubjectRoot;
import com.thinkgem.jeesite.modules.cms.service.PaperService;
import com.thinkgem.jeesite.modules.cms.service.ScoreDetailService;
import com.thinkgem.jeesite.modules.cms.service.ScoreService;
import com.thinkgem.jeesite.modules.cms.service.SubjectRootService;
import com.thinkgem.jeesite.modules.cms.service.SubjectService;
import com.thinkgem.jeesite.modules.cms.utils.CmsUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * 试卷Controller
 * 
 * @author SunJiaMing
 * @version 2017-12-28
 */
@Controller
@RequestMapping(value = "${adminPath}/cms/paper")
public class PaperController extends BaseController {

	private static final String EASY = "1";
	private static final String HARD = "2";
	private static final String NSIMU = "0";
	private static final String SIMU = "1";
	private static final String COMPLEXITY = "complexity";//难易程度
	private static final String SIMULATE = "simulate";//模拟题
	
	@Autowired
	private PaperService paperService;
	@Autowired
	private SubjectRootService subjectRootService;
	@Autowired
	private SubjectService subjectService;
	@Autowired
	private ScoreDetailService scoreDetailService;
	@Autowired
	private ScoreService scoreService;

	@ModelAttribute
	public Paper get(@RequestParam(required = false) String id) {
		if (StringUtils.isNotBlank(id)) {
			return paperService.get(id);
		} else {
			return new Paper();
		}
	}

	/**
	 * 真题试卷列表
	 * @author SunJiaMing
	 */
	@RequiresPermissions("cms:paper:view")
	@RequestMapping(value = "list")
	public String list(Paper paper, HttpServletRequest request, HttpServletResponse response, Model model) {
		System.out.println(">>>>>>>>>>>>>>1");
		Page<Paper> page = paperService.findPage(new Page<Paper>(request, response), paper);
		System.out.println(">>>>>>>>>>>>>>2");
		List<Paper> papList=filtratePaperList(NSIMU, page.getList());//真题试卷集合
		System.out.println(">>>>>>>>>>>>>>3");
		page.setList(papList);
		model.addAttribute("page", page);
		return "modules/cms/paperListView";
	}
	
	/**
	 * 模拟试卷列表
	 * @author SunJiaMing
	 */
	@RequiresPermissions("cms:paper:view")
	@RequestMapping(value ="simuList")
	public String simulateList(Paper paper, HttpServletRequest request, HttpServletResponse response, Model model) {
		System.out.println(">>>>>>>>>>>>>>1");
		Page<Paper> page = paperService.findPage(new Page<Paper>(request, response), paper);
		System.out.println(">>>>>>>>>>>>>>2");
		List<Paper> list=filtratePaperList(SIMU, page.getList());//模拟试卷集合
		System.out.println(">>>>>>>>>>>>>>3");
		page.setList(list);
		model.addAttribute("page", page);
		return "modules/cms/simulatePaperListView";
	}
	
	/**
	   * 手机端模拟考试试卷列表
	   * @author coalZhao
	   */
	  @RequiresPermissions("cms:paper:view")
	  @RequestMapping(value ="simuListMobile")
	  public String simuListMobile(Model model) {
	    List<Paper> simPaperList = paperService.getSimPaper();
	    if(simPaperList.size()==0) {
	      model.addAttribute("msg","error");
	      //System.out.println("方法结束");
	      return "modules/cms/paperList";
	    }else {
	      Paper p = new Paper();
	      String userId = p.getCurrentUser().getId();
	      model.addAttribute("uid",userId);
	    }
	    model.addAttribute("simPaperList", simPaperList);
	    return "modules/cms/paperList";
	  }

	// 试卷列表
	@RequiresPermissions("cms:paper:view")
	@RequestMapping(value = "listPaper")
	public String listPaper(Model model) {
	    List<Paper> paperList = paperService.getAllPaper();
	    //System.out.println("试卷信息，打印题目数量"+paperList.size());
	    if(paperList.size()==0) {
	       model.addAttribute("msg","error");
	       //System.out.println("方法结束");
	      return "modules/cms/paperList";
	    }else {
	    Paper p = new Paper();
	        String userId = p.getCurrentUser().getId();
	        int count = 0;
	       for(int i=0;i<paperList.size();i++) {  //judgePaper方法是用来判断考生是否是第一次选择试卷，如果count为0则表示还没有作答过试卷，将随机从paperList中选择一套试卷用于展示，
	          count = scoreDetailService.judgePaper(userId, paperList.get(i).getId());  //count不为0表示该考生已经选择过一次试卷，则根据List中的试卷id去查找该试卷，用于展示。
	         if(count != 0) {
	           Paper paper = paperService.get(paperList.get(i).getId());
	           model.addAttribute("paper", paper);
	           break;
	         }
	       }
	       if(count==0) {
	    	   Random ran = new Random();
	         Collections.shuffle(paperList);
	         model.addAttribute("paper", paperList.get(ran.nextInt(paperList.size())));
	       ScoreDetail detail = new ScoreDetail();
	         detail.setUserId(userId);
	         detail.setPaperId(paperList.get(0).getId());
	         scoreDetailService.save(detail); 
	       }
	        model.addAttribute("uid",userId);
	        //System.out.println("else方法结束");
	    return "modules/cms/paperList";}
	  }

	@RequiresPermissions("cms:paper:view")
	@RequestMapping(value = "form")
	public String form(Model model,Paper paper) {
		model.addAttribute("subjectRootList", subjectRootService.findByUser(true));
		return "modules/cms/paperCreatAuto";
	}

	@RequiresPermissions("cms:paper:view")
	@RequestMapping(value = "simuform")
	public String simuForm(Model model,Paper paper) {
		model.addAttribute("subjectRootList", subjectRootService.findByUser(true));
		return "modules/cms/simulatePaperCreatAuto";
	}
	
	/**
	 * 编辑试卷
	 * @author SunJiaMing
	 */
	@RequiresPermissions("cms:paper:edit")
	@RequestMapping(value = "edit")
	public String paperEdit(Model model, Paper paper) {
		subjectService.findSubjectByPaper(paper);// 查询试卷对应的所有试题并存入试卷类中
		paper.setPaperStatus("0");//未发布
		paperService.save(paper);
	  	model.addAttribute("paper", paper);
	  	model.addAttribute("subjectRootList", subjectRootService.findByUser(true));//获取题根树
		return "modules/cms/paperEdit";
	}
	
	/**
	 * 预览试卷
	 * @author SunJiaMing
	 */
	@RequiresPermissions("cms:paper:edit")
	@RequestMapping(value = "preview")
	public String paperPreview(Model model, Paper paper) {
		subjectService.findSubjectByPaper(paper);// 查询试卷对应的所有试题并存入试卷类中
	  	model.addAttribute("paper", paper);
//	  	if("1".equals(decide)) {//预览操作
//	  		return "modules/cms/paperPreview";
//	  	}
		return "modules/cms/paperPreview";
	}

	@RequiresPermissions("cms:paper:audit")
	@RequestMapping(value = "delete")
	public String delete( Paper paper, RedirectAttributes redirectAttributes) {
		System.out.println("==============="+paper.getId());
		// 如果没有审核权限，则不允许删除。
		if (!UserUtils.getSubject().isPermitted("cms:subject:audit")){
			addMessage(redirectAttributes, "你没有删除权限");
		}
		paperService.delete(paper);
		paperService.delAllSubject(paper.getId());
		addMessage(redirectAttributes, "删除试卷成功");
		
		System.out.println("》》》》》》》》》》"+paper.getSimulate());
		System.out.println("》》》》》》》》》》"+NSIMU.equals(paper.getSimulate()));
		
		if(NSIMU.equals(paper.getSimulate())) {//返回真题列表
			return "redirect:" + adminPath + "/cms/paper/list";
		}
		return "redirect:" + adminPath + "/cms/paper/simuList";
	}
	
	/**
	 * 获取题型数量
	 * @author SunJiaMing
	 */
	@ResponseBody
	@RequiresPermissions("cms:paper:view")
	@RequestMapping(value = "getNumber")
	public Object getNumber(String id) {
		List<Subject> rl = subjectService.findRadioBySubjectRoot(id);// 当前题根下的单选题
		List<Subject> ml = subjectService.findMultipleBySubjectRoot(id);// 当前题根下的多选题
		int[] num = { filtrateList(EASY, rl,COMPLEXITY).size(), filtrateList(HARD, rl,COMPLEXITY).size(), filtrateList(EASY, ml,COMPLEXITY).size(),
				filtrateList(HARD, ml,COMPLEXITY).size() };
		return num;
	}
	
	/**
	 * 获取题型数量
	 * @author SunJiaMing
	 */
	@ResponseBody
	@RequiresPermissions("cms:paper:view")
	@RequestMapping(value = "getSimuNumber")
	public Object getSimulateNumber(String id) {
		List<Subject> rl = subjectService.findRadioBySubjectRoot(id);// 当前题根下的单选题
		List<Subject> ml = subjectService.findMultipleBySubjectRoot(id);// 当前题根下的多选题
		rl=filtrateList(SIMU, rl, SIMULATE);
		ml=filtrateList(SIMU, ml, SIMULATE);
		int[] num = { filtrateList(EASY, rl,COMPLEXITY).size(), filtrateList(HARD, rl,COMPLEXITY).size(), filtrateList(EASY, ml,COMPLEXITY).size(),
				filtrateList(HARD, ml,COMPLEXITY).size() };
		return num;
	}

	/**
	 * 删除试题
	 * @author SunJiaMing
	 */
	@ResponseBody
	@RequiresPermissions("cms:paper:audit")
	@RequestMapping(value = "delSubject")
	public String delSubject(String paperId, String subId,int rn,int mn) {
		System.out.println(paperId + "========" + subId);
		paperService.delSubject(paperId, subId);
		CmsUtils.subjectSort(paperId);
		Paper paper= paperService.get(paperId);
		paper.setRadioNumber(rn);
		paper.setMultipleNumber(mn);
		paperService.save(paper);
		return "success";
	}

	/**
	 * 修改&添加试题
	 * @author SunJiaMing
	 */
	@ResponseBody
	@RequiresPermissions("cms:paper:edit")
	@RequestMapping(value = "alterSubject")
	public Object alterSubject(String paperId, String subId, String id,int rn,int mn) {
		Paper paper= paperService.get(paperId);
		paper.setRadioNumber(rn);
		paper.setMultipleNumber(mn);
		System.out.println(">>>>>>>>>>>>>>>>>>1"+(paperService.getSubject(paperId, id)));
		if (paperService.getSubject(paperId, id) != 0) {//存在且没有被删除
			System.out.println(">>>>>>>>>>>>>>>>>>2");
			return null;
		}
		if ("nu".equals(subId)) {// 添加
//			if(paperService.getDelSubject(paperId, id) != 0) {//存在且被删除
//				paperService.save(paper);
//				paperService.notDelSubject(paperId, id);
//				CmsUtils.subjectSort(paperId);
//				return subjectService.paperGetSubject(id);
//			}
			//不存在
			paperService.save(paper);
			paperService.saveSubject(paperId, id);
			CmsUtils.subjectSort(paperId);
		} else {// 修改
			System.out.println(">>>>>>>>>>>>>>>>>>3");
			paperService.alterSubject(paperId, subId, id);
		}
		return subjectService.paperGetSubject(id);
	}

/*	*//**
	 * 添加试题
	 * @author SunJiaMing
	 *//*
	@ResponseBody
	@RequiresPermissions("cms:paper:view")
	@RequestMapping(value = "addSubject")
	public Object addSubject(String paperId, String id) {
		paperService.creatPaper(paperId, id);
		CmsUtils.subjectSort(paperId);
		return subjectService.get(id);
	}*/

	/**
	 * 查找单选集合
	 * @author SunJiaMing
	 */
	@ResponseBody
	@RequiresPermissions("cms:paper:view")
	@RequestMapping(value = "findSubject")
	public Object find(String rid, String type) {
		if ("1".equals(type)) {
			return subjectService.findRadioBySubjectRoot(rid);
		}
		if ("2".equals(type)) {
			return subjectService.findMultipleBySubjectRoot(rid);
		}
		return "success";
	}
	
	/**
	 * 自动生成试卷
	 * @author SunJiaMing
	 */
	@RequiresPermissions("cms:paper:view")
	@RequestMapping(value = { "auto", "creat" })
	public String autoCreat(Model model, String paperNumber, Paper paper, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, paper)) {
			if(SIMU.equals(paper.getSimulate())) {
				return simuForm(model, paper);
			}else if(NSIMU.equals(paper.getSimulate())) {
				return form(model, paper);
			}
		}
		paper.setId(null);
		Date date = paper.getBeginTime();
		long time = paper.getPaperDuration() * 60 * 1000 + date.getTime();
		paper.setEndTime(new Date(time));
		paperService.save(paper);
		// 调用自动组题算方法
		paperCreat(paper, redirectAttributes);
		System.out.println("^^^^^^^^^^^^^^^^^^^^^^^"+paper.getSimulate());
		// 调用排序方法
		CmsUtils.subjectSort(paper.getId());
		return "redirect:" + adminPath + "/cms/paper/edit?id=" + (paper.getId() != null ? paper.getId() : "");
	}
	/**
	 * 发布（保存）
	 * @author SunJiaMing
	 */
	@RequiresPermissions("cms:paper:edit")
	@RequestMapping(value = "save")
	public String save(Model model, Paper paper) {
		System.out.println("================");
		Date date = paper.getBeginTime();
		long time = paper.getPaperDuration() * 60 * 1000 + date.getTime();
		paper.setEndTime(new Date(time));
		paper.setPaperStatus("1");//发布
		paperService.save(paper);
		// 调用排序方法
		CmsUtils.subjectSort(paper.getId());
		if(SIMU.equals(paper.getSimulate())) {
			return "redirect:" + adminPath + "/cms/paper/simuList";
		}
		return "redirect:" + adminPath + "/cms/paper/list";
	}

	/**
	 * 试卷生成方法
	 * @author SunJiaMing
	 */
	private void paperCreat(Paper paper, RedirectAttributes redirectAttributes) {
		List<Subject> endList = new ArrayList<Subject>();
		for (int j = 0; j < paper.getSubRootList().size(); j++) {
			SubjectRoot subRoot = paper.getSubRootList().get(j);
			List<Subject> rl = subjectService.findRadioBySubjectRoot(subRoot.getId());// 当前题根下的单选题
			List<Subject> ml = subjectService.findMultipleBySubjectRoot(subRoot.getId());// 当前题根下的多选题
			if(SIMU.equals(paper.getSimulate())) {//模拟卷
				rl = filtrateList(SIMU, rl, SIMULATE);// 当前题根下的单选题
				ml = filtrateList(SIMU, ml, SIMULATE);// 当前题根下的多选题
			}
			extract(filtrateList(EASY, rl,COMPLEXITY), endList, redirectAttributes, subRoot.getEasyRadio());// 筛选单选简单集合
			extract(filtrateList(HARD, rl,COMPLEXITY), endList, redirectAttributes, subRoot.getHardRadio());// 筛选单选困难集合
			extract(filtrateList(EASY, ml,COMPLEXITY), endList, redirectAttributes, subRoot.getEasyMultiple());// 筛选多选简单集合
			extract(filtrateList(HARD, ml,COMPLEXITY), endList, redirectAttributes, subRoot.getHardMultiple());// 筛选多选困难集合
		}
		for (Subject subject : endList) {
			if ("1".equals(subject.getType())) {
				paperService.creatPaper(paper.getId(), subject.getId());
			} else if ("2".equals(subject.getType())) {
				paperService.creatPaper(paper.getId(), subject.getId());
			}
		}
	}

	/**
	 * 集合筛选方法
	 * 筛选试题（0：难易；1：真题模拟）
	 * 筛选试卷
	 * @author SunJiaMing
	 */
	private List<Subject> filtrateList(String complexity, List<Subject> parentList,String judge) {
		List<Subject> subList = new ArrayList<Subject>();
		if("complexity".equals(judge)) {
			for (Subject subject : parentList) {
				if(complexity.equals(subject.getComplexity())) {
					subList.add(subject);
				}
			}
		}else if("simulate".equals(judge)) {
			for (Subject subject : parentList) {
				if(complexity.equals(subject.getSimulate())) {
					subList.add(subject);
				}
			}
		}
		return subList;
	}
	
	private List<Paper> filtratePaperList(String complexity, List<Paper> parentList) {//模拟
		List<Paper> papList = new ArrayList<Paper>();
		for (Paper paper : parentList) {
			if(complexity.equals(paper.getSimulate())) {
				papList.add(paper);
			}
		}
		return papList;
	}

	/**
	 * 抽题方法
	 * @author SunJiaMing
	 */
	private void extract(List<Subject> list, List<Subject> endList, RedirectAttributes redirectAttributes, int number) {
		Random random = new Random();
		if (number <= list.size()) {// 单选简单集合抽题
			for (int i = 0; i < number; i++) {
				int j = random.nextInt(list.size());
				endList.add(list.get(j));
				list.remove(j);
			}
		} else {// 题库题目太少
			// addMessage(redirectAttributes, "题目数量不足！");// 弹窗
			System.out.println("题目数量不足！");
		}
	}

	/**
	 * 下一题和上一题的跳转
	 * @author LiWenPeng
	 */
	@RequiresPermissions("cms:paper:view")
	@ResponseBody
	@RequestMapping(value = "next")
	public Object next(String last, String id, String order, String subId, String choose, Model model) {
		// System.out.println("testAjax执行 last: "+last+" id "+id+" order: "+order+"
		// subId "+subId+" choose "+choose);
		if (choose == null || choose.equals("")) {
			choose = "未作答";
		} else {
			String arr[] = choose.split(",");
			Arrays.sort(arr);
			choose = "";
			for (int i = 0; i < arr.length; i++) {
				choose += arr[i] + ",";
			}
			choose = choose.substring(0, choose.length() - 1);
		} // 将答案重新排序为A,B,C,D
		if (subId != null) {
			String answer = subjectService.getAnswerById(subId);// 根据题目id获取答案
			Subject su = subjectService.getSubTypeById(subId);
			ScoreDetail scoreDetail = new ScoreDetail();
			scoreDetail.setTimuType(su.getType());
			scoreDetail.setTimuId(subId);
			scoreDetail.setRelAnswer(answer);
			scoreDetail.setPaperId(id);
			scoreDetail.setUserId(scoreDetail.getCurrentUser().getId());
			scoreDetail.setCreateBy(scoreDetail.getCurrentUser());
			scoreDetail.setCreateDate(new Date());
			scoreDetail.setUpdateBy(scoreDetail.getCurrentUser());
			scoreDetail.setUpdateDate(new Date());// System.out.println("uid======="+id);//System.out.println("当前用户的用户名==============="+scoreDetail.getCurrentUser().getName());
			scoreDetail.setUserAnswer(choose);
			if (choose.equals(answer)) {
				scoreDetail.setResult('T');// System.out.println("界面第"+(i+1)+"道题回答正确===");
			} else {
				scoreDetail.setResult('F');// System.out.println("界面第"+(i+1)+"道题回答错误===");
			}
			String userAnswer = scoreDetailService.isAnswered(scoreDetail);
			if (userAnswer == null) {// 判断用户是否已经答过该题目，防止恶意刷新，重复提交数据,为空表示未作答
				scoreDetailService.save(scoreDetail);
			} else {
				scoreDetailService.updateScoreDetail(scoreDetail);
			}
		}
		int num = Integer.parseInt(order);
		int sum = scoreDetailService.getSubNum(id);// 通过试卷id获取该试卷中共有多少道题目
		if (last.equals("p")) {
			num = num - 1;
		} else {
			num = num + 1;
		}
		int rest = sum - num;// 剩余数量
		Subject subject = subjectService.getSubjectByOrder(id, num);
		// 保存之前的答题情况
		ScoreDetail scoreDetail2 = new ScoreDetail();
		scoreDetail2.setTimuId(subject.getId());
		scoreDetail2.setUserId(scoreDetail2.getCurrentUser().getId());
		scoreDetail2.setPaperId(id);
		String userAnswer2 = scoreDetailService.isAnswered(scoreDetail2);
		if (userAnswer2 != null) {
			model.addAttribute("userAnswer", userAnswer2);
		} else {
			userAnswer2 = "未作答";
			model.addAttribute("userAnswer", userAnswer2);
		}
		Object[] param = new Object[4];
		param[0] = subject;
		param[1] = num;
		param[2] = rest;
		param[3] = userAnswer2;
		return param;
	}

	/**
	 * 答题完毕，提交试卷，倒计时结束，自动提交试卷。
	 * @author LiWenPeng
	 */
	@RequiresPermissions("cms:paper:view")
	@RequestMapping(value = "commit")
	public String commit(String id, String order, String subId, String choose, Model model) {
		if (choose == null || choose.equals("")) {
			choose = "未作答";
		} else {
			String arr[] = choose.split(",");
			Arrays.sort(arr);
			choose = "";
			for (int i = 0; i < arr.length; i++) {
				choose += arr[i] + ",";
			}
			choose = choose.substring(0, choose.length() - 1);
		} // 将答案重新排序为A,B,C,D
		if (subId != null) {
			String answer = subjectService.getAnswerById(subId);// 根据题目id获取答案
			Subject su = subjectService.getSubTypeById(subId);
			ScoreDetail scoreDetail = new ScoreDetail();
			scoreDetail.setTimuType(su.getType());
			scoreDetail.setTimuId(subId);
			scoreDetail.setRelAnswer(answer);
			scoreDetail.setPaperId(id);
			scoreDetail.setUserId(scoreDetail.getCurrentUser().getId());
			scoreDetail.setCreateBy(scoreDetail.getCurrentUser());
			scoreDetail.setCreateDate(new Date());
			scoreDetail.setUpdateBy(scoreDetail.getCurrentUser());
			scoreDetail.setUpdateDate(new Date());// System.out.println("uid======="+id);//System.out.println("当前用户的用户名==============="+scoreDetail.getCurrentUser().getName());
			scoreDetail.setUserAnswer(choose);
			if (choose.equals(answer)) {
				scoreDetail.setResult('T');// System.out.println("界面第"+(i+1)+"道题回答正确===");
			} else {
				scoreDetail.setResult('F');// System.out.println("界面第"+(i+1)+"道题回答错误===");
			}
			String userAnswer = scoreDetailService.isAnswered(scoreDetail);
			if (userAnswer == null) {// 判断用户是否已经答过该题目，防止恶意刷新，重复提交数据,为空表示未作答
				scoreDetailService.save(scoreDetail);
			} else {
				scoreDetailService.updateScoreDetail(scoreDetail);
			}
		}
		Score score = new Score();
		String userId = score.getCurrentUser().getId(); // 获取当前用户id
		Paper p = new Paper(); // 获取该试卷后，获取其单选分值和多选分值
		p = paperService.get(id); // 获取试卷的信息，获取相应的单选分值和多选分值
		int sinScore = (int) p.getRadioScore();
		int mulScore = (int) p.getMultipleScore();
		int sumScore = 0;
		int sinSub = 0; // 单选题个数
		int mulSub = 0; // 多选题个数
		sinSub = scoreDetailService.getSinCount(userId, id, "1", 'T'); // 获取用户成绩详情中单选题正确的个数
		mulSub = scoreDetailService.getMulCount(userId, id, "2", 'T'); // 获取用户成绩详情中多选题正确的个数
		mulScore = mulScore * mulSub;
		sinScore = sinScore * sinSub;
		sumScore = sinScore + mulScore;
		String paperName = scoreService.getPaperName(id);
	    String userName = scoreService.getUserName(score.getCurrentUser().getId());
	    String loginName = score.getCurrentUser().getLoginName();
	    score.setLoginName(loginName);
	    score.setUserName(userName);
		score.setPaperId(id);
		score.setPaperName(paperName);
		score.setSinScore(sinScore);
		score.setMulScore(mulScore);
		score.setSumScore(sumScore);
		score.setUserId(userId);
		score.setCreateBy(score.getCurrentUser());
		score.setCreateDate(new Date());
		String isCommit = scoreService.isCommit(score); // 判断当前用户是否已经答过该试卷
		if (isCommit == null) {
			scoreService.save(score);
		} else {
			scoreService.upScore(score);
		}
		model.addAttribute("score", score);
//		session.setAttribute("score", score);
		return  "modules/cms/close";
	}

	/**
	 * 开始答题，获取试卷对应的题目，试卷的时长
	 * @author LiWenPeng
	 */
	@RequiresPermissions("cms:paper:view")
	@RequestMapping(value = "start")
	public String start(String id, String order, Model model) {
	    int num = Integer.parseInt(order);
	    int sum = scoreDetailService.getSubNum(id);// 通过试卷id获取该试卷中共有多少道题目
	    num = num + 1;
	    int rest = sum - num;// 剩余数量
	    Subject subject = subjectService.getSubjectByOrder(id, num); //获取到的第一道题目
	    if(subject == null) {
	      model.addAttribute("msg", "error");
	      //System.out.println("if方法结束");
	      return "modules/cms/paperTwo";
	    }else {
	    String uid = subject.getCurrentUser().getId();
	    String subId = subject.getId();
	    ScoreDetail sc = new ScoreDetail();
	    sc.setTimuId(subId);
	    sc.setUserId(uid);
	    sc.setPaperId(id);
	    String userAnswer = scoreDetailService.isAnswered(sc);
	    model.addAttribute("userAnswer", userAnswer);
	    String flag = scoreService.judge(uid,id) ;  //判断是否作答过该试卷
	    if(flag==null) {
	      flag = "ok";
	    }
	    Paper p1 = new Paper(); // System.out.println("___________________"+id);
	    p1 = paperService.get(id); // 根据id获得试卷属性//System.out.println("开始时间===="+p1.getBeginTime()+"结束时间==="+p1.getEndTime());
		
	    String paperName = p1.getPaperName();
		int duration = p1.getPaperDuration();
	    Date start = new Date();
	    Date end = p1.getEndTime();
	    long time1 = end.getTime() - start.getTime(); // 用于界面的倒计时效果
	    long time = time1 / 1000;
	    model.addAttribute("subject", subject);
	    model.addAttribute("order", num); // 题目序号
	    model.addAttribute("id", id);// 试卷id
	    model.addAttribute("sum", sum);
	    model.addAttribute("rest", rest);
	    model.addAttribute("time", time);
	    model.addAttribute("paperName", paperName);
		model.addAttribute("duration", duration);
	    model.addAttribute("flag", flag);
	    System.out.println("else方法结束");
	    return "modules/cms/paperTwo";
	    }
	    
	  }
	/**
	 * 校验试卷名称是否重复
	 * 
	 * @param paperName 试卷名称
	 * @return json
	 */
	@ResponseBody  
	@RequestMapping(value = "isExist", produces = "application/json")   
	public String isExist(String paperName) {  
	     
	   List<Paper> list = new ArrayList<Paper>();
			list =    paperService.findPaperName();
	   
		ArrayList<String>  nameList= new ArrayList<String>();
		for (int i = 0; i < list.size(); i++) {
			nameList.add(list.get(i).getPaperName()) ;
			
		}
			   if (nameList.contains(paperName)) {
					 return "{\"id\":\"yes\"}"; 
				}else {
					 return "{\"id\":\"no\"}";  
				}
		
		}       
	   
}
