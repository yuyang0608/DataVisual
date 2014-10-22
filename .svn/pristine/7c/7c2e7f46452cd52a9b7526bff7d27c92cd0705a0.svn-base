package com.dv.action;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.rosuda.JRI.Rengine;

import com.dv.action.base.DataMiningBaseAction;
import com.dv.util.FileDatasetDetailBean;
import com.dv.util.QuickSort;
import com.dv.util.StaticData;
import com.opensymphony.xwork2.ActionContext;


@SuppressWarnings("serial")
public class DataPreparation extends DataMiningBaseAction{
	private String ids;
	private String method;
	
	private int totalrow;
	private List<FileDatasetDetailBean> fddBeans=new ArrayList<FileDatasetDetailBean>();
	private List<double[]> statdata=new ArrayList<double[]>();//条形图、折线图数据
	private List<double[][]> scatterdata=new ArrayList<double[][]>();//散点图、箱线图数据
	private List<double[][]> outlier=new ArrayList<double[][]>();//箱线图数据异常值
	private List<int[]> varname=new ArrayList<int[]>();//散点图横、纵坐标名称
	
	private String[] colors;
	
	public String dealMissing()
	{
		StaticData sd = StaticData.getInstance();
		sd.setAr();
		Rengine c=sd.re;
		String colids[]=ids.split(",");
		
		for (int i = 0; i < colids.length; i++) {
			if(method.equals("prior"))
			{
				c.eval("data[,"+colids[i]+"]<-na.locf(data[,"+colids[i]+"],fromLast=F)");
			}
			else if(method.equals("mean"))
			{
				c.eval("{data[,"+colids[i]+"]<-as.double(as.character(data[,"+colids[i]+"]));" +
						"data[,"+colids[i]+"][which(is.na(data[,"+colids[i]+"]))]<-mean(data[,"+colids[i]+"][-which(is.na(data[,"+colids[i]+"]))]);" +
						"}");
			}
			
			else if(method.equals("spline"))
			{
				c.eval("{data[,"+colids[i]+"]<-as.double(as.character(data[,"+colids[i]+"]));" +
						"data[,"+colids[i]+"]<-na.spline(data[,"+colids[i]+"],na.rm=TRUE);" +
						"}");
			}
		}
		Map<String,Object> session=ActionContext.getContext().getSession();
		String colnames[]=(String[])session.get("colnames");
		String coltypes[]=(String[])session.get("coltypes");
		int missingnum[] = new int[colnames.length];
		double missingratio[]=new double[colnames.length];
		totalrow=c.eval("length(data[,1])").asInt();
		DecimalFormat df=new DecimalFormat("##.##");
		for (int i = 0; i < colnames.length; i++) 
		{
			missingnum[i]=c.eval("sum(is.na(data[,"+(i+1)+"]))").asInt();
			missingratio[i]=(double)missingnum[i]/(double)totalrow;
		}
		
		
		for (int i = 0; i < colnames.length; i++) 
		{
			FileDatasetDetailBean fddb=new FileDatasetDetailBean();
			fddb.setColname(colnames[i]);
			fddb.setColtype(coltypes[i].equals("S")?"字符型":"数值型");
			fddb.setMissingnum(missingnum[i]);
			fddb.setMissingratio(df.format(missingratio[i]*100)+"%");
			fddBeans.add(fddb);
		}
		return "success";
	}
	
	public String statInfo(){
		StaticData sd = StaticData.getInstance();
		sd.setAr();
		Rengine c=sd.re;
		String colids[]=ids.split(",");
		colors=new String[]{"#FF0000","#EB4310","#F6941D","#FFFF00","#CDD541",
							"#99CC33","#3F9337","#219167","#24998D","#1F9BAA",
							"#A1488E","#C71585","#BD2158","#CCFFFF","#FFCCCC",
							"#33FF99","#FF95CA","#00FFFF","#FF5809","#1AFD9C"};
		if(method.equals("bar"))
		{
			for (int i = 0; i < colids.length; i++) {
				statdata.add(c.eval("data[,"+colids[i]+"]").asDoubleArray());
			}
		}
		else if(method.equals("breakline"))
		{
			for (int i = 0; i < colids.length; i++) {
				statdata.add(c.eval("data[,"+colids[i]+"]").asDoubleArray());
			}
		}
		else if(method.equals("scatter"))
		{
			for (int i = 0; i < colids.length; i++) {
				for (int j = 0; j < colids.length; j++) {
					if(i!=j){
						int[] temp=new int[2];
						temp[0]=Integer.parseInt(colids[i]);
						temp[1]=Integer.parseInt(colids[j]);
						varname.add(temp);
						scatterdata.add(c.eval("as.matrix(data[,c("+colids[i]+","+colids[j]+")])").asDoubleMatrix());
					}
				}
			}
			
		}
		else if(method.equals("box"))
		{
			double fivearray[];
			double outarray[];
			double fivenum[][] = new double[colids.length][5];
			for (int i = 0; i < colids.length; i++) {
				fivearray=c.eval("fivenum(data[,"+colids[i]+"])").asDoubleArray();
				outarray=c.eval("boxplot.stats(data[,"+colids[i]+"])$out").asDoubleArray();
				fivenum[i]=fivearray;
				System.out.println(outarray.length);
				if(outarray.length>0){
					double outpoint[][]=new double[outarray.length][2];
					for (int j = 0; j < outarray.length; j++) {
						outpoint[j]=new double[]{i,outarray[j]};
					}
					outlier.add(outpoint);
				}
			}
			
			scatterdata.add(fivenum);
		}
		
		return SUCCESS;
	}
	
	public String resetBar(){
		StaticData sd = StaticData.getInstance();
		sd.setAr();
		Rengine c=sd.re;
		String colids[]=ids.split(",");
		for (int i = 0; i < colids.length; i++) {
			statdata.add(c.eval("data[,"+colids[i]+"]").asDoubleArray());
		}
		return SUCCESS;
	}
	
	public String sortHighToLow(){
		StaticData sd = StaticData.getInstance();
		sd.setAr();
		Rengine c=sd.re;
		String colids[]=ids.split(",");
		double[] strVoid=null;
		for (int i = 0; i < colids.length; i++) {
			strVoid=c.eval("data[,"+colids[i]+"]").asDoubleArray();
			statdata.add(new QuickSort().quickSort(strVoid,0,strVoid.length-1));
		}
		return SUCCESS;
	}
	
	public String sortLowToHigh(){
		StaticData sd = StaticData.getInstance();
		sd.setAr();
		Rengine c=sd.re;
		String colids[]=ids.split(",");
		double[] strVoid=null;
		for (int i = 0; i < colids.length; i++) {
			strVoid=c.eval("data[,"+colids[i]+"]").asDoubleArray();
			statdata.add(new QuickSort().quickSort1(strVoid,0,strVoid.length-1));
		}
		return SUCCESS;
	}
	
	
	

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	public String getMethod() {
		return method;
	}

	public void setMethod(String method) {
		this.method = method;
	}

	public int getTotalrow() {
		return totalrow;
	}

	public void setTotalrow(int totalrow) {
		this.totalrow = totalrow;
	}

	public List<FileDatasetDetailBean> getFddBeans() {
		return fddBeans;
	}

	public void setFddBeans(List<FileDatasetDetailBean> fddBeans) {
		this.fddBeans = fddBeans;
	}

	public List<double[]> getStatdata() {
		return statdata;
	}

	public void setStatdata(List<double[]> statdata) {
		this.statdata = statdata;
	}

	public List<double[][]> getScatterdata() {
		return scatterdata;
	}

	public void setScatterdata(List<double[][]> scatterdata) {
		this.scatterdata = scatterdata;
	}

	public List<int[]> getVarname() {
		return varname;
	}

	public void setVarname(List<int[]> varname) {
		this.varname = varname;
	}

	public List<double[][]> getOutlier() {
		return outlier;
	}

	public void setOutlier(List<double[][]> outlier) {
		this.outlier = outlier;
	}

	public String[] getColors() {
		return colors;
	}

	public void setColors(String[] colors) {
		this.colors = colors;
	}


}
