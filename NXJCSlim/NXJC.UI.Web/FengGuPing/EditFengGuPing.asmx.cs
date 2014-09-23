using NXJC.Slim.Service.Infrastructure;
using NXJC.Slim.Service.PeakValleyFlat;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace NXJC.UI.Web.FengGuPing
{
    /// <summary>
    /// EditFengGuPing1 的摘要说明
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消注释以下行。 
    [System.Web.Script.Services.ScriptService]
    public class EditFengGuPing1 : System.Web.Services.WebService
    {

        [WebMethod]
        public string GetFGPValueForGrid(int companyId)
        {
            PVFService service = new PVFService();
            IList<PVFItem> items = service.GetPVFByCompanyID(companyId);

            string result = JsonHelper.ObjectToJson(items);

            return result;
        }

        [WebMethod]
        public string SavePVFValues(string myJsonData)
        {
            PVFChanges changed = (PVFChanges)JsonHelper.JsonToObject(myJsonData, new PVFChanges());

            PVFService service = new PVFService();

            service.SavePVFValues(changed.inserted, changed.updated, changed.deleted);


            return "1";
        }
    }
}
