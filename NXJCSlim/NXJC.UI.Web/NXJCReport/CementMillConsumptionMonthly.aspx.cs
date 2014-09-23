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

namespace NXJC.UI.Web.Report
{
    public partial class Company : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string GetCompanyData()
        {
            string connString = ConnectionStringFactory.GetNXJCConnectionString();   //填写链接字符串
            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection(connString))
            {
                //conn.Open();
                SqlCommand cmd = conn.CreateCommand();
                cmd.CommandText = "SELECT [key_id],[vDate],[CementFirstTeam],[CementSecondTeam],[CementThirdTeam],[CementAmountto],[PackagingTransportationFirstTeam],[PackagingTransportationSecondTeam],[PackagingTransportationThirdTeam],[PackagingTransportationAmountto],[DailyFirstTeam],[DailySecondTeam],[DailyThirdTeam],[DailyAmountto] FROM [CementMillProductionLineMonthlyElectricityConsumption]";                          //填写查询语句
                SqlDataAdapter da = new SqlDataAdapter(cmd);

                da.Fill(dt);
            }

            DataGridColumnType columnType = new DataGridColumnType
            {
                ColumnText = new string[] { "ID", "日期", "水泥制备甲班", "水泥制备乙班", "水泥制备丙班", "水泥制备合计", "水泥包装与输送甲班", "水泥包装与输送乙班", "水泥包装与输送丙班", "水泥包装与输送合计", "合计电量甲班", "合计电量乙班", "合计电量丙班", "合计电量合计" },                                 //填写表头及宽度
                ColumnWidth = new int[] { 10, 60, 80, 80, 80, 80, 120, 120, 120, 120, 80, 80, 80, 80 },
                ColumnType = new string[] { "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "" }
            };

            string result = DataGridTemplateHelper.GetDataGridTemplate(dt, columnType);

            return result;
        }
    }
}