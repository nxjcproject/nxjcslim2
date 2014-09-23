<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HandoverLoger.aspx.cs" Inherits="NXJC.UI.Web.Working.HandoverLoger" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>交接班记录</title>
    <link href="/Scripts/easyui/themes/gray/easyui.css" rel="stylesheet" />
    <link href="/Scripts/EasyUI/themes/color.css" rel="stylesheet" />
    <link href="/Scripts/easyui/themes/icon.css" rel="stylesheet" />
    <script src="/Scripts/easyui/jquery.min.js"></script>
    <script src="/Scripts/easyui/jquery.easyui.min.js"></script>
    <script src="/Scripts/EasyUI/locale/easyui-lang-zh_CN.js"></script>
</head>
<body>
    <form id="form1" runat="server">
	<div id="wrapper" class="easyui-panel" style="width:98%;height:auto;padding:2px;">
        <div class="easyui-panel" style="padding:5px;width:100%;">
            <a href="javascript:void(0)" class="easyui-linkbutton easyui-tooltip tooltip-f" data-options="plain:true,iconCls:'icon-ok'" title="提交后不可修改，请谨慎操作。" onclick="submit()">提交</a>
        </div>
	    <div id="p" class="easyui-panel" title="交接班记录" style="width:100%;height:auto;padding:10px;">
            <div style="float:left;">
                时间：
                <input id="time" class="easyui-datetimespinner" value="1111/11/11"  data-options="selections:[[11,13],[14,16]]" style="width:180px;" />
                班次：
                <select id="shifts" class="easyui-combobox" data-options="editable: false" name="state" style="width:80px;">
		            <option value="A">甲班</option>
		            <option value="B">乙班</option>
		            <option value="C">丙班</option>
                </select>
            </div>
            <div style="float:right;">
                当前班组：
                <input id="workingTeam" class="easyui-combobox" data-options="valueField:'ID',textField:'Name',editable:false" name="state" style="width:180px;" />
                负责人：
                <input id="chargeMan" class="easyui-combobox" data-options="valueField:'StaffID',textField:'Combined',method:'post',url:'WorkingService.asmx/GetStaffInfoWithComboboxFormat'" style="width:180px" />
            </div>
            <div style="margin-top: 40px;">
                <!--操作员DataGrid-->
	            <table id="operatorSelector" class="easyui-datagrid" title="操作员选择" style="width:100%;height:auto"
			            data-options="
				            iconCls: 'icon-edit',
				            singleSelect: true,
				            onClickRow: osOnClickRow,
                            toolbar: '#tbOperatorSelector'
			            ">
		            <thead>
			            <tr>
                            <th data-options="field:'WorkingSectionID',hidden:true">工段ID</th>
				            <th data-options="field:'WorkingSectionName',width:280">工段名称</th>
				            <th data-options="field:'StaffID',width:300,
						            formatter:function(value,row){
							            return row.StaffID;
						            },
						            editor:{
							            type:'combobox',
							            options:{
								            valueField:'StaffID',
								            textField:'Combined',
								            method:'post',
								            url:'WorkingService.asmx/GetStaffInfoWithComboboxFormat'
							            }
						            }">操作员工号</th>
                            <th data-options="field:'StaffName',width:300,
						            formatter:function(value,row){
							            return row.StaffName;
						            }">操作员姓名</th>
			            </tr>
		            </thead>
	            </table>
	            <div id="tbOperatorSelector" style="height:auto">
		            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="osAccept()">应用</a>
		            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true" onclick="osReject()">取消</a>
	            </div>
            </div>
	    </div>
        <div class="easyui-panel" style="width:100%;height:auto;padding:10px;">
            <div>
                <!--停机记录DataGrid-->
	            <table id="haltLoger" class="easyui-datagrid" title="停机原因" style="width:100%;height:auto"
			            data-options="
				            iconCls: 'icon-edit',
				            singleSelect: true,
				            onClickRow: hlOnClickRow,
                            toolbar: '#tbHaltLoger'
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
						            },
						            editor:{
							            type:'combobox',
							            options:{
								            valueField:'ID',
								            textField:'Name',
								            method:'post',
								            url:'WorkingService.asmx/GetMachineHaltReasonWithComboboxFormat'
							            }
						            }">停机原因</th>
                            <th data-options="field:'Remarks',width:300,editor:{type:'textbox'}">备注</th>
			            </tr>
		            </thead>
	            </table>
	            <div id="tbHaltLoger" style="height:auto">
		            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="hlAccept()">应用</a>
		            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true" onclick="hlReject()">取消</a>
	            </div>
            </div>
            <div style="margin-top: 20px;">
                <!--dcs报警记录DataGrid-->
	            <table id="dcsWarningLoger" class="easyui-datagrid" title="DCS报警记录" style="width:100%;height:auto"
			            data-options="
				            iconCls: 'icon-edit',
				            singleSelect: true,
				            onClickRow: dcswlOnClickRow,
                            toolbar: '#tbdcsWarningLoger'
			            ">
		            <thead>
			            <tr>
				            <th data-options="field:'WarningTime',width:120">报警时间</th>
                            <th data-options="field:'Label',width:120">报警点号</th>
				            <th data-options="field:'Message',width:120">报警原因</th>
                            <th data-options="field:'HandleInformation',width:300,editor:{type:'textbox'}">处理情况</th>
                            <th data-options="field:'Remarks',width:300,editor:{type:'textbox'}">备注</th>
			            </tr>
		            </thead>
	            </table>
	            <div id="tbdcsWarningLoger" style="height:auto">
		            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="dcswlAccept()">应用</a>
		            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true" onclick="dcswlReject()">取消</a>
	            </div>
            </div>
            <div style="margin-top: 20px;">
                <!--电耗报警记录DataGrid-->
	            <table id="pcWarningLoger" class="easyui-datagrid" title="电耗报警记录" style="width:100%;height:auto"
			            data-options="
				            iconCls: 'icon-edit',
				            singleSelect: true,
				            onClickRow: dcswlOnClickRow,
                            toolbar: '#tbpcWarningLoger'
			            ">
		            <thead>
			            <tr>
				            <th data-options="field:'WarningTime',width:120">报警时间</th>
                            <th data-options="field:'Label',width:120">报警点号</th>
				            <th data-options="field:'Message',width:120">报警原因</th>
                            <th data-options="field:'HandleInformation',width:300,editor:{type:'textbox'}">处理情况</th>
                            <th data-options="field:'Remarks',width:300,editor:{type:'textbox'}">备注</th>
			            </tr>
		            </thead>
	            </table>
	            <div id="tbpcWarningLoger" style="height:auto">
		            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="dcswlAccept()">应用</a>
		            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true" onclick="dcswlReject()">取消</a>
	            </div>
            </div>
            <div style="margin-top: 20px;">
                <!--煤耗报警记录DataGrid-->
	            <table id="ccWarningLoger" class="easyui-datagrid" title="煤耗报警记录" style="width:100%;height:auto"
			            data-options="
				            iconCls: 'icon-edit',
				            singleSelect: true,
				            onClickRow: dcswlOnClickRow,
                            toolbar: '#tbccWarningLoger'
			            ">
		            <thead>
			            <tr>
				            <th data-options="field:'WarningTime',width:120">报警时间</th>
                            <th data-options="field:'Label',width:120">报警点号</th>
				            <th data-options="field:'Message',width:120">报警原因</th>
                            <th data-options="field:'HandleInformation',width:300,editor:{type:'textbox'}">处理情况</th>
                            <th data-options="field:'Remarks',width:300,editor:{type:'textbox'}">备注</th>
			            </tr>
		            </thead>
	            </table>
	            <div id="tbccWarningLoger" style="height:auto">
		            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="dcswlAccept()">应用</a>
		            <a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-undo',plain:true" onclick="dcswlReject()">取消</a>
	            </div>
            </div>
        </div>
        <div class="easyui-panel" style="width:100%;height:auto;padding:10px;">
            <table style="width:100%;">
                <tr>
                    <td style="width:80px">本班生产计划完成情况</td>
                    <td>
                        <textarea id="performToObjectives" style="width:95%;height:50px;"></textarea></td>
                    <td style="width:80px">本班出现的问题及处理情况</td>
                    <td>
                        <textarea id="problemsAndSettlements" style="width:95%;height:50px;"></textarea></td>
                </tr>
                <tr>
                    <td style="width:80px">本班设备运行情况</td>
                    <td>
                        <textarea id="equipmentSituation" style="width:95%;height:50px;"></textarea></td>
                    <td style="width:80px">下班工作重点及建议</td>
                    <td>
                        <textarea id="advicesToNextShift" style="width:95%;height:50px;"></textarea></td>
                </tr>
            </table>
        </div>
        <div class="easyui-panel" style="padding:5px;width:100%;">
            <a href="javascript:void(0)" class="easyui-linkbutton easyui-tooltip tooltip-f" data-options="plain:true,iconCls:'icon-ok'" title="提交后不可修改，请谨慎操作。" onclick="submit()">提交</a>
        </div>
	</div>
	<script type="text/javascript">

	    var productLineId = 1;

	    $(document).ready(function () {
	        // 初始化班组下拉列表
	        initializeWorkingTeam();
            // 获取工段信息
	        getWorkingSection();
            // 获取停机记录
	        getHaltLog();
            // 获取报警记录
	        getWarningLog();
	    });

	    // 初始化班组下拉列表
	    function initializeWorkingTeam() {
	        var productLineId = 1;
	        var queryUrl = 'WorkingService.asmx/GetWorkingTeamWithComboboxFormat';
	        var dataToSend = '{productLineId: ' + productLineId + '}';

	        $.ajax({
	            type: "POST",
	            url: queryUrl,
	            data: dataToSend,
	            contentType: "application/json; charset=utf-8",
	            dataType: "json",
	            success: function (msg) {
	                initializeWorkingTeamCombobox(jQuery.parseJSON(msg.d));
	            }
	        });
	    }

	    function initializeWorkingTeamCombobox(json) {
	        $('#workingTeam').combobox({ data: json, onSelect: changeChargeMan});
	    }

        // 更新负责人
	    function changeChargeMan() {
	        var workingTeamId = parseInt($('#workingTeam').combobox('getValue'));
	        getChargeManByWorkingTeam(workingTeamId);
	    }

	    function getChargeManByWorkingTeam(workingTeamId) {
	        var queryUrl = 'WorkingService.asmx/GetChargeManByWorkingTeamIdWithComboboxFormat';
	        var dataToSend = '{workingTeamId: ' + workingTeamId + '}';

	        $.ajax({
	            type: "POST",
	            url: queryUrl,
	            data: dataToSend,
	            contentType: "application/json; charset=utf-8",
	            dataType: "json",
	            success: function (msg) {
	                setChargeManTextbox(jQuery.parseJSON(msg.d));
	            }
	        });
	    }

        // 设置班组负责人文本框
	    function setChargeManTextbox(json) {
	        $('#chargeMan').combobox('setText',json.ID + "  " + json.Name);
	        $('#chargeMan').combobox('setValue',json.ID);
	    }

	    // 生成操作员选择grid
	    function getWorkingSection() {
	        var productLineId = 1;
	        var queryUrl = 'WorkingService.asmx/GetWorkingSectionWithDataGridFormat';
	        var dataToSend = '{productLineId: ' + productLineId + '}';

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

	    // 操作员选择
        // os: operator selector
	    var osEditIndex = undefined;
	    function osEndEditing() {
	        if (osEditIndex == undefined) { return true }
	        if ($('#operatorSelector').datagrid('validateRow', osEditIndex)) {
	            var ed = $('#operatorSelector').datagrid('getEditor', { index: osEditIndex, field: 'StaffID' });
	            var staffId = $(ed.target).combobox('getValue');
	            var staffName = $(ed.target).combobox('getText').split('  ')[1];
	            $('#operatorSelector').datagrid('getRows')[osEditIndex]['StaffID'] = staffId;
	            $('#operatorSelector').datagrid('getRows')[osEditIndex]['StaffName'] = staffName;
	            $('#operatorSelector').datagrid('endEdit', osEditIndex);
	            osEditIndex = undefined;
	            return true;
	        } else {
	            return false;
	        }
	    }
	    function osOnClickRow(index) {
	        if (osEditIndex != index) {
	            if (osEndEditing()) {
	                $('#operatorSelector').datagrid('selectRow', index)
							.datagrid('beginEdit', index);
	                osEditIndex = index;
	            } else {
	                $('#operatorSelector').datagrid('selectRow', osEditIndex);
	            }
	        }
	    }
	    function osAccept() {
	        if (osEndEditing()) {
	            $('#operatorSelector').datagrid('acceptChanges');
	        }
	    }
	    function osReject() {
	        $('#operatorSelector').datagrid('rejectChanges');
	        osEditIndex = undefined;
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

	    // 停机原因选择
	    // hl: halt log

	    var hlEditIndex = undefined;
	    function hlEndEditing() {
	        if (hlEditIndex == undefined) { return true }
	        if ($('#haltLoger').datagrid('validateRow', hlEditIndex)) {
	            var ed = $('#haltLoger').datagrid('getEditor', { index: hlEditIndex, field: 'Reason' });
	            var reasonId = $(ed.target).combobox('getValue');
	            var reasonText = $(ed.target).combobox('getText');
	            $('#haltLoger').datagrid('getRows')[hlEditIndex]['ReasonID'] = reasonId;
	            $('#haltLoger').datagrid('getRows')[hlEditIndex]['ReasonText'] = reasonText;
	            $('#haltLoger').datagrid('endEdit', hlEditIndex);
	            hlEditIndex = undefined;
	            return true;
	        } else {
	            return false;
	        }
	        return true;
	    }
	    function hlOnClickRow(index) {
	        if (hlEditIndex != index) {
	            if (hlEndEditing()) {
	                $('#haltLoger').datagrid('selectRow', index)
							.datagrid('beginEdit', index);
	                hlEditIndex = index;
	            } else {
	                $('#haltLoger').datagrid('selectRow', hlEditIndex);
	            }
	        }
	    }
	    function hlAccept() {
	        if (hlEndEditing()) {
	            $('#haltLoger').datagrid('acceptChanges');
	        }
	    }
	    function hlReject() {
	        $('#haltLoger').datagrid('rejectChanges');
	        hlEditIndex = undefined;
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

	    // 报警原因选择
	    // dcswl: dcs warning log

	    var dcswlEditIndex = undefined;
	    function dcswlEndEditing() {
	        $('#dcsWarningLoger').datagrid('endEdit', dcswlEditIndex);
	        return true;
	    }
	    function dcswlOnClickRow(index) {
	        if (dcswlEditIndex != index) {
	            if (dcswlEndEditing()) {
	                $('#dcsWarningLoger').datagrid('selectRow', index)
							.datagrid('beginEdit', index);
	                dcswlEditIndex = index;
	            } else {
	                $('#dcsWarningLoger').datagrid('selectRow', dcswlEditIndex);
	            }
	        }
	    }
	    function dcswlAccept() {
	        if (dcswlEndEditing()) {
	            $('#dcsWarningLoger').datagrid('acceptChanges');
	        }
	    }
	    function dcswlReject() {
	        $('#dcsWarningLoger').datagrid('rejectChanges');
	        dcswlEditIndex = undefined;
	    }

	    // 提交

	    function submit() {
            // 应用变化
	        osAccept();
	        hlAccept();
	        dcswlAccept();
	        $('#pcWarningLoger').datagrid('acceptChanges');
	        $('#ccWarningLoger').datagrid('acceptChanges');

	        var time = "\"time\":\"" + $('#time').datetimespinner('getValue') + "\"";
	        var shifts = "\"shifts\":\"" + $('#shifts').combobox('getValue') + "\"";
	        var team = "\"workingTeam\":\"" + $('#workingTeam').combobox('getValue') + "\"";
	        var chargeMan = "\"chargeMan\":\"" + $('#chargeMan').combobox('getValue') + "\"";

	        var operators = "\"operators\":" + (JSON.stringify($('#operatorSelector').datagrid('getData')));
	        var haltLogs = "\"haltLogs\":" + (JSON.stringify($('#haltLoger').datagrid('getData')));
	        var dcsWarningLogs = "\"dcsWarningLogs\":" + (JSON.stringify($('#dcsWarningLoger').datagrid('getData')));

	        var performToObjectives = "\"performToObjectives\":\"" + $('#performToObjectives').val() + "\"";
	        var problemsAndSettlements = "\"problemsAndSettlements\":\"" + $('#problemsAndSettlements').val() + "\"";
	        var equipmentSituation = "\"equipmentSituation\":\"" + $('#equipmentSituation').val() + "\"";
	        var advicesToNextShift = "\"advicesToNextShift\":\"" + $('#advicesToNextShift').val() + "\"";

	        var loger = '{' + time + ',' + shifts + ',' + team + ',' + chargeMan + ',' + operators + ',' + haltLogs + ',' + dcsWarningLogs + ',' + 
                performToObjectives + ',' + problemsAndSettlements + ',' + equipmentSituation + ',' + advicesToNextShift + '}';

	        var productLineId = 1;
	        var queryUrl = 'WorkingService.asmx/CreateWorkingTeamShiftLog';
	        var dataToSend = '{productLineId:' + productLineId + ',json:\''+ loger +'\'}';

	        $.ajax({
	            type: "POST",
	            url: queryUrl,
	            data: dataToSend,
	            contentType: "application/json; charset=utf-8",
	            dataType: "json",
	            success: function (msg) {
	                alert('s');
	            }
	        });

	    }
	</script>
    </form>
</body>
</html>
