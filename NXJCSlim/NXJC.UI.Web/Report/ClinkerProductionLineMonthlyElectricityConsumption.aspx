<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ClinkerProductionLineMonthlyElectricityConsumption.aspx.cs" Inherits="NXJC.UI.Web.Report.ClinkerProductionLineMonthlyElectricityConsumption" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
 <link href="/Scripts/easyui/themes/gray/easyui.css" rel="stylesheet" />
    <link href="/Scripts/easyui/themes/icon.css" rel="stylesheet" />
    <script src="/Scripts/easyui/jquery.min.js"></script>
    <script src="/Scripts/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript">
        var editIndex = undefined;

        $(function () {
            loadGridData('first');

        });
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
        function loadGridData(myLoadType) {

            //parent.$.messager.progress({ text: '数据加载中....' });
            var m_MsgData;
            $.ajax({
                type: "POST",
                url: "ClinkerProductionLineMonthlyElectricityConsumption.aspx/GetCompanyData",                 //填写后台方法链接
                data: "",//"{id: ''}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    if (myLoadType == 'first') {
                        m_MsgData = jQuery.parseJSON(msg.d);
                        InitializeGrid(m_MsgData);
                    }
                    else if (myLoadType == 'last') {
                        m_MsgData = jQuery.parseJSON(msg.d);
                        $('#gridMain_CellEdit').datagrid('loadData', m_MsgData);
                    }
                }
            });
        }
        function InitializeGrid(myData) {

            var m_IdAndNameColumn = myData['columns'].splice(0, 2);
            var m_IdColumn = m_IdAndNameColumn[0].field;

            //添加删除行操作时取消注释
            //myData['columns'].push(                                      
            //{
            //    field: "OP",
            //    width: "35",
            //    title: "操作",
            //    formatter: function (value, row, index) {
            //        return '<img class="iconImg" src = "/lib/extlib/themes/images/ext_icons/notes/note_delete.png" title="删除" onclick="removeRowFun(' + index + ');"/>';
            //    }
            //});


            $('#gridMain_CellEdit').datagrid({
                title: '',
                data: myData,
                dataType: "json",
                striped: true,
                idField: m_IdAndNameColumn[0].field,
                frozenColumns: [[m_IdAndNameColumn[1]]],
                columns: [myData['columns']],
                //loadMsg: '',   //设置本身的提示消息为空 则就不会提示了的。这个设置很关键的
                rownumbers: true,
                //pagination: true,
                singleSelect: true,
                onClickCell: onClickCell,
                //idField: m_IdAndNameColumn[0].field,
                //pageSize: 20,
                //pageList: [20, 50, 100, 500],

                toolbar: '#toolbar'
            });

            //for(
        }

        function endEditing() {
            if (editIndex == undefined) { return true }
            if ($('#gridMain_CellEdit').datagrid('validateRow', editIndex)) {
                $('#gridMain_CellEdit').datagrid('endEdit', editIndex);
                editIndex = undefined;
                return true;
            } else {
                return false;
            }
        }
        function onClickCell(index, field) {
            if (endEditing()) {
                $('#gridMain_CellEdit').datagrid('selectRow', index)
                                .datagrid('editCell', { index: index, field: field });
                editIndex = index;
            }
        }
        function addRowFun() {
            $('#gridMain_CellEdit').datagrid('appendRow', {

            });
        }
        function PrintFun() {
            endEditing();
            CreateFormPage("报表明细", $('#gridMain_CellEdit'));
        }
        function ExportFun() {
            endEditing();
            CreateDataJson($('#gridMain_CellEdit'), "核销账款明细", '2014-6-1', '2014-7-1');
            //ExportExcelPage("核销账款明细", $('#gridMain_CellEdit'));
        }
        function removeRowFun() {
            $.messager.confirm('提示', '你确定删除此条记录吗？', function (r) {
                if (r) {
                    var rows = $('#gridMain_CellEdit').datagrid("getSelected");
                    var index = $('#gridMain_CellEdit').datagrid('getRowIndex', rows);
                    $('#gridMain_CellEdit').datagrid('deleteRow', index);
                }
                //else {
                //    $.messager.show({
                //        title: '信息',
                //        msg: '已经取消了删除操作'
                //    });
                //}
            });
        }
        function saveRowsFun() {

            endEditing();           //关闭正在编辑
            tzValues['Remarks'] = $('#txtRemarks').val();
            var insertRows = $('#gridMain_CellEdit').datagrid('getChanges', 'inserted');
            var updateRows = $('#gridMain_CellEdit').datagrid('getChanges', 'updated');
            var deleteRows = $('#gridMain_CellEdit').datagrid('getChanges', 'deleted');
            var changesRows = {
                inserted: [],
                updated: [],
                deleted: [],
                tzValue: []
            };
            if (insertRows.length > 0) {
                for (var i = 0; i < insertRows.length; i++) {
                    insertRows[i]['KeyID'] = tzValues['KeyID'];
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
            changesRows.tzValue.push(tzValues);
            //var aa = JSON.stringify(changesRows);
            $.ajax({
                type: "POST",
                url: "Service/FormulaYearInformationService.asmx/ChangeDataByGrid",
                data: "{myJsonData:'" + JSON.stringify(changesRows) + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    if (msg.d == "1") {
                        alert("更新成功!");
                        //$('#dlg').dialog('close');
                    } else {
                        alert("更新失败!");
                    }
                }
            });

            //alert(JSON.stringify(changesRows));

            // 保存成功后，可以刷新页面，也可以：
            //$('#tt').datagrid('acceptChanges');
        }

        function saveAnoher() {
            endEditing();           //关闭正在编辑
            tzValues['Remarks'] = $('#txtRemarks').val();
            var rows = $('#gridMain_CellEdit').datagrid('getRows');
            var data2service = {
                ChildrenValue: [],
                TzValue: []
            };
            if (rows.length > 0) {
                for (var i = 0; i < rows.length; i++) {
                    data2service.ChildrenValue.push(rows[i]);
                }
                data2service.TzValue.push(tzValues);
            }
            //var aa = JSON.stringify(data2service);
            $.ajax({
                type: "POST",
                url: "Service/FormulaYearInformationService.asmx/SaveAnotherByGrid",
                data: "{myJsonData:'" + JSON.stringify(data2service) + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    if (msg.d == "1") {
                        alert("更新成功!");
                        //$('#dlg').dialog('close');
                    } else {
                        alert("更新失败!");
                    }
                }
            });
        }


    </script>
    <title></title>
</head>
<body>
    <table id="gridMain_CellEdit" class="easyui-datagrid" title="" style="width:1300px;height:auto">
	</table>
</body>
</html>
