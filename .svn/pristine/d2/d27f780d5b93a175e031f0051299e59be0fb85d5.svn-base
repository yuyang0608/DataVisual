<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
	<base href="<%=basePath%>">
	<title>DataGeek数据可视化平台</title>
	<script type="text/javascript" src="<%=path%>/resources/jquery-1.8.0.js"></script>
	<link rel="stylesheet" href="<%=path%>/resources/css/main.css" type="text/css"></link>
	<style>  
	body {
		position:fixed;
		top:0px;
		width:100%;
		/*background: url(resources/images/home.jpg) repeat-x 0px 0px;*/
		background: url(resources/images/home.jpg);
		-moz-background-size:cover; /* 老版本的 Firefox */
		background-size:cover;
		background-repeat:no-repeat;
		background-origin:content-box;
		border-bottom: 1px solid white;
		z-index: 1;
	}  
	.circle{
		position:absolute;
		top:50px;
		width:580px;
		height:748px;
		background: url(resources/images/circlebg.png);
		-moz-background-size:cover; /* 老版本的 Firefox */
		background-size:cover;
		background-repeat:no-repeat;
		background-origin:content-box;
		
		z-index: 1;
	}
	#dataupload{
		width:81px;
		height:81px;
		position:absolute; 
		background: url(resources/images/uploadcircle.png);
		top:480px;
		left:180px;
	}
	#dataupload:hover{
		background: url(resources/images/uploadcircle_hover.png);
		-moz-background-size: 81px 81px;
		background-size: 81px 81px;
		background-repeat: no-repeat;
		background-origin: content-box;
		cursor: pointer;
	}
	
	#dataselect{
		width:113px;
		height:113px;
		position:absolute; 
		background: url(resources/images/selectcircle.png);
		top:310px;
		left:293px;
	}
	#dataselect:hover{
		background: url(resources/images/selectcircle_hover.png);
		-moz-background-size: 113px 113px;
		background-size: 113px 113px;
		background-repeat: no-repeat;
		background-origin: content-box;
		cursor: pointer;
	}
	
	#datadeal{
		width:70px;
		height:70px;
		position:absolute; 
		background: url(resources/images/dealcircle.png);
		top:130px;
		left:125px;
	}
	#datadeal:hover{
		background: url(resources/images/dealcircle_hover.png);
		-moz-background-size: 70px 70px;
		background-size: 70px 70px;
		background-repeat: no-repeat;
		background-origin: content-box;
		cursor: pointer;
	}
	
	#datamining{
		width:77px;
		height:77px;
		position:absolute; 
		background: url(resources/images/miningcircle.png);
		top:63px;
		left:409px;
	}
	#datamining:hover{
		background: url(resources/images/miningcircle_hover.png);
		-moz-background-size: 77px 77px;
		background-size: 77px 77px;
		background-repeat: no-repeat;
		background-origin: content-box;
		cursor: pointer;
	}
</style>  
</head>

<body>
	<div class="circle">
		<a href="dataSource/datasetUpload.jsp"><div id="dataupload"></div></a>
		<a href="dataSource/fileDatasetList"><div id="dataselect"></div></a>
		<a href="datamining/dealmissing.jsp"><div id="datadeal"></div></a>
		<a href="datamining/apriori.jsp"><div id="datamining"></div></a>
	</div>
		<%--<div class="logincontent">
			<div>
				请输入您的用户名和密码
			</div>
			<form action="userlogin" method="post">
				
				<div>
					<span>用户名：</span><input name="username" id="username" type="text" value="admin" >
				</div>
				<div></div>

				<div>
					<span>密     码：</span><input name="password" id="password" type="password" value="admin">
				</div>
				<button type="submit">登录</button>
			</form>
		</div>	
	
		
--%></body>
</html>
