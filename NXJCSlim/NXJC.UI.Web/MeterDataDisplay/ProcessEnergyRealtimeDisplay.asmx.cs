using NXJC.Slim.Service;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace NXJC.UI.Web.MeterDataDisplay
{
    /// <summary>
    /// ProcessEnergyRealtimeDisplay1 的摘要说明
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消注释以下行。 
    [System.Web.Script.Services.ScriptService]
    public class ProcessEnergyRealtimeDisplay1 : System.Web.Services.WebService
    {

        [WebMethod]
        public void GetFactoryNameForCombobox()
        {
            MeterDataDisplayService service = new MeterDataDisplayService();

            Context.Response.Write(service.GetFactory());
        }

        [WebMethod]
        public void GetElectricalRoomForCombobox(string id)
        {
            MeterDataDisplayService service = new MeterDataDisplayService();
            
            Context.Response.Write(service.GetEletricalRoom(int.Parse(id)));
        }
    }
}
