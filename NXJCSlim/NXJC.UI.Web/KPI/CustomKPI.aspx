<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CustomKPI.aspx.cs" Inherits="NXJC.UI.Web.KPI.CustomKPI" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>自定义对标</title>
    <link href="/Scripts/easyui/themes/gray/easyui.css" rel="stylesheet" />
    <link href="/Scripts/easyui/themes/icon.css" rel="stylesheet" />
    <script src="/Scripts/easyui/jquery.min.js"></script>
    <script src="/Scripts/easyui/jquery.easyui.min.js"></script>
    <script src="/Scripts/EasyUI/locale/easyui-lang-zh_CN.js"></script>
    <style>
        body {
            font-size: 80%;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        起止时间：
        <input class="easyui-datetimebox" id="startTime" name="startTime" 
            data-options="required:true,showSeconds:false" value="3/4/2010 2:3" style="width:150px" />
        -
        <input class="easyui-datetimebox" id="endTime" name="endTime" 
            data-options="required:true,showSeconds:false" value="3/4/2010 2:3" style="width:150px" />

        指标：
	    <select class="easyui-combobox" name="state" data-options="editable: false" style="width:200px;">
		    <option value="AL">熟料综合电耗（kwh/t）</option>
		    <option value="AK">可比熟料综合电耗（kwh/t）</option>
		    <option value="AZ">熟料综合煤耗（kgce/t）</option>
		    <option value="AR">可比熟料综合煤耗（kgce/t）</option>
		    <option value="CA">熟料综合能耗（kgce/t）</option>
		    <option value="CO">可比熟料综合能耗（kgce/t）</option>
		    <option value="CT">水泥综合电耗（kwh/t）</option>
		    <option value="DE">可比水泥综合电耗（kwh/t）</option>
		    <option value="FL">生料制备工段电耗（kwh/t）</option>
		    <option value="GA">孰料制备工段电耗（kwh/t）</option>
		    <option value="HI">孰料制备工段煤耗（kgce/t）</option>
		    <option value="ID">水泥制备工段电耗（kwh/t）</option>
	    </select>


    </div>
    </form>
</body>
</html>
