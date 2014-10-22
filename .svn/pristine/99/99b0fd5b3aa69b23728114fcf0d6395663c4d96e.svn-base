function missing_analyse()
{
	var attrselected=$("#select2 option");
	var ids="";
	for(var i=0;i<attrselected.length;i++)
	{
		ids+=attrselected.eq(i).val()+",";
	}
	ids=ids.substring(0, ids.length-1)
	var method=$("#method").val();
	
	/*if(ids==""||center==null||itermax==null||nstart==null||algorithm==null)
	{
		alert("参数不得为空！");
		return false;
	}*/
	$("#main").mask("缺失值分析，请稍后...");
	$.post("missdata",
	{
		ids:ids,
		method:method
		
	},
	function(success, data) {
		$("#result").empty();
		var obj=eval(data);
		var fddBeans=obj.fddBeans;
		var html=
			"<table width='100%' class='table table-hover'><thead><tr class='theadstyle'>"
				+"<th width='30%'>变量名</th>"
			 	+"<th width='25%'>变量类型</th>"
				+"<th width='25%'>缺失值数目</th>"
				+"<th width='20%'>缺失值比例</th></tr></thead>";
		for(var i=0;i<fddBeans.length;i++){
			html=html+"<tr>"
				+"<td>"+fddBeans[i].colname+"</td>"
				+"<td>"+fddBeans[i].coltype+"</td>"
				+"<td>"+fddBeans[i].missingnum+"</td>"
				+"<td>"+fddBeans[i].missingratio+"</td></tr>";
		}
		$("#result").append(html+"</table>");
		$("#main").unmask();
		//alert("缺失值分析成功！")
	});
}
