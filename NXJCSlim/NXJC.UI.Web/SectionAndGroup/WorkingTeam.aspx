<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WorkingTeam.aspx.cs" Inherits="NXJC.UI.Web.SectionAndGroup.WorkingTeam" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
   <link href="/Scripts/EasyUI/themes/gray/easyui.css" rel="stylesheet" />
    <link href="/Scripts/EasyUI/themes/icon.css" rel="stylesheet" />
    <script src="/Scripts/EasyUI/jquery.min.js"></script>
    <script src="/Scripts/EasyUI/jquery.easyui.min.js"></script>
    <script type="text/javascript">

        $(document).ready(function () {
            loadProductLineComboboxData('first');
            loadStaffInfoComboboxData('first');
            loadGridData('first');
        });

        var m_StaffInfoComboxData;
        var m_ProductLineComboxData;
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

        function loadGridData(myLoadType) {

            //parent.$.messager.progress({ text: '数据加载中....' });
            $.ajax({
                type: "POST",
                url: "WorkingTeam.asmx/GetWorkingTeamDatas",
                data: "{companyId: '1'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    if (myLoadType == 'first') {
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

        function loadProductLineComboboxData(myLoadType) {

            //parent.$.messager.progress({ text: '数据加载中....' });
            $.ajax({
                type: "POST",
                url: "WorkingTeam.asmx/GetProductLineForCombobox",
                data: "",//"{companyId: '1'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    if (myLoadType == 'first') {
                        m_ProductLineComboxData = jQuery.parseJSON(msg.d);
                        //InitializeGrid(m_MsgData);
                    }
                    else if (myLoadType == 'last') {
                        m_ProductLineComboxData = jQuery.parseJSON(msg.d);
                        //$('#dg').datagrid('loadData', m_MsgData);
                    }
                }
            });
        }

        function loadStaffInfoComboboxData(myLoadType) {
            //parent.$.messager.progress({ text: '数据加载中....' });
            $.ajax({
                type: "POST",
                url: "WorkingTeam.asmx/GetStaffInfoForCombobox",
                data: "",//"{companyId: '1'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    if (myLoadType == 'first') {
                        m_StaffInfoComboxData = jQuery.parseJSON(msg.d);
                        //InitializeGrid(m_MsgData);
                    }
                    else if (myLoadType == 'last') {
                        m_StaffInfoComboxData = jQuery.parseJSON(msg.d);
                        //$('#dg').datagrid('loadData', m_MsgData);
                    }
                }
            });
        }

        function InitializeGrid(myData) {

            $('#dg').datagrid({
                data: myData,
                iconCls: 'icon-edit', singleSelect: true, rownumbers: true, striped: true, onClickCell: onClickCell, toolbar: '#tb',
                columns: [[
                    {
                        field: 'ProductLineID', title: '生产线', width: '25%', method: 'post', align: 'center',
                        formatter: function (value, row, rowIndex) {
                            if (value == 0) {
                                return;
                            }
                            for (var i = 0; i < m_ProductLineComboxData.length; i++) {
                                if (m_ProductLineComboxData[i].ID == value) {
                                    return m_ProductLineComboxData[i].Name;
                                }
                            }
                        },
                        editor: {
                            type: 'combobox',
                            options: {
                                valueField: 'ID',
                                textField: 'Name',
                                data: m_ProductLineComboxData,
                                //url: "WorkingSection.asmx/GetProductLineDatas",
                                required: true
                            }
                        }
                    }, {
                        field: 'ChargeManID', title: '负责人', width: '20%', method: 'post', align: 'center',
                        formatter: function (value, row, rowIndex) {
                            if (value == 0) {
                                return;
                            }
                            for (var i = 0; i < m_StaffInfoComboxData.length; i++) {
                                if (m_StaffInfoComboxData[i].ID == value) {
                                    return m_StaffInfoComboxData[i].Name;
                                }
                            }
                        },
                        editor: {
                            type: 'combobox',
                            options: {
                                valueField: 'ID',
                                textField: 'Name',
                                data: m_StaffInfoComboxData,
                                //url: "WorkingSection.asmx/GetProductLineDatas",
                                required: true
                            }
                        }
                    },
                    { field: 'Name', title: '班组名称', width: '25%', align: 'center', editor: 'text' },
                    { field: 'Remarks', title: '备注', width: '27%', align: 'center', editor: 'text' },
                ]]
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
    <title></title>
</head>
<body>
    <div>
        <table id="dg" class="easyui-datagrid" title="" style="width:100%;height:auto">
	    </table>
    </div>
    <div id="tb" style="padding:5px;height:auto">
        <a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addItem()">添加</a>
	    <a href="#" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="saveItem()">保存</a>
    </div>
</body>
</html>
