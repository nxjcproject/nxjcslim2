using NXJC.Slim.Service;
using NXJC.Slim.Service.Infrastructure;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NXJC.UI.Web.SystemData
{
    public partial class GroupInformation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod]
        public static string GetTreeGridDatas()
        {
            GroupService service = new GroupService();

            IEnumerable<GroupTreeNode> datas = service.GetTreeGridDatas();
            string result = JsonHelper.ObjectToJson(datas);

            return result;
        }
    }
}