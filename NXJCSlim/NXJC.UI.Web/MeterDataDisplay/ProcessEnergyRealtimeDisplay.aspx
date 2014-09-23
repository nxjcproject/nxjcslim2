<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProcessEnergyRealtimeDisplay.aspx.cs" Inherits="NXJC.UI.Web.MeterDataDisplay.ProcessEnergyRealtimeDisplay" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="/Scripts/easyui/themes/gray/easyui.css" rel="stylesheet" />
    <link href="/Scripts/easyui/themes/icon.css" rel="stylesheet" />
    <script src="/Scripts/easyui/jquery.min.js"></script>
    <script src="/Scripts/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#companyName').combobox({
                url: 'ProcessEnergyRealtimeDisplay.asmx/GetFactoryNameForCombobox',
                method: 'get',
                onSelect: companyNameSelected
            });
        });

        function companyNameSelected(record) {
            var factoryId = record['ID'];
            $('#electricRoom').combobox({
                url: 'ProcessEnergyRealtimeDisplay.asmx/GetElectricalRoomForCombobox?id=' + factoryId,
                method: 'get'
            });
        };

        function queryProductLine() {
            //alert('test');
            var electricRoomId = $('#electricRoom').combobox('getValue');
            alert(electricRoomId);
        };
    </script>
    <style type="text/css">
        body {
            font-size: 80%;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div style="padding-left: 3px;">
        分公司： <input id="companyName" class="easyui-combobox"
			                data-options="valueField:'ID',textField:'Name'" />
        电气室： <input id="electricRoom" class="easyui-combobox"
			                data-options="valueField:'ID',textField:'Name'" />
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:80px" onclick="queryProductLine();">查询</a>
    </div>
    <div style="margin-top: 10px;">
	    <table class="easyui-datagrid" title="电表实时数据" style="width:700px;height:250px"
			    data-options="singleSelect:true,url:'datagrid_data1.json',method:'get'">
		    <thead>
			    <tr>
				    <th data-options="field:'itemid',width:80">序号</th>
				    <th data-options="field:'productid',width:100">编号</th>
				    <th data-options="field:'listprice',width:80,align:'right'">待定</th>
				    <th data-options="field:'unitcost',width:80,align:'right'">设备位置</th>
				    <th data-options="field:'attr1',width:250">名称</th>
				    <th data-options="field:'status',width:60,align:'center'">功率值</th>
                    <th data-options="field:'status',width:60,align:'center'">电能值</th>
			    </tr>
		    </thead>
	    </table>
    </div>
    </form>
</body>
</html>
