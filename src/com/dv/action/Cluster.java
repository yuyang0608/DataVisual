package com.dv.action;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.struts2.ServletActionContext;
import org.rosuda.JRI.Rengine;

import com.dv.action.base.DataMiningBaseAction;
import com.dv.util.Export_excelBean;
import com.dv.util.Export_imageBean;
import com.dv.util.StaticData;
import com.opensymphony.xwork2.ActionContext;

@SuppressWarnings("serial")
public class Cluster extends DataMiningBaseAction{
	private String ids;
	private String center;//kmeans,clara,pam
	private String itermax;//kmeans
	private String nstart;//kmeans
	private String algorithm;//kmeans
	private String metric;//pam
	private String method;//angens
	private String eps;//dbscan
	private String savaPath;
	private String imagename;
	private String imagename1;

	private List<Export_excelBean> excellist=null;
	private List<Export_imageBean> imagelist=null;

	private int clustersize[]=null;
	private String sample[]=null;
	private double centers[][]=null;
	private double medoids[][]=null;
	private double clusinfo[][]=null;
	

	@SuppressWarnings("deprecation")
	public String getSavaPath() {
		return ServletActionContext.getRequest().getRealPath(savaPath);
	}
	public void setSavaPath(String savaPath) {
		this.savaPath = savaPath;
	}
	
	public String Kmeans()
	{
		//String imagepath=getSavaPath().replace("\\", "//")+"//";
		String imagepath = getSavaPath().replace("\\", "/")+"/"; //windows下路径格式
		String resultspath = imagepath + "../results/";
		System.out.println(imagepath);
		System.out.println(resultspath);
		imagename="result"+new Date().getTime()+".png";
		imagename1="result1"+new Date().getTime()+".png";
		StaticData sd = StaticData.getInstance();
		sd.setAr();
		Rengine c=sd.re;
		Map<String,Object> session=ActionContext.getContext().getSession();
		//c.eval("kc<-kmeans(x=na.omit(data[,c("+ids+")]),centers="+center+",iter.max="+itermax+",nstart="+nstart+",algorithm=c('"+algorithm+"'));");
		c.eval("{ x <- na.omit(data[,c("+ids+")]);kc <- kmeans(x" +
				",centers="+center+",iter.max="+itermax+"); }");
		c.eval("{ Cluster <- kc$cluster; results <- cbind(x, Cluster); write.table(results, file='" + resultspath + "results.csv', row.name = F, quote = T, sep = ',');} ");
		String picture=(String)session.get("picture");
		if(picture.equals("true"))
		{
			c.eval("{" +
					"setwd('"+imagepath+"');" +
					"png(file='"+imagename+"',bg='transparent');" +
					"plot(data[,c("+ids+")],col=kc$cluster,main='kmeans算法的聚类效果图');" +
					"dev.off();" +
					"}");
		}
		else
		{
			c.eval("{" +
					"setwd('"+imagepath+"');" +
					"png(file='"+imagename+"',bg='transparent');" +
					"barplot(kc$size,main='kmeans算法的聚类各簇数目条形图');" +
					"dev.off();" +
					"}");
		}
		
		
		DecimalFormat df=new DecimalFormat(".##");
		c.eval("{temp<-kc$size;dim(temp)<-c(length(kc$size))}");
		clustersize=c.eval("temp").asIntArray();
		for (int i = 0; i < clustersize.length; i++) {
			System.out.println(clustersize[i]);
		}
		
		centers=c.eval("kc$centers").asDoubleMatrix();
		for(int i=0; i<centers.length; i++) {
			 for(int j=0; j<centers[0].length; j++) {
				 centers[i][j]=Double.parseDouble(df.format(centers[i][j]));
				 System.out.print(centers[i][j] + " ");
			 }
			 System.out.println();
		}
		excellist=new ArrayList<Export_excelBean>();
		Export_excelBean ieb=new Export_excelBean();
		ieb.setArrayname("每簇聚类数目");
		ieb.setArray_E(clustersize);
		ieb.setArraytype("E");
		excellist.add(ieb);
		Export_excelBean ieb1=new Export_excelBean();
		ieb1.setArrayname("最佳中心点");
		ieb1.setArray_D(centers);
		ieb1.setArraytype("D");
		excellist.add(ieb1);
		
		imagelist=new ArrayList<Export_imageBean>();
		Export_imageBean exportimage=new Export_imageBean();
		exportimage.setImageinfo("图1");
		exportimage.setImagepath(imagepath+imagename);
		imagelist.add(exportimage);
		
		session.remove("excellist");
		session.put("excellist", excellist);
		session.remove("imagelist");
		session.put("imagelist", imagelist);
		c.eval("rm('kc')");
		return "kmeans";
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

	public String getNstart() {
		return nstart;
	}

	public void setNstart(String nstart) {
		this.nstart = nstart;
	}

	public String getAlgorithm() {
		return algorithm;
	}

	public void setAlgorithm(String algorithm) {
		this.algorithm = algorithm;
	}
	public String getMetric() {
		return metric;
	}
	public void setMetric(String metric) {
		this.metric = metric;
	}
	public String getMethod() {
		return method;
	}
	public void setMethod(String method) {
		this.method = method;
	}
	public String getEps() {
		return eps;
	}
	public void setEps(String eps) {
		this.eps = eps;
	}
	public String getImagename() {
		return imagename;
	}
	public void setImagename(String imagename) {
		this.imagename = imagename;
	}
	public String[] getSample() {
		return sample;
	}
	public void setSample(String[] sample) {
		this.sample = sample;
	}
	public double[][] getCenters() {
		return centers;
	}
	public void setCenters(double[][] centers) {
		this.centers = centers;
	}

	public double[][] getMedoids() {
		return medoids;
	}
	public void setMedoids(double[][] medoids) {
		this.medoids = medoids;
	}
	public double[][] getClusinfo() {
		return clusinfo;
	}
	public void setClusinfo(double[][] clusinfo) {
		this.clusinfo = clusinfo;
	}
	public String getImagename1() {
		return imagename1;
	}
	public void setImagename1(String imagename1) {
		this.imagename1 = imagename1;
	}
	public int[] getClustersize() {
		return clustersize;
	}
	public void setClustersize(int[] clustersize) {
		this.clustersize = clustersize;
	}
	
}
