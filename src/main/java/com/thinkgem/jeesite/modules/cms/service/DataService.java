package com.thinkgem.jeesite.modules.cms.service;

import java.io.FileOutputStream;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.modules.cms.dao.DataDao;
import com.thinkgem.jeesite.modules.cms.entity.DataStatistics;
import com.thinkgem.jeesite.modules.cms.entity.Paper;
import com.thinkgem.jeesite.modules.cms.entity.SubjectData;
import com.thinkgem.jeesite.modules.cms.entity.SubjectRoot;
import com.thinkgem.jeesite.modules.sys.entity.User;

@Service
public class DataService extends CrudService<DataDao,Paper>{
	
	@Autowired
	private DataDao dao;

	public List<User> selectUser() {
		return dao.selectUser();
	}
	/**
	 * 试卷信息统计:出卷数量，修改数量，出题数量，统计数量
	 * @param page
	 * @param dataStatistics
	 * @return
	 */
	public Page<DataStatistics> findData(Page<DataStatistics> page, DataStatistics dataStatistics) {
		if(dataStatistics ==null) dataStatistics=new DataStatistics();
		dataStatistics.setPage(page);
		page.setList(dao.dataStatistics(dataStatistics));
		return page;
	}
	/**
	 * 表格写入
	 * @param list
	 * @throws Exception 
	 */
	public static void write(List<DataStatistics> list) throws Exception {
		// 第一步，创建一个webbook，对应一个Excel文件  
        HSSFWorkbook wb = new HSSFWorkbook();  
        // 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet  
        HSSFSheet sheet = wb.createSheet("数据统计");  
        // 第三步，在sheet中添加表头第0行,注意老版本poi对Excel的行数列数有限制short  
        HSSFRow row = sheet.createRow((int) 0);  
        // 第四步，创建单元格，并设置值表头 设置表头居中  
        HSSFCellStyle style = wb.createCellStyle();  
        style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式  

        HSSFCell cell = row.createCell((short) 0);  
        cell.setCellValue("姓名");  
        cell.setCellStyle(style);  
        cell = row.createCell((short) 1);  
        cell.setCellValue("真题试卷数量");  
        cell.setCellStyle(style);  
        cell = row.createCell((short) 2);  
        cell.setCellValue("模拟试卷数量");  
        cell.setCellStyle(style);
        // 第五步，写入实体数据 实际应用中这些数据从数据库得到，  
        
        for (int i = 0; i < list.size(); i++)  
        {  
            row = sheet.createRow((int) i + 1);  
            DataStatistics data = (DataStatistics) list.get(i);  
            // 第四步，创建单元格，并设置值  
            row.createCell((short) 0).setCellValue( data.getCreateBy().getLoginName());  
            row.createCell((short) 1).setCellValue(data.getPaperNum());  
            row.createCell((short) 2).setCellValue(data.getPapSimNum()); 
        }  
        // 第六步，将文件存到指定位置  
        try  
        {  
        	String fileName = "用户数据"+DateUtils.getDate("yyyyMMddHHmmss")+".xlsx";
            FileOutputStream fout = new FileOutputStream("E:/"+fileName+".xls");  
            wb.write(fout);  
            fout.close();  
        }  
        catch (Exception e)  
        {  
            e.printStackTrace();  
        }  
	}
	/**
	 * 一级模块查询
	 */
	public List<SubjectRoot> selectSubjectRootData() {
		return dao.selectSubjectRoot();
	}
	/**
	 *所有模块下数据统计
	 * @return
	 */
	public List<SubjectData> selectSubData() {
		return dao.selectSubData();
	}
	/**
	 * 模块下题目数据统计
	 * @param id
	 * @return
	 */
	public List<SubjectData> selectModelData(String id) {
		return dao.selectModelData(id);
	}
	
	

	
}
