using NXJC.Slim.Service;
using NXJC.Slim.Service.Infrastructure;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace NXJC.UI.Web.FractionalElectricPowerCount
{
    /// <summary>
    /// ElectricPowerCountService 的摘要说明
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消注释以下行。 
    [System.Web.Script.Services.ScriptService]
    public class PowerCountService : System.Web.Services.WebService
    {
        [WebMethod]
        public void GetProductLinesWithComboboxFormat()
        {
            DataTable productLineTable = ProductLineService.GetProductLines();
            Context.Response.Write(ComboboxJsonParser.DataTableToJson(productLineTable, "ID", "Name"));
        }

        [WebMethod]
        public string GetAvailableFormulaGroupWithComboboxFormat(int productLineId)
        {
            DataTable dt = ElectricPowerCountService.GetAvailableFormulaGroupByProductLineId(productLineId);
            return ComboboxJsonParser.DataTableToJson(dt, "Name", "FormulaGroupID");
        }

        [WebMethod]
        public string GetElectricPowerCountWithTreeGridFormat(int productLineId, string formulaGroupId)
        {
            Guid _formulaGroupId = new Guid(formulaGroupId);

            DataTable dt = ElectricPowerCountService.GetElectricPowerCount(productLineId, _formulaGroupId);
            DataColumn parentIdColumn = new DataColumn("ParentID");
            dt.Columns.Add(parentIdColumn);

            foreach (DataRow row in dt.Rows)
            {
                string levelcode = row["LevelCode"].ToString().Trim();
                if (levelcode.Length > 3)
                    row["ParentID"] = levelcode.Substring(0, levelcode.Length - 2);
            }

            return TreeGridJsonParser.DataTableToJson(dt, "LevelCode", "ParentID", "ProcessName", "PeakPower", "PeakCost", "ValleyPower", "ValleyCost", "FlatPower", "FlatCost", "TotalPower", "TotalCost");
        }
    }
}
