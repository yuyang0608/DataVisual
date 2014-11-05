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
	<title>DataGeek数据挖掘平台</title>
	<link rel="stylesheet" type="text/css" href="<%=path%>/resources/core.css">
	<link rel="stylesheet" href="<%=path%>/resources/css/header.css">
	<link rel="stylesheet" href="<%=path%>/resources/css/forms.css">
	<link href="<%=path%>/resources/loadmask/jquery.loadmask.css" rel="stylesheet" type="text/css"/>
	<link rel="stylesheet" href="<%=path%>/resources/css/table.css" type="text/css"></link>
	<link rel="stylesheet" href="<%=path%>/resources/css/tab.css" type="text/css"></link>
	<style type="text/css">

svg {
  font-size: 14px;
}

.foreground path {
  fill: none;
  stroke-opacity: .5;
  stroke-width: 1.5px;
}

.foreground path.fade {
  stroke: #000;
  stroke-opacity: .05;
}

.legend {
  font-size: 18px;
  font-style: oblique;
}

.legend line {
  stroke-width: 2px;
}

.setosa {
  stroke: #58ADDB;
}

.versicolor {
  stroke: #D53F40; 
}

.virginica {
  stroke: #9ABC32;
}

.brush .extent {
  fill-opacity: .3;
  stroke: #fff;
  shape-rendering: crispEdges;
}

.axis line, .axis path {
  fill: none;
  stroke: #000;
  shape-rendering: crispEdges;
}

.axis text {
  text-shadow: 0 1px 0 #fff;
  cursor: move;
}

    </style>
		
	<script type="text/javascript" src="<%=path%>/resources/jquery-1.8.0.js"></script>
	<script type="text/javascript" src="<%=path%>/resources/loadmask/jquery.loadmask.min.js"></script>
	<script type="text/javascript" src="<%=path%>/resources/highcharts/highcharts.js"></script>
	<script type="text/javascript" src="<%=path%>/resources/highcharts/highcharts-3d.js"></script>
    <script type="text/javascript" src="<%=path%>/resources/highcharts/modules/exporting.js"></script>
	
	
	<script type="text/javascript" src="<%=path%>/resources/datavjs/deps/d3.js"></script>
    <script type="text/javascript" src="<%=path%>/resources/datavjs/deps/raphael.js"></script>
    <script type="text/javascript" src="<%=path%>/resources/datavjs/deps/seajs/sea.js"></script>
	<script type="text/javascript">
	var spath="<%=path%>";
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
			<div class='opr_title_style' style="width: 140px">kmeans聚类分析</div>
			<HR SIZE=1 class='uploadhr'/>
		</div>
		<div id="main">
		
			<div  class='tableList'>
			    <div  class='key_s' style="position:relative;top:-60px">分析列选择：</div>
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
   					<div class='key_s'>聚  类  数：</div>
				    <div class='value_s'>
				      <s:textfield id="center" name="center" value="3"></s:textfield>
				    </div>
		    </div>
		   
		    <div class='tableList'>
   					<div class='key_s'>最大迭代次数：</div>
				    <div class='value_s'>
				      <s:textfield id="itermax" name="itermax" value="10"></s:textfield>
				    </div>
		    </div>

		   <div style='border-top:1px solid gray;
						position: relative;
						width: 48%;
						margin-left: 25px;
						padding-top:10px;
						text-align: right;
						margin-top: 15px;'>
		    	<button  class="btn add"  type="button" id="button" onclick="kmeans_analyse()">聚类分析</button>
		    </div>

		</div>
		
		
		<div style='position: relative;'>
			<div>
				<div class='opr_title_style' style="width: 110px;top: 18px;">分析结果展示</div>
				<HR SIZE=1 class='uploadhr'/>
			</div>
			<div>
				<div  class='tableList' style='margin-left:25px;margin-right:25px'>
				    <div id='result'  style='height:500px;width:100%;display:inline-block;margin-bottom:5px;'>
				   		
				    </div>
				</div>
			</div>
		</div>

	</div>
	<div id="outerWrap_image" class='outerWrap'>
			<div class="blueline" id="blueline_image" style="top: 144px;"></div>
			<ul class="tabGroup" id='tabGroup_image'>
				<li class="tabOption" related-id='result1' >
					<div id='pie' class='div_image' title="饼图"></div>
				</li>
				<li class="tabOption" related-id='result2'>
					<div id='bar' class='div_image' title="条形图"></div>
				</li>
				<li class="tabOption" related-id='result3'>
					<div id='table' class='div_image' title="最佳中心店"></div>
				</li>
				<li class="tabOption selectedTab" related-id='result4'>
					<div id='gplotmatrix' class='div_image' title="散点矩阵"></div>
				</li>
				<li class="tabOption" related-id='result5'>
					<div id='parallelgraph' class='div_image' title="平行坐标图"></div>
				</li>
			</ul> 
	</div>
		
	<script type="text/javascript">
			$(document).ready(function(){
				$("ul#tabGroup_image li").each(function(){
					$(this).click(function(){
						var indexs = -1;
						var count = 0;
						$("ul#tabGroup_image li").each(function(){
							$(this).removeClass("selectedTab");
						});//去掉所有的selectedTab
						$(this).addClass("selectedTab");//为本对象添加selectedTab

						$("ul#tabGroup_image li").each(function(){
							indexs++;
							if($(this).attr("class").indexOf("selectedTab")!=-1){
								count = indexs;
							}
						});//
						$("#blueline_image").css("top",(count*48)+"px");

						//这里处理点击后的事件
						var related_id = $(this).attr("related-id");
						var movetothis = function(related_id){
							$("#piechart").attr("style","display:none");
							$("#barchart").attr("style","display:none");
							$("#clusterinfo").attr("style","display:none");
							$("#scattermatrix").attr("style","display:none");
							$("#parallel").attr("style","display:none");
							if(related_id=="result1"){
								$("#piechart").attr("style","display:visible;");
								
							}
							else if(related_id=="result2"){
								$("#barchart").attr("style","margin:0 auto;display:block");
							}
							else if(related_id=="result3"){
								$("#clusterinfo").attr("style","margin:0 auto;display:block");
							}
							else if(related_id=="result4"){
								$("#scattermatrix").attr("style","margin:0 auto;display:block");
							}
							else if(related_id=="result5"){
								$("#parallel").attr("style","margin:0 auto;display:block");
							}
							
						}
						movetothis(related_id);
						
					});
				});

				//鼠标移动事件
				$("body").mousemove(function(e){
					var wind_wid = $(window).width(); //浏览器当前窗口可视区域宽度
					var wind_hei = $(window).height(); //浏览器当前窗口可视区域高度
					
					if(e.pageY>72 && e.pageY<72+384){
						if(wind_wid-e.pageX<6){
							$("#outerWrap_image").css("right","0px");
						}
					}

				});

				$("body").hover(function(){
					$("#outerWrap_image").css("right","-52px");
				});//content_template
				
				$("#content_template").hover(function(e){
					$("#outerWrap_image").css("right","-52px");
				});//content_template,commonheader

				$("#commonheader").hover(function(){
					$("#outerWrap_image").css("right","-52px");
				});//content_template,commonheader,bottom

				$("#bottom").hover(function(){
					$("#outerWrap_image").css("right","-52px");
				});//content_template,commonheader,bottom


				//使悬浮栏居中
				var hei = parseInt($("#outerWrap_image").css("height").replace("px",""));
				var top_hei = parseInt($("#commonheader").css("height").replace("px",""));
				var bottom_hei = parseInt($("#bottom").css("height").replace("px",""));
				var ksqy_hei = $(window).height();
				
				$("#outerWrap_image").css("top",((ksqy_hei-top_hei-bottom_hei-hei)/2.0+top_hei)+"px");
				
			});
	</script>	
		
	
	
	<script type="text/javascript">
	    seajs.config({
	        alias: {
	            'datav': '/DataVisual/resources/datavjs/datav.js',
	            'scatterplotMatrix': '/DataVisual/resources/datavjs/libs/scatterplotMatrix.js'
	        }
	    });
    </script>
    
    <script type="text/javascript"  src="<%=path%>/resources/js/d3.v2.js"></script>
	<SCRIPT type="text/javascript" src="<%=path%>/analyse_js/cluster.js"></SCRIPT>
	<script type="text/javascript">

var species = ["setosa", "versicolor", "virginica"],
    //traits = ["sepal length", "petal length", "sepal width", "petal width"];
	traits = ["Sepal.Length", "Petal.Length", "Sepal.Width", "Petal.Width"];

var m = [80, 160, 200, 160],
    w = 1180 - m[1] - m[3],
    h = 800 - m[0] - m[2];

var x = d3.scale.ordinal().domain(traits).rangePoints([0, w]),
    y = {};

var line = d3.svg.line(),
    axis = d3.svg.axis().orient("left"),
    foreground;

var svg = null;

//Returns the path for a given data point.
function path(d) {
  return line(traits.map(function(p) { return [x(p), y[p](d[p])]; }));
}

// Handles a brush event, toggling the display of foreground lines.
function brush() {
  var actives = traits.filter(function(p) { return !y[p].brush.empty(); }),
      extents = actives.map(function(p) { return y[p].brush.extent(); });
  foreground.classed("fade", function(d) {
    return !actives.every(function(p, i) {
      return extents[i][0] <= d[p] && d[p] <= extents[i][1];
    });
  });
}

 function drawCluster(){
	 d3.csv("iris2.csv", function(flowers) {

		 svg = d3.select("#parallel").append("svg:svg")
		    .attr("width", w + m[1] + m[3])
		    .attr("height", h + m[0] + m[2])
		  .append("svg:g")
		    .attr("transform", "translate(" + m[3] + "," + m[0] + ")");

		  // Create a scale and brush for each trait.
		  traits.forEach(function(d) {
		    // Coerce values to numbers.
		    flowers.forEach(function(p) { p[d] = +p[d]; });

		    y[d] = d3.scale.linear()
		        .domain(d3.extent(flowers, function(p) { return p[d]; }))
		        .range([h, 0]);

		    y[d].brush = d3.svg.brush()
		        .y(y[d])
		        .on("brush", brush);
		 });

		  // Add a legend.
		  var legend = svg.selectAll("g.legend")
		      .data(species)
		    .enter().append("svg:g")
		      .attr("class", "legend")
		      .attr("transform", function(d, i) { return "translate(0," + (i * 20 + 584) + ")"; });

		  legend.append("svg:line")
		      .attr("class", String)
		      .attr("x2", 8);

		  legend.append("svg:text")
		      .attr("x", 12)
		      .attr("dy", ".31em")
		      .text(function(d) { return "Iris " + d; });

		  // Add foreground lines.
		  foreground = svg.append("svg:g")
		      .attr("class", "foreground")
		    .selectAll("path")
		      .data(flowers)
		    .enter().append("svg:path")
		      .attr("d", path)
		      .attr("class", function(d) { return d.Species; });

		  // Add a group element for each trait.
		  var g = svg.selectAll(".trait")
		      .data(traits)
		    .enter().append("svg:g")
		      .attr("class", "trait")
		      .attr("transform", function(d) { return "translate(" + x(d) + ")"; })
		      .call(d3.behavior.drag()
		      .origin(function(d) { return {x: x(d)}; })
		      .on("dragstart", dragstart)
		      .on("drag", drag)
		      .on("dragend", dragend));

		  // Add an axis and title.
		  g.append("svg:g")
		      .attr("class", "axis")
		      .each(function(d) { d3.select(this).call(axis.scale(y[d])); })
		    .append("svg:text")
		      .attr("text-anchor", "middle")
		      .attr("y", -9)
		      .text(String);

		  // Add a brush for each axis.
		  g.append("svg:g")
		      .attr("class", "brush")
		      .each(function(d) { d3.select(this).call(y[d].brush); })
		    .selectAll("rect")
		      .attr("x", -8)
		      .attr("width", 16);

		  function dragstart(d) {
		    i = traits.indexOf(d);
		  }

		  function drag(d) {
		    x.range()[i] = d3.event.x;
		    traits.sort(function(a, b) { return x(a) - x(b); });
		    g.attr("transform", function(d) { return "translate(" + x(d) + ")"; });
		    foreground.attr("d", path);
		  }

		  function dragend(d) {
		    x.domain(traits).rangePoints([0, w]);
		    var t = d3.transition().duration(500);
		    t.selectAll(".trait").attr("transform", function(d) { return "translate(" + x(d) + ")"; });
		    t.selectAll(".foreground path").attr("d", path);
		  }
		});
 }



    </script>
	
</body>
</html>