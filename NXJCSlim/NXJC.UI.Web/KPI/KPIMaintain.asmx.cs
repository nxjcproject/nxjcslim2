using NXJC.Slim.Service;
using NXJC.Slim.Service.Infrastructure;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace NXJC.UI.Web.KPI
{
    /// <summary>
    /// KPIMaintain1 的摘要说明
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消注释以下行。 
    [System.Web.Script.Services.ScriptService]
    public class KPIMaintain1 : System.Web.Services.WebService
    {

        [WebMethod]
        public string GetKPIDatas()
        {
            KPIMaintainService service = new KPIMaintainService();

            DataTable dt = service.GetKPI();

            string[] column = { "StandardCategory", "Limit_CCS_CCClinker", "Limit_CC_ECClinker", "Limit_CC_ECCement", "Limit_CC_EnCClinker", "Limit_CC_EnCCement", "RawBatch_ElectricityConsumption", "Clinker_CoalConsumption", "Clinker_ElectricityConsumption", "Cement_ElectricityConsumption" };
            string result = DataGridJsonParser.DataTableToJson(dt, column);

            return result;
        }
    }
}
