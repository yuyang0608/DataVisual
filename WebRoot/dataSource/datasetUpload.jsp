<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html>

<head>
<base href="<%=basePath%>">
	<title>DataGeek数据挖掘平台</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="数据可视化展示">
	<meta http-equiv="description" content="数据可视化展示">
	
	<link rel="stylesheet" type="text/css" href="<%=path%>/resources/core.css">
	<link rel="stylesheet" href="<%=path%>/resources/css/header.css">
	<link rel="stylesheet" href="<%=path%>/resources/css/forms.css">
	<link rel="stylesheet" href="<%=path%>/resources/css/table_css_new.css">
	<link href="<%=path%>/resources/loadmask/jquery.loadmask.css" rel="stylesheet" type="text/css" />	
	
	<script type="text/javascript" src="<%=path%>/resources/jquery-1.8.0.js"></script>
	
	<style type="text/css">
		*{margin:0;padding:0;}  
		a{text-decoration:none;}  
		.btn_addPic{  
			display: block;  
			position: relative;  
			width: 100px;  
			height: 25px;  
			overflow: hidden;  
			border: 1px solid #EBEBEB;  
			background: none repeat scroll 0 0 #F3F3F3;  
			color: #999999;  
			cursor: pointer;
			text-align: center;
		}  
		.btn_addPic span{display: block;line-height: 25px;}  
		.btn_addPic em {  
			background:url(http://p7.qhimg.com/t014ce592c1a0b2d489.png) 0 0;  
			display: inline-block;  
			width: 18px;  
			height: 18px;  
			overflow: hidden;  
			margin: 0px 5px 2px 0;  
			line-height: 20em;  
			vertical-align: middle;  
		}  
		.btn_addPic:hover em{background-position:-19px 0;}  
		.filePrew {  
			display: block;  
			position: absolute;  
			top: 0;  
			left: 0;  
			width: 140px;  
			height: 25px;  
			font-size: 100px; /* 增大不同浏览器的可点击区域 */  
			opacity: 0; /* 实现的关键点 */  
			filter:alpha(opacity=0);/* 兼容IE */  
		}
		
		.yastyle,.filePrew{
			border:1px solid #ABADB3;
		
		}
		
		object{
			position: relative;
			top: -12px;
		}
		
		#f div{
			width:100%;
			color: #333;
			font-size: 14px;
			font-family: '微软雅黑';
			margin-bottom:5px;
			border-bottom: 1px solid rgba(26,122,166,1);
		}
		
		#f div a{
			color: red;
			float: right;
		}
		
		#f div a:HOVER{
			color: blue;
		}
		
	</style>
	
</head>

<body>

	<jsp:include page="../common/header.jsp" flush="true"/>
	<jsp:include page="../common/leftmenu.jsp" flush="true"/>
	<jsp:include page="../common/bottom.jsp" flush="true"/>
	
	<div id="content_template" class="content">
		<div>
			<div class='opr_title_style'>数据集上传</div>
			<HR SIZE=1 class='uploadhr'/>
		</div>
		<div id="main">
			<form action="upload" method="post" id="form" enctype="multipart/form-data" class="form-horizontal">
				<s:hidden name="fileName" id="fileName" value=""></s:hidden>
				<s:hidden name="filePath" id="filePath" value=""></s:hidden>
				<s:hidden name="fileSize" id="fileSize" value=""></s:hidden>
				<div class='tableList'>
   					<div class='key_s'>数据集名称</div>
				    <div class='value_s'>
				      <s:textfield id="datasetname" name="datasetname" value=""></s:textfield>
				    </div>
			    </div>
			    
			    <div class='tableList'>
   					<div class='key_s'>数据分隔符</div>
				    <div class='value_s'>
				      <select name="separatorselect" id="separatorselect" class="selectstyle">
			    		<option value="-1">--选择数据分隔符--</option>
			    		<option value=",">,</option>
			    		<option value=";">;</option>
			    		<option value="other">其它</option>
			    	  </select>
			    	  <input type="text" id="separator" name="separator" value="" style="display:none" maxlength="60"></input>
				    </div>
			    </div>
			    
			    <div class='tableList'>
   					<div class='key_s'>包含首行变量</div>
				    <div class='value_s'>
				      <select name="hasheadline">
			    		<option value="T">是</option>
			    		<option value="F">否</option>
		    		 </select>
				    </div>
			    </div>
			    
			    <div class='tableList'>
   					<div class='key_s'>缺失值符号</div>
				    <div class='value_s'>
				      <select name="hasmissing" id="hasmissing">
			    		<option value="false">无缺失值</option>
			    		<option value="true">有缺失值</option>
		    		  </select>
			    	  <input type="text" id="missing" name="missing" value="" class="input-mini" style="display:none" maxlength="60"></input>
				    </div>
			    </div>

			    <div class='tableList'>
			    	<div class='key_s' style='position:relative;top:-25px'>数据集文件</div>
			    	<div id="newFiles" style='display:inline-block;'>
		    		  <div id="f" style='width: 250px;
									height: 75px;
									border: 1px solid gray;
									display: inline-block;
									position: relative;
									top: 8px;
									overflow-x: auto;
									overflow-y: scroll;'>
		    		  
		    		  </div>
				    </div>
   					<div id="spanButtonPlaceholder" style='position: relative;top: 12px;'></div>
				</div>
			    
			    <div style='border-top:1px solid gray;
							position: relative;
							width: 40%;
							margin-left: 25px;
							padding-top:10px;
							text-align: right;
							margin-top: 15px;'>
			    	<button  class="btn add"  type="button" id="button">上   传</button>
			    </div>

		  </form>
	 
		</div>
	</div>
	
	<script type="text/javascript" src="<%=path%>/resources/swfupload/swfupload.js"></script>
	<script type="text/javascript" src="<%=path%>/resources/loadmask/jquery.loadmask.min.js"></script>
	<script type="text/javascript" src="<%=path%>/dataSource/upload.js"></script>
	<script type="text/javascript">
		var msg="${request.message}";
		if(msg!=""){
		    alert(msg);    
		}  	
		var spath="<%=path%>";
		$(document).ready(function()    
			{
			$("#hasmissing").change(function(){
					var hasmissing=$(this).children('option:selected').val();
					if(hasmissing=="true"){
						$("#missing").show();
					}
					else{
						$("#missing").attr("style","display:none");
					}
			});
			$("#separatorselect").change(function(){
					var separatorselect=$(this).children('option:selected').val();
					if(separatorselect=="other"){
						$("#separator").val("");
						$("#separator").removeAttr("style");
					}
					else if(separatorselect=="-1"){
						$("#separator").attr("style","display:none");
					}
					else{
						$("#separator").val(separatorselect);
						$("#separator").attr("style","display:none");
					}
			});
		});

		
		function s(){ 
	        var f = $("#f").val();  
	        $("#fileName").val(f.substr(12));  
	        $("#fileName").attr("title",f.substr(12));
	    }
	    
	</script>

	<script type="text/javascript">
		jQuery(document).ready(function($) {
			send();
		});
	</script>
		
</body>
</html>