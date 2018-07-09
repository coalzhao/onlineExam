package com.thinkgem.jeesite.modules.cms.web;



import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.cms.entity.DataStatistics;
import com.thinkgem.jeesite.modules.cms.entity.SubjectData;
import com.thinkgem.jeesite.modules.cms.entity.SubjectRoot;
import com.thinkgem.jeesite.modules.cms.service.DataService;
import com.thinkgem.jeesite.modules.sys.entity.User;
/**
 * 数据处理
 * @author cofe
 *
 */
@Controller
@RequestMapping(value = "${adminPath}/cms/data")
public class DataController extends BaseController{
	
	@Autowired
	private DataService dataService;
	
	
	/**
	 * 题目数据统计
	 * @return
	 */
	@RequestMapping("goSubDataSelect")
	public String goSubjectData(Model model,HttpServletRequest request){
		List<SubjectRoot> subjectRootData = dataService.selectSubjectRootData();
		request.getSession().setAttribute("subjectRoot", subjectRootData);
		return "modules/cms/data/subDataSelect";
	}
	
	@RequestMapping("subDataSelect")
	@ResponseBody
	public Object selectSubjectData(){
		List<SubjectData>list=dataService.selectSubData();
		return list;
	}
	/**
	 * 查询模块下题目数据
	 * @return
	 */
	@RequestMapping("selectModelData")
	@ResponseBody
	public Object selectModelData(String id,Model model){
		List<SubjectData>list=dataService.selectModelData(id);
		return list;
	}
	
	/**
	 * 跳转到试卷数据统计页面
	 * @return
	 */
	@RequestMapping("goDataSelect")
	public String goDataSelect(HttpServletRequest request, HttpServletResponse response,DataStatistics dataStatistics,Model model){
		List<User>user=dataService.selectUser();
		request.getSession().setAttribute("users", user);
		Page<DataStatistics> page = dataService.findData(new Page<DataStatistics>(request, response), dataStatistics);
        model.addAttribute("page", page);
		return "modules/cms/data/dataSelect";
	}
	
	/**
	 * 试卷数据统计
	 * @return
	 */
	@RequestMapping("statistics")
	public String statistics(HttpServletRequest request, HttpServletResponse response,DataStatistics dataStatistics,Model model){
		model.addAttribute("beginTime", dataStatistics.getBeginTime());
		model.addAttribute("endTime", dataStatistics.getEndTime());
		Page<DataStatistics> page = dataService.findData(new Page<DataStatistics>(request, response), dataStatistics);
        model.addAttribute("page", page);
		return "modules/cms/data/dataSelect";
	}
	
	/**
	 * 导出试卷数据
	 * @param user
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
    @RequestMapping(value = "export", method=RequestMethod.POST)
    public String exportFile(DataStatistics dataStatistics, HttpServletRequest request, HttpServletResponse response, RedirectAttributes redirectAttributes) {
    	Page<DataStatistics> page = dataService.findData(new Page<DataStatistics>(request, response), dataStatistics);
    	try {
			DataService.write(page.getList());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:" + adminPath + "/cms/data/statistics?repage";
    }
}
