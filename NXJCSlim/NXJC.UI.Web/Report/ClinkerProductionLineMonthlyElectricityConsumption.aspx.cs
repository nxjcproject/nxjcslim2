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
    public partial class ClinkerProductionLineMonthlyElectricityConsumption : System.Web.UI.Page
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
                cmd.CommandText = "SELECT key_id,vDate,ClinkerFirstTeam,ClinkerSecondTeam,ClinkerThirdTeam,ClinkerAmountto,DailyFirstTeam,DailySecondTeam,DailyThirdTeam,DailyAmountto,RawBatchFirstTeam,RawBatchSecondTeam,RawBatchThirdTeam,RawBatchAmountto FROM ClinkerProductionLineMonthlyElectricityConsumption";                          //填写查询语句
                SqlDataAdapter da = new SqlDataAdapter(cmd);

                da.Fill(dt);
            }

            DataGridColumnType columnType = new DataGridColumnType
            {
                ColumnText = new string[] { "ID", "日期", "甲班生料制备", "乙班生料制备", "丙班生料制备", "合计生料制备", "甲班熟料制备", "乙班熟料制备", "丙班熟料制备", "合计熟料制备", "甲班合计电量", "乙班合计电量", "丙班合计电量", "合计电量" },                                 //填写表头及宽度
                ColumnWidth = new int[] { 10, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100,100 },
                ColumnType = new string[] { "", "", "", "", "", "", "", "", "", "", "", "", "","" }
            };

            string result = DataGridTemplateHelper.GetDataGridTemplate(dt, columnType);

            return result;
        }
    }
}