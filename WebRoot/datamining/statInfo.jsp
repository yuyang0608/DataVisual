<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="en">

<head>
<base href="<%=basePath%>">
	<title>DataGeek数据挖掘可视化平台</title>
	<link rel="stylesheet" type="text/css" href="<%=path%>/resources/core.css">
	<link rel="stylesheet" href="<%=path%>/resources/css/header.css">
	<link rel="stylesheet" href="<%=path%>/resources/css/forms.css">
<%--	<link rel="stylesheet" href="<%=path%>/resources/css/table_css_new.css">--%>
	<script type="text/javascript" src="<%=path%>/resources/jquery-1.8.0.js"></script>
	<link href="<%=path%>/resources/loadmask/jquery.loadmask.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="<%=path%>/resources/loadmask/jquery.loadmask.min.js"></script>
	<script type="text/javascript" src="<%=path%>/resources/d3.js"></script>
	<script type="text/javascript" src="<%=path%>/resources/highcharts/highcharts.js"></script>
	<script type="text/javascript" src="<%=path%>/resources/highcharts/highcharts-more.js"></script>
    <script type="text/javascript" src="<%=path%>/resources/highcharts/modules/exporting.js"></script>
	<SCRIPT type="text/javascript" src="<%=path%>/analyse_js/dealstat.js"></SCRIPT>
	<script type="text/javascript">
	$(function(){
	    //移到右边
	    $('#add').click(function() {
	    //获取选中的选项，删除并追加给对方
	        $('#select1 option:selected').appendTo('#select2');
	    });
	    //移到左边
	    $('#remove').click(function() {
	        $('#select2 option:selected').appendTo('#select1');
	    });
	    //全部移到右边
	    $('#add_all').click(function() {
	        //获取全部的选项,删除并追加给对方
	        $('#select1 option').appendTo('#select2');
	    });
	    //全部移到左边
	    $('#remove_all').click(function() {
	        $('#select2 option').appendTo('#select1');
	    });
	    //双击选项
	    $('#select1').dblclick(function(){ //绑定双击事件
	        //获取全部的选项,删除并追加给对方
	        $("option:selected",this).appendTo('#select2'); //追加给对方
	    });
	    //双击选项
	    $('#select2').dblclick(function(){
	       $("option:selected",this).appendTo('#select1');
	    });
	});
	</script>
</head>

<body>
	<jsp:include page="../common/header.jsp" flush="true"/>
	<jsp:include page="../common/leftmenu.jsp" flush="true"/>
	<jsp:include page="../common/bottom.jsp" flush="true"/>
	
	<div id="content_template" class="content">
		<div>
			<div class='opr_title_style' style="width: 110px">统计信息描述</div>
			<HR SIZE=1 class='uploadhr'/>
		</div>
		<div id="main">
		
			<div  class='tableList'>
			    <div  class='key_s' style="position:relative;top:-60px;width: 150px">分析列选择：</div>
			    <div class="value_s">
				    <div style="display:inline-block;">
				        <select multiple="multiple" id="select1" style="width:160px;height:160px;border: 1px solid #a0c3da;font-size: 18px;color: royalblue;">
					        <s:iterator value="#session.colnames" id="s" status="st">
					        	<option value="${st.index + 1}"><s:property value='s'/></option>
					        </s:iterator>
				        </select>
				    </div>
				    <div style="display:inline-block;position: relative;top:-20px;margin-left: 5px;">
				    	<div><button class='reset' id="add" style="width: 40px">&gt;</button></div>
				    	<div><button class='reset' id="add_all" style="width: 40px">&gt;&gt;</button></div>
				    	<div><button class='reset' id="remove" style="width: 40px">&lt;</button></div>
				    	<div><button class='reset' id="remove_all" style="width: 40px">&lt;&lt;</button>  </div> 
					</div>
					<div style="display:inline-block;">
				        <select multiple="multiple" id="select2" style="width: 160px;height:160px;border: 1px solid #a0c3da;font-size: 18px;color: blueviolet;">
				        </select>
				    </div>
			    </div>
			</div>
			
		    <div class='tableList'>
  				<div class='key_s' style="width: 150px">统计信息图类型：</div>
			    <div class='value_s'>
			      <select id="method">
		    			<option value="bar">条形图</option>
						<option value="breakline">折线图</option>
						<option value="scatter">散点图</option>
						<option value="box">箱线图</option>
		    	  </select>
			    </div>
		    </div>

		   <div style='border-top:1px solid gray;
						position: relative;
						width: 48%;
						margin-left: 25px;
						padding-top:10px;
						text-align: right;
						margin-top: 15px;'>
		    	<button  class="btn add"  type="button" id="button" onclick="stat_analyse()">数据统计</button>
		    </div>

		</div>
		
		
		<div style='position: relative;'>
			<div>
				<div class='opr_title_style' style="width: 110px;top: 18px;">分析结果展示</div>
				<HR SIZE=1 class='uploadhr'/>
			</div>
			<div>
				<div  class='tableList' style='margin-left:25px;margin-right:25px'>
				    <div id='result'  style='height:500px;width:85%;margin-bottom:5px;margin:0 auto;'>
				   		
				    </div>
				</div>
			</div>
		</div>

	</div>
	
</body>
</html>