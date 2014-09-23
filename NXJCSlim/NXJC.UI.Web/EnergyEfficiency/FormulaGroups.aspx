<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FormulaGroups.aspx.cs" Inherits="NXJC.UI.Web.EnergyEfficiency.FormulaGroups" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>公式组列表</title>
    <link href="/Scripts/easyui/themes/gray/easyui.css" rel="stylesheet" />
    <link href="/Scripts/EasyUI/themes/color.css" rel="stylesheet" />
    <link href="/Scripts/easyui/themes/icon.css" rel="stylesheet" />
    <script src="/Scripts/easyui/jquery.min.js"></script>
    <script src="/Scripts/easyui/jquery.easyui.min.js"></script>
    <script src="/Scripts/EasyUI/locale/easyui-lang-zh_CN.js"></script>
    <style>
        body {
            font-size: 80%;
        }
        .textbox{
			height:20px;
			margin:0;
			padding:0 2px;
			box-sizing:content-box;
		}
    </style>
</head>
<body class="easyui-layout">
    <form id="form1" runat="server">
	<div data-options="region:'east',split:true,title:'公式组使用状态'" style="width:40%;padding:2px;">
	    <table id="formulaGroupsEffectived" class="easyui-datagrid" title="正在使用中的公式组" style="width:100%;height:33%"
			    data-options="singleSelect:true,collapsible:true">
		    <thead>
			    <tr>
				    <th data-options="field:'KeyID',hidden:true"></th>
				    <th data-options="field:'Name',width:200">公式组名称</th>
				    <th data-options="field:'EffectiveDate',width:80">生效时间</th>
				    <th data-options="field:'ExpirationDate',width:80">失效时间</th>
				    <th data-options="field:'attr1',width:40,formatter:formatAction"">查看</th>
			    </tr>
		    </thead>
	    </table>
	    <table id="formulaGroupsPendingEffectived" class="easyui-datagrid" title="即将启用的公式组" style="width:100%;height:33%"
			    data-options="singleSelect:true,collapsible:true,collapsed:false">
		    <thead>
			    <tr>
				    <th data-options="field:'KeyID',hidden:true">Item ID</th>
				    <th data-options="field:'Name',width:200">公式组名称</th>
				    <th data-options="field:'EffectiveDate',width:80">生效时间</th>
				    <th data-options="field:'ExpirationDate',width:80">失效时间</th>
				    <th data-options="field:'attr1',width:40,formatter:formatAction"">查看</th>
			    </tr>
		    </thead>
	    </table>
	    <table id="formulaGroupsPendingExpiration" class="easyui-datagrid" title="即将停用的公式组" style="width:100%;height:33%"
			    data-options="singleSelect:true,collapsible:true,collapsed:false">
		    <thead>
			    <tr>
				    <th data-options="field:'KeyID',hidden:true">Item ID</th>
				    <th data-options="field:'Name',width:200">公式组名称</th>
				    <th data-options="field:'EffectiveDate',width:80">生效时间</th>
				    <th data-options="field:'ExpirationDate',width:80">失效时间</th>
				    <th data-options="field:'attr1',width:40,formatter:formatAction"">查看</th>
			    </tr>
		    </thead>
	    </table>
	</div>
    <div data-options="region:'center'" style="padding:2px;">
	    <table id="formulaGroups" class="easyui-datagrid" title="公式组列表" style="width:100%;height:100%"
			    data-options="rownumbers:true,singleSelect:true,toolbar:toolbar">
		    <thead>
			    <tr>
				    <th data-options="field:'KeyID',hidden:true"></th>
				    <th data-options="field:'Name',width:260">公式组名称</th>
				    <th data-options="field:'CreateDate',width:120">创建时间</th>
				    <th data-options="field:'State',width:80,formatter:formatState">状态</th>
                    <th data-options="field:'unitcost',width:80,formatter:formatAction">操作</th>
			    </tr>
		    </thead>
	    </table>
    </div>
	<script type="text/javascript">
	    var toolbar = [{
	        text: '新增公式组',
	        iconCls: 'icon-add',
	        handler: createNewFormulaGroup
	    }, '-', {
	        text: '删除公式组',
	        iconCls: 'icon-clear',
	        handler: function () { alert('save') }
	    }];

	    function formatState(val, row) {
	        return '暂存';
	    }
	    function formatAction(val, row) {
	        return '<a href="FormulaEditor.aspx?groupId=' + row.KeyID + '">编辑</a>';
	    }

	    $(document).ready(function () {
	        loadFormulaGroups();
	        loadFormulaGroupsEffectived();
	        loadFormulaGroupsPendingEffectived();
	        loadFormulaGroupsPendingExpiration();
	    });

        // 所有公式组
	    function loadFormulaGroups() {
	        var factoryId = 1;
	        var queryUrl = 'FormulaService.asmx/GetFormulaGroupsWithDataGridFormat';
	        var dataToSend = '{factoryId: ' + factoryId + '}';

	        $.ajax({
	            type: "POST",
	            url: queryUrl,
	            data: dataToSend,
	            contentType: "application/json; charset=utf-8",
	            dataType: "json",
	            success: function (msg) {
	                initializeFormulaGroups(jQuery.parseJSON(msg.d));
	            }
	        });
	    }

	    function initializeFormulaGroups(jsonData) {
	        $('#formulaGroups').datagrid({
	            data: jsonData,
                dataType: "json"
	        });
	    }

        // 生效中的公式组
	    function loadFormulaGroupsEffectived() {
	        var factoryId = 1;
	        var queryUrl = 'FormulaService.asmx/GetFormulaGroupsEffectivedWithDataGridFormat';
	        var dataToSend = '{factoryId: ' + factoryId + '}';

	        $.ajax({
	            type: "POST",
	            url: queryUrl,
	            data: dataToSend,
	            contentType: "application/json; charset=utf-8",
	            dataType: "json",
	            success: function (msg) {
	                initializeFormulaGroupsEffectived(jQuery.parseJSON(msg.d));
	            }
	        });
	    }

	    function initializeFormulaGroupsEffectived(jsonData) {
	        $('#formulaGroupsEffectived').datagrid({
	            data: jsonData,
	            dataType: "json"
	        });
	    }

	    // 即将生效的公式组
	    function loadFormulaGroupsPendingEffectived() {
	        var factoryId = 1;
	        var queryUrl = 'FormulaService.asmx/GetFormulaGroupsPendingEffectivedWithDataGridFormat';
	        var dataToSend = '{factoryId: ' + factoryId + '}';

	        $.ajax({
	            type: "POST",
	            url: queryUrl,
	            data: dataToSend,
	            contentType: "application/json; charset=utf-8",
	            dataType: "json",
	            success: function (msg) {
	                initializeFormulaGroupsPendingEffectived(jQuery.parseJSON(msg.d));
	            }
	        });
	    }

	    function initializeFormulaGroupsPendingEffectived(jsonData) {
	        $('#formulaGroupsPendingEffectived').datagrid({
	            data: jsonData,
	            dataType: "json"
	        });
	    }

        // 即将失效的公式组
	    function loadFormulaGroupsPendingExpiration() {
	        var factoryId = 1;
	        var queryUrl = 'FormulaService.asmx/GetFormulaGroupsPendingExpirationWithDataGridFormat';
	        var dataToSend = '{factoryId: ' + factoryId + '}';

	        $.ajax({
	            type: "POST",
	            url: queryUrl,
	            data: dataToSend,
	            contentType: "application/json; charset=utf-8",
	            dataType: "json",
	            success: function (msg) {
	                initializeFormulaGroupsPendingExpiration(jQuery.parseJSON(msg.d));
	            }
	        });
	    }

	    function initializeFormulaGroupsPendingExpiration(jsonData) {
	        $('#formulaGroupsPendingExpiration').datagrid({
	            data: jsonData,
	            dataType: "json"
	        });
	    }

        // 创建新公式组
	    function createNewFormulaGroup() {
	        var factoryId = 1;
	        var queryUrl = 'FormulaService.asmx/CreateFormulaGroup';
	        var dataToSend = '{factoryId: ' + factoryId + '}';

	        $.ajax({
	            type: "POST",
	            url: queryUrl,
	            data: dataToSend,
	            contentType: "application/json; charset=utf-8",
	            dataType: "json",
	            success: function (msg) {
	                self.location = 'FormulaEditor.aspx?groupId=' + jQuery.parseJSON(msg.d).groupId;
	            }
	        });
	    }
	</script>
    </form>
</body>
</html>
