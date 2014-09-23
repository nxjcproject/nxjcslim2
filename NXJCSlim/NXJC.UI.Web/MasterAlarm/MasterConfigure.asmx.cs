using NXJC.Slim.Service;
using NXJC.Slim.Service.Infrastructure;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace NXJC.UI.Web.MasterAlarm
{
    /// <summary>
    /// MasterConfigure1 的摘要说明
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消注释以下行。 
    [System.Web.Script.Services.ScriptService]
    public class MasterConfigure1 : System.Web.Services.WebService
    {
        [WebMethod]
        public string GetEquipmentDatas(string ProductLineID)
        {
            int id = 0;
            int.TryParse(ProductLineID, out id);

            MasterConfigureService service = new MasterConfigureService();
            DataTable dt = service.GetEquipment(id);

            string[] column = { "VariableName", "EquipmentName" };
            string result = ComboboxJsonParser.DataTableToJson(dt, column);

            return result;
        }

        [WebMethod]
        public string GetmastersDatas(string ProductLineID)
        {
            int id = 0;
            int.TryParse(ProductLineID, out id);

            MasterConfigureService service = new MasterConfigureService();
            DataTable dt = service.GetMaser(id);

            string[] column = { "VariableName", "EquipmentName" };
            string result = ComboboxJsonParser.DataTableToJson(dt, column);

            return result;
        }

        [WebMethod]
        public string GetAlarmConfigureDatas(string ProductLineID)
        {
            int id = 0;
            int.TryParse(ProductLineID, out id);

            MasterConfigureService service = new MasterConfigureService();

            DataTable dt = service.GetAlarmConfigure(id);

            string[] column = { "VariableName", "EquipmentName", "Ismaster", "Belong", "IsAlarm", "StopPosition", "AlarmPosition", "AlarmMessage" };
            string result = DataGridJsonParser.DataTableToJson(dt, column);

            return result;
        }
    }
}
