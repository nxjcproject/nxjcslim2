<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HaltCauseQuerying.aspx.cs" Inherits="NXJC.UI.Web.Temp.HaltCauseQuerying" %>

<%@ Register Src="~/Common/OrganisationTree.ascx" TagPrefix="uc1" TagName="OrganisationTree" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>停机原因查询</title>
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
        <div id="p1" class="easyui-panel" title="明细表" style="width:100%;height:45%;">
	        <table id="dg" class="easyui-datagrid" style="width:100%;height:100%"
			        data-options="rownumbers:true,singleSelect:true,url:'datagrid_data1.json',method:'get'">
		        <thead>
			        <tr>
				        <th data-options="field:'itemid',width:80">类别1</th>
                        <th data-options="field:'itemid',width:80">类别2</th>
                        <th data-options="field:'itemid',width:100">具体描述</th>
				        <th data-options="field:'listprice',width:80">日期</th>
				        <th data-options="field:'unitcost',width:80">班次</th>
                        <th data-options="field:'itemid',width:100">DCS</th>
                        <th data-options="field:'itemid',width:100">设备点号</th>
                        <th data-options="field:'itemid',width:100">设备名称</th>
                        <th data-options="field:'itemid',width:100">停机时间</th>
                        <th data-options="field:'itemid',width:100">恢复时间</th>
				        <th data-options="field:'attr1',width:300">备注</th>
			        </tr>
		        </thead>
	        </table>
        </div>
        <div id="p2" class="easyui-panel" title="分类统计表" style="width:100%;height:45%;">
	        <table id="Table1" class="easyui-datagrid" style="width:100%;height:100%"
			        data-options="rownumbers:true,singleSelect:true,url:'datagrid_data1.json',method:'get'">
		        <thead>
			        <tr>
				        <th data-options="field:'itemid',width:300">故障种类</th>
				        <th data-options="field:'productid',width:300">次数</th>
			        </tr>
		        </thead>
	        </table>
        </div>
    </div>
    </form>
</body>
</html>
