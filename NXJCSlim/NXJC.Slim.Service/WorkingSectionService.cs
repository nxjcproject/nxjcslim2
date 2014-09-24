using NXJC.Infrastructure.Configuration;
using SqlServerDataAdapter;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;

namespace NXJC.Slim.Service
{
    public class WorkingSectionService
    {
        private ISqlServerDataFactory dataFactory;
        string connString;

        public WorkingSectionService()
        {
            connString = ConnectionStringFactory.NXJCConnectionString;
            dataFactory = new SqlServerDataFactory(connString);
        }

        /// <summary>
        /// 按生产线ID获取工段
        /// </summary>
        /// <param name="productLineId"></param>
        /// <returns></returns>
        public static DataTable GetWorkingTeamByProductLineId(int productLineId)
        {
            string connectionString = ConnectionStringFactory.NXJCConnectionString;

            ISqlServerDataFactory factory = new SqlServerDataFactory(connectionString);
            Query query = new Query("WorkingSection");
            query.AddCriterion("ProductLineID", productLineId, SqlServerDataAdapter.Infrastruction.CriteriaOperator.Equal);

            return factory.Query(query);
        }

        public DataTable GetProductLine()
        {
            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection(connString))
            {
                SqlCommand cmd = conn.CreateCommand();
                cmd.CommandText = "SELECT ID, Name FROM ProductLine";

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
            }
            return dt;
        }

        public DataTable GetWorkingSection()
        {
            Query query = new Query("WorkingSection");
            DataTable dt = dataFactory.Query(query);

            return dt;
        }
    }
}
