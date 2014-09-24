using NXJC.Slim.Service;
using NXJC.Infrastructure.Configuration;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using EasyUIJsonParser;

namespace NXJC.UI.Web.staffInfo
{
    /// <summary>
    /// StaffInfo 的摘要说明
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消注释以下行。 
    [System.Web.Script.Services.ScriptService]
    public class StaffInfo : System.Web.Services.WebService
    {

        [WebMethod]
        public string GetStaffInfoDatas()
        {
            StaffInfoService service = new StaffInfoService();

            DataTable dt = service.GetStaffInfo();

            string[] column = { "ID", "Name", "Sex", "PhoneNumber" };
            string result = DataGridJsonParser.DataTableToJson(dt, column);

            return result;
        }
    }
}
