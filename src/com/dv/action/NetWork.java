package com.dv.action;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.rosuda.JRI.Rengine;

import com.dv.action.base.DataSourceBaseAction;
import com.dv.entity.Filedataset;
import com.dv.util.FileDatasetDetailBean;
import com.dv.util.StaticData;
import com.dv.util.ToolsFactory;
import com.opensymphony.xwork2.ActionContext;

@SuppressWarnings("serial")
public class NetWork extends DataSourceBaseAction{
	private String sid;
	private String separator;
	private String hasheadline;
	private String missing;
	private double filedatasize;
	private int totalrow;
	private List<FileDatasetDetailBean> fddBeans=new ArrayList<FileDatasetDetailBean>();
	private String[] datacolnames;
	
	public String readFileDataset(){
		HttpServletRequest request=ServletActionContext.getRequest();
		Filedataset fd=dsservice.getById(sid);
		separator=fd.getSeparate();
		hasheadline=fd.getHasheadline();
		missing=fd.getMissing();
		filedatasize=Double.parseDouble(fd.getFilesize());
		String filePath=(request.getRealPath("/datasets")+"\\"+fd.getFilepath()).replace("\\", "/");
		StaticData sd = StaticData.getInstance();
		sd.setAr();
		Rengine c=sd.re;
		c.eval("rm(list=ls()");
		if(filedatasize<4)
		{
			c.eval("data<-read.table('"+filePath+"',header="+hasheadline+",sep='"+separator+"')");
			c.eval("{rcolname<-names(data);dim(rcolname)<-c(length(names(data)))}");
			String colnames[]=c.eval("rcolname").asStringArray();
			datacolnames=new String[colnames.length+1];
			for (int i = 0; i <= colnames.length; i++) {
				if(i==0){
					datacolnames[i]="序号";
				}
				else{
					datacolnames[i]=colnames[i-1];
				}
			}
			Map<String,Object> session=ActionContext.getContext().getSession();
			session.remove("colnames");
			session.put("colnames",colnames);
			String coltypes[]=ToolsFactory.getColType(filePath, hasheadline, separator, missing, colnames.length);
			session.remove("coltypes");
			session.put("coltypes",coltypes);
			int missingnum[] = new int[colnames.length];
			double missingratio[]=new double[colnames.length];
			totalrow=c.eval("length(data[,1])").asInt();
			DecimalFormat df=new DecimalFormat("##.##");
			
			if(!missing.equals("无缺失值"))
			{
				for (int i = 0; i < colnames.length; i++) 
				{
					c.eval("data[,"+(i+1)+"][data[,"+(i+1)+"]=='"+missing+"']=NA");
					missingnum[i]=c.eval("sum(is.na(data[,"+(i+1)+"]))").asInt();
					missingratio[i]=(double)missingnum[i]/(double)totalrow;
				}
			}
			else
			{
				for (int i = 0; i < colnames.length; i++) 
				{
					missingnum[i]=0;
					missingratio[i]=0.00;
				}
			}
			//数据集各字段基本信息
			for (int i = 0; i < colnames.length; i++) 
			{
				FileDatasetDetailBean fddb=new FileDatasetDetailBean();
				fddb.setColname(colnames[i]);
				fddb.setColtype(coltypes[i].equals("S")?"字符型":"数值型");
				fddb.setMissingnum(missingnum[i]);
				fddb.setMissingratio(df.format(missingratio[i]*100)+"%");
				//fddb.setMissingratio(Double.toString(missingratio[i]));
				fddBeans.add(fddb);
			}
		
		}
		else if(filedatasize>=4&&filedatasize<=500)
		{
			if(!missing.equals("无缺失值"))
			{
				if(fd.getFiletype().equals("txt"))
				{
					c.eval("data<-read.table.ffdf(file='"+filePath+"',header="+hasheadline+",sep='"+separator+"',first.rows=100,next.rows=5000,na.strings='"+missing+"')");
				}
				else if(fd.getFiletype().equals("csv"))
				{
					c.eval("data<-read.csv.ffdf(file='"+filePath+"',header="+hasheadline+",sep='"+separator+"',first.rows=100,next.rows=5000,na.strings='"+missing+"')");
				}
			}
			else
			{
				if(fd.getFiletype().equals("txt"))
				{
					c.eval("data<-read.table.ffdf(file='"+filePath+"',header="+hasheadline+",sep='"+separator+"',first.rows=100,next.rows=5000,na.strings='')");
				}
				else if(fd.getFiletype().equals("csv"))
				{
					c.eval("data<-read.csv.ffdf(file='"+filePath+"',header="+hasheadline+",sep='"+separator+"',first.rows=100,next.rows=5000,na.strings='')");
				}
			}
			
			c.eval("{rcolname<-names(data);dim(rcolname)<-c(length(names(data)))}");
			String colnames[]=c.eval("rcolname").asStringArray();
			datacolnames=new String[colnames.length+1];
			for (int i = 0; i <= colnames.length; i++) {
				if(i==0){
					datacolnames[i]="序号";
				}
				else{
					datacolnames[i]=colnames[i-1];
				}
			}
			Map<String,Object> session=ActionContext.getContext().getSession();
			session.remove("colnames");
			session.put("colnames",colnames);
			String coltypes[]=ToolsFactory.getColType(filePath, hasheadline, separator, missing, colnames.length);
			session.remove("coltypes");
			session.put("coltypes",coltypes);
			int missingnum[] = new int[colnames.length];
			double missingratio[]=new double[colnames.length];
			totalrow=c.eval("length(data[,1])").asInt();
			DecimalFormat df=new DecimalFormat("##.##");
			
			if(!missing.equals("无缺失值"))
			{
				for (int i = 0; i < colnames.length; i++) 
				{
					//c.eval("data[,"+(i+1)+"][data[,"+(i+1)+"]=='"+missing+"']=NA");
					missingnum[i]=c.eval("sum(is.na(data[,"+(i+1)+"]))").asInt();
					missingratio[i]=(double)missingnum[i]/(double)totalrow;
				}
			}
			else
			{
				for (int i = 0; i < colnames.length; i++) 
				{
					missingnum[i]=0;
					missingratio[i]=0.00;
				}
			}
			for (int i = 0; i < colnames.length; i++) 
			{
				FileDatasetDetailBean fddb=new FileDatasetDetailBean();
				fddb.setColname(colnames[i]);
				fddb.setColtype(coltypes[i].equals("S")?"字符型":"数值型");
				fddb.setMissingnum(missingnum[i]);
				fddb.setMissingratio(df.format(missingratio[i]*100)+"%");
				//fddb.setMissingratio(Double.toString(missingratio[i]));
				fddBeans.add(fddb);
			}
		}
		return SUCCESS;
	}
	
	
	public String network(){
		return "network";
	}
}
