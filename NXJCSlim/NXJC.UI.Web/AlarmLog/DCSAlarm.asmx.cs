using NXJC.Slim.Service;
using NXJC.Slim.Service.Infrastructure;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace NXJC.UI.Web.AlarmLog
{
    /// <summary>
    /// DCSAlarm1 的摘要说明
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消注释以下行。 
    [System.Web.Script.Services.ScriptService]
    public class DCSAlarm1 : System.Web.Services.WebService
    {

        [WebMethod]
        public string GetProductLineData()
        {
            DCSAlarmService service = new DCSAlarmService();

            DataTable dt = service.GetProductLine();
            string[] column = {"ID","Name"};
            string result = ComboboxJsonParser.DataTableToJson(dt, column);

            return result;
        }

        [WebMethod]
        public string GetDCSWarningLogData()
        {
            DCSAlarmService service = new DCSAlarmService();

            DataTable dt = service.GetDCSWarningLog();
            string[] column = { "WarningTime", "Label", "EndingTime", "Message", "HandleInformation" };
            string result = DataGridJsonParser.DataTableToJson(dt, column);

            return result;
        }
    }
}
