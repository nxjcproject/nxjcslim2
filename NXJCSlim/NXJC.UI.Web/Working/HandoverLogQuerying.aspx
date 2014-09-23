<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HandoverLogQuerying.aspx.cs" Inherits="NXJC.UI.Web.Working.HandoverLogQuerying" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>交接班日志查询</title>
    <link href="/Scripts/easyui/themes/gray/easyui.css" rel="stylesheet" />
    <link href="/Scripts/EasyUI/themes/color.css" rel="stylesheet" />
    <link href="/Scripts/easyui/themes/icon.css" rel="stylesheet" />
    <script src="/Scripts/easyui/jquery.min.js"></script>
    <script src="/Scripts/easyui/jquery.easyui.min.js"></script>
    <script src="/Scripts/EasyUI/locale/easyui-lang-zh_CN.js"></script>
</head>
<body>
    <form id="form1" runat="server">
	<div style="margin:20px 0;"></div>
	
	<table id="dg" title="交接班日志查询" style="width:100%;height:auto;" data-options="
				rownumbers:true,
				singleSelect:true,
				autoRowHeight:false,
				pagination:true,
				pageSize:10,
                toolbar:'#tb'">
		<thead>
			<tr>
				<th data-options="field:'ID',hidden: true">ID</th>
				<th data-options="field:'ProductLineID',hidden: true">生产线ID</th>
                <th data-options="field:'ProductLineName',width:100">生产线名称</th>
				<th data-options="field:'ShiftDate',width:120">换班时间</th>
				<th data-options="field:'Shifts',width:100">班次</th>
				<th data-options="field:'WorkingTeamID',hidden:true">班组ID</th>
                <th data-options="field:'WorkingTeamName',width:100">班组名称</th>
				<th data-options="field:'ChargeManID',width:120">负责人ID</th>
                <th data-options="field:'ChargeManName',width:100">负责人姓名</th>
				<th data-options="field:'X',width:100,formatter:formatAction">操作</th>
			</tr>
		</thead>
	</table>
	<div id="tb" style="padding:5px;height:auto">
		<div style="margin-bottom:5px">
			<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true"></a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true"></a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-save" plain="true"></a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-cut" plain="true"></a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true"></a>
		</div>
		<div>
			生产线：<select class="easyui-combobox" panelHeight="auto" style="width:100px">
				<option value="java">一号生产线</option>
				<option value="c">二号生产线</option>
				<option value="basic">三号生产线</option>
				<option value="perl">四号生产线</option>
				<option value="python">五号生产线</option>
			</select>
			起始日期：<input class="easyui-datebox" style="width:100px" />
			结束日期：<input class="easyui-datebox" style="width:100px" />

			<a href="#" class="easyui-linkbutton" iconCls="icon-search">搜索</a>
		</div>
	</div>
	<script>
	    function getData() {
	        var rows = [];
	        for (var i = 1; i <= 800; i++) {
	            var amount = Math.floor(Math.random() * 1000);
	            var price = Math.floor(Math.random() * 1000);
	            rows.push({
	                inv: 'Inv No ' + i,
	                date: $.fn.datebox.defaults.formatter(new Date()),
	                name: 'Name ' + i,
	                amount: amount,
	                price: price,
	                cost: amount * price,
	                note: 'Note ' + i
	            });
	        }
	        return rows;
	    }

	    function pagerFilter(data) {
	        if (typeof data.length == 'number' && typeof data.splice == 'function') {	// is array
	            data = {
	                total: data.length,
	                rows: data
	            }
	        }
	        var dg = $(this);
	        var opts = dg.datagrid('options');
	        var pager = dg.datagrid('getPager');
	        pager.pagination({
	            onSelectPage: function (pageNum, pageSize) {
	                opts.pageNumber = pageNum;
	                opts.pageSize = pageSize;
	                pager.pagination('refresh', {
	                    pageNumber: pageNum,
	                    pageSize: pageSize
	                });
	                dg.datagrid('loadData', data);
	            }
	        });
	        if (!data.originalRows) {
	            data.originalRows = (data.rows);
	        }
	        var start = (opts.pageNumber - 1) * parseInt(opts.pageSize);
	        var end = start + parseInt(opts.pageSize);
	        data.rows = (data.originalRows.slice(start, end));
	        return data;
	    }

	    function formatAction(val, row) {
	        return '<a href="HandoverLogDetail.aspx?id=' + row.ID + '">查看</a>';
	    }

	    $(function () {
	        getWorkingTeamShiftLog();
	    });

	    // 初始化日志查询列表
	    function getWorkingTeamShiftLog() {
	        var queryUrl = 'WorkingService.asmx/GetHandoverLogWithDataGridFormat';

	        $.ajax({
	            type: "POST",
	            url: queryUrl,
	            contentType: "application/json; charset=utf-8",
	            dataType: "json",
	            success: function (msg) {
	                initializeDg(jQuery.parseJSON(msg.d));
	            }
	        });
	    }

	    function initializeDg(data) {
	        $('#dg').datagrid({ loadFilter: pagerFilter }).datagrid('loadData', data);
	    }
	</script>
    </form>
</body>
</html>
