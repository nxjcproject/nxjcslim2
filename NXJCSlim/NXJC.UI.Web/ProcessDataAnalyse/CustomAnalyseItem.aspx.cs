using NXJC.Slim.Service;
using NXJC.Slim.Service.Infrastructure;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NXJC.UI.Web.ProcessDataAnalyse
{
    public partial class CustomAnalyseItem : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        [WebMethod]
        public  string GetLabelsWithTreeGridFormat(int productLineId)
        {
            try
            {
                DataTable labelTable = ProductLineService.GetLabelsByProductLineId(productLineId);
                return TreeGridJsonParser.DataTableToJson(labelTable, "ViewName", new string[] { "VariableName", "FieldName" });
            }
            catch
            {
               return "[]";
            }
        }
    }
}