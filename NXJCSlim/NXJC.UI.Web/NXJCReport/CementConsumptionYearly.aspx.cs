using NXJC.Slim.Service.Infrastructure;
using NXJC.UI.Web.EasyUIDataGrid;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NXJC.UI.Web.NXJCReport
{
    public partial class CementConsumptionYearly : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod]
        public static string GetCompanyData()
        {
            string connString = ConnectionStringFactory.GetNXJCConnectionString() ;   //填写链接字符串
            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection(connString))
            {
                //conn.Open();
                SqlCommand cmd = conn.CreateCommand();
                cmd.CommandText = "SELECT [key_id],VMonth,CementTypes,Output,ElectricityConsumption,DistributionPowerConsumption,ConversionDistributionPowerConsumption FROM [CementYeldPerUnitDistributionPowerConsumptionYearly]";
                SqlDataAdapter da = new SqlDataAdapter(cmd);

                da.Fill(dt);
            }

            DataGridColumnType columnType = new DataGridColumnType
            {
                ColumnText = new string[] { "ID", "月份", "水泥品种", "产量", "用电量", "分步电耗", "折算P.O42.5分布电耗", },                               
                ColumnWidth = new int[] { 10, 40, 60, 40, 50, 60, 140 },
                ColumnType = new string[] { "", "", "", "", "", "", "" }
            };

            string result = DataGridTemplateHelper.GetDataGridTemplate(dt, columnType);

            return result;
        }
    }
}