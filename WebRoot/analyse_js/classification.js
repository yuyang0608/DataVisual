
var m = [20, 120, 20, 120],
		w = 1280 - m[1] - m[3],
	    h = 800 - m[0] - m[2],
	    i = 0,
	    rect_width = 80,
	    rect_height = 20,
	    max_link_width = 20,
	    min_link_width = 1.5,
	    char_to_pxl = 6,
	    root;

var tree,diagonal,vis, link_stoke_scale,color_map,stroke_callback;


function dtree_analyse()
{
	var outputline=$("#outputline").val();
	var attrselected=$("#select2 option");
	var ids="";
	for(var i=0;i<attrselected.length;i++)
	{
		ids+=attrselected.eq(i).val()+",";
	}
	ids=ids.substring(0, ids.length-1)
	$("#main").mask("决策树分析，请稍后...");
	$.post("dtree",
			{
				outputline:outputline,
				ids:ids
			},
			function(returnedData, status) {
				if("success"==status)
				{
					var obj=eval(returnedData);
					var tempArrays=obj.tempArrays;
					var pnames=obj.pnames;
					var imagename=obj.imagename;
					var totalrow=obj.totalrow;
					var acc=obj.acc;
					$("#result").empty();
					
					$("#result").append("<div id='tree'></div>");
					d3.json("iris2.json", load_dataset); //为何结果设置为固定文件名
					
					$("#result").append("<div id='forecast' style='display:none'></div>");
					var html="";
					html="<div class='tabletitle'>概率预测：共"+totalrow+"行数据（取前20行）</div><div class='exporttable'><img src='resources/images/exporttable.png'/><a href='"+spath+"/export/export_excel'>导出表格</a></div>" +
						"<table width='100%' class='table table-hover'><thead><tr class='theadstyle'>"
						+"<th>序号</th>";
					for(var j=0;j<pnames.length;j++){
						html=html+"<th>"+pnames[j]+"</th>";
					}
					html=html+"</tr></thead>";
					for(var i=0;i<tempArrays.length;i++){
						var arr_link=tempArrays[i];
					    html=html+"<tr><td>["+(i+1)+"]</td>";
					    for(var j=0;j<arr_link.length;j++){
					    	 html=html+"<td>"+arr_link[j]+"</td>";
					    }
					    html=html+"</tr>";
					}
					html=html+"</table>";
					$("#forecast").append(html);
					
					$("#result").append("<div id='roc' style='display:none'></div>");
					html="";
					html=html+"<div class='curvegraph'>ROC曲线图</div><div class='exportgraph'><img src='resources/images/exportgraph.png'/><a href='"+spath+"/export/export_pdf'>导出图片</a></div><div class='graphstyle'><img src='"+spath+"/rimages/"+imagename+"'></div>"
						+"<div class='illustratestyle'>分类器性能评估："+acc+"%</div>";
					html=html+"<hr style='width:100%;'>"
						+"</div>";
					$("#roc").append(html);
					
					
					$("#main").unmask();
				}
			});
}

