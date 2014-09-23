<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Configuration.aspx.cs" Inherits="NXJC.UI.Web.EnergyConsumptionAlarm.Configuration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>能耗报警设置</title>
    <link href="/Scripts/easyui/themes/gray/easyui.css" rel="stylesheet" />
    <link href="/Scripts/EasyUI/themes/color.css" rel="stylesheet" />
    <link href="/Scripts/easyui/themes/icon.css" rel="stylesheet" />
    <script src="/Scripts/easyui/jquery.min.js"></script>
    <script src="/Scripts/easyui/jquery.easyui.min.js"></script>
    <script src="/Scripts/EasyUI/locale/easyui-lang-zh_CN.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div id="wrapper" class="easyui-panel" style="width:98%;height:auto;padding:2px;">
	<div class="easyui-panel" style="width:100%;padding:5px;">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-save'" onclick="submit()">保存</a> 
	</div>
    <br />
    <table id="electricityEnergyAlarmSettingEditor" class="easyui-treegrid" title="工序能耗报警设置" style="width:100%;height:450px"
		data-options="
			iconCls: 'icon-edit',
			rownumbers: true,
			animate: true,
			fitColumns: true,
			idField: 'LevelCode',
			treeField: 'Name',
            onDblClickRow: elecEdit,
            onClickRow: elecSave
		">
		<thead>
			<tr>
                <th data-options="field:'LevelCode',width:50">层次码</th>
				<th data-options="field:'Name',width:180">工序名称</th>
				<th data-options="field:'StandardValue',width:180,editor:'text'">标准值</th>
                <th data-options="field:'AlarmValue',width:180,editor:'text'">报警值</th>
			</tr>
		</thead>
	</table>
    <br />
    <table id="coalConsumptionAlarmSettingEditor" class="easyui-treegrid" title="煤耗报警设置" style="width:100%;height:80px;"
		data-options="
			iconCls: 'icon-edit',
			rownumbers: true,
			animate: true,
			fitColumns: true,
			idField: 'Name',
			treeField: 'Name',
            onDblClickRow: coalEdit,
            onClickRow: coalSave
		">
		<thead>
			<tr>
				<th data-options="field:'Name',width:180">名称</th>
				<th data-options="field:'StandardValue',width:180,editor:'text'">标准值</th>
                <th data-options="field:'AlarmValue',width:180,editor:'text'">报警值</th>
			</tr>
		</thead>
	</table>
    <br />
	<div class="easyui-panel" style="width:100%;padding:5px;">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-save'" onclick="submit()">保存</a> 
	</div>
    </div>
    </form>

    <script type="text/javascript">

        ///////////////////////////////////////////////////////////

        // 编辑
        var elecEditingId;
        function elecEdit() {
            if (elecEditingId != undefined) {
                $('#electricityEnergyAlarmSettingEditor').treegrid('select', elecEditingId);
                return;
            }
            var row = $('#electricityEnergyAlarmSettingEditor').treegrid('getSelected');
            if (row) {
                elecEditingId = row.LevelCode
                $('#electricityEnergyAlarmSettingEditor').treegrid('beginEdit', elecEditingId);
            }
        }
        function elecSave() {
            if (elecEditingId != undefined) {
                var t = $('#electricityEnergyAlarmSettingEditor');
                t.treegrid('endEdit', elecEditingId);
                elecEditingId = undefined;
            }
        }
        function elecCancel() {
            if (elecEditingId != undefined) {
                $('#electricityEnergyAlarmSettingEditor').treegrid('cancelEdit', elecEditingId);
                elecEditingId = undefined;
            }
        }

        // 编辑
        var coalEditingId;
        function coalEdit() {
            if (coalEditingId != undefined) {
                $('#coalConsumptionAlarmSettingEditor').treegrid('select', coalEditingId);
                return;
            }
            var row = $('#coalConsumptionAlarmSettingEditor').treegrid('getSelected');
            if (row) {
                coalEditingId = row.Name;
                $('#coalConsumptionAlarmSettingEditor').treegrid('beginEdit', coalEditingId);
            }
        }
        function coalSave() {
            if (coalEditingId != undefined) {
                var t = $('#coalConsumptionAlarmSettingEditor');
                t.treegrid('endEdit', coalEditingId);
                coalEditingId = undefined;
            }
        }
        function coalCancel() {
            if (coalEditingId != undefined) {
                $('#coalConsumptionAlarmSettingEditor').treegrid('cancelEdit', coalEditingId);
                coalEditingId = undefined;
            }
        }

        ///////////////////////////////////////////////////////////

        function loadElectricityEnergyAlarmSettingEditorSettings(productLineId) {
            var queryUrl = 'EnergyConsumptionAlarmService.asmx/GetElectricityConsumptionAlarmSettingsWithTreeGridFormat';
            var dataToSend = '{productLineId: "' + productLineId + '"}';

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
                    initializeElectricityEnergyAlarmSettingEditorSettingEditor(jQuery.parseJSON(msg.d));
                    $.messager.progress('close');
                },
                error: function () {
                    $.messager.progress('close');
                    $.messager.alert('错误', '数据载入失败！');
                }
            });
        }

        // 初始化公式编辑器
        function initializeElectricityEnergyAlarmSettingEditorSettingEditor(jsonData) {
            $('#electricityEnergyAlarmSettingEditor').treegrid({
                data: jsonData,
                dataType: "json"
            });
        }

        ///////////////////////////////////////////////////////////

        function loadCoalAlarmSettingEditorSettings(productLineId) {
            var queryUrl = 'EnergyConsumptionAlarmService.asmx/GetCoalConsumptionAlarmSettingsWithTreeGridFormat';
            var dataToSend = '{productLineId: "' + productLineId + '"}';

            $.ajax({
                type: "POST",
                url: queryUrl,
                data: dataToSend,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    initializeCoalEnergyAlarmSettingEditorSettingEditor(jQuery.parseJSON(msg.d));
                    $.messager.progress('close');
                },
                error: function () {
                    $.messager.alert('错误', '数据载入失败！');
                }
            });
        }

        // 初始化公式编辑器
        function initializeCoalEnergyAlarmSettingEditorSettingEditor(jsonData) {
            $('#coalConsumptionAlarmSettingEditor').treegrid({
                data: jsonData,
                dataType: "json"
            });
        }

        ////////////////////////////////////////////////////////////////////

        function submit() {
            elecCancel();
            coalCancel();
        }

        $(document).ready(function () {
            var productLineId = 1;
            loadElectricityEnergyAlarmSettingEditorSettings(productLineId);
            loadCoalAlarmSettingEditorSettings(productLineId);
        });
    </script>
</body>
</html>
