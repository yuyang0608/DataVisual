function apriori_analyse()
{
	var attrselected=$("#select2 option");
	var ids="";
	for(var i=0;i<attrselected.length;i++)
	{
		ids+=attrselected.eq(i).val()+",";
	}
	ids=ids.substring(0, ids.length-1)
	var lift=$("#lift").val();
	var conf=$("#conf").val();
	
	
	/*if(ids==""||center==null||itermax==null||nstart==null||algorithm==null)
	{
		alert("参数不得为空！");
		return false;
	}*/
	$("#main").mask("关联规则分析，请稍后...");
	$.post("apriori",
	{
		ids:ids,
		lift:lift,
		conf:conf
	},
	function(returnedData, status) {
		if("success"==status)
		{
			var obj=eval(returnedData);
			var imagename=obj.imagename;
			$("#result").empty();
			/*$("#result").append("<div id='matrix1'></div>");
			$("#result").append("<div id='matrix2'></div>");
			$("#result").append("<div id='matrix3'></div>");
			seajs.use(["matrix", "datav"], function (Matrix, DataV) {
				var matrix1 = new Matrix("matrix1", {});
				DataV.csv("matrix1.csv", function(source){
					matrix1.setSource(source);
					matrix1.render();
				});
				
				var matrix2 = new Matrix("matrix2", {});
				DataV.csv("matrix1.csv", function(source){
					matrix2.setSource(source);
					matrix2.render();
				});
				
				var matrix3 = new Matrix("matrix3", {});
				DataV.csv("matrix1.csv", function(source){
					matrix3.setSource(source);
					matrix3.render();
				});

				matrix1.on("click", function (event) {
					var sort = new Array();
					var count;
					var pt;
					for (n=0;n<100;n++)
					{
						sort[n] = n;
					}

					for (n=0;n<100;n++)
					{	
						count = Math.random() * 99;
						count = Math.round(count);

						pt = sort[n];
						sort[n] = sort[count];
						sort[count] = pt;
					}

					matrix1.update(sort);
				});
			});*/

			var allrules=obj.allrules;
			var aprinfo=obj.aprinfo;
			
			$("#result").append("<div id='showrules'></div>");
			html="";
			html=html+"<div class='tabletitle'>关联规则分析结果</div>" +
					"<table width='100%' class='table table-hover'><thead><tr class='theadstyle'>";
			html=html+"<tr>" +
					"<th>序号</th>" +
					"<th>规则</th>" +
					"<th>支持度</th>" +
					"<th>置信度</th>" +
					"<th>提升度</th></tr></thead>";
			
			for(var i=0;i<allrules.length;i++){
				html=html+"<tr>" +
						"<td>["+(i+1)+"]</td>" +
						"<td>"+allrules[i]+"</td>" +
						"<td>"+aprinfo[i][0].toFixed(4)+"</td>" +
						"<td>"+aprinfo[i][1].toFixed(4)+"</td>" +
						"<td>"+aprinfo[i][2].toFixed(4)+"</td>" +
						"</tr>";
			}
			html=html+"</table>";
			$("#showrules").append(html);
			
			
			$("#result").append("<div id='rulesimg' style='display:none'></div>");
			html="";
			html=html+"<div align='center'><img width=600px height=600px  src='"+spath+"/rimages/"+imagename+"'></div>";
			$("#rulesimg").append(html);
			
			
			$("#result").append("<div id='parallel' style='display:none'></div>");
			//平行坐标系的绘制，多对多
			drawParallel();
			
			$("#main").unmask();
		}
	})
}


