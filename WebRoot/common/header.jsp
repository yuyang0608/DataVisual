<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<style>
	#logo{
		width: 500px;
		height: 80px;
		background: url(<%=path%>/resources/images/titleV02.png);
		-moz-background-size:500px 80px; /* 老版本的 Firefox */
		background-size:500px 80px;
		background-repeat:no-repeat;
		background-origin:content-box;
		background-position:0px -8px;
	}
</style>
	
<div id="commonheader" class="content">
	<div id='logo'>
		
	</div>
</div>
