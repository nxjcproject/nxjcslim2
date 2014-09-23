<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Daily.aspx.cs" Inherits="NXJC.UI.Web.FractionalElectricPowerCount.Daily" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>分步用电成本-日查询</title>
    <link href="/Scripts/easyui/themes/gray/easyui.css" rel="stylesheet" />
    <link href="/Scripts/EasyUI/themes/color.css" rel="stylesheet" />
    <link href="/Scripts/easyui/themes/icon.css" rel="stylesheet" />
    <script src="/Scripts/easyui/jquery.min.js"></script>
    <script src="/Scripts/easyui/jquery.easyui.min.js"></script>
    <script src="/Scripts/EasyUI/locale/easyui-lang-zh_CN.js"></script>
    <script src="/Scripts/jquery.utility.js"></script>
</head>
<body>
    <form id="form1" runat="server">
	<div id="wrapper" class="easyui-panel" style="width:98%;height:auto;padding:2px;">
	<div class="easyui-panel" style="width:100%;padding:5px;">
        日期：<input id="dd" type="text" class="easyui-datebox" required="required" />
        生产线：<input id="productLine" class="easyui-combobox" data-options="valueField:'ID',textField:'Name',editable:false,url:'PowerCountService.asmx/GetProductLinesWithComboboxFormat',onSelect:onProductLineSelected" /> 
        公式：<input id="formulaGroup" class="easyui-combobox" data-options="valueField:'FormulaGroupID',textField:'Name'" /> 
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search',onClick:query" style="width:80px">查询</a>
	</div>
	<table id="tg" class="easyui-treegrid" title="分步用电成本" style="width:100%;height:450px"
			data-options="
				rownumbers: true,
				animate: true,
				idField: 'LevelCode',
				treeField: 'ProcessName'
			">
		<thead frozen="true">
			<tr>
                <th data-options="field:'LevelCode',width:100">层次码</th>
				<th data-options="field:'ProcessName',width:180">工序名称</th>
			</tr>
		</thead>
		<thead>
            <tr>
				<th colspan="2">峰期</th>
				<th colspan="2">谷期</th>
                <th colspan="2">平期</th>
                <th colspan="2">小计</th>
			</tr>
			<tr>
                <th data-options="field:'PeakPower',width:80">电量</th>
                <th data-options="field:'PeakCost',width:80" >成本</th>
                <th data-options="field:'ValleyPower',width:80">电量</th>
                <th data-options="field:'ValleyCost',width:80">成本</th>
                <th data-options="field:'FlatPower',width:80">电量</th>
                <th data-options="field:'FlatCost',width:80">成本</th>
                <th data-options="field:'TotalPower',width:80">电量</th>
                <th data-options="field:'TotalCost',width:80">成本</th>
			</tr>
		</thead>
	</table>

	<script type="text/javascript">
	    $(document).ready(function () {
	    });

	    function onProductLineSelected() {
	        var queryUrl = 'PowerCountService.asmx/GetAvailableFormulaGroupWithComboboxFormat';
	        var dataToSend = '{productLineId: "' + $('#productLine').combobox('getValue') + '"}';

	        $.ajax({
	            type: "POST",
	            url: queryUrl,
	            data: dataToSend,
	            contentType: "application/json; charset=utf-8",
	            dataType: "json",
	            success: function (msg) {
	                $('#formulaGroup').combobox('clear');
	                $('#formulaGroup').combobox('loadData', jQuery.parseJSON(msg.d));
	            }
	        });
	    }

	    function query() {
	        var queryUrl = 'PowerCountService.asmx/GetElectricPowerCountWithTreeGridFormat';
	        var dataToSend = '{productLineId: "' + $('#productLine').combobox('getValue') + '", formulaGroupId: "' + $('#formulaGroup').combobox('getValue') + '"}';

	        var win = $.messager.progress({
	            title: '请稍后',
	            msg: '数据载入中...'
	        });

	        $.ajax({
	            type: "POST",
	            url: queryUrl,
	            data: dataToSend,
	            contentType: "application/json; charset=utf-8",
	            dataType: "json",
	            success: function (msg) {
	                $('#tg').treegrid({
	                    data: jQuery.parseJSON(msg.d),
	                    dataType: "json"
	                });
                    $.messager.progress('close');
	            },
	            error: function () {
	                $.messager.progress('close');
	                $.messager.alert('错误', '数据载入失败！');
	            }
	        });
	    }

	    function collapse() {
	        var node = $('#formulaEditor').treegrid('getSelected');
	        if (node) {
	            $('#formulaEditor').treegrid('collapse', node.LevelCode);
	        }
	    }
	    function expand() {
	        var node = $('#formulaEditor').treegrid('getSelected');
	        if (node) {
	            $('#formulaEditor').treegrid('expand', node.LevelCode);
	        }
	    }

	    function loadName(groupId) {
	        var queryUrl = 'FormulaService.asmx/GetFormulaName';
	        var dataToSend = '{groupId: "' + groupId + '"}';

	        $.ajax({
	            type: "POST",
	            url: queryUrl,
	            data: dataToSend,
	            contentType: "application/json; charset=utf-8",
	            dataType: "json",
	            success: function (msg) {
	                $('#formulaGroupName').val(jQuery.parseJSON(msg.d).name);
	            }
	        });
	    }

	    function loadFormulas(groupId) {
	        var queryUrl = 'FormulaService.asmx/GetFormulasWithTreeGridFormat';
	        var dataToSend = '{groupId: "' + groupId + '"}';

	        var win = $.messager.progress({
	            title: '请稍后',
	            msg: '数据载入中...'
	        });

	        $.ajax({
	            type: "POST",
	            url: queryUrl,
	            data: dataToSend,
	            contentType: "application/json; charset=utf-8",
	            dataType: "json",
	            success: function (msg) {
	                initializeFormulaEditor(jQuery.parseJSON(msg.d));
	                $.messager.progress('close');
	            },
	            error: function () {
	                $.messager.progress('close');
	                $.messager.alert('错误', '数据载入失败！');
	            }
	        });
	    }

	    function initializeFormulaEditor(jsonData) {
	        $('#formulaEditor').treegrid({
	            data: jsonData,
	            dataType: "json"
	        });
	    }

	    //////////////////////////////////////////////////////////////////////

	</script>
    </div>

    </form>
</body>
</html>
