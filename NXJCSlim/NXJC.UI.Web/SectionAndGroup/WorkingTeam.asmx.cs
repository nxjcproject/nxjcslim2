using NXJC.Slim.Service;
using NXJC.Slim.Service.Infrastructure;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace NXJC.UI.Web.SectionAndGroup
{
    /// <summary>
    /// WorkingTeam1 的摘要说明
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消注释以下行。 
    [System.Web.Script.Services.ScriptService]
    public class WorkingTeam1 : System.Web.Services.WebService
    {

        [WebMethod]
        public string GetProductLineForCombobox()
        {
            WorkingTeamService service = new WorkingTeamService();

            DataTable dt = service.GetProductLine();
            string[] column = { "ID", "Name" };

            string result = ComboboxJsonParser.DataTableToJson(dt, column);

            return result;
        }

        [WebMethod]
        public string GetStaffInfoForCombobox()
        {
            WorkingTeamService service = new WorkingTeamService();

            DataTable dt = service.GetStaffInfo();
            string[] column = { "ID", "Name" };

            string result = ComboboxJsonParser.DataTableToJson(dt, column);

            return result;
        }

        [WebMethod]
        public string GetWorkingTeamDatas()
        {
            WorkingTeamService service = new WorkingTeamService();

            DataTable dt = service.GetWorkingTeam();
            string[] column = { "ID", "ProductLineID","ChargeManID","Name","Remarks" };

            string result = DataGridJsonParser.DataTableToJson(dt, column);

            return result;
        }
    }
}
