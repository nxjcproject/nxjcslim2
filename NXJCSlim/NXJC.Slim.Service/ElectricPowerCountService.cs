using NXJC.Slim.Service.Infrastructure;
using SqlServerDataAdapter;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace NXJC.Slim.Service
{
    public class ElectricPowerCountService
    {
        /// <summary>
        /// 获取分步用电查询可用的公式组
        /// </summary>
        /// <param name="productLineId"></param>
        /// <returns></returns>
        public static DataTable GetAvailableFormulaGroupByProductLineId(int productLineId)
        {
            string connectionString = ConnectionStringFactory.GetNXJCConnectionString();
            DataSet ds = new DataSet();

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                SqlCommand command = connection.CreateCommand();
                command.CommandText = @"SELECT DISTINCT	FormulaGroup.Name, table_ElectricPowerCount.FormulaGroupID
                                        FROM    FormulaGroup INNER JOIN
                                                table_ElectricPowerCount ON FormulaGroup.KeyID = table_ElectricPowerCount.FormulaGroupID
                                        WHERE   table_ElectricPowerCount.FormulaGroupID IN (
                                                SELECT DISTINCT FormulaGroupID FROM [table_ElectricPowerCount] WHERE [ProductLineID] = @productLineId)";

                command.Parameters.Add(new SqlParameter("productLineId", productLineId));
                SqlDataAdapter adapter = new SqlDataAdapter(command);
                adapter.Fill(ds);
            }

            return ds.Tables[0];
        }

        /// <summary>
        /// 获取用电量
        /// </summary>
        /// <param name="productLineId"></param>
        /// <param name="formulaGroupId"></param>
        /// <returns></returns>
        public static DataTable GetElectricPowerCount(int productLineId, Guid formulaGroupId)
        {
            double peakUnitPrice = 0.6876;
            double valleyUnitPrice = 0.4310;
            double flatUnitPrice = 0.2744;

            string connectionString = ConnectionStringFactory.GetNXJCConnectionString();

            ISqlServerDataFactory factory = new SqlServerDataFactory(connectionString);
            Query query = new Query("table_ElectricPowerCount");
            query.AddCriterion("ProductLineID", "productLineId", productLineId, SqlServerDataAdapter.Infrastruction.CriteriaOperator.Equal);
            query.AddCriterion("FormulaGroupID", "formulaGroupId", formulaGroupId.ToString(), SqlServerDataAdapter.Infrastruction.CriteriaOperator.Equal);

            DataTable result =  factory.Query(query);

            DataColumn PeakCost = new DataColumn("PeakCost");
            result.Columns.Add(PeakCost);
            DataColumn ValleyCost = new DataColumn("ValleyCost");
            result.Columns.Add(ValleyCost);
            DataColumn FlatCost = new DataColumn("FlatCost");
            result.Columns.Add(FlatCost);
            DataColumn TotalCost = new DataColumn("TotalCost");
            result.Columns.Add(TotalCost);

            foreach (DataRow row in result.Rows)
            {
                double peakCost = int.Parse(row["PeakPower"].ToString()) * peakUnitPrice;
                double valleyCost = int.Parse(row["ValleyPower"].ToString()) * valleyUnitPrice;
                double flatCost = int.Parse(row["FlatPower"].ToString()) * flatUnitPrice;
                double totalCost = peakCost + valleyCost + flatCost;

                row["PeakCost"] = peakCost;
                row["ValleyCost"] = valleyCost;
                row["FlatCost"] = flatCost;
                row["TotalCost"] = totalCost;
            }

            return result;
        }
    }
}