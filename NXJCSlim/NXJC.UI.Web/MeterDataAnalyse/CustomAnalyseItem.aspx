<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CustomAnalyseItem.aspx.cs" Inherits="NXJC.UI.Web.MeterDataAnalyse.CustomAnalyseItem" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="/Scripts/easyui/themes/gray/easyui.css" rel="stylesheet" />
    <link href="/Scripts/easyui/themes/icon.css" rel="stylesheet" />
    <script src="/Scripts/easyui/jquery.min.js"></script>
    <script src="/Scripts/easyui/jquery.easyui.min.js"></script>
    <script src="/Scripts/EasyUI/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#labelSelectedList').datagrid({
                onDblClickRow: onLabelSelectedDoubleClicked
            });
        });

        function queryProductLine() {
            var productLineName = $('#productLineName').combobox('getText');
            var queryUrl = 'treegrid_data1.htm?' + productLineName;

            $('#labelSelector').treegrid({
                url: queryUrl,
                onDblClickRow: onLabelDoubleClicked,
            });
        }

        // 标签候选列表双击事件
        function onLabelDoubleClicked(row) {
            var productLineName = $('#productLineName').combobox('getText');
            appendToLabelSelectedList(productLineName, row['labelName'], row['name']);
        };

        // 标签已选列表双击事件
        function onLabelSelectedDoubleClicked(rowIndex, rowData) {
            $('#labelSelectedList').datagrid('deleteRow', rowIndex);
            reasignNumberOfLabelSelectedList();
        };

        // 追加标签项至已选择标签列表
        function appendToLabelSelectedList(_productLineName, _labelName, _name) {
            // 最多只能添加8条标签项
            if ($('#labelSelectedList').datagrid('getRows').length >= 8) {
                $.messager.alert('警告', '最多只能添加8项！', 'warning');
                return;
            }

            $('#labelSelectedList').datagrid('appendRow', {
                productLineName: _productLineName,
                labelName: _labelName,
                name: _name
            });
            reasignNumberOfLabelSelectedList();
        };

        // 重新分配已选择标签项的序号
        function reasignNumberOfLabelSelectedList() {
            $.each($('#labelSelectedList').datagrid('getRows'), function (rowIndex) {
                $('#labelSelectedList').datagrid('updateRow', {
                    index: rowIndex,
                    row: {
                        index: rowIndex + 1
                    }
                });
            });
        };
    </script>
    <style>
        body {
            font-size: 90%;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div style="width: 100%; padding-left: 3px;">
        分公司： <input id="productLineName" class="easyui-combobox" style="width:100px"
			            url="data/combobox_data.json"
			            valueField="Id" textField="Name">
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:80px" onclick="queryProductLine();">查询</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" style="width:80px;float:right;" onclick="$('#w').window('open');">提交</a>
    </div>
    <div style="width: 49%; float: left; margin-top: 10px;">
        <table id="labelSelector" title="选择分析标签" class="easyui-treegrid" style="width:100%;height:250px;"
			    data-options="
				    method: 'get',
				    rownumbers: true,
				    idField: 'id',
				    treeField: 'name',
			    ">
		    <thead>
			    <tr>
				    <th data-options="field:'labelName'" width="220">标签名</th>
				    <th data-options="field:'name'" width="100" align="right">名称</th>
			    </tr>
		    </thead>
	    </table>
    </div>
    <div style="width: 49%; float: right; margin-top: 10px;">
	    <table id="labelSelectedList" class="easyui-datagrid" title="已选择标签项" style="width:100%;height:250px; margin-left: 10px;"
			    data-options="singleSelect:true">
		    <thead>
			    <tr>
				    <th data-options="field:'index',width:80">序号</th>
				    <th data-options="field:'productLineName',width:100">生产线名称</th>
				    <th data-options="field:'labelName',width:80,align:'right'">标签名</th>
				    <th data-options="field:'name',width:80,align:'right'">名称</th>
			    </tr>
		    </thead>
	    </table>
    </div>

	<div id="w" class="easyui-window" title="过程数据分析" data-options="closed:true" style="width:500px;height:200px;padding:10px;">
		这里放分析图形
	</div>

    </form>
</body>
</html>
