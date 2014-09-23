using NXJC.Slim.Service;
using NXJC.Slim.Service.Infrastructure;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Collections;

namespace NXJC.UI.Web.ProcessDataAnalyse
{
    /// <summary>
    /// CustomAnalyseItem1 的摘要说明
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // 若要允许使用 ASP.NET AJAX 从脚本中调用此 Web 服务，请取消注释以下行。 
    [System.Web.Script.Services.ScriptService]
    public class CustomAnalyseItem1 : System.Web.Services.WebService
    {
        [WebMethod]
        public void GetProductLinesWithComboboxFormat()
        {
            DataTable productLineTable = ProductLineService.GetProductLines();
            Context.Response.Write(ComboboxJsonParser.DataTableToJson(productLineTable, "ID", "Name"));
        }

        [WebMethod]
        public string  GetLabelsWithTreeGridFormat(int productLineId)
        {
            try
            {
                DataTable labelTable = ProductLineService.GetLabelsByProductLineId(productLineId);
                return TreeGridJsonParser.DataTableToJson(labelTable, "ViewName", new string[] { "VariableName", "VariableDescription" });
            }
            catch
            {
                return "[]";
            }
        }

        [WebMethod]
        public string GetCharDatas(string myJsonData)
        {
            string[] seletedStrings = myJsonData.JsonPickArray("selectedLines");
            ArrayList productLineAndlableNames = new ArrayList();
            foreach (var item in seletedStrings)
            {
                string productLineAndlableName = item.JsonPick("VariableName");
                productLineAndlableNames.Add(productLineAndlableName);
            }
            CustomAnalyseItemService service = new CustomAnalyseItemService();
            DataTable dt = service.GetProcessDatas(productLineAndlableNames);

            string result = DataTable2ChartJson.ToChartJson(dt, "Time", "T", "100");

            return result;
        }


        [WebMethod]
        public string GetModelDatas(string builderId)
        {
            CustomAnalyseItemService service = new CustomAnalyseItemService();
            DataTable dt = service.GetDIYAnalyseModel();
            string[] column = {"ID","Name","Date","Builder","Description","IsPrivate"};
            string result = DataGridJsonParser.DataTableToJson(dt, column);

            return result;
        }

        [WebMethod]
        public string GetModelDatasByModelID(string DIYAnalyseModelID)
        {
            int id = 0;
            int.TryParse(DIYAnalyseModelID, out id);
            CustomAnalyseItemService service = new CustomAnalyseItemService();
            DataTable dt = service.GetModelDatasByDIYAnalyseModelID(id);
            string[] column = { "ID", "DIYAnalyseModelID", "ProductLineID", "ProductLineName", "VariableName", "VariableDescription" };

            string result = DataGridJsonParser.DataTableToJson(dt, column);

            return result;
        }
    }
}
