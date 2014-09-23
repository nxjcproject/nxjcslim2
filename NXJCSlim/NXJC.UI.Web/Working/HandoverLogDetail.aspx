<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HandoverLogDetail.aspx.cs" Inherits="NXJC.UI.Web.Working.HandoverLogDetail" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>交接班日志详情</title>
    <link href="/Scripts/easyui/themes/gray/easyui.css" rel="stylesheet" />
    <link href="/Scripts/EasyUI/themes/color.css" rel="stylesheet" />
    <link href="/Scripts/easyui/themes/icon.css" rel="stylesheet" />
    <script src="/Scripts/easyui/jquery.min.js"></script>
    <script src="/Scripts/easyui/jquery.easyui.min.js"></script>
    <script src="/Scripts/EasyUI/locale/easyui-lang-zh_CN.js"></script>
    <script src="/Scripts/jquery.utility.js"></script>
</head>
<body>
    <form id="form1" runat="server">
	<div id="wrapper" class="easyui-panel" style="width:98%;height:auto;padding:2px;">
	    <div id="p" class="easyui-panel" title="交接班记录" style="width:100%;height:auto;padding:10px;">
            <div style="float:left;">
                时间：
                <input id="time" class="easyui-datetimespinner" value="1111/11/11" data-options="selections:[[11,13],[14,16]]" readonly="true" style="width:180px;" />
                班次：
                <select id="shifts" class="easyui-combobox" data-options="editable: false" name="state" readonly="true" style="width:80px;">
                </select>
            </div>
            <div style="float:right;">
                当前班组：
                <input id="workingTeam" class="easyui-combobox" data-options="valueField:'ID',textField:'Name',editable:false" readonly="true" name="state" style="width:180px;" />
                负责人：
                <input id="chargeMan" class="easyui-combobox" data-options="valueField:'StaffID',textField:'Combined',method:'post',url:'WorkingService.asmx/GetStaffInfoWithComboboxFormat'" readonly="true" style="width:180px" />
            </div>
            <div style="margin-top: 40px;">
                <!--操作员DataGrid-->
	            <table id="operatorSelector" class="easyui-datagrid" title="操作员选择" style="width:100%;height:auto"
			            data-options="
				            singleSelect: true
			            ">
		            <thead>
			            <tr>
                            <th data-options="field:'WorkingSectionID',hidden:true">工段ID</th>
				            <th data-options="field:'WorkingSectionName',width:280">工段名称</th>
				            <th data-options="field:'StaffID',width:300,
						            formatter:function(value,row){
							            return row.StaffID;
						            }">操作员工号</th>
                            <th data-options="field:'StaffName',width:300,
						            formatter:function(value,row){
							            return row.StaffName;
						            }">操作员姓名</th>
			            </tr>
		            </thead>
	            </table>
            </div>
	    </div>
        <div class="easyui-panel" style="width:100%;height:auto;padding:10px;">
            <div>
                <!--停机记录DataGrid-->
	            <table id="haltLoger" class="easyui-datagrid" title="停机原因" style="width:100%;height:auto"
			            data-options="
				            singleSelect: true
			            ">
		            <thead>
			            <tr>
				            <th data-options="field:'HaltTime',width:120">停机时间</th>
                            <th data-options="field:'ReasonID',hidden:true"></th>
                            <th data-options="field:'ReasonText',hidden:true"></th>
                            <th data-options="field:'Label',width:120">设备点号</th>
                            <th data-options="field:'Machine',width:120">设备名称</th>
				            <th data-options="field:'Reason',width:300,
                                    formatter:function(value,row){
							            return row.ReasonText;
						            }">停机原因</th>
                            <th data-options="field:'Remarks',width:300">备注</th>
			            </tr>
		            </thead>
	            </table>
            </div>
            <div style="margin-top: 20px;">
                <!--dcs报警记录DataGrid-->
	            <table id="dcsWarningLoger" class="easyui-datagrid" title="DCS报警记录" style="width:100%;height:auto"
			            data-options="
				            singleSelect: true
			            ">
		            <thead>
			            <tr>
				            <th data-options="field:'WarningTime',width:120">报警时间</th>
                            <th data-options="field:'Label',width:120">报警点号</th>
				            <th data-options="field:'Message',width:120">报警原因</th>
                            <th data-options="field:'HandleInformation',width:300">处理情况</th>
                            <th data-options="field:'Remarks',width:300">备注</th>
			            </tr>
		            </thead>
	            </table>
            </div>
            <div style="margin-top: 20px;">
                <!--电耗报警记录DataGrid-->
	            <table id="pcWarningLoger" class="easyui-datagrid" title="电耗报警记录" style="width:100%;height:auto"
			            data-options="
				            singleSelect: true
			            ">
		            <thead>
			            <tr>
				            <th data-options="field:'WarningTime',width:120">报警时间</th>
                            <th data-options="field:'Label',width:120">报警点号</th>
				            <th data-options="field:'Message',width:120">报警原因</th>
                            <th data-options="field:'HandleInformation',width:300">处理情况</th>
                            <th data-options="field:'Remarks',width:300">备注</th>
			            </tr>
		            </thead>
	            </table>
            </div>
            <div style="margin-top: 20px;">
                <!--煤耗报警记录DataGrid-->
	            <table id="ccWarningLoger" class="easyui-datagrid" title="煤耗报警记录" style="width:100%;height:auto"
			            data-options="
				            singleSelect: true
			            ">
		            <thead>
			            <tr>
				            <th data-options="field:'WarningTime',width:120">报警时间</th>
                            <th data-options="field:'Label',width:120">报警点号</th>
				            <th data-options="field:'Message',width:120">报警原因</th>
                            <th data-options="field:'HandleInformation',width:300">处理情况</th>
                            <th data-options="field:'Remarks',width:300">备注</th>
			            </tr>
		            </thead>
	            </table>
            </div>
        </div>
        <div class="easyui-panel" style="width:100%;height:auto;padding:10px;">
            <table style="width:100%;">
                <tr>
                    <td style="width:80px">本班生产计划完成情况</td>
                    <td>
                        <textarea id="performToObjectives" readonly="readonly" style="width:95%;height:50px;"></textarea></td>
                    <td style="width:80px">本班出现的问题及处理情况</td>
                    <td>
                        <textarea id="problemsAndSettlements" readonly="readonly" style="width:95%;height:50px;"></textarea></td>
                </tr>
                <tr>
                    <td style="width:80px">本班设备运行情况</td>
                    <td>
                        <textarea id="equipmentSituation" readonly="readonly" style="width:95%;height:50px;"></textarea></td>
                    <td style="width:80px">下班工作重点及建议</td>
                    <td>
                        <textarea id="advicesToNextShift" readonly="readonly" style="width:95%;height:50px;"></textarea></td>
                </tr>
            </table>
        </div>
	</div>
	<script type="text/javascript">

	    var productLineId = 1;

	    $(document).ready(function () {
	        // 查询交接班日志信息
	        getHandoverLogInfo();
            // 获取工段信息
	        getWorkingSection();
            // 获取停机记录
	        getHaltLog();
            // 获取报警记录
	        getWarningLog();
	    });

        // 查询交接班日志信息
	    function getHandoverLogInfo() {
	        var queryUrl = 'WorkingService.asmx/GetHandoverLogWithSimpleGridFormat';
	        var dataToSend = '{handoverLogId: ' + $.getUrlParam("id") + '}';

	        $.ajax({
	            type: "POST",
	            url: queryUrl,
	            data: dataToSend,
	            contentType: "application/json; charset=utf-8",
	            dataType: "json",
	            success: function (msg) {
	                initializeHandoverLogInfo(jQuery.parseJSON(msg.d));
	            }
	        });
	    }

	    function initializeHandoverLogInfo(json) {
	        $('#time').timespinner('setValue', json.ShiftDate);
	        $('#shifts').combobox('setText', json.Shifts);
	        $('#workingTeam').combobox('setText', json.WorkingTeamName);
	        $('#chargeMan').combobox('setText', json.ChargeManID + "  " + json.ChargeManName);
	        $('#performToObjectives').val(json.PerformToObjectives);
	        $('#problemsAndSettlements').val(json.ProblemsAndSettlements);
	        $('#equipmentSituation').val(json.EquipmentSituation);
	        $('#advicesToNextShift').val(json.AdvicesToNextShift);
	    }

	    // 生成操作员选择grid
	    function getWorkingSection() {
	        var queryUrl = 'WorkingService.asmx/GetWorkingSectionAssignmentWithDataGridFormat';
	        var dataToSend = '{handoverLogId: ' + $.getUrlParam("id") + '}';

	        $.ajax({
	            type: "POST",
	            url: queryUrl,
	            data: dataToSend,
	            contentType: "application/json; charset=utf-8",
	            dataType: "json",
	            success: function (msg) {
	                initializeStaffSelector(jQuery.parseJSON(msg.d));
	            }
	        });
	    }

	    function initializeStaffSelector(json) {
	        $('#operatorSelector').datagrid({
	            data: json
	        });
	    }
	    // 停机原因选择
	    function getHaltLog() {
	        var productLineId = 1;
	        var queryUrl = 'WorkingService.asmx/GetMachineHaltLogWithDataGridFormat';
	        var dataToSend = '{productLineId: ' + productLineId + '}';

	        $.ajax({
	            type: "POST",
	            url: queryUrl,
	            data: dataToSend,
	            contentType: "application/json; charset=utf-8",
	            dataType: "json",
	            success: function (msg) {
	                initializeHaltLoger(jQuery.parseJSON(msg.d));
	            }
	        });
	    }

	    function initializeHaltLoger(json) {
	        $('#haltLoger').datagrid({
	            data: json
	        });
	    }
	    // 生成报警信息grid
	    function getWarningLog() {
	        var productLineId = 1;
	        var queryUrl = 'WorkingService.asmx/GetDCSWarningLogWithDataGridFormat';
	        var dataToSend = '{productLineId: ' + productLineId + '}';

	        $.ajax({
	            type: "POST",
	            url: queryUrl,
	            data: dataToSend,
	            contentType: "application/json; charset=utf-8",
	            dataType: "json",
	            success: function (msg) {
	                initializeWarningLoger(jQuery.parseJSON(msg.d));
	            }
	        });
	    }

	    function initializeWarningLoger(json) {
	        $('#dcsWarningLoger').datagrid({
	            data: json
	        });
	    }
        </script>
    </form>
</body>
</html>
