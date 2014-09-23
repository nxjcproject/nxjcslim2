<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GroupInformation.aspx.cs" Inherits="NXJC.UI.Web.SystemData.GroupInformation" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href="/Scripts/easyui/themes/gray/easyui.css" rel="stylesheet" />
    <link href="/Scripts/easyui/themes/icon.css" rel="stylesheet" />
    <script src="/Scripts/easyui/jquery.min.js"></script>
    <script src="/Scripts/easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript">

        $(document).ready(function() {
            loadTreeGridDatas('first');
        });

        function loadTreeGridDatas(myLoadType) {
            //parent.$.messager.progress({ text: '数据加载中....' });
            $.ajax({
                type: "POST",
                url: "GroupInformation.aspx/GetTreeGridDatas",
                data:"",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    if (myLoadType == 'first') {
                        var m_MsgData = jQuery.parseJSON(msg.d);
                        InitializeGrid(m_MsgData);
                    }
                    else if (myLoadType == 'last') {
                        var m_MsgData = jQuery.parseJSON(msg.d);
                        $('#groupTreeGrid').treegrid('loadData', m_MsgData);
                    }
                }
            });
        }

        function InitializeGrid(myData) {
            $('#groupTreeGrid').treegrid({
                data: myData,
                onDblClickRow: getSelectedRow
            });
        }

        function getSelectedRow(row) {
            if (row['FactoryID'] == 0 && row['ProductLineID'] == 0) {             
                $('#companyPanel').panel('open');
                $('#factoryPanel').panel('close');
                $('#productLinePanel').panel('close');
                var companyId = "{'companyId':" + row['CompanyID'] + "}"
                loadCompanyData('first');
            }
            else if (row['ProductLineID'] == 0) {
                $('#companyPanel').panel('close');
                $('#factoryPanel').panel('open');
                $('#productLinePanel').panel('close');
                var factoryId = "{'factoryId':" + row['FactoryID'] + "}"
                loadFactoryData('first');
            }
            else {
                $('#companyPanel').panel('close');
                $('#factoryPanel').panel('close');
                $('#productLinePanel').panel('open');
                var productLineId = "{'productLineId':" + row['ProductLineID'] + "}"
                loadProductLineData('first');
            }
        }

        function loadCompanyData(myLoadType) {
            $.ajax({
                type: "POST",
                url: "GroupInformation.aspx/GetTreeGridDatas",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    if (myLoadType == 'first') {
                        var m_MsgData = jQuery.parseJSON(msg.d);
                        InitializeCompanyGrid(m_MsgData);
                    }
                    else if (myLoadType == 'last') {
                        var m_MsgData = jQuery.parseJSON(msg.d);
                        $('#dgCompany').treegrid('loadData', m_MsgData);
                    }
                }
            });
        }
        function InitializeCompanyGrid(m_MsgData) {
            //$('#dgCompany').treegrid({
            //    data: m_MsgData
            //});
        }
        
        function loadFactoryData(myLoadType) {
        }

        function loadProductLineData(myLoadType) {
        }

    </script>
    <title></title>
</head>
<body>
	<div class="easyui-layout" style="width:100%;height:380px;">
		<div data-options="region:'west',split:true" title="企业信息列表" style="width:25%;height:380px">
            <table id="groupTreeGrid" title="" class="easyui-treegrid" style="width:100%;height:350px"
			        data-options="idField: 'guid',treeField: 'Name',striped:false">
		        <thead>
			        <tr>
				        <th data-options="field:'Name'" width="250">名称</th>
			        </tr>
		        </thead>
	        </table>
		</div>
		<div data-options="region:'center',title:'企业信息',iconCls:'icon-ok',collapsible:false" style="width:75%;">
			<div id="companyPanel" class="easyui-panel" title="分公司信息" style="width:100%;height:350px;padding:10px;" data-options="closed: true">
		        <table id="dgCompany" class="easyui-datagrid" title="" style="width:100%;height:auto;" 
                    data-options="iconCls: 'icon-edit',singleSelect:true,collapsible:true,rownumbers:true,striped:true,toolbar:'#tbCompany'">
                     <thead>
			            <tr>
				            <th data-options="field:'name',width:'10%',align:'center'">名称</th>
				            <th data-options="field:'a',width:'18%',align:'center'">地址</th>
				            <th data-options="field:'d',width:'15%',align:'center'">法人代表</th>
				            <th data-options="field:'c',width:'18%',align:'center'">主要产品</th>
				            <th data-options="field:'d',width:'7%',align:'center'">投产日期</th>
				            <th data-options="field:'remark',width:'15%',align:'center'">备注</th>
			            </tr>
		            </thead>
	            </table>
                <div id="tbCompany" style="padding:5px;height:auto">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addItem()">添加</a>
	                <a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="deleteItem()">删除</a>
	                <a href="#" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="saveItem()">保存</a>
                </div>
	        </div>
            <div id="factoryPanel" class="easyui-panel" title="分厂信息" style="width:100%;height:350px;padding:10px;" data-options="closed: true">
		        <table id="dgFactory" class="easyui-datagrid" title="" style="width:100%;height:auto;" 
                     data-options="iconCls: 'icon-edit',singleSelect:true,collapsible:true,rownumbers:true,striped:true,toolbar:'#tbFactory'">
                    <thead>
			            <tr>
				            <th data-options="field:'a',width:'15%',align:'center'">名称</th>
				            <th data-options="field:'s',width:'18%',align:'center'">地址</th>
				            <th data-options="field:'ss',width:'15%',align:'center'">法人代表</th>
				            <th data-options="field:'aa',width:'20%',align:'center'">主要产品</th>
				            <th data-options="field:'f',width:'7%',align:'center'">投产日期</th>
				            <th data-options="field:'e',width:'15%',align:'center'">备注</th>
			            </tr>
		            </thead>
	            </table>
                <div id="tbFactory" style="padding:5px;height:auto">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addItem()">添加</a>
	                <a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="deleteItem()">删除</a>
	                <a href="#" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="saveItem()">保存</a>
                </div>
	        </div>
            <div id="productLinePanel" class="easyui-panel" title="生产线信息" style="width:100%;height:350px;padding:10px;" data-options="closed: true">
		        <table id="dgProductLine" class="easyui-datagrid" title="" style="width:100%;height:auto;" 
                    data-options="iconCls:'icon-edit',singleSelect:true,collapsible:true,rownumbers:true,striped:true,toolbar:'#tbProductLine'">
                    <thead>
			            <tr>
				            <th data-options="field:'q',width:'10%',align:'center'">名称</th>
				            <th data-options="field:'s',width:'10%',align:'center'">地址</th>
				            <th data-options="field:'f',width:'8%',align:'center'">类型</th>
				            <th data-options="field:'ss',width:'12%',align:'center'">主要产品</th>
				            <th data-options="field:'f',width:'8%',align:'center'">生产规模</th>
                            <th data-options="field:'f',width:'8%',align:'center'">投产日期</th>
                            <th data-options="field:'f',width:'8%',align:'center'">联系人</th>
                            <th data-options="field:'f',width:'10%',align:'center'">联系人信息</th>
				            <th data-options="field:'a',width:'15%',align:'center'">备注</th>
			            </tr>
		            </thead>
	            </table>
                <div id="tbProductLine" style="padding:5px;height:auto">
                    <a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addItem()">添加</a>
	                <a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="deleteItem()">删除</a>
	                <a href="#" class="easyui-linkbutton" iconCls="icon-save" plain="true" onclick="saveItem()">保存</a>
                </div>
	        </div>
		</div>
	</div>
</body>
</html>
