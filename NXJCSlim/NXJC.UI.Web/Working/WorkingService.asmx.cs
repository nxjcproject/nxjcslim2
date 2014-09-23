using NXJC.Slim.Service;
using NXJC.Slim.Service.Infrastructure;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace NXJC.UI.Web.Working
{
    /// <summary>
    /// WorkingService 的摘要说明
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消注释以下行。 
    [System.Web.Script.Services.ScriptService]
    public class WorkingService : System.Web.Services.WebService
    {

        #region Create
        
        [WebMethod]
        public string CreateWorkingTeamShiftLog(int productLineId, string json)
        {
            string time = json.JsonPick("time");
            string shifts = json.JsonPick("shifts");
            string workingTeam = json.JsonPick("workingTeam");
            string chargeMan = json.JsonPick("chargeMan");
            string operators = json.JsonPick("operators");
            string haltLogs = json.JsonPick("haltLogs");
            string dcsWarningLogs = json.JsonPick("dcsWarningLogs");
            string performToObjectives = json.JsonPick("performToObjectives");
            string problemsAndSettlements = json.JsonPick("problemsAndSettlements");
            string equipmentSituation = json.JsonPick("equipmentSituation");
            string advicesToNextShift = json.JsonPick("advicesToNextShift");

            string[] operatorJsons = operators.JsonPickArray("rows");



            return "";
        }

        #endregion

        #region Read
        [WebMethod]
        public string GetWorkingTeamWithComboboxFormat(int productLineId)
        {
            DataTable dt = StaffService.GetWorkingTeamByProductLineId(productLineId);
            return ComboboxJsonParser.DataTableToJson(dt, "ID", "ChargeManID", "Name");
        }

        [WebMethod]
        public string GetChargeManByWorkingTeamIdWithComboboxFormat(int workingTeamId)
        {
            DataTable dt = StaffService.GetChargeManByWorkingTeamId(workingTeamId);
            if (dt.Rows.Count == 0)
                return "";
            return "{\"ID\":\"" + dt.Rows[0]["ID"].ToString() + "\", \"Name\":\"" + dt.Rows[0]["Name"].ToString() + "\"}";
        }

        [WebMethod]
        public void GetStaffInfoWithComboboxFormat()
        {
            DataTable dt = StaffService.GetStaffInfo();
            dt.Columns["ID"].ColumnName = "StaffID";
            dt.Columns["Name"].ColumnName = "StaffName";
            dt.Columns.Add("Combined");
            foreach (DataRow dr in dt.Rows)
            {
                dr["Combined"] = dr["StaffID"] + "  " + dr["StaffName"];
            }
            Context.Response.Write(ComboboxJsonParser.DataTableToJson(dt, "StaffID", "StaffName", "Combined"));
        }
        
        [WebMethod]
        public string GetWorkingSectionWithDataGridFormat(int productLineId)
        {
            DataTable dt = WorkingSectionService.GetWorkingTeamByProductLineId(productLineId);
            dt.Columns["ID"].ColumnName = "WorkingSectionID";
            dt.Columns["Name"].ColumnName = "WorkingSectionName";
            return DataGridJsonParser.DataTableToJson(dt, "WorkingSectionID", "WorkingSectionName");
        }

        [WebMethod]
        public string GetWorkingSectionAssignmentWithDataGridFormat(int handoverLogId)
        {
            DataTable dt = HandoverLogService.GetWorkingSectionAssignmentByHandoverLogId(handoverLogId);
            return DataGridJsonParser.DataTableToJson(dt, "WorkingSectionID", "StaffID", "StaffName", "WorkingSectionName");
        }

        [WebMethod]
        public string GetDCSWarningLogWithDataGridFormat(int productLineId)
        {
            DataTable dt = DCSWarningLogService.GetWarningLog(productLineId);
            return DataGridJsonParser.DataTableToJson(dt, "WarningTime", "Label", "Message");
        }

        [WebMethod]
        public void GetMachineHaltReasonWithComboboxFormat()
        {
            DataTable dt = MachineHaltLogService.GetMachineHaltReason();
            Context.Response.Write(ComboboxJsonParser.DataTableToJson(dt, "ID", "Name"));
        }

        [WebMethod]
        public string GetMachineHaltLogWithDataGridFormat(int productLineId)
        {
            DataTable dt = MachineHaltLogService.GetHaltLog(productLineId);
            return DataGridJsonParser.DataTableToJson(dt, "HaltTime", "Label", "Machine");
        }
        #endregion

        #region Aggregate Root Read
        [WebMethod]
        public string GetHandoverLogWithDataGridFormat()
        {
            DataTable dt = HandoverLogService.GetHandoverLog();
            return DataGridJsonParser.DataTableToJson(dt, "ID", "ProductLineID", "ProductLineName", "ShiftDate", "Shifts", "WorkingTeamID", "WorkingTeamName", "ChargeManID", "ChargeManName");
        }

        [WebMethod]
        public string GetHandoverLogWithSimpleGridFormat(int handoverLogId)
        {
            DataTable dt = HandoverLogService.GetHandoverLogByHandoverLogId(handoverLogId);
            return JsonHelper.DataTableFirstRowToJson(dt);
        }
        #endregion
    }
}
