<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FormulaEditor.aspx.cs" Inherits="NXJC.UI.Web.EnergyEfficiency.FormulaEditor" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>公式编辑</title>
    <link href="/Scripts/easyui/themes/gray/easyui.css" rel="stylesheet" />
    <link href="/Scripts/EasyUI/themes/color.css" rel="stylesheet" />
    <link href="/Scripts/easyui/themes/icon.css" rel="stylesheet" />
    <script src="/Scripts/easyui/jquery.min.js"></script>
    <script src="/Scripts/easyui/jquery.easyui.min.js"></script>
    <script src="/Scripts/EasyUI/locale/easyui-lang-zh_CN.js"></script>
    <script src="/Scripts/jquery.utility.js"></script>
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
<body>
    <form id="form1" runat="server">
	<div id="wrapper" class="easyui-panel" style="width:98%;height:auto;padding:2px;">
	<div class="easyui-panel" style="width:100%;padding:5px;">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-back'" onclick="javascript:history.go(-1);">返回</a> | 
		名称：<input id="formulaGroupName" class="easyui-validatebox textbox" data-options="required:true,validType:'length[3,50]'" /> | 

        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-save'" onclick="temporarySave()">暂存</a> 
        <a href="javascript:void(0)" class="easyui-linkbutton c4 easyui-tooltip tooltip-f" data-options="plain:true,iconCls:'icon-ok'" title="提交后不可修改，请谨慎操作。" onclick="">提交</a>
	</div>
	<table id="formulaEditor" class="easyui-treegrid" title="公式录入" style="width:100%;height:450px"
			data-options="
				iconCls: 'icon-edit',
				rownumbers: true,
				animate: true,
				fitColumns: true,
				idField: 'LevelCode',
				treeField: 'Name',
				onContextMenu: onContextMenu,
                onDblClickRow: edit,
                onClickRow: save
			">
		<thead>
			<tr>
                <th data-options="field:'LevelCode',width:50">层次码</th>
				<th data-options="field:'Name',width:180,editor:'text'">工序名称</th>
				<th data-options="field:'Formula',width:180,formatter:formatFormula,editor:'text'">公式</th>
			</tr>
		</thead>
	</table>
	<div class="easyui-panel" style="width:100%;padding:5px;">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-add'" onclick="appendRoot()">添加根工序</a> | 
        <a href="javascript:void(0)" class="easyui-linkbutton easyui-tooltip tooltip-f" data-options="plain:true,iconCls:'icon-reload'" title="从其他公式组载入。" onclick="$('#dlgLoad').dialog('open')">载入</a> | 
        <a href="javascript:void(0)" class="easyui-linkbutton easyui-tooltip tooltip-f" data-options="plain:true,iconCls:'icon-filter'" title="查看可用的电表变量。" onclick="$('#dlgAmmeter').dialog('open')">电表变量表</a> 
        <a href="javascript:void(0)" class="easyui-linkbutton easyui-tooltip tooltip-f" data-options="plain:true,iconCls:'icon-filter'" title="查看可用的累积量变量。" onclick="$('#dlgCumulant').dialog('open')">累计量变量表</a> 
	</div>
	<div id="mm" class="easyui-menu" style="width:120px;">
		<div onclick="append()" data-options="iconCls:'icon-add'">添加</div>
		<div onclick="removeIt()" data-options="iconCls:'icon-remove'">删除</div>
		<div class="menu-sep"></div>
        <div onclick="appendRoot()" data-options="iconCls:'icon-add'">添加根工序</div>
        <div class="menu-sep"></div>
		<div onclick="collapse()">收起</div>
		<div onclick="expand()">展开</div>
	</div>

    <div id="dlgLoad" class="easyui-dialog" title="载入公式组" style="width:500px;height:500px;" 
        data-options="
            iconCls:'icon-reload',
            modal:true,
            closed:true
        " >
	    <table id="formulaGroups" class="easyui-datagrid" style="width:100%;height:100%"
			    data-options="singleSelect:true">
		    <thead>
			    <tr>
				    <th data-options="field:'KeyID',hidden:true"></th>
				    <th data-options="field:'Name',width:260">公式组名称</th>
				    <th data-options="field:'CreateDate',width:100">创建时间</th>
				    <th data-options="field:'State',width:100,align:'center'">状态</th>
			    </tr>
		    </thead>
	    </table>
	</div>

    <div id="dlgAmmeter" class="easyui-dialog" title="电表变量表" style="width:550px;height:500px;" 
        data-options="
            iconCls:'icon-filter',
            closed:true
        " >
	    <table id="tgAmmeters" class="easyui-treegrid" style="width:100%;height:100%"
			    data-options="idField:'AmmeterNumber',treeField:'AmmeterNumber',singleSelect:true">
		    <thead>
			    <tr>
				    <th data-options="field:'AmmeterNumber',width:260">电表变量</th>
				    <th data-options="field:'AmmeterName',width:260">电表描述</th>
			    </tr>
		    </thead>
	    </table>
	</div>

    <div id="dlgCumulant" class="easyui-dialog" title="累计量变量表" style="width:500px;height:500px;" 
        data-options="
            iconCls:'icon-reload',
            modal:true,
            closed:true
        " >
	    <table id="Table2" class="easyui-datagrid" style="width:100%;height:100%"
			    data-options="singleSelect:true">
		    <thead>
			    <tr>
				    <th data-options="field:'KeyID',hidden:true"></th>
				    <th data-options="field:'Name',width:260">公式组名称</th>
				    <th data-options="field:'CreateDate',width:100">创建时间</th>
				    <th data-options="field:'State',width:100,align:'center'">状态</th>
			    </tr>
		    </thead>
	    </table>
	</div>

	<script type="text/javascript">
        // 公式检验样式
	    function formatFormula(value) {
	        var validateResult = validateExpression(value);
	        
	        if (validateResult == "success") {
	            var s = '<div style="width:100%;">' + value;
	            s += '<div style="float:right;width:16px;height:16px;" class="icon-ok"></div></div>';
	            return s;
	        }
	        else {
	            var s = '<div style="width:100%;">' + value;
	            s += '<div title="' + validateResult + '" class="easyui-tooltip icon-no" style="float:right;width:16px;height:16px;"></div></div>';
	            return s;
	        }
	    }
        
        /////////////////////////////////////////////////////////////////////

        // 右键菜单
	    function onContextMenu(e, row) {
	        e.preventDefault();
	        $(this).treegrid('select', row.LevelCode);
	        $('#mm').menu('show', {
	            left: e.pageX,
	            top: e.pageY
	        });
	    }

        // 添加根节点
	    function appendRoot() {
	        var levelCode = getAppendRootLevelCode();
	        $('#formulaEditor').treegrid('append', {
	            data: [{
	                LevelCode: levelCode,
	                Name: '新工序',
	                Formula: ''
	            }]
	        })
	    }

        //添加子节点
	    function append() {
	        var node = $('#formulaEditor').treegrid('getSelected');
	        var levelCode = getAppendLevelCode(node.LevelCode);
	        $('#formulaEditor').treegrid('append', {
	            parent: node.LevelCode,
	            data: [{
	                LevelCode: levelCode,
	                Name: '新工序',
	                Formula: ''
	            }]
	        })
	    }

        // 删除节点
	    function removeIt() {
	        var node = $('#formulaEditor').treegrid('getSelected');
	        if (node) {
	            $('#formulaEditor').treegrid('remove', node.LevelCode);
	        }
	    }

        // 收起节点
	    function collapse() {
	        var node = $('#formulaEditor').treegrid('getSelected');
	        if (node) {
	            $('#formulaEditor').treegrid('collapse', node.LevelCode);
	        }
	    }

        // 展开节点
	    function expand() {
	        var node = $('#formulaEditor').treegrid('getSelected');
	        if (node) {
	            $('#formulaEditor').treegrid('expand', node.LevelCode);
	        }
	    }

	    ////////////////////////////////////////////////////////////////////////////////

        // 生成根节点ID
	    function getAppendRootLevelCode() {
	        var rows = $('#formulaEditor').treegrid('getRoots');
	        if (rows.length == 0) {
	            return 'P01';
	        }
	        else {
	            var maxCode = 0;
	            for (var i = 0; i < rows.length; i++) {
	                var temp = rows[i].LevelCode;
	                if (temp.length != 3)
	                    continue;
	                var p = parseInt(temp.substring(1, temp.length));
	                if (p > maxCode)
	                    maxCode = p;
	            }
	            maxCode = maxCode + 1;
	            if (maxCode.toString().length % 2 == 1)
	                return 'P0' + maxCode;
	            else
	                return 'P' + maxCode;
	        }
	    }

        // 生成子节点ID
	    function getAppendLevelCode(parentId) {
	        var rows = $('#formulaEditor').treegrid('getChildren', parentId);

	        if (rows.length == 0) {
	            return parentId + '01';
	        }
	        else {
	            var maxCode = 0;
	            for (var i = 0; i < rows.length; i++) {
	                var temp = rows[i].LevelCode;
	                if (temp.length != parentId.length + 2)
	                    continue;
	                var p = parseInt(temp.substring(1, temp.length));
	                if (p > maxCode)
	                    maxCode = p;
	            }
	            maxCode = maxCode + 1;
	            if (maxCode.toString().length % 2 == 1)
	                return 'P0' + maxCode;
	            else
	                return 'P' + maxCode;
	        }
	    }

	    ///////////////////////////////////////////////////////////

        // 编辑
	    var editingId;
	    function edit() {
	        if (editingId != undefined) {
	            $('#formulaEditor').treegrid('select', editingId);
	            return;
	        }
	        var row = $('#formulaEditor').treegrid('getSelected');
	        if (row) {
	            editingId = row.LevelCode
	            $('#formulaEditor').treegrid('beginEdit', editingId);
	        }
	    }
	    function save() {
	        if (editingId != undefined) {
	            var t = $('#formulaEditor');
	            t.treegrid('endEdit', editingId);
	            editingId = undefined;

	            $('.easyui-tooltip').tooltip({ position: 'left' });
	        }
	    }
	    function cancel() {
	        if (editingId != undefined) {
	            $('#formulaEditor').treegrid('cancelEdit', editingId);
	            editingId = undefined;
	        }
	    }

        //////////////////////////////////////////////////////////////////////

        // 验证公式合法性
	    function validateExpression(expression) {
	        var queryUrl = 'FormulaService.asmx/ValidateExpression';
	        var dataToSend = '{expression: "' + expression + '"}';
	        var result = '验证服务不可用';

	        $.ajax({
	            type: "POST",
	            url: queryUrl,
	            data: dataToSend,
	            async: false,
	            contentType: "application/json; charset=utf-8",
	            dataType: "json",
	            success: function (msg) {
	                result = msg.d;
	            }
	        });

	        return result;
	    }

	    //////////////////////////////////////////////////////////////////////

        // 按公式组ID获取公式名
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

        // 按公式组获取所有公式
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

        // 初始化公式编辑器
	    function initializeFormulaEditor(jsonData) {
	        $('#formulaEditor').treegrid({
	            data: jsonData,
	            dataType: "json"
	        });
	    }

	    ///////////////////////////////////////////////////////////////////////

        // 获取公式组
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
	            dataType: "json",
	            onDblClickRow: function (rowIndex, rowData) {
	                loadFormulas(rowData.KeyID);
	                $('#dlg').dialog('close');
	            }
	        });
	    }

	    //////////////////////////////////////////////////////////////////////

        // 暂存
	    function temporarySave() {
	        var groupId = $.getUrlParam('groupId');

	        if ($('#formulaGroupName').validatebox('isValid') == false)
	            return;

	        var queryUrl = 'FormulaService.asmx/UpdateFormulaGroupName';
	        var dataToSend = '{"groupId":"' + groupId + '","name":\'' + ($('#formulaGroupName').val()) + '\'}';

	        $.ajax({
	            type: "POST",
	            url: queryUrl,
	            data: dataToSend,
	            contentType: "application/json; charset=utf-8",
	            dataType: "json",
	            success: function (msg) {
	            }
	        });

	        queryUrl = 'FormulaService.asmx/SaveFormulasWithTreeGridFormat';
	        dataToSend = '{"groupId":"' + groupId + '","json":\'' + JSON.stringify($('#formulaEditor').treegrid('getData')) + '\'}';

	        $.ajax({
	            type: "POST",
	            url: queryUrl,
	            data: dataToSend,
	            contentType: "application/json; charset=utf-8",
	            dataType: "json",
	            success: function (msg) {
	                $.messager.alert('消息', '暂存成功。', 'info');
	            }
	        });
	    }

	    //////////////////////////////////////////////////////////////////////

	    // 读取电表变量表

	    function queryAmmeters() {
	        var queryUrl = 'FormulaService.asmx/GetAmmeterLabelsWithTreeGridFormat';
	        var dataToSend = '{factoryId: ' + 1 + '}';

	        $.ajax({
	            type: "POST",
	            url: queryUrl,
	            data: dataToSend,
	            contentType: "application/json; charset=utf-8",
	            dataType: "json",
	            success: function (msg) {
	                initializeAmmeterTreeGrid(jQuery.parseJSON(msg.d));
	            }
	        });
	    }

	    function initializeAmmeterTreeGrid(jsonData) {
	        $('#tgAmmeters').treegrid({
	            data: jsonData,
	            dataType: "json"
	        });
	    };

        ///////////////////////////////////////////////////////////////////////

	    $(document).ready(function () {
	        //var groupId = 'e7f7f49f-9c9d-473a-9e3f-53d76d22cc64';
	        var groupId = $.getUrlParam('groupId');
	        loadName(groupId);
	        loadFormulas(groupId);
	        loadFormulaGroups();
	        queryAmmeters();
	    });

	    //////////////////////////////////////////////////////////////////////

	</script>
    </div>
    </form>
</body>
</html>
