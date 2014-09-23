using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NXJCSlim.UI.Web.Monitoring
{
    public partial class Realtime : System.Web.UI.Page
    {
        public string TemplatePath { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            string templateName = Request.QueryString["templateName"];
            TemplatePath = "/Monitoring/PowerEquipment/Template/" + templateName + "/template.html";
        }
    }
}