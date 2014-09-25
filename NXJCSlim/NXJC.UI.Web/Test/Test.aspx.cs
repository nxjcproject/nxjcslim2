using NXJC.Slim.Service;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NXJC.UI.Web.Test
{
    public partial class Test : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AppStructureService service = new AppStructureService();
            DataTable dt = service.GetLevelCode();
            GridView1.DataSource = dt;
            GridView1.DataBind();
        }
    }
}