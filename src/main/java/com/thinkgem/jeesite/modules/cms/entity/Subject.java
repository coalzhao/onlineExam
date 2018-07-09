package com.thinkgem.jeesite.modules.cms.entity;

import javax.validation.constraints.NotNull;


import com.thinkgem.jeesite.common.persistence.DataEntity;
import com.thinkgem.jeesite.modules.sys.entity.User;

/**
 * 题目Entity
 * @author SunJiaMing
 * @version 2017-11-27
 */
public class Subject extends DataEntity<Subject> {
	
	@Override
	public String toString() {
		return "Subject [title=" + title + ", a=" + a + ", b=" + b + ", c=" + c + ", d=" + d + ", e=" + e + ", f=" + f
				+ ", g=" + g + ", correct=" + correct + ", type=" + type + ", complexity=" + complexity + ", judge="
				+ judge + ", simulate=" + simulate + ", user=" + user + ", subjectRoot=" + subjectRoot
				+ ", scoreDetail=" + scoreDetail + ", userAnswer=" + userAnswer + ", result=" + result + "]";
	}

	private static final long serialVersionUID = 1L;
	private String title;// 题目
	private String a;// 选项a
	private String b;// 选项b
	private String c;// 选项c
	private String d;// 选项d
	private String e;// 选项e
	private String f;// 选项f
	private String g;// 选项g
	private String correct;// 正确选项
	private String type;// 题型
	private String complexity;// 难易程度
	private String judge;//判断是否为图片题(选项)
	private String simulate;//判断是否为模拟题(1:是，0:不是)
	
	private User user;
	private SubjectRoot subjectRoot;// 题根
	
	private ScoreDetail scoreDetail;// 成绩详情
	private String userAnswer;    //用户选择的选项
	private String result;    //判断结果是否正确
	
//	private String aa; //临时存储图片地址a
//	private String bb; //临时存储图片地址b
//	private String cc; //临时存储图片地址c
//	private String dd; //临时存储图片地址d
//	private String ee; //临时存储图片地址e
//	private String ff; //临时存储图片地址f
//	private String gg; //临时存储图片地址g
	
	public String getSimulate() {
		return simulate;
	}

	public void setSimulate(String simulate) {
		this.simulate = simulate;
	}

	public String getJudge() {
		return judge;
	}

	public void setJudge(String judge) {
		this.judge = judge;
	}

	public String getUserAnswer() {
		return userAnswer;
	}

	public void setUserAnswer(String userAnswer) {
		this.userAnswer = userAnswer;
	}

	public String getResult() {
		return result;
	}

	public void setResult(String result) {
		this.result = result;
	}

	public ScoreDetail getScoreDetail() {
		return scoreDetail;
	}

	public void setScoreDetail(ScoreDetail scoreDetail) {
		this.scoreDetail = scoreDetail;
	}

	public Subject() {
		super();
	}
	
	public Subject(SubjectRoot subjectRoot) {
		this();
		this.subjectRoot=subjectRoot;
	}

	public Subject(String id) {
		this();
		this.id = id;
	}
	
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getA() {
		return a;
	}

	public void setA(String a) {
		this.a = a;
	}

	public String getB() {
		return b;
	}

	public void setB(String b) {
		this.b = b;
	}

	public String getC() {
		return c;
	}

	public void setC(String c) {
		this.c = c;
	}

	public String getD() {
		return d;
	}

	public void setD(String d) {
		this.d = d;
	}

	public String getE() {
		return e;
	}

	public void setE(String e) {
		this.e = e;
	}

	public String getF() {
		return f;
	}

	public void setF(String f) {
		this.f = f;
	}

	public String getG() {
		return g;
	}

	public void setG(String g) {
		this.g = g;
	}
	

	public String getCorrect() {
		return correct;
	}

	public void setCorrect(String correct) {
		this.correct = correct;
	}

	@NotNull
	public String getType() {
		return type;
	}
	
	public void setType(String type) {
		this.type = type;
	}

	public SubjectRoot getSubjectRoot() {
		return subjectRoot;
	}

	public void setSubjectRoot(SubjectRoot subjectRoot) {
		this.subjectRoot = subjectRoot;
	}
	@NotNull
	public String getComplexity() {
		return complexity;
	}

	public void setComplexity(String complexity) {
		this.complexity = complexity;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((a == null) ? 0 : a.hashCode());
		result = prime * result + ((b == null) ? 0 : b.hashCode());
		result = prime * result + ((c == null) ? 0 : c.hashCode());
		result = prime * result + ((complexity == null) ? 0 : complexity.hashCode());
		result = prime * result + ((correct == null) ? 0 : correct.hashCode());
		result = prime * result + ((d == null) ? 0 : d.hashCode());
		result = prime * result + ((e == null) ? 0 : e.hashCode());
		result = prime * result + ((f == null) ? 0 : f.hashCode());
		result = prime * result + ((g == null) ? 0 : g.hashCode());
		result = prime * result + ((subjectRoot == null) ? 0 : subjectRoot.hashCode());
		result = prime * result + ((title == null) ? 0 : title.hashCode());
		result = prime * result + ((type == null) ? 0 : type.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (!super.equals(obj))
			return false;
		if (getClass() != obj.getClass())
			return false;
		Subject other = (Subject) obj;
		if (a == null) {
			if (other.a != null)
				return false;
		} else if (!a.equals(other.a))
			return false;
		if (b == null) {
			if (other.b != null)
				return false;
		} else if (!b.equals(other.b))
			return false;
		if (c == null) {
			if (other.c != null)
				return false;
		} else if (!c.equals(other.c))
			return false;
		if (complexity == null) {
			if (other.complexity != null)
				return false;
		} else if (!complexity.equals(other.complexity))
			return false;
		if (correct == null) {
			if (other.correct != null)
				return false;
		} else if (!correct.equals(other.correct))
			return false;
		if (d == null) {
			if (other.d != null)
				return false;
		} else if (!d.equals(other.d))
			return false;
		if (e == null) {
			if (other.e != null)
				return false;
		} else if (!e.equals(other.e))
			return false;
		if (f == null) {
			if (other.f != null)
				return false;
		} else if (!f.equals(other.f))
			return false;
		if (g == null) {
			if (other.g != null)
				return false;
		} else if (!g.equals(other.g))
			return false;
		if (subjectRoot == null) {
			if (other.subjectRoot != null)
				return false;
		} else if (!subjectRoot.equals(other.subjectRoot))
			return false;
		if (title == null) {
			if (other.title != null)
				return false;
		} else if (!title.equals(other.title))
			return false;
		if (type == null) {
			if (other.type != null)
				return false;
		} else if (!type.equals(other.type))
			return false;
		return true;
	}
	
	
}
