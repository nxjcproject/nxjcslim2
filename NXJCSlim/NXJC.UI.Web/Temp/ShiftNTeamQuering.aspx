<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShiftNTeamQuering.aspx.cs" Inherits="NXJC.UI.Web.Temp.ShiftNTeamQuering" %>

<%@ Register Src="~/Common/OrganisationTree.ascx" TagPrefix="uc1" TagName="OrganisationTree" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>班次和班组设置</title>
    <link href="/Scripts/easyui/themes/gray/easyui.css" rel="stylesheet" />
    <link href="/Scripts/EasyUI/themes/color.css" rel="stylesheet" />
    <link href="/Scripts/easyui/themes/icon.css" rel="stylesheet" />
    <script src="/Scripts/easyui/jquery.min.js"></script>
    <script src="/Scripts/easyui/jquery.easyui.min.js"></script>
    <script src="/Scripts/EasyUI/locale/easyui-lang-zh_CN.js"></script>
</head>
<body class="easyui-layout">
    <form id="form1" runat="server">
	<div data-options="region:'west',split:true,title:'生产机构'" style="width:20%;padding:10px;">
        <uc1:OrganisationTree runat="server" ID="OrganisationTree" />
	</div>
    <div data-options="region:'center',title:''" style="padding:2px;">
        <div id="p1" class="easyui-panel" title="班次时间设置" style="width:100%;height:50%;">
	        <table id="dg" class="easyui-datagrid" style="width:100%;height:90%"
			        data-options="rownumbers:true,singleSelect:true,url:'datagrid_data1.json',method:'get'">
		        <thead>
			        <tr>
				        <th data-options="field:'ck',checkbox:true"></th>
				        <th data-options="field:'itemid',width:100">班次</th>
				        <th data-options="field:'listprice',width:150,align:'center'">起始时间</th>
				        <th data-options="field:'unitcost',width:150,align:'center'">终止时间</th>
				        <th data-options="field:'attr1',width:300">备注</th>
			        </tr>
		        </thead>
	        </table>
            <span>注：选择班次只能从“甲班”开始顺序进行，不能隔行。</span>
        </div>
        <div id="p2" class="easyui-panel" title="班组设置" style="width:100%;height:50%;">
	        <table id="Table1" class="easyui-datagrid" style="width:100%;height:90%"
			        data-options="rownumbers:true,singleSelect:true,url:'datagrid_data1.json',method:'get'">
		        <thead>
			        <tr>
				        <th data-options="field:'ck',checkbox:true"></th>
				        <th data-options="field:'itemid',width:100">班组</th>
				        <th data-options="field:'productid',width:300">负责人</th>
				        <th data-options="field:'attr1',width:300">备注</th>
			        </tr>
		        </thead>
	        </table>
            <span>注：选择班组只能从“A班”开始顺序进行，不能隔行。</span>
        </div>
    </div>
    </form>
</body>
</html>
