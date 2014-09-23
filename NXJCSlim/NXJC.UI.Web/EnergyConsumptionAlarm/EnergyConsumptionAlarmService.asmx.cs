using NXJC.Slim.Service;
using NXJC.Slim.Service.Infrastructure;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace NXJC.UI.Web.EnergyConsumptionAlarm
{
    /// <summary>
    /// EnergyConsumptionAlarmService 的摘要说明
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消注释以下行。 
    [System.Web.Script.Services.ScriptService]
    public class EnergyConsumptionAlarmService : System.Web.Services.WebService
    {

        [WebMethod]
        public string GetElectricityConsumptionAlarmSettingsWithTreeGridFormat(int productLineId)
        {
            DataTable dt = EnergyConsumptionService.GetElectricityConsumptionAlarmSettingsByFactoryId(productLineId);
            DataColumn parentIdColumn = new DataColumn("ParentID");
            dt.Columns.Add(parentIdColumn);

            foreach (DataRow row in dt.Rows)
            {
                string levelcode = row["LevelCode"].ToString().Trim();
                if (levelcode.Length > 3)
                    row["ParentID"] = levelcode.Substring(0, levelcode.Length - 2);
            }

            return TreeGridJsonParser.DataTableToJson(dt, "LevelCode", "ParentID", "Name", "StandardValue", "AlarmValue");
        }


        [WebMethod]
        public string GetCoalConsumptionAlarmSettingsWithTreeGridFormat(int productLineId)
        {
            DataTable dt = EnergyConsumptionService.GetCoalConsumptionAlarmSettingsByFactoryId(productLineId);
            DataColumn parentIdColumn = new DataColumn("ParentID");
            dt.Columns.Add(parentIdColumn);

            foreach (DataRow row in dt.Rows)
            {
                row["ParentID"] = "";
            }

            return TreeGridJsonParser.DataTableToJson(dt, "Name", "ParentID", "StandardValue", "AlarmValue");
        }
    }
}
