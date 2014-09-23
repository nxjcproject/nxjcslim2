<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DCSAlarm.aspx.cs" Inherits="NXJC.UI.Web.AlarmLog.DCSAlarm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href="/Scripts/EasyUI/themes/gray/easyui.css" rel="stylesheet" />
    <link href="/Scripts/EasyUI/themes/icon.css" rel="stylesheet" />
    <script src="/Scripts/EasyUI/jquery.min.js"></script>
    <script src="/Scripts/EasyUI/jquery.easyui.min.js"></script>
    <title>DCS报警记录查询</title>
</head>
<body>
    <div style="width:100%;">
        <%--<table id="dg" class="easyui-datagrid" title="" style="width:100%;height:auto">
	    </table>--%>
        <table id="dg" class="easyui-datagrid" title="DCS报警记录" style="width:100%;height:450px"
			data-options="singleSelect:true,collapsible:true,rownumbers: true ,toolbar: '#tb'">
		    <thead>
			    <tr>
				    <th data-options="field:'WarningTime',width:'20%',align:'center'">报警时间</th>
				    <th data-options="field:'Label',width:'17%',align:'center'">报警位置</th>
				    <th data-options="field:'EndingTime',width:'20%',align:'center'">结束时间</th>
				    <th data-options="field:'Message',width:'20%',align:'center'">报警原因</th>
				    <th data-options="field:'HandleInformation',width:'20%',align:'center'">处理方式</th>
			    </tr>
		    </thead>
	    </table>
    </div>
    <div id="tb">
        生产线：<input id="productLineComobox" class="easyui-combobox" 
            data-options="
                valueField: 'ID',
                textField: 'Name'
            "/>
        <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="checkProduct()">查询</a>
    </div>

    <script type="text/javascript">

        $(document).ready(function () {
            loadProductLine();
        })
        var myProductLineData;

        function loadProductLine() {
            //parent.$.messager.progress({ text: '数据加载中....' });
            $.ajax({
                type: "POST",
                //async: false,
                url: "DCSAlarm.asmx/GetProductLineData",
                data: "",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    myProductLineData = jQuery.parseJSON(msg.d);
                    InitializeProductLineComobox(myProductLineData);
                }
            });
        }

        function InitializeProductLineComobox(myData) {
            $('#productLineComobox').combobox({
                data: myData,
                //onSelect: selectProductCombobox
            });
        }

        function checkProduct() {
            loadGridData('first');
        }

        function loadGridData(myLoadType) {

            //parent.$.messager.progress({ text: '数据加载中....' });
            $.ajax({
                type: "POST",
                url: "DCSAlarm.asmx/GetDCSWarningLogData",
                data: "",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
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
                data: myData
            });
        }

    </script>
</body>
</html>
