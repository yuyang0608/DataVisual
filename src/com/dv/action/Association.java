package com.dv.action;

import java.util.Date;
import java.util.List;

import org.apache.struts2.ServletActionContext;
import org.rosuda.JRI.RFactor;
import org.rosuda.JRI.Rengine;

import com.dv.action.base.DataMiningBaseAction;
import com.dv.util.Export_excelBean;
import com.dv.util.Export_imageBean;
import com.dv.util.StaticData;

@SuppressWarnings("serial")
public class Association extends DataMiningBaseAction{
	private String ids;
	private String center;//kmeans,clara,pam
	private String itermax;//kmeans
	//private String nstart;//kmeans
	//private String algorithm;//kmeans
	private String savaPath;
	private String imagename;
	private String imagename1;

	private List<Export_excelBean> excellist=null;
	private List<Export_imageBean> imagelist=null;

	private String[] allrules=null;
	private double aprinfo[][]=null;

	@SuppressWarnings("deprecation")
	public String getSavaPath() {
		return ServletActionContext.getRequest().getRealPath(savaPath);
	}
	public void setSavaPath(String savaPath) {
		this.savaPath = savaPath;
	}
	
	public String Apriori()
	{
		String imagepath=getSavaPath().replace("\\", "//")+"//";
		imagename="result"+new Date().getTime()+".png";
		imagename1="result1"+new Date().getTime()+".png";
		StaticData sd = StaticData.getInstance();
		sd.setAr();
		Rengine c=sd.re;
		c.eval("rules<-apriori(data);");
		c.eval("{" +
				"setwd('"+imagepath+"');" +
				"png(file='"+imagename+"',bg='transparent');" +
				"plot(rules, method='graph', control=list(type='items'));" +
				"dev.off();" +
				"}");
		c.eval("allrules<-as(rules,'data.frame')");
		RFactor rf=c.eval("allrules[,1]").asFactor();
		allrules=new String[rf.size()];
		for (int i = 0; i < rf.size(); i++) {
			allrules[i]=rf.at(i);
		}
		aprinfo=c.eval("as.matrix(allrules[,c(2,3,4)])").asDoubleMatrix();
		c.eval("rm('rules')");
		c.eval("rm('allrules')");
		return "apriori";
	}

	
	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	public String getCenter() {
		return center;
	}

	public void setCenter(String center) {
		this.center = center;
	}

	public String getItermax() {
		return itermax;
	}

	public void setItermax(String itermax) {
		this.itermax = itermax;
	}
	
	public String getImagename() {
		return imagename;
	}
	public void setImagename(String imagename) {
		this.imagename = imagename;
	}

	public String getImagename1() {
		return imagename1;
	}
	public void setImagename1(String imagename1) {
		this.imagename1 = imagename1;
	}
	public String[] getAllrules() {
		return allrules;
	}
	public void setAllrules(String[] allrules) {
		this.allrules = allrules;
	}
	public double[][] getAprinfo() {
		return aprinfo;
	}
	public void setAprinfo(double[][] aprinfo) {
		this.aprinfo = aprinfo;
	}

}
