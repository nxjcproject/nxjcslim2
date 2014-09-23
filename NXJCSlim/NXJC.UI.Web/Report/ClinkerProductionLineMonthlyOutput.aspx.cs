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
    public partial class ClinkerProductionLineMonthlyOutput : System.Web.UI.Page
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
                cmd.CommandText = "SELECT key_id,ClinkerAmountto,ClinkerFirstTeam,ClinkerSecondTeam,ClinkerThirdTeam,CoalDustAmountto,CoalDustFirstTeam,CoalDustSecondTeam,CoalDustThirdTeam,PowerGenerationAmountto,PowerGenerationFirstTeam,PowerGenerationhSecondTeam,PowerGenerationThirdTeam,RawBatchAmountto,RawBatchFirstTeam,RawBatchSecondTeam,RawBatchThirdTeam,vDate from ClinkerProductionLineMonthlyOutput";                          //填写查询语句
                SqlDataAdapter da = new SqlDataAdapter(cmd);

                da.Fill(dt);
            }

            DataGridColumnType columnType = new DataGridColumnType
            {
                ColumnText = new string[] { "ID", "日期", "甲班生料生产", "乙班生料生产", "丙班生料生产","合计生料生产", "甲班熟料生产", "乙班熟料生产", "丙班熟料生产","合计熟料生产", "甲班发电量", "乙班发电量", "丙班发电量","合计发电量", "甲班煤粉产量", "乙班煤粉产量", "丙班煤粉产量","合计煤粉产量" },                                 //填写表头及宽度
                ColumnWidth = new int[] { 10, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100, 100,100,100 },
                ColumnType = new string[] { "", "", "", "", "", "", "", "", "", "", "", "", "", "", "","","","" }
            };

            string result = DataGridTemplateHelper.GetDataGridTemplate(dt, columnType);

            return result;
        }
    }
}