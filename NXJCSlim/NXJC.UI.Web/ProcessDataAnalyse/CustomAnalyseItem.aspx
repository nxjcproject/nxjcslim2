<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CustomAnalyseItem.aspx.cs" Inherits="NXJC.UI.Web.ProcessDataAnalyse.CustomAnalyseItem" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>自定义过程数据分析项</title>
    <link href="/Scripts/easyui/themes/gray/easyui.css" rel="stylesheet" />
    <link href="/Scripts/easyui/themes/icon.css" rel="stylesheet" />
    <script src="/Scripts/easyui/jquery.min.js"></script>
    <script src="/Scripts/easyui/jquery.easyui.min.js"></script>
    <script src="/Scripts/EasyUI/locale/easyui-lang-zh_CN.js"></script>

    <%--<link rel="stylesheet" type="text/css" href="/Scripts/ealib/themes/gray/easyui.css"/>
	<link rel="stylesheet" type="text/css" href="/Scripts/ealib/themes/icon.css"/>--%>
    <link rel="stylesheet" type="text/css" href="/Scripts/extlib/themes/syExtIcon.css"/>

    <link rel="stylesheet" type="text/css" href="/Scripts/pllib/themes/jquery.jqplot.min.css" />
    <link type="text/css" rel="stylesheet" href="/Scripts/pllib/syntaxhighlighter/styles/shCoreDefault.min.css" />
    <link type="text/css" rel="stylesheet" href="/Scripts/pllib/syntaxhighlighter/styles/shThemejqPlot.min.css" />
    <link type="text/css" rel="stylesheet" href="/Content/charts.css" />

	<%--<script type="text/javascript" src="/Scripts/ealib/jquery-1.8.3.min.js" charset="utf-8"></script>
	<script type="text/javascript" src="/Scripts/ealib/jquery.easyui.min.js" charset="utf-8"></script>
    <script type="text/javascript" src="/Scripts/ealib/easyui-lang-zh_CN.js" charset="utf-8"></script>--%>

    <script type="text/javascript" src="/Scripts/pllib/jquery.jqplot.min.js"></script>
    <script type="text/javascript" src="/Scripts/pllib/syntaxhighlighter/scripts/shCore.min.js"></script>
    <script type="text/javascript" src="/Scripts/pllib/syntaxhighlighter/scripts/shBrushJScript.min.js"></script>
    <script type="text/javascript" src="/Scripts/pllib/syntaxhighlighter/scripts/shBrushXml.min.js"></script>
        
    <!-- Additional plugins go here -->
    <script type="text/javascript" src="/Scripts/pllib/plugins/jqplot.barRenderer.min.js"></script>
    <script type="text/javascript" src="/Scripts/pllib/plugins/jqplot.pieRenderer.min.js"></script>
    <script type="text/javascript" src="/Scripts/pllib/plugins/jqplot.categoryAxisRenderer.min.js"></script>
    <script type="text/javascript" src="/Scripts/pllib/plugins/jqplot.pointLabels.min.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $('#productLineName').combobox({
                onSelect: queryProductLine
            });

            $('#labelSelectedList').datagrid({
                onDblClickRow: onLabelSelectedDoubleClicked
            });
        });

        function queryProductLine() {
            var productLineId = $('#productLineName').combobox('getValue');
            var queryUrl = 'CustomAnalyseItem.asmx/GetLabelsWithTreeGridFormat';
            var dataToSend = '{productLineId: '+ productLineId +'}';

            $.ajax({
                type: "POST",
                url: queryUrl,
                data: dataToSend,
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    initializeLabelSelector(jQuery.parseJSON(msg.d));
                }
            });
        }

        function initializeLabelSelector(jsonData) {
            $('#labelSelector').treegrid({
                data: jsonData,
                dataType: "json",
                onDblClickRow: onLabelDoubleClicked
            });
        };

        // 标签候选列表双击事件
        function onLabelDoubleClicked(row) {
            var productLineId = $('#productLineName').combobox('getValue');
            var productLineName = $('#productLineName').combobox('getText');
            appendToLabelSelectedList(productLineId, productLineName, row['VariableName'], row['VariableDescription']);
        };

        // 标签已选列表双击事件
        function onLabelSelectedDoubleClicked(rowIndex, rowData) {
            $('#labelSelectedList').datagrid('deleteRow', rowIndex);
        };

        // 追加标签项至已选择标签列表
        function appendToLabelSelectedList(_productLineId, _productLineName, _variableName, _variableDescription) {
            if (_variableName == null || _variableDescription == null)
                return;

            // 最多只能添加8条标签项
            if ($('#labelSelectedList').datagrid('getRows').length >= 8) {
                $.messager.alert('警告', '最多只能添加8项！', 'warning');
                return;
            }

            $('#labelSelectedList').datagrid('appendRow', {
                ProductLineId: _productLineId,
                ProductLineName: _productLineName,
                VariableName: _variableName,
                VariableDescription: _variableDescription
            });
        };
    </script>
    <script type="text/javascript">

        var myLoadType = 'first';
        var ChartJqplot;
        function submit() {

            $('#w').window('open');

            var rows = $('#labelSelectedList').datagrid('getRows');
            var data2service = {
                selectedLines: []
            };
            for (var i = 0; i < rows.length; i++) {
                data2service.selectedLines.push(rows[i]);
            }

            $.ajax({
                type: "POST",
                url: "CustomAnalyseItem.asmx/GetCharDatas",
                data: "{myJsonData:'" + JSON.stringify(data2service) + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    var MsgData = jQuery.parseJSON(msg.d);

                    if (myLoadType == 'first') {
                        myLoadType = 'last';
                        CreatChart(MsgData);
                        InitializeChartGrid(MsgData);

                    }
                    else if (myLoadType == 'last') {
                        ReleasePlotChart("chart9", ChartJqplot);
                        CreatChart(MsgData);
                        $('#grid_ChartMain').datagrid('loadData', MsgData);
                    }
                }
            });

        }
        function ReleasePlotChart(containerId, plot) {
            if (plot) {
                plot.destroy();

                var elementId = '#' + containerId;
                $(elementId).unbind(); // for iexplorer  
                $(elementId).empty();

                plot = null;
            }
        }
        function CreatChart(msg) {
            //var line1 = [6.5, 9.2, 14, 19.65, 26.4, 35, 51];
            //var line2 = [3.5, 3.2, 12, 13.65, 41.4, 21, 51]
            var m_ColumnName = "";
            var m_Rows = msg['rows'];
            var m_Labels = new Array();
            var m_AxisX = new Array();
            ////////////////////////////////获得颜色标签名
            for (var i = 0; i < m_Rows.length; i++) {
                var m_LabelItem = { label: m_Rows[i][msg['columns'][0]['field']] };
                m_Labels.push(m_LabelItem);
            }
            /////////////////////////////获得x轴坐标名称//////////////////////
            for (var i = 1; i < msg['columns'].length; i++) {
                var m_AxisItem = [i, msg['columns'][i]['title']];
                m_AxisX.push(m_AxisItem);
            }
            var m_Lines = new Array();
            for (var i = 0; i < m_Rows.length; i++) {
                var m_LineTemp = new Array();
                for (var j = 1; j < msg['columns'].length; j++) {
                    m_ColumnName = msg['columns'][j]['field'];
                    for (var m_Name in m_Rows[i]) {
                        if (m_ColumnName == m_Name) {
                            m_LineTemp.push(m_Rows[i][m_Name]);
                        }
                    }
                }
                m_Lines.push(m_LineTemp);
            }
            ChartJqplot = $.jqplot('chart9', m_Lines, {
                series: m_Labels,
                legend: {
                    show: true,
                    fontSize: '3pt',
                    show: true,
                    location: 'e',
                    placement: 'outside'
                },
                axes: {
                    xaxis: {
                        tickRenderer: $.jqplot.CanvasAxisTickRenderer,
                        //ticks: [['1', '一月份'], ['2', '二月份'], ['3', '三月份'], ['4', '四月份'], ['5', '五月份'], ['6', '六月份'], ['7', '七月份']],
                        ticks: m_AxisX,
                        label: msg['Units']['UnitX'],
                        labelOptions: {
                            fontFamily: 'Helvetica',
                            fontSize: '8pt'
                        },
                        labelRenderer: $.jqplot.CanvasAxisLabelRenderer
                    },
                    yaxis: {
                        renderer: $.jqplot.LogAxisRenderer,

                        tickRenderer: $.jqplot.CanvasAxisTickRenderer,
                        labelRenderer: $.jqplot.CanvasAxisLabelRenderer,
                        labelOptions: {
                            fontFamily: 'Helvetica',
                            fontSize: '8pt'
                        },
                        tickInterval: msg['Units']['MaxY'] / 10,
                        min: 0,
                        max: msg['Units']['MaxY'],
                        pad: 0,
                        label: msg['Units']['UnitY']
                    }
                }
            });
        }

        function InitializeChartGrid(myData) {

            var m_IdAndNameColumn = myData['columns'].splice(0, 1);
            var m_IdColumn = m_IdAndNameColumn[0].field;

            $('#grid_ChartMain').datagrid({
                title: '',
                data: myData,
                dataType: "json",
                striped: true,
                idField: m_IdColumn,
                frozenColumns: [[m_IdAndNameColumn[0]]],
                columns: [myData['columns']],
                //loadMsg: '',   //设置本身的提示消息为空 则就不会提示了的。这个设置很关键的
                rownumbers: true,
                //pagination: true,
                singleSelect: true
                //onClickCell: onClickCell
                //idField: m_IdAndNameColumn[0].field,
                //pageSize: 20,
                //pageList: [20, 50, 100, 500],

                //toolbar: '#toolbar'
            });
        }

    </script>
    <script type="text/javascript">

        var myDIYModelLoadType;

        function showModelDatagrid() {
            var modelType = document.getElementById("model").style.display;
            if (modelType == 'none') {
                //document.getElementById("model").style.display = "";
                loadModelDatagrid('first');
                $("#model").css('display', '');
            }
            else {
                //document.getElementById("model").style.display = 'none';
                $("#model").css('display', 'none');
            }
        }

        function loadModelDatagrid(myDIYModelLoadType) {
            //parent.$.messager.progress({ text: '数据加载中....' });
            $.ajax({
                type: "POST",
                url: "CustomAnalyseItem.asmx/GetModelDatas",
                data: "{builderId: '1'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                    if (myDIYModelLoadType == 'first') {
                        m_MsgData = jQuery.parseJSON(msg.d);
                        myDIYModelLoadType = 'last';
                        InitializeModeDatagrid(m_MsgData);
                    }
                    else if (myDIYModelLoadType == 'last') {
                        m_MsgData = jQuery.parseJSON(msg.d);
                        $('#modelDatagrid').datagrid('loadData', m_MsgData);
                    }
                }
            });
        }
        function InitializeModeDatagrid(myData) {
            $('#modelDatagrid').datagrid({
                data: myData,
                iconCls: 'icon-edit', singleSelect: true, rownumbers: true, striped: true,
                columns: [[
                    { field: 'Name', title: '名称', width: '10%', align: 'center' },
                    { field: 'Date', title: '创建日期', width: '20%', align: 'center'},
                    { field: 'Builder', title: '创建人', width: '20%', align: 'center' },
                    { field: 'Description', title: '模板描述', width: '20%', align: 'center' },
                    {
                        field: 'IsPrivate', title: '是否私有', width: '15%', align: 'center',
                        formatter: function (value) {
                            if (value == true || value == "True")
                                return "是";
                            else if (value == false || value == "False")
                                return "否";
                            else
                                return "";
                        },
                        editor: { type: 'checkbox', options: { on: true, off: false } }
                    },
                    {
                        field: 'action', title: '操作', width: '14%', align: 'center',
                        formatter: function (value, row, index) {
                            var s = '<a href="#" onclick="loadModel(' + row['ID'] + ')">载入模板</a> ';
                            return s;
                        }
                    }
                ]]
            });
        };

        function loadModel(rowId) {
            //parent.$.messager.progress({ text: '数据加载中....' });
            $.ajax({
                type: "POST",
                url: "CustomAnalyseItem.asmx/GetModelDatasByModelID",
                data: "{DIYAnalyseModelID: '" + rowId + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (msg) {
                        m_MsgData = jQuery.parseJSON(msg.d);
                        InitializelabelSelectedList(m_MsgData);
                }
            });
        }
        function InitializelabelSelectedList(myData) {
            $('#labelSelectedList').datagrid('loadData', myData);
        }

        function DIYModel() {
            $('#dlg').dialog('open');
        }

    </script>
    <style>
        body {
            font-size: 80%;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div style="width: 100%; padding-left: 3px; margin-bottom: 10px;">
        生产线： <input id="productLineName" class="easyui-combobox"
                        data-options="valueField:'ID',textField:'Name', editable: false,
                                      url:'CustomAnalyseItem.asmx/GetProductLinesWithComboboxFormat'" />
        <a href="javascript:void(0)" class="easyui-linkbutton" style="width:100px;" onclick="showModelDatagrid()">选择自定义模板</a>
        <!--<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:80px" onclick="queryProductLine();">查询</a>-->
        <a href="javascript:void(0)" class="easyui-linkbutton" style="width:80px;" onclick="DIYModel()">自定义模板</a>
        <a href="javascript:void(0)" class="easyui-linkbutton" style="width:80px;float:right;" onclick="submit()">提交</a>  <%--$('#w').window('open');--%>
    </div>
    <div id="model" style="width:100%;display:none">
        <table id="modelDatagrid" class="easyui-datagrid" title="自定义模板" style="width:100%;height:260px; margin-left: 10px;" >
	    </table>
    </div>
    <div style="width: 49%; float: left;">
        <table id="labelSelector" title="选择分析标签" class="easyui-treegrid" style="width:100%;height:260px;"
			    data-options="method: 'post', rownumbers: true, idField: 'guid', treeField: 'VariableName'">
		    <thead>
			    <tr>
				    <th data-options="field:'VariableName', width:220">变量名</th>
				    <th data-options="field:'VariableDescription', width:220">标签名</th>
			    </tr>
		    </thead>
	    </table>
    </div>
    <div style="width: 49%; float: right;">
	    <table id="labelSelectedList" class="easyui-datagrid" title="已选择标签项" style="width:100%;height:260px; margin-left: 10px;"
			    data-options="singleSelect:true,rownumbers: true">
		    <thead>
			    <tr>
                    <th data-options="field:'ProductLineID',hidden:true"></th>
				    <th data-options="field:'ProductLineName',width:100">生产线名称</th>
				    <th data-options="field:'VariableName',width:150">变量名</th>
				    <th data-options="field:'VariableDescription',width:150">变量描述</th>
			    </tr>
		    </thead>
	    </table>
    </div>

	<div id="w" class="easyui-window" title="过程数据分析" data-options="closed:true" style="width:900px;height:500px;padding:10px;">
		<div class="easyui-panel" data-options="region:'north',border:true, collapsible:false, split:false" style="height:45%;">
		    <table id="grid_ChartMain" data-options="fit:true,border:false"></table>
	    </div>
        <div id = "chart9" class="easyui-panel" data-options="region:'center',border:false" style="margin-left:20px;padding-right:100px;">

	    </div>
    </div>
    <div id="dlg" class="easyui-dialog" title="创建人信息" style="width:400px;height:200px;padding:10px"
		data-options="
			iconCls: 'icon-save',
            closed:true,
			buttons: [{
				text:'保存',
				iconCls:'icon-ok',
				handler:function(){
					alert('ok');
				}
			},{
				text:'取消',
				handler:function(){
					alert('cancel');
				}
			}]
		">
	    <table>
            <tr>
                <td>模板名称：</td>
                <td><input id="modelName" type="text" /></td>
            </tr>
            <tr>
                <td>模板描述：</td>
                <td><textarea id="builderName"></textarea></td>
            </tr>
            <tr>
                <td>是否私有：</td>
                <td><input id="isPrivate" type="checkbox" value="true" /></td>
            </tr>
	    </table>
    </div>

    </form>
</body>
</html>
