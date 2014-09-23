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
    public partial class ClinkerConsumptionYearly : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        [WebMethod]
        public static string GetCompanyData()
        {
            string connString = ConnectionStringFactory.GetNXJCConnectionString();
            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection(connString))
            {

                SqlCommand cmd = conn.CreateCommand();
                cmd.CommandText = "SELECT [key_id],VMonth,ElectricityConsumption,CoalDust,Qnet,Diesel,ResidualHeatSupply,ResidualHeatProduction,ResidualHeatSelfUse,ClinkerOutput,ClinkerIntensity,ClinkerIntensityCorrectionFactor,ComprehensiveECC,ComparableComprehensiveECC,ComprehensiveStandardCCC,ComparableComprehensiveStandardCCC,ComprehensiveDCC,ConversionResidualHeatSupply,ComprehensiveEnCC,ComparableComprehensiveEnCC FROM [ClinkerYeldPerUnitDistributionEnergyConsumptionYearly]";
                SqlDataAdapter da = new SqlDataAdapter(cmd);

                da.Fill(dt);
            }

            DataGridColumnType columnType = new DataGridColumnType
            {
                ColumnText = new string[] { "ID", "月份", "熟料用电量 ", "入窑煤粉量", "煤粉空干基低位发热量", "点火用油", "余热供电量", "余热发电量", "余热自用电", "熟料产量", "熟料强度", "熟料强度修正系数", "熟料综合电耗", "可比熟料综合电耗", "熟料综合煤耗", "可比熟料综合煤耗", "熟料油耗", "余热供电折标", "熟料综合能耗", "可比熟料综合能耗" },                                 //填写表头及宽度
                ColumnWidth = new int[] { 10, 40, 70, 70, 130, 60, 70, 70, 70, 60, 60, 110, 80, 110, 80, 110, 60, 80, 80, 110 },
                ColumnType = new string[] { "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "","","","", }
            };

            string result = DataGridTemplateHelper.GetDataGridTemplate(dt, columnType);

            return result;
        }
    }
}