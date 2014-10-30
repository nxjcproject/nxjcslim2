<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShiftsQuering.aspx.cs" Inherits="NXJC.UI.Web.Temp.ShiftsQuering" %>

<%@ Register Src="~/Common/OrganisationTree.ascx" TagPrefix="uc1" TagName="OrganisationTree" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>值班情况查询</title>
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
        <div id="p1" class="easyui-panel" title="值班情况查询" style="width:100%;height:100%;">
	        <table id="dg" class="easyui-datagrid" style="width:100%;height:100%"
			        data-options="rownumbers:true,singleSelect:true,url:'datagrid_data1.json',method:'get',toolbar:'#tb'">
		        <thead>
			        <tr>
				        <th data-options="field:'itemid',width:150">日期</th>
				        <th data-options="field:'listprice',width:150,align:'center'">甲班</th>
				        <th data-options="field:'unitcost',width:150,align:'center'">乙班</th>
				        <th data-options="field:'attr1',width:150,align:'center'">丙班</th>
			        </tr>
		        </thead>
	        </table>
	        <div id="tb" style="padding:5px;height:auto">
		        <div>
			        请选择班组: 
			        <select class="easyui-combobox" panelHeight="auto" style="width:100px">
				        <option value="java">全部</option>
				        <option value="c">A组</option>
				        <option value="basic">B组</option>
				        <option value="perl">C组</option>
				        <option value="python">D组</option>
			        </select>
			        时间: <input class="easyui-datebox" style="width:120px" />
			        至 <input class="easyui-datebox" style="width:120px" />
			        <a href="#" class="easyui-linkbutton" iconCls="icon-search">查询</a>
		        </div>
	        </div>
        </div>
    </div>
    </form>
</body>
</html>
