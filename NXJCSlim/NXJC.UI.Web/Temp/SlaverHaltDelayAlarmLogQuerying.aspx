<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SlaverHaltDelayAlarmLogQuerying.aspx.cs" Inherits="NXJC.UI.Web.Temp.SlaverHaltDelayAlarmLogQuerying" %>

<%@ Register Src="~/Common/OrganisationTree.ascx" TagPrefix="uc1" TagName="OrganisationTree" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>主从设备拖延停机报警查询</title>
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
        <div id="ptool" class="easyui-panel" title="查询" style="width:100%;height:65px;padding:5px;">
		    <div>
			    请选择班组: 
			    <select class="easyui-combobox" panelHeight="auto" style="width:100px">
				    <option value="all">全部</option>
				    <option value="a">A组</option>
				    <option value="b">B组</option>
				    <option value="c">C组</option>
				    <option value="d">D组</option>
			    </select>
			    时间: <input class="easyui-datebox" style="width:120px" />
			    至 <input class="easyui-datebox" style="width:120px" />
			    <a href="#" class="easyui-linkbutton" iconCls="icon-search">查询</a>
		    </div>
        </div>
        <div id="p1" class="easyui-panel" title="明细表" style="width:100%;height:90%;">
	        <table id="dg" class="easyui-datagrid" style="width:100%;height:100%"
			        data-options="rownumbers:true,singleSelect:true,url:'datagrid_data1.json',method:'get'">
		        <thead>
			        <tr>
				        <th data-options="field:'itemid',width:100">日期</th>
				        <th data-options="field:'listprice',width:100">班次</th>
				        <th data-options="field:'unitcost',width:150">报警产生时间</th>
				        <th data-options="field:'attr1',width:100">设备点号</th>
                        <th data-options="field:'attr1',width:150">设备名称</th>
                        <th data-options="field:'attr1',width:150">主机停机时间</th>
                        <th data-options="field:'attr1',width:150">从机停机情况</th>
                        <th data-options="field:'attr1',width:250">情况说明</th>
			        </tr>
		        </thead>
	        </table>
        </div>
    </div>
    </form>
</body>
</html>
