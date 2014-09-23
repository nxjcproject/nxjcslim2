<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MasterConfigure.aspx.cs" Inherits="NXJC.UI.Web.MasterAlarm.MasterConfigure" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href="/Scripts/EasyUI/themes/gray/easyui.css" rel="stylesheet" />
    <link href="/Scripts/EasyUI/themes/icon.css" rel="stylesheet" />
    <script src="/Scripts/EasyUI/jquery.min.js"></script>
    <script src="/Scripts/EasyUI/jquery.easyui.min.js"></script>
    <title></title>  
</head>
<body>
    <table id="dg" class="easyui-datagrid" title="" style="width:100%;height:auto">
	</table>
    <div id="tb" style="padding:5px;height:auto">
        <a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addItem()">添加</a>
	    <a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="deleteItem()">删除</a>
	    <a href="#" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="saveItem()">保存</a>
    </div>

    <script type="text/javascript">

        $(document).ready(function () {
            loadMasterData();
            loadEquipmentData();
            loadGridData('first');
        });

        var equipmentData;
        var masterData;
        var m_MsgData;
        var editIndex = undefined;

        $.extend($.fn.datagrid.methods, {
            editCell: function (jq, param) {
                return jq.each(function () {
                    var opts = $(this).datagrid('options');
                    var fields = $(this).datagrid('getColumnFields', true).concat($(this).datagrid('getColumnFields'));
                    for (var i = 0; i < fields.length; i++) {
                        var col = $(this).datagrid('getColumnOption', fields[i]);
                        col.editor1 = col.editor;
                        if (fields[i] != param.field) {
                            col.editor = null;
                        }
                    }
                    $(this).datagrid('beginEdit', param.index);
                    for (var i = 0; i < fields.length; i++) {
                        var col = $(this).datagrid('getColumnOption', fields[i]);
                        col.editor = col.editor1;
                    }
                });
            }
        });

        function endEditing() {
            if (editIndex == undefined) { return true }
            if ($('#dg').datagrid('validateRow', editIndex)) {
                $('#dg').datagrid('endEdit', editIndex);
                editIndex = undefined;
                return true;
            } else {
                return false;
            }
        }
        function onClickCell(index, field) {
            if (endEditing()) {
                $('#dg').datagrid('selectRow', index)
						.datagrid('editCell', { index: index, field: field });
                editIndex = index;
            }
        }

        function loadEquipmentData() {
            //parent.$.messager.progress({ text: '数据加载中....' });
            $.ajax({
                type: "POST",
                async: false,
                url: "MasterConfigure.asmx/GetEquipmentDatas",
                data: "{ProductLineID: '1'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    equipmentData = jQuery.parseJSON(msg.d);
                }
            });
        }

        function loadMasterData() {
            //parent.$.messager.progress({ text: '数据加载中....' });
            $.ajax({
                type: "POST",
                async: false,
                url: "MasterConfigure.asmx/GetmastersDatas",
                data: "{ProductLineID: '1'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    masterData = jQuery.parseJSON(msg.d);
                }
            });
        }

        function belongComboboxFormatter(value) {
            if (value == 0 || value == "")
                return;

            for (var i = 0; i < masterData.length; i++) {
                if (masterData[i].VariableName == value)
                    return masterData[i].EquipmentName;
            }
        }
        function equipmentNameComboboxFormatter(value) {
            if (value == 0 || value == "")
                return;

            for (var i = 0; i < equipmentData.length; i++) {
                if (equipmentData[i].VariableName == value)
                    return equipmentData[i].EquipmentName;
            }
        }

        function selectEquipmentCombobox() {
            if (editIndex == undefined) { return true }
            if ($('#dg').datagrid('validateRow', editIndex)) {
                var ed = $('#dg').datagrid('getEditor', { index: editIndex, field: 'VariableName' });
                var equipmentName = $(ed.target).combobox('getText');
                $('#dg').datagrid('getRows')[editIndex]['EquipmentName'] = equipmentName;
                $('#dg').datagrid('endEdit', editIndex);
                editIndex = undefined;
            }
        }

        function loadGridData(myLoadType) {

            //parent.$.messager.progress({ text: '数据加载中....' });
            $.ajax({
                type: "POST",
                url: "MasterConfigure.asmx/GetAlarmConfigureDatas",
                data: "{ProductLineID: '1'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                //async: false,//取消异步请求
                success: function (msg) {
                    if (myLoadType == 'first') {
                        myLoadType = 'last';
                        m_MsgData = jQuery.parseJSON(msg.d);
                        InitializeGrid(m_MsgData);
                    }
                    else if (myLoadType == 'last') {
                        m_MsgData = jQuery.parseJSON(msg.d);
                        $('#dg').datagrid('loadData', m_MsgData);
                    }
                }
            });
        }
        function InitializeGrid(myData) {

            $('#dg').datagrid({
                iconCls: 'icon-edit', singleSelect: true, rownumbers: true, striped: true, onClickCell: onClickCell, toolbar: '#tb',
                columns: [[
                    {
                        field: 'VariableName', title: '标签名', width: '10%', align: 'center',
                        editor: {
                            type: 'combobox',
                            options: {
                                data: equipmentData,
                                valueField: 'VariableName',
                                textField: 'EquipmentName',
                                onSelect: selectEquipmentCombobox
                            }
                        }
                    },
                    { field: 'EquipmentName', title: '设备名称', width: '10%', align: 'center' },
                    {
                        field: 'Ismaster', title: '主机标志', width: '6%', align: 'center',
                        formatter: function (value) {
                            if (value == 'True')
                                return '主机';
                            else if (value == 'False' || value == '')
                                return '从机';
                            else
                                return '';
                        },
                        editor: {
                            type: 'checkbox',
                            options: {
                                on: 'True',
                                off: 'False'
                            }
                        }
                    },
                    {
                        field: 'Belong', title: '所属主机', width: '20%', align: 'center',
                        formatter: belongComboboxFormatter,
                        editor: {
                            type: 'combobox',
                            options: {
                                data: masterData,
                                valueField: 'VariableName',
                                textField: 'EquipmentName'
                            }
                        }
                    },
                    {
                        field: 'IsAlarm', title: '报警标志', width: '6%', align: 'center',
                        formatter: function (value) {
                            if (value == 'True')
                                return '1';
                            else if (value == 'False')
                                return '0';
                            else
                                return '';
                        },
                        editor: {
                            type: 'checkbox',
                            options: {
                                on: 'True',
                                off: 'False'
                            }
                        }
                    },
                    {
                        field: 'StopPosition', title: '停机位置', width: '6%', align: 'center',
                        formatter: function (value) {
                            if (value == 'True')
                                return '1';
                            else if (value == 'False')
                                return '0';
                            else
                                return '';
                        },
                        editor: {
                            type: 'checkbox',
                            options: {
                                on: 'True',
                                off: 'False'
                            }
                        }
                    },
                    {
                        field: 'AlarmPosition', title: '报警位置', width: '6%', align: 'center',
                        formatter: function (value) {
                            if (value == 'True')
                                return '1';
                            else if (value == 'False')
                                return '0';
                            else
                                return '';
                        },
                        editor: {
                            type: 'checkbox',
                            options: {
                                on: 'True',
                                off: 'False'
                            }
                        }
                    },
                    { field: 'AlarmMessage', title: '报警信息', width: '20%', align: 'center', editor: 'text' },
                    {
                        field: 'action', title: '操作', width: '14%', align: 'center',
                        formatter: function (value, row, index) {
                            var s = '<a href="#" onclick="deleteItem(' + index + ')">删除</a> ';
                            return s;
                        }
                    }
                ]],
                data: myData,
            });
        }


        function addItem() {
            $('#dg').datagrid('appendRow', {});
        }
        function deleteItem(index) {
            $('#dg').datagrid('deleteRow', index);
        }
        function saveItem() {
            //alert('test');
            endEditing();           //关闭正在编辑

            var insertRows = $('#dg').datagrid('getChanges', 'inserted');
            var updateRows = $('#dg').datagrid('getChanges', 'updated');
            var deleteRows = $('#dg').datagrid('getChanges', 'deleted');
            var changesRows = {
                inserted: [],
                updated: [],
                deleted: []
            };
            if (insertRows.length > 0) {
                for (var i = 0; i < insertRows.length; i++) {
                    insertRows[i]["CompanyID"] = m_MsgData[1]["CompanyID"];
                    changesRows.inserted.push(insertRows[i]);
                }
            }

            if (updateRows.length > 0) {
                for (var k = 0; k < updateRows.length; k++) {
                    changesRows.updated.push(updateRows[k]);
                }
            }

            if (deleteRows.length > 0) {
                for (var j = 0; j < deleteRows.length; j++) {
                    changesRows.deleted.push(deleteRows[j]);
                }
            }

            $.ajax({
                type: "POST",
                url: "EditFengGuPing.asmx/SavePVFValues",
                data: "{myJsonData:'" + JSON.stringify(changesRows) + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    if (msg.d == "1") {
                        alert("更新成功!");
                    } else {
                        alert("更新失败!");
                    }
                }
            });

            //alert(JSON.stringify(changesRows));

            // 保存成功后，可以刷新页面，也可以：
            //$('#tt').datagrid('acceptChanges');
        }
    </script>
</body>
</html>