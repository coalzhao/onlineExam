/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.cms.entity;

import java.util.List;

import org.hibernate.validator.constraints.Length;

import com.google.common.collect.Lists;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.TreeEntity;

/**
 * 题根Entity
 * @author SunJiaMing
 * @version 2017-11-28
 */
public class SubjectRoot extends TreeEntity<SubjectRoot> {

    public static final String DEFAULT_TEMPLATE = "frontList";

	private static final long serialVersionUID = 1L;

//	private Category parent;// 父级菜单
//	private String parentIds;// 所有父级编号
//	private String name; 	// 栏目名称
	private String description; 	// 描述，填写有助于搜索引擎优化
	private String keywords; 	// 关键字，填写有助于搜索引擎优化
//	private Integer sort; 		// 排序（升序）
	private String inMenu; 		// 是否在导航中显示（1：显示；0：不显示）
	private String inList; 		// 是否在分类页中显示列表（1：显示；0：不显示）
	private String showModes; 	// 展现方式（0:有子栏目显示栏目列表，无子栏目显示内容列表;1：首栏目内容列表；2：栏目第一条内容）
	
	
	private int easyRadio;//易单选数
	private int hardRadio;//难单选数
	private int easyMultiple;//易多选数
	private int hardMultiple;//难多选数
	
	private List<SubjectRoot> childList = Lists.newArrayList(); 	// 拥有子分类列表

	public SubjectRoot(){
		super();
		this.sort = 30;
		this.inMenu = Global.HIDE;
		this.inList = Global.SHOW;
		this.showModes = "0";
		this.delFlag = DEL_FLAG_NORMAL;
	}

	public int getEasyRadio() {
		return easyRadio;
	}

	public void setEasyRadio(int easyRadio) {
		this.easyRadio = easyRadio;
	}

	public int getHardRadio() {
		return hardRadio;
	}

	public void setHardRadio(int hardRadio) {
		this.hardRadio = hardRadio;
	}

	public int getEasyMultiple() {
		return easyMultiple;
	}

	public void setEasyMultiple(int easyMultiple) {
		this.easyMultiple = easyMultiple;
	}

	public int getHardMultiple() {
		return hardMultiple;
	}

	public void setHardMultiple(int hardMultiple) {
		this.hardMultiple = hardMultiple;
	}

	public SubjectRoot(String id){
		this();
		this.id = id;
	}
	
	public SubjectRoot getParent() {
		return parent;
	}

	public void setParent(SubjectRoot parent) {
		this.parent = parent;
	}

	public List<SubjectRoot> getChildList() {
		return childList;
	}

	public void setChildList(List<SubjectRoot> childList) {
		this.childList = childList;
	}

	
	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getKeywords() {
		return keywords;
	}

	public void setKeywords(String keywords) {
		this.keywords = keywords;
	}

	@Length(min=1, max=1)
	public String getInMenu() {
		return inMenu;
	}

	public void setInMenu(String inMenu) {
		this.inMenu = inMenu;
	}

	@Length(min=1, max=1)
	public String getInList() {
		return inList;
	}

	public void setInList(String inList) {
		this.inList = inList;
	}

	@Length(min=1, max=1)
	public String getShowModes() {
		return showModes;
	}

	public void setShowModes(String showModes) {
		this.showModes = showModes;
	}
	
	public static void sortList(List<SubjectRoot> list, List<SubjectRoot> sourcelist, String parentId){
		for (int i=0; i<sourcelist.size(); i++){
			SubjectRoot e = sourcelist.get(i);
			if (e.getParent()!=null && e.getParent().getId()!=null
					&& e.getParent().getId().equals(parentId)){
				list.add(e);
				// 判断是否还有子节点, 有则继续获取子节点
				for (int j=0; j<sourcelist.size(); j++){
					SubjectRoot child = sourcelist.get(j);
					if (child.getParent()!=null && child.getParent().getId()!=null
							&& child.getParent().getId().equals(e.getId())){
						sortList(list, sourcelist, e.getId());
						break;
					}
				}
			}
		}
	}
	
	public String getIds() {
		return (this.getParentIds() !=null ? this.getParentIds().replaceAll(",", " ") : "") 
				+ (this.getId() != null ? this.getId() : "");
	}

	public boolean isRoot(){
		return isRoot(this.id);
	}
	
	public static boolean isRoot(String id){
		return id != null && id.equals("1");
	}

	@Override
	public String toString() {
		return "SubjectRoot [description=" + description + ", keywords=" + keywords + ", inMenu=" + inMenu + ", inList="
				+ inList + ", showModes=" + showModes + ", easyRadio=" + easyRadio + ", hardRadio=" + hardRadio
				+ ", easyMultiple=" + easyMultiple + ", hardMultiple=" + hardMultiple + ", childList=" + childList
				+ "]";
	}

	

}