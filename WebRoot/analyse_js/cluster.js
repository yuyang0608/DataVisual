function kmeans_analyse()
{
	var attrselected=$("#select2 option");
	var ids="";
	for(var i=0;i<attrselected.length;i++)
	{
		ids+=attrselected.eq(i).val()+",";
	}
	ids=ids.substring(0, ids.length-1)
	var center=$("#center").val();
	var itermax=$("#itermax").val();
	//var nstart=$("#nstart").val();
	//var algorithm=$("#algorithm").val();
	
	/*if(ids==""||center==null||itermax==null||nstart==null||algorithm==null)
	{
		alert("参数不得为空！");
		return false;
	}*/
	$("#main").mask("k-means算法分析，请稍后...");
	$.post("kmeans",
	{
		ids:ids,
		center:center,
		itermax:itermax
		//nstart:nstart,
		//algorithm:algorithm
	},
	function(returnedData, status) {
		if("success"==status)
		{
			var obj=eval(returnedData);
			var imagename=obj.imagename;
			var imagename1=obj.imagename1;
			var clustersize=obj.clustersize;
			var centers=obj.centers;
			var select2=$("#select2 option");
			$("#result").empty();
			
			//$("#result").append("<div style='width:85%;margin:0 auto;'><div id='piechart' style='width:48%;height:400px;float:left;border:1px solid #C0C0C0;margin:5px 5px;'></div><div id='barchart' style='width:48%;height:400px;float:left;border:1px solid #C0C0C0;margin:5px 5px;'></div></div>");
			$("#result").append("<div id='piechart' style='width:1000px;height:500px;'></div>");
			pie3D();
			var chart = $('#piechart').highcharts();
			var piedata=new Array();
			for(var i=0;i<clustersize.length;i++)
			{
				piedata[i]=new Array();
				
				piedata[i][0]="聚类簇"+(i+1);
				piedata[i][1]=clustersize[i];
				
			}
			chart.addSeries({data:piedata,name:"该簇占总数的百分比"});
			$("#piechart").attr("style","display:none");
			
			
			/*var html="<div>各簇数据数目：";
			for(var i=0;i<clustersize.length;i++){
				html=html+clustersize[i]+"&nbsp;&nbsp;";
			}
			html=html+"</div>";
			$('#chart').append(html);*/
			
			
			$("#result").append("<div id='barchart' style='display:none;width:1000px;height:500px;'></div>");
			bar();
			var barchart = $('#barchart').highcharts();
			for ( var i = 0; i < clustersize.length; i++) {
				 var temp=[];
				 temp[0]=Number(clustersize[i]);
				 barchart.addSeries({data:temp,name:"聚类簇"+(i+1)});
	        }
			
			
			$("#result").append("<div id='clusterinfo' style='display:none'></div>");
			html="";
			html=html+"<div class='tabletitle' style='margin-top:20px;'>最佳中心点</div><div class='exporttable'><img src='resources/images/exporttable.png'/><a href='"+spath+"/export/export_excel'>导出表格</a></div>" +
					"<table width='100%' class='table table-hover'><thead><tr class='theadstyle'><th>序号</th>";
			for(var i=0;i<select2.length;i++){
				html=html+"<th>"+select2.eq(i).html()+"</th>";
			}
			html=html+"</tr></thead>";
			for(var i=0;i<centers.length;i++){
				var arr_link=centers[i];
			    html=html+"<tr><td>["+(i+1)+"]</td>";
			    for(var j=0;j<arr_link.length;j++){
			    	 html=html+"<td>"+arr_link[j]+"</td>";
			    }
			    html=html+"</tr>";
			}
			
			$("#clusterinfo").append(html+"</table>");
			
			
			$("#result").append("<div id='scattermatrix'></div>");
			seajs.use(["datav", "scatterplotMatrix"], function (DataV, ScatterplotMatrix) {
		        var scatterplotMatrix = new ScatterplotMatrix("scattermatrix", {"width": 800, "height": 600, "margin": 50});
		        DataV.csv("./results/results.csv", function(dataSource) {
		            scatterplotMatrix.setSource(dataSource);
		            scatterplotMatrix.setOptions({"typeName": "Cluster"});
		            scatterplotMatrix.setDimensionsX(["Sepal.Length", "Sepal.Width", "Petal.Length","Petal.Width"]);
		            scatterplotMatrix.setDimensionsY(["Sepal.Length", "Sepal.Width", "Petal.Length","Petal.Width"]);
		            scatterplotMatrix.setTypeName(["聚类簇1","聚类簇2","聚类簇3","聚类簇4","聚类簇5","聚类簇6","聚类簇7"]);
		            scatterplotMatrix.render();
		        });
			});
//			html="";
//			html=html+"<hr style='width:100%;'>"
//				+"<a style='color:#1841E2' href='"+spath+"/export/export_pdf'>导出图片</a></h3></div>";
//			$("#result").append(html);
			
			$("#result").append("<div id='parallel' style='display:none'></div>");
			drawCluster();
			 
			$("#main").unmask();
			//alert("k-means算法分析完成！");
		}
	})
}


function pie(){
	$('#piechart').highcharts({
        chart: {
			type: 'pie',
            plotBackgroundColor: null,
            plotBorderWidth: null,
            plotShadow: false
        },
        title: {
            text: '各簇数目所占比例（饼图）'
        },
        tooltip: {
    	    pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                dataLabels: {
                    enabled: true,
                    color: '#000000',
                    connectorColor: '#000000',
                    format: '<b>{point.name}</b>: {point.percentage:.1f} %'
                },
                showInLegend: false
            }
        },
        credits:{
            enabled:false
        }
    });
}

function pie3D(){
	$('#piechart').highcharts({
        chart: {
            type: 'pie',
            options3d: {
                enabled: true,
                alpha: 45,
                beta: 0
            }
        },
        title: {
            text: '各簇数目所占比例（饼图）'
        },
        tooltip: {
            pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
        },
        plotOptions: {
            pie: {
                allowPointSelect: true,
                cursor: 'pointer',
                depth: 35,
                dataLabels: {
                    enabled: true,
                    format: '{point.name}'
                }
            }
        },
        credits:{
            enabled:false
        }
    });
}


function bar(){
	$('#barchart').highcharts({
        chart: {
			zoomType: 'x',
            type: 'column'
        },
        title: {
            text: '各簇聚类数目（条形图）'
        },
        subtitle: {
        	
        },
        xAxis: {
           
        },
        yAxis: {
            
        },
        tooltip: {
            headerFormat: '<span style="font-size:10px">各簇数目：</span><table>',
            pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
                '<td style="padding:0"><b>{point.y} </b></td></tr>',
            footerFormat: '</table>',
            useHTML: true
        },
        credits:{
            enabled:false
        },
        plotOptions: {
            column: {
                pointPadding: 0.2,
                borderWidth: 0
            }
        }
    });
}
